import turtle

screen = turtle.Screen()
turt = turtle.Turtle()

def turn_red():
    turt.color("red")
    print("supposed to turn red")

def turn_black():
    turt.color("black")
    print("supposed to turn black")
    
screen.onclick(turt.goto)
screen.onkey(turn_red, "r")
screen.onkey(turn_black, "k")
screen.listen()

