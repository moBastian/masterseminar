# -*- encoding : utf-8 -*-
#Adminseed beim kompletten neuaufsetzen der Plattform  oder für einen neuen Admin

STDOUT.puts "Enter e-mail for admin:"
email = STDIN.gets.strip.downcase
STDOUT.puts "Enter password for admin:"
pw = STDIN.gets.strip
STDOUT.puts "Re-enter password for admin:"
pwc = STDIN.gets.strip

u = User.create(email: email, password: pw, password_confirmation: pwc, name: "Administrator", capabilities:"admin", state:15, account_type: 2)
if u.save
  STDOUT.puts "Admin account created!"
else
  STDOUT.puts "Something went wrong!"
end

