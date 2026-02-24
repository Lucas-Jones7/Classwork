##def reverse(text):
##    reversed_text= ""
##    for char in text:
##        reversed_text = char + reversed_text
##
##    return reversed_text
##
##word = "Lucas Jones"
##print(reverse(word))


import string

def rot_13(original_text):
    encoded_text = ""
    for char in original_text:
        if char in string.ascii_lowercase:
            original_index = string.ascii_lowercase.find(char)
            shifted_index = (original_index + 13)%26
            encoded_char = string.ascii_lowercase [shifted_index]
        else:
            original_index = string.ascii_uppercase.find(char)
            shifted_index = (original_index + 13)%26
            encoded_char = string.ascii_uppercase [shifted_index]
            print(encoded_char)

        encoded_text += encoded_char

    return encoded_text

def ceaser_cipher_encode(original_text, shift):
    encoded_text = ""
    for char in original_text:
        if char in string.ascii_lowercase:
            original_index = string.ascii_lowercase.find(char)
            shifted_index = (original_index + shift)%26
            encoded_char = string.ascii_lowercase [shifted_index]
        else:
            original_index = string.ascii_uppercase.find(char)
            shifted_index = (original_index + shift)%26
            encoded_char = string.ascii_uppercase [shifted_index]
            #print(encoded_char)

        encoded_text += encoded_char

    return encoded_text

def ceaser_cipher_decode(encoded_text, shift):
    decoded_text = ""
    for char in encoded_text:
        if char in string.ascii_lowercase:
            original_index = string.ascii_lowercase.find(char)
            shifted_index = (original_index + shift)%26
            decoded_char = string.ascii_lowercase [shifted_index]
        else:
            original_index = string.ascii_uppercase.find(char)
            shifted_index = (original_index + shift)%26
            decoded_char = string.ascii_uppercase [shifted_index]

        decoded_text += decoded_char

    return decoded_text

def ceaser_cipher_decode_v2(encoded_text, shift):
    decoded_text = ceaser_cipher_encode(encoded_text, -shift)

    return decoded_text

def main():
    text = string.ascii_lowercase + string.ascii_uppercase
    shift_value = int(input("pick a shift number: "))
    encrypted_text = ceaser_cipher_encode(text, shift_value)
    decrypted_text = ceaser_cipher_decode(encrypted_text, shift_value)
    decrypted_text_v2 = ceaser_cipher_decode_v2(encrypted_text, shift_value)
    print(encrypted_text)
    print(decrypted_text)
    print(decrypted_text_v2)


main()
