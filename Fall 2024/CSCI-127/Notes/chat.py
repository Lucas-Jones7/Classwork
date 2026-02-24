import turtle

def move(some_turtle, direction, distance):
    some_turtle.setheading(direction)
    some_turtle.forward(distance)


#Original Command String: "Bn050Ge100Rs150Yw200bN250gE300rS350yW400bn450ge500rs550yw600"
#New Command String for Custom Drawing: "Bh050rJ100Yk150gL200bz250RX300yC250"

def main():  
    command_string = "Bh050rJ100Yk150gL200bz250RX300yC250"
    drawing = turtle.Turtle()
    drawing.speed(0)
    drawing.pensize(10)
    drawing.hideturtle()


    index = 0
    while index < len(command_string):
        command = command_string[index]
        index += 1

        #if statements to change the drawing color
        
        if command.lower() == 'b':
            drawing.color("blue")
        elif command.lower() == 'g':
            drawing.color("green")
        elif command.lower() == 'r':
            drawing.color("red")
        elif command.lower() == 'y':
            drawing.color("yellow")
            
        #if statements to change the drawing direction and distance
            
        elif command.lower() == 'n':
            distance = int(command_string[index:index+3])
            move(drawing, 90, distance)
        elif command.lower() == 's':
            distance = int(command_string[index:index+3])
            move(drawing, 270, distance)
        elif command.lower() == 'e':
            distance = int(command_string[index:index+3])
            move(drawing, 0, distance)
        elif command.lower() == 'w':
            distance = int(command_string[index:index+3])
            move(drawing, 180, distance)
        
        #if statements to change the drawing direction and distance of the triangle shape
            
        elif command.lower() == 'h':
            distance = int(command_string[index:index+3])
            move(drawing, 60, distance)
        elif command.lower() == 'j':
            distance = int(command_string[index:index+3])
            move(drawing, 300, distance)
        elif command.lower() == 'k':
            distance = int(command_string[index:index+3])
            move(drawing, 180, distance)
        elif command.lower() == 'l':
            distance = int(command_string[index:index+3])
            move(drawing, 60, distance)
        elif command.lower() == 'z':
            distance = int(command_string[index:index+3])
            move(drawing, 300, distance)
        elif command.lower() == 'x':
            distance = int(command_string[index:index+3])
            move(drawing, 180, distance)
        elif command.lower() == 'c':
            distance = int(command_string[index:index+3])
            move(drawing, 60, distance)
            
        

    turtle.done()


main()
