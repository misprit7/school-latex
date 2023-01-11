import numpy as np
letters = "abracadabra"

def arrangements(s):
    counts = [s.count(c) for c in set(s)]
    return np.math.factorial(len(s)) / np.prod([np.math.factorial(c) for c in counts])

print(arrangements(letters))


