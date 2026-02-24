# Towers of Hanoi

def hanoi(disks, S, T, F):
    # base case
    if disks > 0: 
        # move n-1 disks from S to T
        hanoi(disks-1, S, T, F)
        # move biggest disk from S to F
        print("Moving", disks, "from", S, "to", F)
        # move n-1 disks from ...?
        hanoi(disks-1, T, S, F)

def main():
    hanoi(3, "start", "temp", "finish")


main()
