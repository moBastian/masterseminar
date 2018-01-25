# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
330
18-29
58
USA
2
1,4
300
20
800
11
60
25
178
400
Nordamerika
44
48
3,5
Island
China
100
15
4
250.000
150.000
75.000
450.000
2600
2005
300
1300
20

}
question_n4 = [
		"Wieviele monatlich aktive Nutzer hat Twitter? (in Millionen)",
		"In welchem Alter ist die größte Nutzergruppe von Twitter? (36%)",
		"Wieviel Prozent der Twitternutzer nutzen die Mobile App?",
		"Mit 21% (ca. 70 Millionen) stammt die größte Nutzergruppe von Twitter aus?",
		"Wieviele monatlich aktive Nutzer hatte Facebook Ende 2017? (in Milliarden)",
		"Wieviele Nutzer griffen Ende 2017 täglich auf Facebook zu? (in Milliarden)",
		"Wieviele Millionen Menschen in Europa sind auf Facebook vertreten?",
		"Wieviele Minuten verbringen Nutzer auf Facebook im Durchschnitt?",
		"Wieviele Millionen Nutzer hatte Instagram 2017?",
		"Wieviele Millionen Likes hatte der 2017 beliebteste Instagram-Post?",
		"Wieviel Prozent der Instagram-Nutzer sind zwischen 18 und 29 Jahren alt?",
		"Wieviel Prozent der eingeblendeten Werbung auf Instagram sind Einzelvideos?",
		"Wieviele täglich aktive Nutzer hatte Snapchat Ende 2017? (in Millionen)",
		"Wieviel Umsatz erzeugte Snapchat 2016? (in Millionen US-Dollar)",
		"Aus welcher Region kommen die meisten täglich aktiven Snapchat-Nutzer?",
		"Nach wievielen Monaten hatte Snapchat 100 Millionen Nutzer?",
		"Wieviel % der Internetnutzer kamen bereits 2013 aus Asien?",
		"Wieviele Menschen hatten 2016 zu Hause Internetzugang? (in Milliarden)",
		"In welchem Land hatten 2016 die meisten Menschen Internetzugang? (nahezu 100%)",
		"Welches Land hat die meisten Internetnutzer?",
		"Wieviele Millionen Spammails wurden Mitte 2017 pro Minute versandt?",
		"Wieviele Millionen Textnachrichten wurden Mitte 2017 pro Minute im Internet versandt?",
		"Wieviele Millionen Youtube-Videos wurden Mitte 2017 pro Minute angeschaut?",
		"Wieviele US-Dollar wurden Mitte 2017 pro Minute bei Amazon umgesetzt?",
		"Wieviele Anrufe via Skype wurden Mitte 2017 pro Minute getätigt?",
		"Wieviele Stunden Netflixvideos wurden Mitte 2017 pro Minute gestreamt?",
		"Wieviele Tweets wurden Mitte 2017 pro Minute versandt?",
		"Wieviel Datenvolumen wurde Mitte 2017 pro Minute allein durch US-Amerikaner genutzt? (in Tausend Gigabyte)",
		"Wann wurde das erste Youtube-Video hochgeladen?",
		"Wieviele Stunden Videomaterial werden pro Minute auf Youtube hochgeladen?",
		"Wieviele Menschen nutzen Youtube? (in Millionen)",
		"Wieviel Prozent aller geschauten Videos auf Youtube werden nach 10 Sekunden geschlossen?",


]



item_alternatives_n4 = [
		%w{110 220 330 440},
		%w{18-29 30-49 50-64 65+},
		%w{28 38 48 58},
		%w{Deutschland USA China Indien},
		%w{1 2 3 4},
		%w{0,4 1 1,4 2},
		%w{50 100 200 300 },
		%w{20 30 40 50},
		%w{600 700 800 900},
		%w{1 5 8 11},
		%w{40 60 80 100},
		%w{25 50 75 100},
		%w{63 118 178 255},
		%w{300 400 500 600},
		%w{Nordamerika Europa Asien Afrika},
		%w{14 24 34 44},
		%w{28 48 68 88},
		%w{1,5 2,5 3,5 4,5},
		%w{China Deutschland Indien Island},
		%w{China Indien Russland USA},
		%w{10 50 100 150},
		%w{5 15 25 35},
		%w{1 2 3 4},
		%w{250.000 500.000 1.000.000 5.000.000},
		%w{10.000 50.000 100.000 150.000},
		%w{25.000 50.000 75.000 100.000},
		%w{250.000 450.000 650.000 850.000},
		%w{2600 5400 10.800 25.000},
		%w{2005 2007 2009 2011},
		%w{200 300 400 500},
		%w{300 1000 1300 2000},
		%w{5 10 15 20},


]

t = Test.create(name: "Social Media",  info: "Social Media-Test", short_info: "Social Media-Test",len: 1, time: 900, subject: "Social Media", picture: "/images/Logos/social_media.png", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
	if(i==0)
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