def dream(level):
    if level != 0:
        print(level)
        dream(level-1)

#dream(10)

def dream_iter(level):
    for i in range(1, level+1):
        print(i)


#dream_iter(10)


def sum_recur(n):
    if n==0:  #Base case
        answer = 0
    else:
        print("value of n", n)
        answer = n+sum_recur(n-1) #General Case
        print("returning", answer)

    return answer

print("Answer", sum_recur(5))
