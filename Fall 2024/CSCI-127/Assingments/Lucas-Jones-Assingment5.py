# -----------------------------------------+
# Lucas Jones                              |
# CSCI 107, Assignment 5                   |
# Last Updated: 10, 2023                   |
# -----------------------------------------|
# Determine distance of robot arm movement |
# -----------------------------------------+

def calculate_distance(octant1, x1, y1, z1, octant2, x2, y2, z2):
    d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)

    if octant1 == 1:
        x1 = x1
        y1 = y1
        z1 = z1
    elif octant1 == 2:
        x1 = x1
        y1 = y1
        z1 = z1 * -1
    elif octant1 == 3:
        x1 = x1
        y1 = y1 * -1
        z1 = z1
    elif octant1 == 4:
        x1 = x1
        y1 = y1 * -1
        z1 = z1 * -1
    elif octant1 == 5:
        x1 = x1 * -1
        y1 = y1
        z1 = z1
    elif octant1 == 6:
        x1 = x1 * -1
        y1 = y1
        z1 = z1 * -1
    elif octant1 == 7:
        x1 = x1 * -1
        y1 = y1 * -1
        z1 = z1
    elif octant1 == 8:
        x1 = x1 * -1
        y1 = y1 * -1
        z1 = z1 * -1

    

#----------------------------------------+


    if octant2 == 1:
        x2 = x2
        y2 = y2
        z2 = z2
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 2:
        x2 = x2
        y2 = y2
        z2 = z2 * -1
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 3:
        x2 = x2
        y2 = y2 * -1
        z2 = z2
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 4:
        x2 = x2
        y2 = y2 * -1
        z2 = z2 * -1
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 5:
        x2 = x2 * -1
        y2 = y2
        z2 = z2
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 6:
        x2 = x2 * -1
        y2 = y2
        z2 = z2 * -1
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 7:
        x2 = x2 * -1
        y2 = y2 * -1
        z2 = z2
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    elif octant2 == 8:
        x2 = x2 * -1
        y2 = y2 * -1
        z2 = z2 * -1
        d = ((x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2)**(1/2)
    print("Distance from ("+str(x1)+","+str(y1)+","+str(z1)+") to ("+str(x2)+","+str(y2)+","+str(z1)+") =","{:0.2f}".format(d),"units")



# -----------------------------------------+
# test_suite (no parameters)               |
# -----------------------------------------+
# Determine the distance between (2,3,4) in|
# Octant 1 with that same point in each    |
# of the eight octants.                    |
# -----------------------------------------+

def test_suite():
    calculate_distance(1, 5, 10, 15, 1, 5, 10, 15)
    calculate_distance(1, 5, 10, 15, 2, 5, 10, 15)
    calculate_distance(1, 5, 10, 15, 3, 5, 10, 15)
    calculate_distance(1, 5, 10, 15, 4, 5, 10, 15)
    calculate_distance(1, 5, 10, 15, 5, 5, 10, 15)
    calculate_distance(1, 5, 10, 15, 6, 5, 10, 15)
    calculate_distance(7, 5, 10, 15, 1, 5, 10, 15)
    calculate_distance(8, 5, 10, 15, 1, 5, 10, 15)

# -----------------------------------------+

test_suite()
