#map a random walk with turtle graphics

import random
import turtle

def walk_drunk(t, steps):
    for step in range(steps):
        turn = random.randint(1, 360)
        t.left(turn)
        t.forward(10)

def main():
    drunkard = turtle.Turtle()
    drunkard.color("blue")
    walk_drunk(drunkard, 100)

main()

