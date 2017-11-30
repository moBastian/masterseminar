# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
	Augen
	fleißig
	Sobald
	Blumen
	schmeckt
	In
	Schere
	Haus
	wegen
	bevor
}
before_gap_part_n4 = [
		"Ein Gesicht hat zwei",
		"Meine Schwester lernt immer",
		"",
		"Die",
		"Der Kuchen",
		"",
		"Die",
		"Meine Freundin zieht in ein neues",
		"Wir können",
		"Ich putze meine Zähne,",

]


after_gap_part_n4 = [
		".",
		".",
		"ich fertig bin, melde ich mich bei dir.",
		"blühen auf der Wiese.",
		"uns allen gut.",
		"dem Schloss wohnt ein Geist.",
		"schneidet das Papier.",
		"um.",
		"dem schlechten Wetter nicht zu euch kommen.",
		"ich ins Bett gehe.",

]

item_alternatives_n4 = [
		%w{ Augen  Bücher  Autos  Finger  },
		%w{ dünn  grün  flach  fleißig  },
		%w{ Und  Doch  Sobald  Darum  },
		%w{ Jungen  Vögel  Stühle  Blumen  },
		%w{ riecht  trinkt  wählt  schmeckt  },
		%w{ Aus  Im  Durch  In  },
		%w{ Schere  Stirn  Pizza  Zwiebel  },
		%w{ Haus  Hemd  Beet  Heft  },
		%w{ wegen  hinter  über  für  },
		%w{ bald  davon  bevor  nachdem  },

]
categories_n4 = %W{
	1
	2
	3
	1
	2
	3
	1
	1
	3
	3
}

t = TestSEL.create(name: "Sinnentnehmendes Lesen",  info: "Sinnentnehmendes Lesen N4", short_info: "Sinnentnehmendes Lesen N4",len: 63, time: 480, subject: "Deutsch", construct: "Sinnentnehmendes Lesen", student_access:true, archive: false, level: "N4")

i = t.items.build(itemtext: "Hallo", difficulty: 0, itemtype:-1, itemview: "items/studentbased/sinnentnehmender_lesetest/1hallo")
i.save

i = 0
while i<items_n4.size do
	it = t.items.build(itemtext: before_gap_part_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}" + after_gap_part_n4[i], shorthand: items_n4[i], difficulty: categories_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", difficulty: 1, itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save