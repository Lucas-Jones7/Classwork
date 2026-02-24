# -----------------------------------------+
# Lucas Jones                              |  
# CSCI 107, Assignment 2                   |
# Last Updated: September 6, 2023          |  
# -----------------------------------------|
# create a program that asks the user      |
# information and fills out a business     |
# card with the information                |
# -----------------------------------------+

firstname = input("Please enter your first name: ")
lastname = input("Please enter your last name: ")
phonenumber = input("Please enter your telephone number: ")
fnlength = len(firstname)
lnlength = len(lastname)
print(" ")
print("Here is your business card")
print(" ")

print("+------------------------------------------------+")
print("|    |                                           |")
print("|   -|          "+lastname+"," ,firstname+"|".rjust(32-(lnlength + fnlength)))
print("|  --|          Tribute Liabilities Associate    |")
print("| ---|          Parasail Capital                 |")
print("| ---------                                      |")
print("|  -------      4 Hunger Plaza                   |")
print("|               STE 1400                         |")
print("|               District 12, Panem 00012         |")
print("|                                                |")
print("| Work: "+phonenumber,  "@:" ,firstname+"@parasail.com"+"|".rjust(11-fnlength))
print("+------------------------------------------------+")
