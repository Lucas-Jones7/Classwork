import turtle
canvas = turtle.Screen()
bgcol = input("What is your prefered color for the backround? ")
pens = input("What is your prefered pen size? ")
penc = input("What is your prefered pen color? ")
canvas.bgcolor (bgcol)
alex = turtle.Turtle()
alex.pensize(pens)
alex.pencolor(penc)
#alex.forward(150)
#alex.left(90)
#alex.forward(75)
#alex.left(90)
#alex.forward(150)
#alex.left(90)
#alex.forward(75)


#alex.right(45)
#alex.forward(50)
#alex.left(90)
#alex.forward(90)


alex.forward(150)
alex.left(180-180/5)
alex.forward(150)
alex.left(180-180/5)
alex.forward(150)
alex.left(180-180/5)
alex.forward(150)
alex.left(180-180/5)
alex.forward(150)
alex.penup() #how to have pen not draw
alex.goto(-200, 200)
alex.pendown()

for _ in range(5):
    alex.forward(150)
    alex.left(180-180/5)
alex.hideturtle()



