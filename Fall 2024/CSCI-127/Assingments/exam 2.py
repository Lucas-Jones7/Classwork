import math

while True:
    try:
        n = int(input("Enter a positive integer: "))
        if n <= 0:
            print("That's not a positive integer. Please try again.")
        else:
            factorial = math.factorial(n)
            print(f"The factorial of {n} is {factorial}")
            break
    except ValueError:
        print("Invalid input. Please enter a positive integer.")







##def age_group():
##    age = int(input("Enter your age: "))
##    if age < 18:
##        print("You are a minor.")
##    elif 18 <= age < 65:
##        print("You are an adult.")
##    elif 65 <= age:
##        print("You are a senior citizen")
##
##
##age_group()

##def printnums(x,y):
##    for h in range(y):
##        print("We made it here!")
##        for i in range(x):
##            print("We made it here!")
##
##printnums()



##x = 5
##y = 3
##while x > 0:
##    x = x - 1
##    y = y + 1
##    x = x - 2
##    y = y + x
##
##
##print(x, y)
