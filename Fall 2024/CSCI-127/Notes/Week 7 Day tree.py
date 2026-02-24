"""
def is_even(n):

    return n%2==0

def is_even_v2(n):
    if n%2==0:
        answer = True
    else:
        answer = False
    return answer


def is_odd(n):
    return not n%2 ==0

def is_odd_v2 (n):
    if is_even(n):
        answer = False
    else:
        answer = True
    return answer


for n in range(10):
    print(is_odd_v2(n))
"""

def is_leap (year):
    answer = False
    if year%4 ==0:
        answer = True

    if year%100 ==0:
        answer = False

    if year%400 ==0:
        answer = True

    return answer


#-----------------------
for test_year in range (1995, 2010):
    print (test_year, is_leap(test_year))

print (2100, is_leap (2100))
