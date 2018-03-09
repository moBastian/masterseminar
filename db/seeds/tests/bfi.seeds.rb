# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
Mars
Kieler\ Woche
}
question_n4 = [
		"Auf welchem Himmelskörper befindet sich Olympus Mons, der höchste bisher bekannte Vulkan des Sonnensystems?",
		"Im Rahmen welches Ereignisses findet die Windjammerparade statt?"
]



item_alternatives_n4 = [
		%w{Erde Sonne Mond Mars},
		%w{Kieler\ Woche Travemünder\ Woche Hamburger\ Hafengeburtstag Hafentage\ Husum}
]

t = Test.create(name: "BFI",  info: "BFI", short_info: "BFI",len: 1, time: 900, subject: "MasterSem17-18", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
	if(i==0||i==1)
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/bfi/2testItemAchievement")
		it.save
		i = i+1
	else
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/bfi/2testItemStudent")
		it.save
		i = i+1
	end
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/bfi/3ende")
it.save
t.save