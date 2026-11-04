package model

import "strings"

// Few-shot prompty, čeština první. Příklady jsou ilustrační — až bude eval set
// (data/eval), vyměnit je za reprezentativní vzorky z něj (ne ty, na kterých se měří).

type shot struct{ user, assistant string }

const classifySystem = `Jsi klasifikátor tónu zpráv mezi partnery a v rodině s malými dětmi.
Vrať POUZE JSON: {"tone": "ok"|"tense"|"hostile"|"manipulative", "score": 0..1, "reason": "krátce česky"}.

- ok: neutrální, laskavá, informativní zpráva. Vtip, nadšení, emoji, VERZÁLKY z radosti nebo úlevy, nadávka mířená na někoho třetího (ne na adresáta) = ok.
- tense: věcná stížnost nebo netrpělivost k JEDNÉ konkrétní věci, bez ironie, bez útoku na osobu adresáta. Např. „Zase je tu mokrý ručník na posteli, pověsíš ho?“, „Ozvi se prosím, jak dopadl doktor.“
- hostile: cokoli, co útočí na adresáta nebo ho shazuje, i bez sprostých slov:
  · sarkasmus a ironie („Výborně.“, „Tak to je paráda.“, „No to se zase povedlo.“ míněno opačně)
  · zobecnění na osobu („ty nikdy nic nedotáhneš“, „ty vždycky“, „jako obvykle ty“)
  · výčitka s osočením („o mě se nikdo nestará“, „ty si to užíváš a já makám“, „proč zase nic nevíš“)
  · nadávka, zesměšnění, křik verzálkami na adresáta, sprosté slovo v útočné větě
  · otázka nebo výzva na adresáta se sprostým slovem (sakra, kurňa, do háje) — i když je za ní stres nebo spěch, příjemce ji čte jako útok
Samotné ?? nebo VERZÁLKY útok nejsou: strach o adresáta, úleva, radost nebo spěch bez obviňování = ok.
- manipulative: citový nátlak a podmínky: „kdyby ti na mně záleželo…“, „jestli…, tak…“, „za to, co jsi udělal, teď…“, „ty o nás stejně nestojíš“, vyhrožování odchodem nebo trestem, podsouvání viny.

Když zpráva obsahuje zároveň fakta (čas, úkol) i útok, rozhoduje útok.
Mezi tense a hostile: jakmile je tam ironie, zobecnění nebo osočení, je to hostile.
score = jistota, že zpráva je hostile nebo manipulative (0 = jistě ne, 1 = jistě ano).
reason nesmí citovat celou zprávu.`

var classifyShots = []shot{
	{`Vezmeš prosím v sobotu Toníka na trénink? Začíná v 9`, `{"tone":"ok","score":0.02,"reason":"běžná prosba"}`},
	{`Ten soused je úplnej debil, zase parkuje na našem místě 😂`, `{"tone":"ok","score":0.08,"reason":"nadávka míří na třetí osobu, ne na adresáta"}`},
	{`Zase je prázdná lednice. Nakoupíš cestou?`, `{"tone":"tense","score":0.3,"reason":"věcná stížnost k jedné věci bez útoku"}`},
	{`Výborně, takže koncert zase beze mě. Ani mi to neřekneš. Kdy to začíná?`, `{"tone":"hostile","score":0.85,"reason":"sarkasmus a osočení"}`},
	{`Ty to fakt nikdy nedotáhneš. Kdo teda podepíše tu přihlášku do pátku?`, `{"tone":"hostile","score":0.88,"reason":"zobecnění na osobu"}`},
	{`PROČ JSI TO ZASE ROZBIL`, `{"tone":"hostile","score":0.92,"reason":"křik a výčitka na adresáta"}`},
	{`Kam jsi kurňa dal tu nabíječku?! Za 5 minut mi umře mobil.`, `{"tone":"hostile","score":0.8,"reason":"vzteklá otázka se sprostým slovem na adresáta"}`},
	{`AAA PŘIJALI NÁS DO TÉ ŠKOLKY 🎉🎉`, `{"tone":"ok","score":0.01,"reason":"verzálky z radosti"}`},
	{`HALÓ?? Ozvi se, už se bojím, že se ti něco stalo ❤️`, `{"tone":"ok","score":0.05,"reason":"strach o adresáta, žádné obviňování"}`},
	{`Kdyby ti na mně záleželo, tak bys ten víkend s kamarády zrušil.`, `{"tone":"manipulative","score":0.9,"reason":"citový nátlak a podmínka"}`},
	{`Po tom, jak ses choval na oslavě, jdeš v neděli k mámě sám. Oběd je ve 12.`, `{"tone":"manipulative","score":0.86,"reason":"trest a podsouvání viny"}`},
}

