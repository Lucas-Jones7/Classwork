
is_sunny = str(input("Is it sunny today? "))
is_warm = str(input("Is it warm today? "))
has_invitation = str(input("Do you have a picnic invitation? "))
can_go_picnic = True
if has_invitation == ("yes"):
    if is_sunny == ("yes"):
        can_go_picnic = True
    elif is_warm == ("yes"):
        can_go_picnic = True
        
else:
    can_go_picnic = False
if (can_go_picnic == True):
    print("You can go to a picnic todday!")
else:
    print("You cannot go to a picnic today")
    




can_go_picnic()
























##import math
##
##def bmicalc():
##    weight = (float(input("what is your weight in kilograms? ")))
##    height = (float(input("what is your height in meters? ")))
##    bmi = (weight / (height**(2)))
##    print(bmi)
##    if bmi < 18.5:
##        print("underweight")
##    elif 18.5 <= bmi < 25:
##        print("normal")
##    elif 25 <= bmi < 30:
##        print("overweight")
##    elif bmi > 30:
##        print("obese")
##
##
##bmicalc()




##def keyword():
##    key = (str(input("Enter a word: ")))
##
##    if key == str("def"):
##        print("That is a python keyword.")
##    else:
##        print("That is not a python keyword.")
##
##
##
##
##keyword()




