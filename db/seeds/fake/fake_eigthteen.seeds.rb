#hier passende Mail eingeben
#user = User.find_by_email("test@test.com")
user = User.find_by_email("stu114712@mail.uni-kiel.de")
#hier passenden Namen der Gruppe angeben
#group = Group.where(user_id: user, name:"1Test").first
group = Group.where(user_id: user, name:"1MaSem1718").first


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
}

i = 0
while(i<logins.size)

  achievement = {"a1"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_bronze.png","","Erstes Geographie-Quiz durchgeführt."], "a2"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_silber.png","","50% der Geographie-Fragen kennengelernt."],"a3"=>[false, "/images/Badges/empty.png", "/images/Badges/welt_gold.png","" ,"90% der Geographie-Fragen kennengelernt."],
                 "a4"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_bronze.png","","Erstes Mathe-Quiz durchgeführt."],"a5"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_silber.png","","50% der Mathe-Fragen kennengelernt."], "a6"=>[false, "/images/Badges/empty.png", "/images/Badges/mathe_gold.png","","90% der Mathe-Fragen kennengelernt."],
                 "a7"=>[false, "/images/Badges/erste_frage.png", "/images/Badges/erste_frage_bronze.png","noch nicht erreicht: Erste Frage richtig beantwortet.","Erste Frage richtig beantwortet."], "a8"=>[false, "/images/Badges/email.png", "/images/Badges/email_bronze.png","noch nicht erreicht: Logincode per Email zugeschickt.","Logincode per Email zugeschickt."],
                 "a9"=>[false, "/images/Badges/empty.png", "/images/Badges/geoCor_silber.png","","Sonnensystem-Frage richtig beantwortet."], "a10"=>[false, "/images/Badges/empty.png", "/images/Badges/matheCor_silber.png", "","Pi-Frage richtig beantwortet."],
                 "a11"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_bronze.png","","Erstes Politik-Quiz durchgeführt."],"a12"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_silber.png","","50% der Politik-Fragen kennengelernt."], "a13"=>[false, "/images/Badges/empty.png", "/images/Badges/politik_gold.png","","90% der Politik-Fragen kennengelernt."],
                 "a14"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_bronze.png", "", "Erstes Sport-Quiz durchgeführt."], "a15"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_silber.png","","50% der Sport-Fragen kennengelernt."], "a16"=>[false, "/images/Badges/empty.png", "/images/Badges/sport_gold.png", "", "90% der Sport-Fragen kennengelernt."],
                 "a17"=>[false, "/images/Badges/haus.png", "/images/Badges/haus_silber.png", "noch nicht erreicht: Erfolgreich erneut eingeloggt.","Erfolgreich erneut eingeloggt."],"a18"=>[false, "/images/Badges/kiel.png", "/images/Badges/kiel_silber.png", "noch nicht erreicht: Kiel-Frage richtig beantwortet.","Kiel-Frage richtig beantwortet."],
                 "a19"=>[false, "/images/Badges/empty.png", "/images/Badges/politikCor_silber.png","","Karlsruhe-Frage richtig beantwortet."], "a20"=>[false, "/images/Badges/empty.png", "/images/Badges/sportCor_silber.png","","Olympia-Frage richtig beantwortet."],
                 "a21" => [false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_bronze.png", "", "Erstes Tiere&Pflanzen-Quiz durchgeführt."], "a22"=>[false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_silber.png", "", "50% der Tiere&Pflanzen-Fragen kennengelernt."],"a23"=>[false, "/images/Badges/empty.png", "/images/Badges/tier_pflanze_gold.png","","90% der Tiere&Pflanzen-Fragen kennengelernt."],
                 "a24"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_bronze.png","","Erstes Social-Media-Quiz durchgeführt."], "a25"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_silber.png","","50% der Social-Media-Fragen kennengelernt."], "a26"=>[false, "/images/Badges/empty.png", "/images/Badges/social_media_gold.png","","90% der Social-Media-Fragen kennengelernt."],
                 "a27"=>[false, "/images/Badges/quizmaster.png", "/images/Badges/quizmaster_gold.png","noch nicht erreicht: Quizmaster! Alle versteckten Abzeichen erhalten.","Quizmaster! Alle versteckten Abzeichen erhalten."],"a28"=>[false, "/images/Badges/fragebogen.png", "/images/Badges/fragebogen_gold.png", "noch nicht erreicht: Feedback abgeschickt.", "Feedback abgeschickt."],
                 "a29"=>[false, "/images/Badges/empty.png", "/images/Badges/tierPflanzenCor_silber.png","","Fliegenpilz-Frage richtig beantwortet."], "a30"=>[false, "/images/Badges/empty.png", "/images/Badges/socialMediaCor_silber.png", "", "WLAN-Frage richtig beantwortet."]}
  testLoginFree = true
  while testLoginFree
    cur = (('0'..'9').to_a + ('a'..'z').to_a).shuffle.first(6).join
    if(Student.where(:login => cur).empty?)
      testLoginFree=false
    end
  end
  if(i<3)
  s = group.students.build(name: cur, group_type: 0,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  elsif(i<6)
    s = group.students.build(name: cur, group_type: 1,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  elsif(i<9)
    s = group.students.build(name: cur, group_type: 2,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  elsif(i<12)
    s = group.students.build(name: cur, group_type: 3,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  elsif(i<15)
    s = group.students.build(name: cur, group_type: 4,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  else
    s = group.students.build(name: cur, group_type: 5,feedback_send:false,survey_done:false, login_times:0, ip: "pretest", fingerprint: "pretest", gender:"keine Angabe", achievement: achievement, points:0, played_questions:0)
  end
  s.save




  i = i+1
end
