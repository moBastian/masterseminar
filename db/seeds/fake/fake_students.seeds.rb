#Seeds um fakeprobanden anzulegen für den angegeben Nutzer
#hier passende Mail eingeben
#user = User.find_by_email("test@test.com")
user = User.find_by_email("stu114712@mail.uni-kiel.de")
#hier passenden Namen der Gruppe angeben
#group = Group.where(user_id: user, name:"1Test").first
group = Group.where(user_id: user, name:"1quiz").first

#Array für Usernamen
usernames = %w{
FakeLobster
Victorc
Lupita
Emilia
Von6
Galaxygaming72
Patrik
Jan-Hendrik
user18
user48
Erhart\ Daschner
Mina
Hansine
Alina
Kokahontas13
Serhat
Leon
Cadrick
user72
Nina\ Busch
Ranya
Jin
Alisar
Nekoroms_9000
Pia46
Mark
Edward
user96
Raoul\ Fisch
Tama
Keyla
Ava
Selfowned
Caide_
Nils
Gianmarco
Eirene
Themajesticpie
Bobbygeeeeee
Rasmus
}

scores = %w{
642
571
533
513
490
451
431
414
398
357
331
330
288
252
221
212
210
200
154
113
102
99
85
84
71
47
44
41
36
34
34
29
26
25
17
14
4
4
3
0
}

playedQ = %w{
963
856
799
769
735
676
646
621
597
535
496
495
432
378
331
318
315
300
231
169
153
148
127
126
106
70
66
61
54
51
51
43
39
37
25
21
6
6
4
0
}

logins = %w{
#1
#2
#3
#4
#5
#6
#7
#8
#9
#10
#11
#12
#13
#14
#15
#16
#17
#18
#19
#20
#21
#22
#23
#24
#25
#26
#27
#28
#29
#30
#31
#32
#33
#34
#35
#36
#37
#38
#39
#40
}

i = 0
while(i<usernames.size)
  s = group.students.build(name: usernames[i], group_type: -1, gender:"empty", points:scores[i], played_questions:playedQ[i])
  s.save
  i = i+1
end
