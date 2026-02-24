def collatz_i(n):
    while (n > 1):
        print(n)
        if (n % 2 == 0): # even
            n = n // 2
        else: # odd
            n = 3*n+1
            
def main():
    collatz_i(20)
    collatz_i(20)

main()
