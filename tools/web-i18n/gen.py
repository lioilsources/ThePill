#!/usr/bin/env python3
"""Generate docs/<lang>/{index,privacy,support}.html from tools/web-i18n/strings/<lang>.json
and add a language list to the Czech root pages (cs stays in docs/*.html).
Run from the repo root: python3 tools/web-i18n/gen.py"""
import html, json, os, re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
DOCS = os.path.join(ROOT, 'docs')
STR = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'strings')
MAIL = 'business@olin.now'
NAMES = {
    'cs': 'Čeština', 'en': 'English', 'ar': 'العربية', 'bn': 'বাংলা', 'ca': 'Català', 'da': 'Dansk',
    'de': 'Deutsch', 'el': 'Ελληνικά', 'es': 'Español', 'fi': 'Suomi', 'fr': 'Français', 'gu': 'ગુજરાતી',
    'he': 'עברית', 'hi': 'हिन्दी', 'hr': 'Hrvatski', 'hu': 'Magyar', 'id': 'Indonesia', 'it': 'Italiano',
    'ja': '日本語', 'kn': 'ಕನ್ನಡ', 'ko': '한국어', 'ml': 'മലയാളം', 'mr': 'मराठी', 'ms': 'Melayu',
    'nb': 'Norsk bokmål', 'nl': 'Nederlands', 'or': 'ଓଡ଼ିଆ', 'pa': 'ਪੰਜਾਬੀ', 'pl': 'Polski',
    'pt-BR': 'Português (Brasil)', 'pt-PT': 'Português (Portugal)', 'ro': 'Română', 'ru': 'Русский',
    'sk': 'Slovenčina', 'sl': 'Slovenščina', 'sv': 'Svenska', 'ta': 'தமிழ்', 'te': 'తెలుగు', 'th': 'ไทย',
    'tr': 'Türkçe', 'uk': 'Українська', 'ur': 'اردو', 'vi': 'Tiếng Việt', 'zh-Hans': '简体中文',
    'zh-Hant': '繁體中文',
}
RTL = {'ar', 'he', 'ur'}
CSS = """    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      background: #0b0f0d;
      color: #e8efe9;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      max-width: 720px;
      margin: 0 auto;
      padding: 60px 24px;
      line-height: 1.7;
    }
    body.home { text-align: center; }
    img { width: 128px; height: 128px; border-radius: 28px; margin-bottom: 24px; }
    h1 { font-size: 2rem; color: #7fd18b; margin-bottom: 24px; }
    body.home h1 { font-size: 2.2rem; margin-bottom: 8px; }
    h2 { font-size: 1.1rem; color: #7fd18b; margin: 32px 0 10px; }
    p, li { color: #c9d4cc; margin-bottom: 12px; }
    .status, .updated { color: #7c8a80; font-size: 0.9rem; }
    ol, ul { padding-inline-start: 20px; }
    a { color: #7aa7ff; }
    nav { margin-top: 40px; }
    nav a { margin: 0 12px; text-decoration: none; }
    footer { margin-top: 48px; padding-top: 24px; border-top: 1px solid #1f2a23; }
    footer a { color: #8a998f; text-decoration: none; }
    footer a:hover { color: #7fd18b; }
    .langs { margin-top: 24px; font-size: 0.85rem; line-height: 2; }
    .langs a { margin-inline-end: 10px; white-space: nowrap; }"""


def e(s): return html.escape(s, quote=False)


def mail_link(s):
    a = '<a href="mailto:%s">%s</a>' % (MAIL, MAIL)
    return e(s).replace('{mail}', a)


def langs_html(cur, prefix):
    out = []
    for code, name in NAMES.items():
        href = (prefix + 'index.html') if code == 'cs' else '%s%s/index.html' % (prefix, code)
        if code == cur:
            out.append('<strong>%s</strong>' % e(name))
        else:
            out.append('<a href="%s" hreflang="%s" lang="%s">%s</a>' % (href, code, code, e(name)))
    return '  <p class="langs">%s</p>\n' % ' '.join(out)


