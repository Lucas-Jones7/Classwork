# -----------------------------------------+
# Lucas Jones                              |  
# CSCI 107, Assignment 2                   |
# Last Updated: September 15, 2023         |  
# -----------------------------------------|
# create a program that uses turtle        |
# graphics to draw an app icon             |
# -----------------------------------------+


import turtle
canvas = turtle.Screen()
luke = turtle.Turtle()
fill_col = "#CFC9D4"
luke.pencolor(fill_col)
luke.fillcolor(fill_col)


cam = turtle.Turtle()
cam_col = "#30312A"
cam.pensize(25)
cam.pencolor(cam_col)
cam.fillcolor(cam_col)


tim = turtle.Turtle()
tim_col = "#BEBEC7"
tim.pensize(15)
tim.pencolor(tim_col)
tim.fillcolor(tim_col)


hank = turtle.Turtle()
hank_col = "#FFCA03"
hank.pensize(1)
hank.pencolor(hank_col)
hank.fillcolor(hank_col)

luke.penup()
luke.goto(-200,-200)
luke.pendown()
luke.speed (75)

luke.begin_fill()
luke.forward (400)
luke.left (90)
luke.forward (400)
luke.left (90)
luke.forward (400)
luke.left (90)
luke.forward (400)
luke.left (90)
luke.end_fill()

luke.hideturtle()



cam.penup()
cam.goto(-150,-115)
cam.pendown()
cam.speed (75)

cam.begin_fill()
cam.forward (300)
cam.left (90)
cam.forward (200)
cam.left (90)
cam.forward(75)
cam.right (45)
cam.forward (50)
cam.end_fill()

cam.penup()
cam.goto(-150,-115)
cam.pendown()

cam.begin_fill()
cam.right (45)
cam.forward (200)
cam.right(90)
cam.forward (75)
cam.left(45)
cam.forward (50)
cam.right(45)
cam.forward (81)
cam.end_fill()

cam.hideturtle()



tim.penup()
tim.goto(0,-85)
tim.pendown()
tim.speed(75)

tim.circle(75)

tim.hideturtle()



hank.penup()
hank.goto(90,45)
hank.pendown()

hank.begin_fill()
hank.circle(13)
hank.end_fill()

hank.hideturtle()




