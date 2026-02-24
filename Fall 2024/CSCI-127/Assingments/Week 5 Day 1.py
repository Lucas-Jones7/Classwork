import turtle
canvas = turtle.Screen()
canvas.bgcolor("light green")

luke = turtle.Turtle()
luke.shape("turtle")
luke.color("blue")

hank = turtle.Turtle()
hank.pensize(3)
hank.color("blue")

luke.stamp()
luke.penup()

for i in range(12):
    luke.forward(100)
    luke.stamp()
    luke.backward(100)
    luke.left(360/12)


luke.hideturtle
hank.penup()
hank.hideturtle

for h in range(12):
    hank.forward(80)
    hank.pendown()
    hank.forward(5)
    hank.penup()
    hank.backward(85)
    hank.left(360/12)

hank.color("red")
hank.pensize(1)

for h in range(60):
    hank.forward(80)
    hank.pendown()
    hank.forward(5)
    hank.penup()
    hank.backward(85)
    hank.left(360/60)



    
    


