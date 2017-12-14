# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
	Augen
	Wau
}
question_n4 = [
		"Womit sehen wir?",
    "Ein Hund macht?"
]



item_alternatives_n4 = [
		%w{ Augen Bücher Autos Finger},
		%w{ Miau Mähh Wau Muuh},
]

t = TestSEL.create(name: "Probetest",  info: "Probetest", short_info: "Probetest",len: 1, time: 900, subject: "Deutsch", construct: "Probe", student_access:true, archive: false, level: "0")

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