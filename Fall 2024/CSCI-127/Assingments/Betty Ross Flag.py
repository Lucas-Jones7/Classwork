# -----------------------------------------+
# Lucas Jones, Derek Price                 |
# CSCI 107, Assignment 4                   |
# Last Updated: 10/5/2023                   |
# -----------------------------------------|
# Define and comment the two missing       |
# functions such that the desired Betsy    |
# Ross flag is drawn.                      |
# -----------------------------------------+

import turtle

#------------------------+
# main(no parameters)    |
#------------------------+


#Function made to allow for parameters to draw rectangles
def draw_rectangle(t,color,length,width,x1,y1):
        t.fillcolor(color)
        t.penup()
        t.goto(x1,y1)
        t.pendown()
        t.begin_fill()
        for i in range(2):
            t.forward(length)
            t.right(90)
            t.forward(width)
            t.right(90)
        t.end_fill()
        
#function made to allow for parameters to draw a star
def draw_star(t,color,length,x1,y1):
        t.color(color)
        t.penup()
        t.goto(x1,y1)
        t.pendown()
        t.begin_fill()
        for i in range(5):
            t.forward(length)
            t.right(144)
        t.end_fill()


def main():
    window = turtle.Screen()
    flag = turtle.Turtle()
    flag.hideturtle()
    flag.speed(0)

    # initially, make the background of the entire flag red
    # the dimensions of the flag are 450 by 325
    # the upper left corner of the flag is at (-200, 175)
    draw_rectangle(flag, "red", 450, 325, -200, 175)

    # fill in the blue part in the upper left corner
    draw_rectangle(flag, "blue", 175, 175, -200, 175)

    # draw the three white strips to the right of the blue part
    y = 150
    for _ in range(3):
        draw_rectangle(flag, "white", 275, 25, -25, y)
        y -= 50

    # draw the three white stripes below the blue part
    for _ in range(3):
        draw_rectangle(flag, "white", 450, 25, -200, y)
        y -= 50

    # draw the 13 white stars
    flag.penup()
    flag.goto(-185, 95)
    for _ in range(13):
        # each of the 5 lines of the star is 20 pixels
        # the left side of the horizontal line is at (flag.xcor(), flag.ycor())
        draw_star(flag, "white", 20, flag.xcor(), flag.ycor())
        flag.penup()
        flag.forward(140)
        flag.right(180 - 180/13)

    window.exitonclick()

# -----------------------------------------+

main()
