import random


def main():
    print("How many games do you want to simulate?")
    def simulate_one_game():
        roll = random.randint(1, 6) + random.randint(1, 6)


        if roll in (7,11):
            return True

        elif roll in (2,3,12):
            return False

        else:
            num = roll
            while True:
                roll2 = random.randint(1,6) + random.randint(1,6)
                if roll2 == num:
                    return True
                elif roll2 == 7:
                    return False


    def get_integer(minval, maxval, message):
        while True:
            inpt = int(input(message))
            if inpt in range(100,5000000):
                return inpt
            else:
                print(int(input("Please enter a number between 100 and 5000000: ")))


    while True:
        games = get_integer(100, 5000000, "Enter a number between 100 and 5000000: ")
        wins = 0
        for i in range(games):
            if simulate_one_game():
                wins +=1
        percentage = (wins / games) * 100
        print("Win Percentage:",percentage,"%")
        break
                







main()
