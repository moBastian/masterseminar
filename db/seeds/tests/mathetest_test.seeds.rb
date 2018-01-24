# -*- encoding : utf-8 -*-

# Neue Elemente mit der festen Reihenfolge

items_n4 = %w{
9
45
81
21
2
23
11
97
-1
0,0001
1/20
1/2
26
4/6
0
13
1000
500
100
50
10
5
1
keine
1949
1492
4
13
15
21
30
84
13
2
1
16
3
9
6
0
9
18
9
4
3
4
9
1
225
0
1
100
5
1
2
-1
3>2
1>0
2/3>1/2
71>72/2
a^2\ +\ 2ab\ +\ b^2
a^2\ -\ 2ab\ +\ b^2
(a+b)(a-b)
3


}
question_n4 = [
		"Welche dieser Zahlen ist keine Primzahl?",
		"Welche dieser Zahlen ist keine Primzahl?",
		"Welche dieser Zahlen ist keine Primzahl?",
		"Welche dieser Zahlen ist keine Primzahl?",
		"Welche dieser Zahlen ist eine Primzahl?",
		"Welche dieser Zahlen ist eine Primzahl?",
		"Welche dieser Zahlen ist eine Primzahl?",
		"Welche dieser Zahlen ist eine Primzahl?",
		"Welche dieser Zahlen ist die kleinste?",
		"Welche dieser Zahlen ist die kleinste?",
		"Welche dieser Zahlen ist die kleinste?",
		"Welche dieser Zahlen ist die kleinste?",
		"Welche dieser Zahlen ist die größte?",
		"Welche dieser Zahlen ist die größte?",
		"Welche dieser Zahlen ist die größte?",
		"Welche dieser Zahlen ist die größte?",
		"Welcher Dezimalzahl entspricht die römische Zahl M?",
		"Welcher Zahl entspricht die römische Zahl D?",
		"Welcher Zahl entspricht die römische Zahl C?",
		"Welcher Zahl entspricht die römische Zahl L?",
		"Welcher Zahl entspricht die römische Zahl X?",
		"Welcher Zahl entspricht die römische Zahl V?",
		"Welcher Zahl entspricht die römische Zahl I?",
		"Welche römische Zahl entspricht der Dezimalzahl 0?",
		"Welcher Zahl entspricht die römische Zahl MCMXLIX?",
		"Welcher Zahl entspricht die römische Zahl MCDXCII?",
		"Welcher Zahl entspricht die römische Zahl IV?",
		"Welcher Zahl entspricht die römische Zahl XIII?",
		"Wie lautet das kleinste gemeinsame Vielfache von 3 und 5?",
		"Wie lautet das kleinste gemeinsame Vielfache von 7 und 21?",
		"Wie lautet das kleinste gemeinsame Vielfache von 10 und 15?",
		"Wie lautet das kleinste gemeinsame Vielfache von 3 und 28?",
		"Wie lautet der größte gemeinsame Teiler von 13 und 39?",
		"Wie lautet der größte gemeinsame Teiler von 24 und 38?",
		"Wie lautet der größte gemeinsame Teiler von 2 und 3?",
		"Wie lautet der größte gemeinsame Teiler von -48 und 16?",
		"Wenn die Quersumme einer Zahl durch 3 teilbar ist, so ist die Zahl selbst teilbar durch?",
		"Wenn die Quersumme einer Zahl durch 9 teilbar ist, so ist die Zahl selbst teilbar durch?",
		"Ist die Quersumme einer Zahl durch 3 teilbar und die Zahl selbst gerade, so ist die Zahl teilbar durch?",
		"Wie lautet die Quersumme von 0?",
		"Wie lautet die Quersumme von 18?",
		"Wie lautet die Quersumme von 45322?",
		"Wie lautet die Quersumme von 36?",
		"Wie lautet die Quersumme von 40",
		"Wie lautet die dritte Wurzel aus 27?",
		"Wie lautet die dritte Wurzel aus 64?",
		"Wie lautet die Quadratwurzel aus 81?",
		"Wie lautet die Quadratwurzel aus 1?",
		"Wie lautet das Quadrat von 15?",
		"Wie lautet das Quadrat von 0?",
		"Wie lautet das Quadrat von 1?",
		"Wie lautet das Quadrat von 10",
		"Wieviel ist 3 + 4 / 2?",
		"Wieviel ist 3/4 + 1/4?",
		"Wieviel ist 1 + 3 - 2?",
		"Wieviel ist 1 + (-2)?",
		"Was stimmt?",
		"Was stimmt?",
		"Was stimmt?",
		"Was stimmt?",
		"Die erste binomische Formel besagt: (a + b)^2 = …",
		"Die zweite binomische Formel besagt: (a - b)^2 = …",
		"Die dritte binomische Formel besagt: a^2 - b^2 = …",
		"Wieviele binomische Formeln gibt es?",


]



