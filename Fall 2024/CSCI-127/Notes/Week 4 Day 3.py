import turtle
canvas = turtle.Screen()
luke = turtle.Turtle()
fill_col = input("What Color? ")
side_no = int(input("How many sides for your polygon? "))
side_len = int(input("What is the side length? "))

#luke.color(fill_col)
#luke.begin_fill()
#luke.forward (side_len)
#luke.left (90)
#luke.forward (side_len)
#luke.left (90)
#luke.forward (side_len)
#luke.left (90)
#luke.forward (side_len)
#luke.left (90)

#luke.end_fill()


luke.color(fill_col)
luke.begin_fill()

for _ in range(side_no):
    luke.forward (side_len)
    luke.left (360/side_no)

luke.end_fill()

luke.hideturtle()
