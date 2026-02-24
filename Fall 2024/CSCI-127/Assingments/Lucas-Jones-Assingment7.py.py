# -----------------------------------------+
# Lucas Jones                              |
# CSCI 107, Assignment 7                   |
# Last Updated: 11/3/23                    |
# -----------------------------------------|
# Grammars describing robot languages      |
# -----------------------------------------+

def three_ones(string):
    count = 0
    for char in string: #for loop to count amount of 1's and 0's in a string
        if char == '1':
            count += 1
            if count > 3: 
                return False #returns false if there is less than 3 1's
    return count == 3 #returns true if amount of 1's is exactly 3

def same_amount_of_both(string): 
    count1 = 0
    count0 = 0
    for char in string: #for loop to count amount of 1's and 0's in a string
        if char == '1':
                count1 += 1
        elif char == '0':
                count0 += 1

    return count1 == count0 #returns true if the amount of 1's and 0's are equal


def all_same(string):
    count1 = 0
    count0 = 0
    if len(string) == 0: #if statement to check if the string is empty, if it is it automatically returns false
        return False
    else:
        for char in string: #for loop to count amount of 1's and 0's in a string
            if char == '1':
                count1 += 1
            elif char == '0':
                count0 += 1
    
        return count1 == 0 or count0 == 0#returns true if there are either 0 1's or 0 0's
    
        

# ---------------------------------------------------+
# robot_grammar: The main function for Assignment 7.|
# ---------------------------------------------------+
def robot_grammar():
    # test strings to see if they contain three ones
    print()
    print("Testing three-ones language:")
    print("---------------------------")
    # these tests should accept
    test(three_ones, "111")
    test(three_ones, "01110")
    test(three_ones, "0010001100")
    test(three_ones, "10101")
    # these tests should not accept
    test(three_ones, "000000000")
    test(three_ones, "111111111")
    test(three_ones, "01")
    test(three_ones, "110")  
    test(three_ones, "")

    # test strings to see if they contain same amount of both.
    print()
    print("Testing same-of-both language:")
    print("---------------------------")
    # these tests should accept
    test(same_amount_of_both, "")
    test(same_amount_of_both, "0011")
    test(same_amount_of_both, "00001111")
    test(same_amount_of_both, "0101")
    test(same_amount_of_both, "0101001101")
    # these tests should not accept
    test(same_amount_of_both, "01101101") 
    test(same_amount_of_both, "01010101110")
    test(same_amount_of_both, "11100")
    test(same_amount_of_both, "1")  
    test(same_amount_of_both, "00000")
    test(same_amount_of_both, "011011")

    # test strings to see if they contain all same bit
    print()
    print("Testing all-same language:")
    print("---------------------------")
    # these tests should accept
    test(all_same, "1")
    test(all_same, "0")
    test(all_same, "1111")
    test(all_same, "000000000")
    # these tests should not accept
    test(all_same, "100000")
    test(all_same, "01")
    test(all_same, "100")  
    test(all_same, "")

# -----------------------------------------------------------+
# test: Determine whether a given function accepts a string. |
# -----------------------------------------------------------|
# fn: The function to use, e.g. four_or_more_ones            |
# string: The string to test, e.g. "000111"                  |
# -----------------------------------------------------------+
    
def test(fn, string):

    if fn(string):
        result = "YES!"
    else:
        result = "no"

    status = "Testing string "+string.ljust(20, '.')
    status += result
    print(status)

# -----------------------------------------------------------+

robot_grammar()       # run the simulation
