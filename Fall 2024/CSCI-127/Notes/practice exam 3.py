##def badwolf(bite):
##    hunger = int(input("How many bites? "))  # Convert input to an integer
##    for i in range(hunger):  # Fix the syntax of the for loop
##        print(bite)  # Use the variable 'bite' instead of 'bites'
##    return "Delicious"
##
##print(badwolf("chomp"))


##import random
##
##def guess_the_number():
##    secret_number = random.randint(1, 100)
##    attempts = 0
##    guessed = False
##
##    print("Welcome to the Guess the Number Game!")
##
##    while not guessed:
##       user_guess = int(input("Enter your guess (between 1 and 100): "))
##       attempts += 1
##
##        
##       if user_guess == secret_number:
##            print(f"Congratulations! You guessed the correct number {secret_number} in {attempts} attempts.")
##            guessed = True
##       elif user_guess < secret_number:
##            print("Too low! Try again.")
##       else:
##            print("Too high! Try again.")
##
##
##guess_the_number()

def create_pyramid(rows):
    for i in range(1, rows + 1):
        print(" " * (rows - i) + "*" * (2 * i - 1))
num_rows = int(input("Enter the number of rows for the pyramid: "))
create_pyramid(num_rows)