item_alternatives_n4 = [
		%w{3 5 7 9},
		%w{41 43 45 47},
		%w{79 81 83 89},
		%w{21 31 41 61},
		%w{2 4 8 16},
		%w{21 23 25 27},
		%w{9 10 11 12},
		%w{91 93 95 97},
		%w{0,1 -1 0 1},
		%w{0,1 0,01 0,001 0,0001},
		%w{1/3 1/7 1/20 1/2},
		%w{1/2 3/4 20/35 14/15},
		%w{-27 26 25 24},
		%w{1/2 1/8 1/4 4/6},
		%w{-13 -2 0 -5},
		%w{13 12 5 19/29},
		%w{50 100 500 1000},
		%w{50 100 500 1000},
		%w{50 100 500 1000},
		%w{50 100 500 1000},
		%w{0 1 5 10},
		%w{0 1 5 10},
		%w{0 1 5 10},
		%w{keine F M L},
		%w{1900 1949 1999 2001},
		%w{1492 1502 1902 2002},
		%w{1 2 3 4},
		%w{11 12 13 14},
		%w{8 12 15 25},
		%w{7 21 28 147},
		%w{10 15 25 30},
		%w{84 31 28 3},
		%w{1 3 13 39},
		%w{1 2 3 4},
		%w{1 2 3 23},
		%w{2 4 -16 16},
		%w{2 3 4 6},
		%w{4 6 8 9},
		%w{4 5 6 7},
		%w{0 1 2 -1},
		%w{1 8 9 10},
		%w{18 45 53 22},
		%w{3 6 8 9},
		%w{20 4 40 2},
		%w{3 9 18 27},
		%w{1 2 4 8},
		%w{3 5 7 9},
		%w{0 1 2 -1},
		%w{15 25 150 225},
		%w{0 1 -1 2},
		%w{0 1 -1 2},
		%w{10 11 100 110},
		%w{3 3,5 4 5},
		%w{1 2 3 4},
		%w{0 1 2 3},
		%w{-3 -1 1 3},
		%w{3>7 3>3 3>2 3>8},
		%w{1>2 1>0 -1>2 -1>1},
		%w{5/12>5/11 1/5>10/50 1/3>1/2 2/3>1/2},
		%w{10>11 71>72/2 13>31 11>111},
		%w{a b a^2\ +\ b^2 a^2\ +\ 2ab\ +\ b^2},
		%w{a a^2\ -\ 2ab\ +\ b^2 b a^2\ -\ b^2},
		%w{(a+b)(a-b) a b ab},
		%w{1 2 3 4},
]

t = Test.create(name: "Mathematik",  info: "Mathetest", short_info: "Mathetest",len: 1, time: 900, subject: "Mathe", picture: "/images/Logos/mathe.png", construct: "Probe", student_access:true, archive: false)

i= 0
while i<items_n4.size do
		it = t.items.build(itemtext: question_n4[i] + "{" + item_alternatives_n4[i].join(",") + "}", shorthand: items_n4[i], itemtype: 0, itemview: "items/studentbased/sinnentnehmender_lesetest/2testItemStudent")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/sinnentnehmender_lesetest/3ende")
it.save
t.save