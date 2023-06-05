import random

def rsa(p,q):
    n = p * q
    e = get_relatively_prime((p - 1) * (q - 1))
    d = pow(e, -1, (p - 1) * (q - 1))
    return n, e, d

def rsa_fun(p, q, text):
    n, e, d = rsa(p, q)
    print(f'n = {n}, e = {e}, d = {d}')
    dataAsNumber = hash(text) % n
    print(f'DataAsNumber: {dataAsNumber}')
    en_text = rsa_encrypt(dataAsNumber, e, n)
    print(f'Encrypted text: {en_text}')
    de_text = rsa_decrypt(en_text, d, n)
    print(f'Decrypted text: {de_text}')
    return en_text, de_text

def rsa_encrypt(text, e, n):
    return pow(text, e, n)

def rsa_decrypt(t, d, n):
    return pow(t, d, n)
    
    
def get_relatively_prime(n):
    def is_relatively_prime(a, b):
        while b != 0:
            a, b = b, a % b
        return a == 1

    while True:
        i = random.randint(2, n)
        if is_relatively_prime(n, i):
            return i
    
if __name__ == "__main__":
    rsa_fun(53, 59, '1234567')