# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
Karlsruhe
Karlsruhe
Erfurt
München
Leipzig
Kassel
Stuttgart
München
Berlin
Potsdam
Bremen
Hamburg
Wiesbaden
Schwerin
Hannover
Düsseldorf
Mainz
Saarbrücken
Dresden
Magdeburg
Kiel
Erfurt
16
Bundesrat
}
question_n4 = [
		"Wo befindet sich der Hauptsitz des Bundesverfassungsgerichts?",
"Wo befindet sich der Hauptsitz des Bundesgerichtshofes?",
"Wo befindet sich der Hauptsitz des Bundesarbeitsgerichts?",
"Wo befindet sich der Hauptsitz des Bundesfinanzhofs?",
"Wo befindet sich der Hauptsitz des Bundesverwaltungsgerichts?",
"Wo befindet sich der Hauptsitz des Bundessozialgerichts?",
"Wie heißt die Landeshauptstadt von Baden-Württemberg?",
"Wie heißt die Landeshauptstadt von Bayern?",
"Wie heißt die Landeshauptstadt von Berlin?",
"Wie heißt die Landeshauptstadt von Brandenburg?",
"Wie heißt die Landeshauptstadt von Bremen?",
"Wie heißt die Landeshauptstadt von Hamburg?",
"Wie heißt die Landeshauptstadt von Hessen?",
"Wie heißt die Landeshauptstadt von Mecklenburg-Vorpommern?",
"Wie heißt die Landeshauptstadt von Niedersachsen?",
"Wie heißt die Landeshauptstadt von Nordrhein-Westfalen?",
"Wie heißt die Landeshauptstadt von Rheinland-Pfalz?",
"Wie heißt die Landeshauptstadt von Saarland?",
"Wie heißt die Landeshauptstadt von Sachsen?",
"Wie heißt die Landeshauptstadt von Sachsen-Anhalt?",
"Wie heißt die Landeshauptstadt von Schleswig-Holstein?",
"Wie heißt die Landeshauptstadt von Thüringen?",
"Wieviele Bundesländer hat die Bundesrepublik Deutschland?",
"Über welches Organ wirken die Landesregierungen an der Gesetzgebung des Bundes mit?",

]



item_alternatives_n4 = [
		%w{Karlsruhe Kassel Leipzig München},
%w{Leipzig Karlsruhe München Erfurt},
%w{Berlin Dresden Erfurt München},
%w{Karlsruhe Kassel Leipzig München},
%w{Leipzig Karlsruhe München Erfurt},
%w{Karlsruhe Kassel Leipzig München},
%w{Freiburg Mannheim Stuttgart Ulm},
%w{Augsburg Erlangen Ingolstadt München},
%w{Berlin Bremen Hamburg München},
%w{Cottbus Potsdam Prenzlau Templin},
%w{Augsburg Berlin Bremen Hamburg},
%w{Augsburg Berlin Bremen Hamburg},
%w{Darmstadt Fulda Frankfurt\ am\ Main Wiesbaden},
%w{Greifswald Rostock Schwerin Stralsund},
%w{Braunschweig Hannover Lüneburg Salzgitter},
%w{Düsseldorf Essen Köln Wuppertal},
%w{Mainz Neuwied Trier Worms},
%w{Homburg Neunkirchen Saarbrücken Saarlouis},
%w{Chemnitz Dresden Leipzig Zwickau},
%w{Aschersleben Dessau Halle Magdeburg},
%w{Flensburg Husum Kiel Lübeck},
%w{Erfurt Gera Jena Mühlhausen},
%w{10 13 15 16},
%w{Bundespräsident Bundesrat Bundestag Bundesverfassungsgericht},
]

t = TestSEL.create(name: "Politiktest",  info: "Politiktest", short_info: "Politiktest",len: 1, time: 900, subject: "Deutsch", picture: "/images/politik.png", construct: "Probe", student_access:true, archive: false, level: "0")

i = t.items.build(itemtext: "Hallo", difficulty: 0, itemtype:-1, itemview: "items/studentbased/sinnentnehmender_lesetest/1hallo")
i.save

i = 0
while i<items_n4.size do
	it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", difficulty: 1, itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save