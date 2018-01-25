# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
Europa
Europa
Europa
Europa
Afrika
Afrika
Afrika
Afrika
Amerika
Amerika
Amerika
Amerika
Asien
Asien
Asien
Asien
Europa
Europa
Europa
Europa
Afrika
Afrika
Afrika
Afrika
Amerika
Amerika
Amerika
Amerika
Asien
Asien
Asien
Asien
Afrika
Amerika
Asien
Europa
Afrika
Asien
Nordamerika
Südamerika
21.3.
21.6.
23.9.
21.12.
11000
Pazifik
1957
2000
Aborigines
Australien
Murray\ River
Tiger


}
question_n4 = [
		"Auf welchem Kontinent fließt der Rhein?",
		"Auf welchem Kontinent fließt die Donau?",
		"Auf welchem Kontinent fließt die Loire?",
		"Auf welchem Kontinent fließt die Elbe?",
		"Auf welchem Kontinent fließt der Kongo?",
		"Auf welchem Kontinent fließt der Niger?",
		"Auf welchem Kontinent fließt der Nil?",
		"Auf welchem Kontinent fließt der Sambesi?",
		"Auf welchem Kontinent fließt der Amazonas?",
		"Auf welchem Kontinent fließt der Rio Grande?",
		"Auf welchem Kontinent fließt der Yukon",
		"Auf welchem Kontinent fließt der Orinoco?",
		"Auf welchem Kontinent fließt der Mekong?",
		"Auf welchem Kontinent fließt der Ganges?",
		"Auf welchem Kontinent fließt der Euphrat?",
		"Auf welchem Kontinent fließt die Lena?",
		"Die Pyrenäen sind ein Gebirge auf welchem Kontinent?",
		"Die Alpen sind ein Gebirge auf welchem Kontinent?",
		"Die Karpaten sind ein Gebirge auf welchem Kontinent?",
		"Der Apennin ist ein Gebirge auf welchem Kontinent?",
		"Der Atlas ist ein Gebirge auf welchem Kontinent?",
		"Die Drakensberge sind ein Gebirge auf welchem Kontinent?",
		"Das Ahaggar ist ein Gebirge auf welchem Kontinent?",
		"Das Pare-Gebirge liegt auf welchem Kontinent?",
		"Die Rocky Mountains sind ein Gebirge auf welchem Kontinent?",
		"Die Anden sind ein Gebirge auf welchem Kontinent?",
		"Die Appalachen sind ein Gebirge auf welchem Kontinent?",
		"Die Sierra Madre des Sur ein Gebirge auf welchem Kontinent?",
		"Der Himalaya ist ein Gebirge auf welchem Kontinent?",
		"Der Hindukusch ist ein Gebirge auf welchem Kontinent?",
		"Der Altai ist ein Gebirge auf welchem Kontinent?",
		"Der Tian Shan ist ein Gebirge auf welchem Kontinent?",
		"Der Kibo ist der höchste Berg welches Kontinents?",
		"Der Aconcagua ist der höchste Berg welches Kontinents?",
		"Der Mount Everest ist der höchste Berg welches Kontinents?",
		"Der Mont Blanc ist der höchste Berg welches Kontinents?",
		"Die Sahara liegt auf welchem Kontinent?",
		"Die Wüste Gobi liegt auf welchem Kontinent?",
		"Die Mojave-Wüste liegt auf welchem Kontinent?",
		"Die Atacama-Wüste liegt auf welchem Kontinent?",
		"Wann beginnt der Frühling auf der Nordhalbkugel?",
		"Wann beginnt der Sommer auf der Nordhalbkugel?",
		"Wann beginnt der Herbst auf der Nordhalbkugel?",
		"Wann beginnt der Winter auf der Nordhalbkugel?",
		"Wieviele Meter tief ist die tiefste Stelle am Meeresgrund (im Marianengraben) ungefähr?",
		"In welchem (Welt-)Meer liegt der Mariannengraben?",
		"In welchem Jahr wurde die Messung der tiefsten Stelle im Marianengraben durchgeführt?",
		"Wieviele Inseln umfasst das westpazifische Inselgebiet Mikronesien ungefähr?",
		"Wie heißen die Ureinwohner Australiens?",
		"Wo liegt das größte Korallenriff der Erde? (Great Barrier Reef)",
		"Der längste Fluss Australiens heißt?",
		"Welches dieser Tiere lebt nicht in Australien?",


]



item_alternatives_n4 = [
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Amerika Asien Europa},
		%w{Afrika Asien Nordamerika Südamerika},
		%w{Afrika Asien Nordamerika Südamerika},
		%w{Afrika Asien Nordamerika Südamerika},
		%w{Afrika Asien Nordamerika Südamerika},
		%w{21.3. 23.3. 21.4. 23.4.},
		%w{21.5. 21.6. 21.7. 21.8.},
		%w{23.8. 21.8. 23.9. 21.9.},
		%w{23.11. 21.11. 23.12. 21.12.},
		%w{3000 5000 8000 11.000},
		%w{Atlantik Ostchinesisches\ Meer Pazifik Totes\ Meer},
		%w{1957 1977 1997 2017},
		%w{1000 2000 3000 4000},
		%w{Azteken Aborigines Maya Inka},
		%w{Afrika Asien Australien Amerika},
		%w{Murray\ River Darling\ River Cooper\ Creek Lachlan\ River},
		%w{Känguru Koala Wombat Tiger},

]

t = Test.create(name: "Geographie",  info: "Geographietest", short_info: "Geographietest",len: 1, time: 900, subject: "Erdkunde", picture: "/images/Logos/welt.png", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
	if(i==0||i==1)
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemAchievement")
		it.save
		i = i+1
	else
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
		it.save
		i = i+1
	end
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save