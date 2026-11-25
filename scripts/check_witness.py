"""Rediscover and verify a counterexample to Conjecture 2 in OEIS A399369."""

from collections import defaultdict
from fractions import Fraction
from itertools import count
from math import isqrt, prod


def is_prime(n: int) -> bool:
    return n >= 2 and all(n % d for d in range(2, isqrt(n) + 1))


def primes():
    return (n for n in count(2) if is_prime(n))


def factor(n: int) -> dict[int, int]:
    if n < 1:
        raise ValueError("factor expects a positive integer")
    factors = {}
    for p in primes():
        if p * p > n:
            break
        while n % p == 0:
            factors[p] = factors.get(p, 0) + 1
            n //= p
    if n > 1:
        factors[n] = factors.get(n, 0) + 1
    return factors


def reduced_by_digits(n: int) -> int:
    """Evaluate A276086(A276085(n)) through place values and successive divmod."""
    exponents = factor(n)
    code = 0
    place = 1
    for p in primes():
        if p > max(exponents, default=0):
            break
        code += exponents.get(p, 0) * place
        place *= p
    result = 1
    for p in primes():
        if code == 0:
            return result
        code, digit = divmod(code, p)
        result *= p**digit


def reduced_by_carries(n: int) -> int:
    """Independently run the least-overflowing-prime rule of A392879."""
    exponents = factor(n)
    while eligible := [p for p, e in exponents.items() if e >= p]:
        p = min(eligible)
        q = next(k for k in count(p + 1) if is_prime(k))
        carry, exponents[p] = divmod(exponents[p], p)
        exponents[q] = exponents.get(q, 0) + carry
    return prod(p**e for p, e in exponents.items())


def derivative(n: int) -> int:
    return sum(e * (n // p) for p, e in factor(n).items())


def find_pair(limit: int) -> tuple[int, int, int, int]:
    """Match a common gap, then try scaling the cores by a prime power."""
    by_gap = defaultdict(list)
    for k in range(2, limit + 1):
        gap = k - reduced_by_carries(k)
        if not gap:
            continue
        dk = derivative(k)
        for j, dj in by_gap[gap]:
            if dj <= dk:
                continue
            ratio = Fraction(dj - dk, k - j)
            e, p = ratio.numerator, ratio.denominator
            if not (e < p and is_prime(p)):
                continue
            c = p**e
            if k*c - reduced_by_carries(k*c) == j*c - reduced_by_carries(j*c):
                return j, k, p, e
        by_gap[gap].append((k, dk))
    raise ValueError(f"No witness through core {limit}")


def main() -> None:
    j0, k0, p, e = find_pair(4000)
    assert (j0, k0, p, e) == (1024, 3916, 241, 67)
    c = p**e
    j, k = j0*c, k0*c
    assert 0 < j < k and (j, k) != (16, 28)
    assert 4 <= k and k % (2**2) == 0 and j % (2**2) == 0
    for n, expected in ((j0, 45), (k0, 2937), (j, 45*c), (k, 2937*c)):
        assert reduced_by_digits(n) == reduced_by_carries(n) == expected
    assert j - reduced_by_digits(j) == k - reduced_by_digits(k) == 979*c
    assert (derivative(j0), derivative(k0)) == (5120, 4316)
    assert derivative(j) == derivative(k) == (5120*p + 1024*e)*p**(e-1)
    print(f"Search found cores j0={j0}, k0={k0} and scale c={p}^{e}.")
    print("Both normalizations agree: R(j)=45*c and R(k)=2937*c.")
    print("Both gaps are 979*c. Both arithmetic derivatives are 1302528*241^66.")


if __name__ == "__main__":
    main()
