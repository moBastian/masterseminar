# -*- encoding : utf-8 -*-

tN1 = Test.create(name: "Zahlen lesen", len: 11, info: "", short_info: "", time: 60, subject: "Mathematik", construct: "Zahlen lesen", level: "Niveaustufe 1",type_info:"Speed-Test", archive: false, student_access: false)

it = tN1.items.build(itemtext: "Preparation", difficulty: 0, itemtype:-1, itemview:"items/userbased/preparationUser")
it.save

(0..10).to_a.each do |i|
  it = tN1.items.build(itemtext: i.to_s, difficulty: 0, itemtype: 0, itemview:"items/userbased/testItemUser")
  it.save
end

it = tN1.items.build(itemtext: "Ende", difficulty: 0, itemtype:1, itemview:"items/userbased/endItemUser")
it.save


tN1.save
