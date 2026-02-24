import turtle
import math

# -----------------------------------------+
# Your name                                |
# CSCI 107, Assignment 8                   |
# Last Updated: November 17, 2023          |
# -----------------------------------------|
# Applying recursion to turtle graphics    |
# -----------------------------------------+

colormap = ["red", "orange", "yellow", "green", "blue"]

# -----------------------------------------+
# draw_diamond                             |
# -----------------------------------------+
# diamond_turtle: turtle to draw with      |
# top_x: x coordinate of top of diamond    |
# top_y: y coordinate of top of diamond    |
# height: height of diamond                |
# diamond_color: fill color for diamond    |
# -----------------------------------------+
# Draw the specified diamond.              |
# -----------------------------------------+

def draw_diamond(diamond_turtle, top_x, top_y, height, diamond_color):
    diamond_turtle.up()
    diamond_turtle.goto(top_x, top_y)
    diamond_turtle.down()
    diamond_turtle.seth(-45)
    
    # calculate length of side, given height of diamond 
    length = math.sqrt(height * height / 2)
    
    diamond_turtle.fillcolor(diamond_color)
    diamond_turtle.begin_fill()
    for _ in range(4):
        diamond_turtle.forward(length)
        diamond_turtle.right(90)
    diamond_turtle.end_fill()

# ------------------------------------------

def draw_diamonds(diamond, x, y, distance, level):
    colormap = ["red", "orange", "yellow", "green", "blue"]
    if level == 0:
        draw_diamond(diamond, x, y, distance, colormap[level])
    else:
        draw_diamond(diamond, x, y, distance, colormap[level])
        lx = x
        ly = y - distance/(2.25**(1/2))
        rx = x
        ry = y

        d = distance/3

        draw_diamonds(diamond, lx, ly, d, level-1)
        draw_diamonds(diamond, rx, ry, d, level-1)
        
    

# ------------------------------------------

def main():
    window = turtle.Screen()
    diamond = turtle.Turtle()
    diamond.speed(0)
    diamond.hideturtle()
    x = 0             # x coordinate of top point of largest diamond
    y = 300           # y coordinate of top point of largest diamond
    distance = 600    # distance between top and bottom points of largest diamond
    level = int(input("Enter level [0 - 4]: "))     # number of recursive levels
    draw_diamonds(diamond, x, y, distance, level)
    window.exitonclick()

# ------------------------------------------

main()
