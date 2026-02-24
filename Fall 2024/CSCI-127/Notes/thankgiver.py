def count_e(s):
    # return s.count('e') # built in string method
    e = 0
    for char in s:
        if char == 'e':
            e += 1
    return e

def main():
    sentence = "Howmany e's are in this sentence?"
    print(count_e(sentence))


main()
