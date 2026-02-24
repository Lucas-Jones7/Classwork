#plot a sine wave

import math
import turtle

def plot_sin_wave(t, start, stop, step):
    x=0
    for i in range(100): #stop when x is 10 (10/0.1 is 100)
        t.goto(x, math.sin(x))
        x += step #same as x = x + step
        print(round(x, 2))

    
def main():
    canvas = turtle.Screen()
    canvas.setworldcoordinates(0, -2, 10, 2)
    
    luke = turtle.Turtle()
    luke.hideturtle()
    plot_sin_wave(luke, 0, 10, 0.1)

main()
