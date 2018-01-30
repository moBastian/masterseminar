#hier passende Mail eingeben
user = User.find_by_email("test@test.com")
#hier passenden Namen der Gruppe angeben
group = Group.where(user_id: user, name:"1Test")

#Array für Usernamen
usernames = %w{

}
#Array für played_questions
played_questions = %w{

}
#Array für correct_questions
correct_questions = %w{

}
i = 0
while(i<usernames.size)
  s = group.students.build(name: usernames[i], group_type: -1, points:correct_questions[i], played_questions:played_questions[i])
  s.save
  i = i+1
end
