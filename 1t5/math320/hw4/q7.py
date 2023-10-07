def compute_recurrence_terms(n, lambda_value, a0, a1):
    terms = [a0, a1]
    for i in range(2, n):
        next_term = (1 - lambda_value) * terms[i-1] + lambda_value * terms[i-2]
        terms.append(next_term)
    return terms

# Given values
lambda_value = 2/3
a0 = 7
a1 = 17
n = 100

terms = compute_recurrence_terms(n, lambda_value, a0, a1)
print(terms[-1])
print((lambda_value*a0+a1)/(lambda_value+1))

