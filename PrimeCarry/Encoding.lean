module

public import PrimeCarry.Reduction
import Mathlib.Tactic

public section

namespace PrimeCarry

/-- The primorial logarithm is additive on products of positive integers. -/
theorem primorialLog_mul {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) :
    primorialLog (a*b) = primorialLog a + primorialLog b := by
  unfold primorialLog
  rw [((Nat.perm_primeFactorsList_mul ha hb).map weight).sum_eq, List.map_append, List.sum_append]

theorem primorialLog_prime {p : ℕ} (hp : p.Prime) : primorialLog p = weight p := by
  simp [primorialLog, Nat.primeFactorsList_prime hp]

theorem primorialLog_prime_pow {p : ℕ} (hp : p.Prime) (e : ℕ) :
    primorialLog (p^e) = e * weight p := by
  simp [primorialLog, hp.primeFactorsList_pow, List.map_replicate]

private theorem weight_two : weight 2 = 1 := by decide

theorem encoding_left : primorialLog (1024*scale) = 10 + 67*weight 241 := by
  have h241 : Nat.Prime 241 := by norm_num
  rw [primorialLog_mul (by decide) (by dsimp [scale]; positivity),
    show (1024 : ℕ) = 2^10 by decide, primorialLog_prime_pow Nat.prime_two,
    scale, primorialLog_prime_pow h241, weight_two, Nat.mul_one]

theorem encoding_right : primorialLog (3916*scale) =
    2 + weight 11 + weight 89 + 67*weight 241 := by
  have h241 : Nat.Prime 241 := by norm_num
  rw [primorialLog_mul (by decide) (by dsimp [scale]; positivity),
    show (3916 : ℕ) = (2^2 * 11) * 89 by decide,
    primorialLog_mul (by decide) (by decide), primorialLog_mul (by decide) (by decide),
    primorialLog_prime_pow Nat.prime_two, primorialLog_prime (by norm_num : Nat.Prime 11),
    primorialLog_prime (by norm_num : Nat.Prime 89), scale,
    primorialLog_prime_pow h241, weight_two, Nat.mul_one]

end PrimeCarry
