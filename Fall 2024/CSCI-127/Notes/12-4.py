import string

def eliminate_constants(text):
    answer = ""
    vowels = "aeiouAEIOU"
    for char in text:
        if char in vowels:
            answer += char

        return answer

result = eliminate_constants("mississippi")
result2 = eliminate_constants(string.ascii_lowercase + string.ascii_uppercase)
print(result)
