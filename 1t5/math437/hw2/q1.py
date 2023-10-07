def special_numbers():
    # Check if d+2 divides n+2 for all divisors d of n
    def condition_met(n):
        for d in range(1, n + 1):
            if n % d == 0:
                if (n + 2) % (d + 2) != 0:
                    return False
        return True

    # Get all numbers up to 1000 that meet the condition
    return [n for n in range(2, 10001) if condition_met(n)]

def is_prime(n):
    """Check if a number is prime."""
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

nums = special_numbers()

print(nums)
print(any(not is_prime(x) for x in nums))