def page(code, kind, t):
    d = ' dir="rtl"' if code in RTL else ''
    pre = '../'
    title = {'index': 'The Pill', 'privacy': t['priv_title'] + ' — The Pill', 'support': t['sup_title'] + ' — The Pill'}[kind]
    b = []
    if kind == 'index':
        b.append('  <img src="../icon.png" alt="The Pill">\n  <h1>The Pill</h1>\n')
        b.append('  <p>%s</p>\n  <p class="status">%s</p>\n' % (e(t['lp_tagline']), e(t['lp_status'])))
        b.append('  <nav>\n    <a href="https://olin.now/thepill">olin.now</a>\n    <a href="privacy.html">%s</a>\n    <a href="support.html">%s</a>\n  </nav>\n'
                 % (e(t['nav_privacy']), e(t['nav_support'])))
        b.append(langs_html(code, pre))
    elif kind == 'support':
        b.append('  <h1>%s</h1>\n\n  <h2>%s</h2>\n  <ol>\n' % (e(t['sup_title']), e(t['sup_h_enable'])))
        for k in ('sup_li_android', 'sup_li_ios', 'sup_li_app'): b.append('    <li>%s</li>\n' % e(t[k]))
        b.append('  </ol>\n\n  <h2>%s</h2>\n  <p>%s</p>\n\n  <h2>%s</h2>\n  <p>%s</p>\n'
                 % (e(t['sup_h_none']), e(t['sup_p_none']), e(t['sup_h_contact']), mail_link(t['sup_p_contact'])))
    else:
        b.append('  <h1>%s</h1>\n  <p class="updated">%s</p>\n  <p>%s</p>\n  <ul>\n' % (e(t['priv_title']), e(t['priv_updated']), e(t['priv_intro'])))
        for k in ('priv_li1', 'priv_li2', 'priv_li3', 'priv_li4'): b.append('    <li>%s</li>\n' % e(t[k]))
        b.append('  </ul>\n  <p>%s <a href="mailto:%s">%s</a></p>\n' % (e(t['priv_contact']), MAIL, MAIL))
    if kind != 'index':
        if code in RTL: t = dict(t, back=t['back'].replace('←', '→'))
        other = ('privacy', t['nav_privacy']) if kind == 'support' else ('support', t['nav_support'])
        b.append('\n  <footer>\n    <a href="index.html">%s</a> &nbsp;·&nbsp;\n    <a href="%s.html">%s</a>\n  </footer>\n' % (e(t['back']), other[0], e(other[1])))
    return ('<!DOCTYPE html>\n<html lang="%s"%s>\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
            '  <title>%s</title>\n  <style>\n%s\n  </style>\n</head>\n<body%s>\n%s</body>\n</html>\n'
            % (code, d, e(title), CSS, ' class="home"' if kind == 'index' else '', ''.join(b)))


KEYS = None
for code in NAMES:
    if code == 'cs': continue
    t = json.load(open(os.path.join(STR, code + '.json'), encoding='utf-8'))
    if KEYS is None: KEYS = set(t)
    assert set(t) == KEYS, code
    assert '{mail}' in t['sup_p_contact'], code
    os.makedirs(os.path.join(DOCS, code), exist_ok=True)
    for kind in ('index', 'privacy', 'support'):
        with open(os.path.join(DOCS, code, kind + '.html'), 'w', encoding='utf-8') as f:
            f.write(page(code, kind, t))

# language list in the Czech root pages (idempotent)
for kind in ('index', 'privacy', 'support'):
    p = os.path.join(DOCS, kind + '.html')
    s = open(p, encoding='utf-8').read()
    s = re.sub(r'  <!-- langs -->.*?<!-- /langs -->\n', '', s, flags=re.S)
    block = '  <!-- langs -->\n' + langs_html('cs', '') + '  <!-- /langs -->\n'
    s = s.replace('</body>', block + '</body>', 1)
    if '.langs' not in s:
        s = s.replace('  </style>', '    .langs { margin-top: 24px; font-size: 0.85rem; line-height: 2; text-align: center; }\n    .langs a { margin-right: 10px; white-space: nowrap; }\n  </style>', 1)
    open(p, 'w', encoding='utf-8').write(s)
print('ok')