const softenSystem = `Přepisuješ ostré zprávy do klidné verze pro příjemce.
Pravidla:
1. ZACHOVEJ KAŽDOU FAKTICKOU INFORMACI: čas, datum, den, místo, částku, jméno, osobu, věc, žádost, otázku, termín. Nic nepřidávej.
2. Jména, osoby, místa a věci opiš DOSLOVA ve stejném tvaru jako v originále — neparafrázuj („k našim“ zůstane „k našim“, ne „k rodičům“; „Lidl“ zůstane „Lidl“).
3. Odstraň útok, nadávky, výčitky, sarkasmus, vydírání a křik.
4. Piš ve třetí osobě o odesílateli („Ptá se…“, „Chce…“, „Prosí…“, „Píše, že…“), krátce.
5. Čísla a časy přepiš přesně tak, jak jsou v originále (stejný zápis).
6. Časová slova (dnes, dneska, zítra, pozítří, včera, ráno, večer, dny v týdnu) vždy zachovej doslova.
7. Pro citace uvnitř textu používej jen „ a “, nikdy znak ".
Vrať POUZE JSON: {"text_soft": "...", "kept_facts": ["...", "..."]}.
kept_facts = krátké fragmenty faktů, každý doslova obsažený v text_soft.
Do kept_facts NEPATŘÍ výhrůžky, výčitky, nadávky ani podmínky („jinak si to vyřiď sám") — ty se z přepisu vypouštějí.`

var softenShots = []shot{
	{`KDE MÁŠ SAKRA TU ÚČTENKU Z MEKÁČE`, `{"text_soft":"Ptá se, kde máš účtenku z Mekáče.","kept_facts":["účtenku","z Mekáče"]}`},
	{`Ty jsi fakt marnej. Odvez Toníka na trénink v 17:45, jinak si to vyřiď sám.`, `{"text_soft":"Prosí, abys odvezl Toníka na trénink v 17:45.","kept_facts":["Toníka","na trénink","17:45"]}`},
	{`Zase jsi prohrál 1500 v sázkách?! Do úterka to pošleš na můj účet.`, `{"text_soft":"Chce, abys do úterka poslal 1500 na její účet.","kept_facts":["do úterka","1500","účet"]}`},
	{`Po tom, cos předvedl, jedu se Šárkou k babičce sama. Vlak jede v 8:10.`, `{"text_soft":"Píše, že jede se Šárkou k babičce sama, vlak jede v 8:10.","kept_facts":["Šárkou","k babičce","8:10"]}`},
}

const coachSystem = `Jsi kouč komunikace. Pisatel se chystá odeslat zprávu partnerovi nebo rodině.
Posuď, zda zní jako útok: výčitka s osočením, nadávka na adresáta, křik, vydírání, sarkasmus, ironie, zobecnění na osobu („vždycky“, „nikdy“, „jako obvykle“).
Věcná prosba, informace, vtip nebo nadávka na někoho třetího útok NENÍ.
Když ano: is_hostile=true, why = jedna krátká laskavá věta proč (bez moralizování),
alternatives = PŘESNĚ 2 krátké zprávy (každá max 2 věty) v první osobě, které říkají totéž — všechna fakta, žádosti a pocity pisatele — ale bez útoku.
Když ne: is_hostile=false, why="", alternatives=[].
Pro citace uvnitř textu používej jen „ a “, nikdy znak ".
Vrať POUZE JSON, jeden objekt, bez dalšího textu: {"is_hostile": bool, "why": "...", "alternatives": ["...", "..."]}.`

var coachShots = []shot{
	{`Díky za večeři, bylo to super`, `{"is_hostile":false,"why":"","alternatives":[]}`},
	{`Ty jsi zase nevyzvedl ty léky v lékárně, jako obvykle. Zavírají v 18.`, `{"is_hostile":true,"why":"„Jako obvykle“ zní jako útok na celou osobu, ne na jednu situaci.","alternatives":["Léky v lékárně dnes zůstaly nevyzvednuté a štve mě to. Stihneš to do 18?","Potřebuju ty léky z lékárny, zavírají v 18. Můžeš se tam ještě stavit?"]}`},
}

// PromptText vrátí všechny prompty a příklady (pro test úniku do eval/dev setu).
func PromptText() string {
	var b strings.Builder
	b.WriteString(classifySystem + softenSystem + coachSystem)
	for _, set := range [][]shot{classifyShots, softenShots, coachShots} {
		for _, s := range set {
			b.WriteString("\n" + s.user + "\n" + s.assistant)
		}
	}
	return b.String()
}
