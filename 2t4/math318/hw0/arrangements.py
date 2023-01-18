import numpy as np
import math
letters = "abracadabra"

def arrangements(s):
    return math.factorial(len(s))/np.prod([math.factorial(s.count(c))\
                                           for c in set(s)])

print(arrangements(letters))
