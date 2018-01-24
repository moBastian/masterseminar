# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
Ahorn
Buche
Linde
Eiche
Weide
Kastanie
Pappel
Birke
Fichte
Tanne
Zeder
Zypresse
Kiefer
Eibe
Lärche
Wacholder
Eibe
Eiche
Esche
Kiefer
Linde
Tanne
Walnussbaum
Zypresse
Ahorn
Apfelbaum
Birke
Fichte
Hainbuche
Pappel
Rosskastanie
Weide
Amerika
Afrika
Mittelmeerraum
geringe\ Frostfestigkeit
Minnesota
Birne
Mirabelle
Dattel
Fliegenpilz
Gifthäubling
Erlenkrempling
Satansröhrling
Frostrasling
Eselsohr
Brätling
Birkenpilz


}
question_n4 = [
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Laubbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Nadelbaum?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Pfahlwurzler (Tiefwurzler)?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Welcher dieser Bäume ist ein Flachwurzler?",
		"Von welchem Kontinent stammt Vanille ursprünglich?",
		"Wo liegen heute die Hauptanbaugebiete für Vanille?",
		"Woher stammt Rosmarin ursprünglich?",
		"Was erschwerte die Kultivierung von Rosmarin nördlich der Alpen?",
		"In welchem dieser Bundesstaaten gilt der Tulpenbaum nicht als bundesstaatliches Wahrzeichen?",
		"Welche dieser Obstsorten ist kein Steinobst?",
		"Welche dieser Obstsorten ist kein Kernobst?",
		"Welche dieser Obstsorten ist Beerenobst?",
		"Welcher dieser Pilze ist giftig?",
		"Welcher dieser Pilze ist giftig?",
		"Welcher dieser Pilze ist giftig?",
		"Welcher dieser Pilze ist giftig?",
		"Welcher dieser Pilze ist essbar?",
		"Welcher dieser Pilze ist essbar?",
		"Welcher dieser Pilze ist essbar?",
		"Welcher dieser Pilze ist essbar?",

]



item_alternatives_n4 = [
		%w{Ahorn Fichte Zeder Kiefer},
		%w{Eibe Buche Lärche Kiefer},
		%w{Zeder Zypresse Linde Lärche},
		%w{Fichte Eibe Kiefer Eiche},
		%w{Wacholder Tanne Weide Fichte},
		%w{Kiefer Lärche Eibe Kastanie},
		%w{Pappel Fichte Zeder Kiefer},
		%w{Kiefer Birke Tanne Fichte},
		%w{Fichte Ahorn Linde Birke},
		%w{Ahorn Birke Linde Tanne},
		%w{Weide Eiche  Zeder Pappel},
		%w{Pappel Zypresse Kastanie Linde},
		%w{Linde  Kiefer Eiche Weide},
		%w{Ahorn Buche Eibe Eiche},
		%w{Eiche Buche Birke Lärche},
		%w{Wacholder Weide Kastanie Pappel},
		%w{Eibe Birke Ahorn Pappel},
		%w{Weide Fichte Apfelbaum Eiche},
		%w{Fichte Hainbuche Esche Weide},
		%w{Fichte Kiefer Birke Pappel},
		%w{Linde Ahorn Rosskastanie Pappel},
		%w{Apfelbaum Birke Fichte Tanne},
		%w{Fichte Walnussbaum Hainbuche Rosskastanie},
		%w{Ahorn Weide Zypresse Fichte},
		%w{Ahorn Eiche Esche Linde},
		%w{Kiefer Eiche Tanne Apfelbaum},
		%w{Walnussbaum Zypresse Birke Esche},
		%w{Kiefer Fichte Tanne Linde},
		%w{Kiefer Linde Tanne Hainbuche},
		%w{Pappel Tanne Eibe Zypresse},
		%w{Kiefer Rosskastanie Walnussbaum Zypresse},
		%w{Kiefer Tanne Weide Zypresse},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Alpen Feuerland Mittelmeerraum Skandinavien },
		%w{Blattfarbe Bodenarten Wassertemperatur geringe\ Frostfestigkeit},
		%w{Indiana Kentucky Minnesota Tennessee},
		%w{Aprikose Pflaume Kirsche Birne},
		%w{Mirabelle Birne Olive Quitte},
		%w{Apfel Dattel Kirsche Nektarine},
		%w{Frostrasling Eselsohr Fliegenpilz Birkenpilz},
		%w{Gifthäubling Herbstlorchel Habichtspilz Judasohr},
		%w{Birkenpilz Erlenkrempling Eichenrotkappe Buchenrasling},
		%w{Butterpilz Pfifferling Riesenbovist Satansröhrling},
		%w{Frostrasling Riesenrötling Pantherpilz Fliegenpilz},
		%w{Nebelkappe Eselsohr Fliegenpilz Gifthäubling},
		%w{Graukappe Feldtrichterling Brätling Lila\ Dickfuß},
		%w{Pantherpilz Fliegenpilz Riesenrötling Birkenpilz},


]

t = Test.create(name: "Tiere&Pflanzen",  info: "Tiere&Pflanzen-Test", short_info: "Tiere&Pflanzen-Test",len: 1, time: 900, subject: "Biologie", picture: "/images/Logos/tier_pflanze.png", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save