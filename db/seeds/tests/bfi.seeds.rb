# -*- encoding : utf-8 -*-


questions = [
"Ich bin eher zurückhaltend, reserviert.",
"Ich schenke anderen leicht Vertrauen, glaube an das Gute im Menschen.",
"Ich bin bequem, neige zur Faulheit.",
"ich bin entspannt, lasse mich durch Stress nicht aus der Ruhe bringen.",
"Ich habe nur wenig künstlerisches Interesse.",
"Ich gehe aus mir heraus, bin gesellig.",
"Ich neige dazu, andere zu kristisieren.",
"Ich erledige Aufgaben gründlich.",
"Ich werde leicht nervös und unsicher.",
"Ich habe eine aktive Vorstellungskraft, bin fantasievoll.",
]


t = Test.create(name: "BFI",  info: "BFI", short_info: "BFI",len: 1, time: 900, subject: "MasterSem17-18", construct: "Probe", student_access:true, archive: false)

i= 0
while i<questions.size do
	it = t.items.build(itemtext: questions[i], shorthand: questions[i], itemtype: 0, itemview: "items/studentbased/bfi/survey")
	it.save
	i = i+1
end

it = t.items.build(itemtext: "Ende", itemtype:1, itemview:"items/studentbased/bfi/3ende")
it.save
t.save