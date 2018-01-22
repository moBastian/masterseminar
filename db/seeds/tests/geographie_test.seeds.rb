# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
9

}
question_n4 = [
		"Welche dieser Zahlen ist keine Primzahl?",

]



item_alternatives_n4 = [
		%w{3 5 7 9},

]

t = Test.create(name: "Geographietest",  info: "Geographietest", short_info: "Geographietest",len: 1, time: 900, subject: "Erdkunde", picture: "/images/Logos/welt.png", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save