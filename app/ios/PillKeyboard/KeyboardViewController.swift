import UIKit

/// Klávesnice The Pill pro iOS: česká QWERTZ + lišta kouče.
/// Po pauze v psaní pošle rozepsanou zprávu na /coach (jen s „Plným přístupem“).
/// Text nahradí JEN po tapnutí na alternativu — nikdy sama nic neodesílá ani nepřepisuje.
final class KeyboardViewController: UIInputViewController {
  private static let rows = ["1234567890", "ěščřžýáíéůú", "qwertzuiop", "asdfghjkl"]
  private static let maxChars = 2000

  private var gate = CoachGate()
  private var shift = false
  private var generation = 0
  private var debounce: Timer?
  private var letterButtons: [UIButton] = []

  private let coachBar = UIStackView()
  private let coachLabel = UILabel()
  private let altPanel = UIStackView()

  // MARK: - Životní cyklus

  override func viewDidLoad() {
    super.viewDidLoad()
    let root = UIStackView()
    root.axis = .vertical
    root.spacing = 4
    root.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(root)
    NSLayoutConstraint.activate([
      root.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3),
      root.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3),
      root.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
      root.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4),
    ])
    root.addArrangedSubview(buildCoachBar())
    root.addArrangedSubview(altPanel)
    altPanel.axis = .vertical
    altPanel.spacing = 4
    altPanel.isHidden = true
    Self.rows.forEach { root.addArrangedSubview(letterRow($0)) }
    root.addArrangedSubview(shiftRow())
    root.addArrangedSubview(bottomRow())
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    gate.reset()
    hideCoach()
  }

  // MARK: - Psaní

  private func type(_ s: String) {
    textDocumentProxy.insertText(shift ? s.uppercased() : s)
    if shift { setShift(false) }
    afterEdit()
  }

  private func backspace() {
    textDocumentProxy.deleteBackward()
    afterEdit()
  }

  private func afterEdit() {
    hideCoach()
    generation += 1
    debounce?.invalidate()
    debounce = Timer.scheduledTimer(withTimeInterval: CoachGate.debounce, repeats: false) { [weak self] _ in
      self?.maybeCheck()
    }
  }

  private var currentText: String {
    (textDocumentProxy.documentContextBeforeInput ?? "") + (textDocumentProxy.documentContextAfterInput ?? "")
  }

  // MARK: - Kouč

  private func maybeCheck() {
    let text = String(currentText.suffix(Self.maxChars))
    let url = SharedConfig.serverURL
    guard gate.shouldCheck(text, enabled: SharedConfig.coachEnabled, serverURL: url,
                           sensitive: CoachGate.isSensitive(textDocumentProxy.keyboardType),
                           fullAccess: hasFullAccess) else { return }
    gate.markChecked(text)
    let gen = generation
    CoachClient.coach(serverURL: url, text: text, token: SharedConfig.token) { [weak self] c in
      DispatchQueue.main.async {
        // Uživatel mezitím psal dál → odpověď patří k jinému textu.
        guard let self, gen == self.generation, let c, c.isHostile else { return }
        self.showCoach(c)
      }
    }
  }

  private func showCoach(_ c: Coaching) {
    coachLabel.text = NSLocalizedString("coach_warning", comment: "")
    coachBar.isHidden = false
    altPanel.arrangedSubviews.forEach { $0.removeFromSuperview() }
    if !c.why.isEmpty {
      let why = UILabel()
      why.text = c.why
      why.numberOfLines = 0
      why.font = .preferredFont(forTextStyle: .footnote)
      altPanel.addArrangedSubview(why)
    }
    for alt in c.alternatives {
      let b = UIButton(type: .system)
      b.setTitle(alt, for: .normal)
      b.titleLabel?.numberOfLines = 0
      b.contentHorizontalAlignment = .leading
      b.addAction(UIAction { [weak self] _ in self?.replace(with: alt) }, for: .touchUpInside)
      altPanel.addArrangedSubview(b)
    }
    altPanel.isHidden = true
  }

  private func hideCoach() {
    coachBar.isHidden = true
    altPanel.isHidden = true
  }

  /// Nahradí rozepsaný text alternativou — jen na výslovné tapnutí.
  /// iOS dává jen omezený kontext kolem kurzoru; u velmi dlouhých zpráv se nahradí ta viditelná část.
  private func replace(with alt: String) {
    let after = textDocumentProxy.documentContextAfterInput ?? ""
    if !after.isEmpty { textDocumentProxy.adjustTextPosition(byCharacterOffset: after.count) }
    for _ in 0..<currentText.count { textDocumentProxy.deleteBackward() }
    textDocumentProxy.insertText(alt)
    gate.markChecked(alt)
    hideCoach()
  }

  // MARK: - UI

  private func buildCoachBar() -> UIStackView {
    coachBar.axis = .horizontal
    coachBar.spacing = 8
    coachBar.isHidden = true
    coachLabel.numberOfLines = 2
    coachLabel.font = .preferredFont(forTextStyle: .subheadline)
    coachLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    let show = UIButton(type: .system)
    show.setTitle(NSLocalizedString("coach_show", comment: ""), for: .normal)
    show.addAction(UIAction { [weak self] _ in self?.altPanel.isHidden = false }, for: .touchUpInside)
    let dismiss = UIButton(type: .system)
    dismiss.setTitle(NSLocalizedString("coach_dismiss", comment: ""), for: .normal)
    dismiss.addAction(UIAction { [weak self] _ in self?.hideCoach() }, for: .touchUpInside)
    [coachLabel, show, dismiss].forEach(coachBar.addArrangedSubview)
    return coachBar
  }

  private func row() -> UIStackView {
    let r = UIStackView()
    r.axis = .horizontal
    r.spacing = 4
    r.distribution = .fill
    r.heightAnchor.constraint(equalToConstant: 42).isActive = true
    return r
  }

  private func key(_ title: String, _ action: @escaping () -> Void) -> UIButton {
    let b = UIButton(type: .system)
    b.setTitle(title, for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 20)
    b.backgroundColor = .secondarySystemBackground
    b.layer.cornerRadius = 5
    b.addAction(UIAction { _ in action() }, for: .touchUpInside)
    return b
  }

  /// Přidá klávesy se šířkou v poměru k `weights` (1 = písmeno).
  private func add(_ keys: [(UIButton, CGFloat)], to r: UIStackView) {
    guard let unit = keys.first(where: { $0.1 == 1 })?.0 ?? keys.first?.0 else { return }
    for (b, w) in keys {
      r.addArrangedSubview(b)
      if b !== unit { b.widthAnchor.constraint(equalTo: unit.widthAnchor, multiplier: w).isActive = true }
    }
  }

  private func letterRow(_ chars: String) -> UIStackView {
    let r = row()
    add(chars.map { ch in
      let s = String(ch)
      let b = key(s) { [weak self] in self?.type(s) }
      if ch.isLetter { letterButtons.append(b) }
      return (b, 1)
    }, to: r)
    return r
  }

  private func shiftRow() -> UIStackView {
    let r = row()
    var keys: [(UIButton, CGFloat)] = [(key("⇧") { [weak self] in self?.setShift(!(self?.shift ?? false)) }, 1.5)]
    for ch in "yxcvbnm" {
      let s = String(ch)
      let b = key(s) { [weak self] in self?.type(s) }
      letterButtons.append(b)
      keys.append((b, 1))
    }
    keys.append((key("⌫") { [weak self] in self?.backspace() }, 1.5))
    add(keys, to: r)
    return r
  }

  private func bottomRow() -> UIStackView {
    let r = row()
    let globe = key("🌐") {}
    globe.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
    globe.isHidden = !needsInputModeSwitchKey
    add([
      (key(",") { [weak self] in self?.type(",") }, 1),
      (globe, 1.2),
      (key(NSLocalizedString("key_space", comment: "")) { [weak self] in self?.type(" ") }, 4),
      (key(".") { [weak self] in self?.type(".") }, 1),
      (key("?") { [weak self] in self?.type("?") }, 1),
      (key("↵") { [weak self] in self?.type("\n") }, 1.5),
    ], to: r)
    return r
  }

  private func setShift(_ on: Bool) {
    shift = on
    for b in letterButtons {
      let t = b.title(for: .normal) ?? ""
      b.setTitle(on ? t.uppercased() : t.lowercased(), for: .normal)
    }
  }
}
