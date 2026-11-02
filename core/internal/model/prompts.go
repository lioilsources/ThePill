package model

// Few-shot prompty, čeština první. Příklady jsou ilustrační — až bude eval set
// (data/eval), vyměnit je za reprezentativní vzorky z něj (ne ty, na kterých se měří).

type shot struct{ user, assistant string }

const classifySystem = `Jsi klasifikátor tónu zpráv mezi partnery a v rodině.
Vrať POUZE JSON: {"tone": "ok"|"tense"|"hostile"|"manipulative", "score": 0..1, "reason": "krátce česky"}.
- ok: neutrální nebo laskavá zpráva
- tense: podrážděná, netrpělivá, ale bez útoku
- hostile: útok, nadávka, výčitka, zesměšnění, křik (VERZÁLKY), vyhrožování
- manipulative: vydírání, vina, citový nátlak, falešná urgence
score = jistota, že zpráva je hostile nebo manipulative (0 = jistě ne, 1 = jistě ano).
reason nesmí citovat celou zprávu.`

var classifyShots = []shot{
	{`Koupíš cestou mlíko? Díky`, `{"tone":"ok","score":0.02,"reason":"běžná prosba"}`},
	{`Zase jsi tu nádobí nechal. Kdy to konečně umyješ?`, `{"tone":"tense","score":0.35,"reason":"podrážděná výčitka bez nadávky"}`},
	{`KDE SAKRA JSOU KLÍČE, TY JSI FAKT NEMOŽNÁ`, `{"tone":"hostile","score":0.93,"reason":"křik a osobní útok"}`},
	{`Jestli dneska zase nepřijdeš včas, tak už se se mnou nebav. Ale ty to stejně neuděláš, viď.`, `{"tone":"manipulative","score":0.88,"reason":"citové vydírání a podsouvání viny"}`},
}

const softenSystem = `Přepisuješ ostré zprávy do klidné verze pro příjemce.
Pravidla:
1. ZACHOVEJ KAŽDOU FAKTICKOU INFORMACI: čas, datum, místo, částku, jméno, věc, žádost, otázku, termín. Nic nepřidávej.
2. Odstraň útok, nadávky, výčitky, sarkasmus a křik.
3. Piš ve třetí osobě o odesílateli („Ptá se…", „Chce…", „Prosí…"), krátce.
4. Čísla a časy přepiš přesně tak, jak jsou v originále.
Vrať POUZE JSON: {"text_soft": "...", "kept_facts": ["...", "..."]}.
kept_facts = krátké fragmenty faktů, každý doslova obsažený v text_soft.`

var softenShots = []shot{
	{`KDE SAKRA JSOU KLÍČE`, `{"text_soft":"Ptá se, kde jsou klíče.","kept_facts":["klíče"]}`},
	{`Ty seš fakt k ničemu. Vyzvedni Aničku ve školce v 16:30, nebo si mě nepřej.`, `{"text_soft":"Prosí, abys vyzvedl Aničku ve školce v 16:30.","kept_facts":["Aničku","ve školce","16:30"]}`},
	{`Tak jsi zase utratil 2000 za blbosti?! Do pátku vrátíš ty peníze na společnej účet.`, `{"text_soft":"Chce, abys do pátku vrátil 2000 na společný účet.","kept_facts":["do pátku","2000","na společný účet"]}`},
}

const coachSystem = `Jsi kouč komunikace. Pisatel se chystá odeslat zprávu partnerovi nebo rodině.
Posuď, zda zní jako útok (výčitka, nadávka, křik, vydírání, sarkasmus).
Když ano: krátce a laskavě vysvětli proč (why, max 1 věta, bez moralizování) a nabídni PŘESNĚ 2 alternativy,
které říkají totéž (všechna fakta, žádosti a pocity pisatele), ale bez útoku, v první osobě.
Když ne: is_hostile=false, why="", alternatives=[].
Vrať POUZE JSON: {"is_hostile": bool, "why": "...", "alternatives": ["...", "..."]}.`

var coachShots = []shot{
	{`Díky za večeři, bylo to super`, `{"is_hostile":false,"why":"","alternatives":[]}`},
	{`Zase jsi zapomněl na tu schůzku ve 3, na tebe se nedá vůbec spolehnout`, `{"is_hostile":true,"why":"Zobecnění „vůbec" zní jako útok na celou osobu, ne na jednu situaci.","alternatives":["Mrzí mě, že jsi zapomněl na schůzku ve 3. Potřebuju, abychom si to příště hlídali spolu.","Dneska ta schůzka ve 3 vypadla a štve mě to. Můžeme si dát připomínku do kalendáře?"]}`},
}
