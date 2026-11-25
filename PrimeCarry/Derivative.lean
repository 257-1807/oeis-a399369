module

public import Mathlib.Data.Nat.Factors
public import Mathlib.Algebra.BigOperators.Ring.List
import Mathlib.Data.Nat.Factorization.Induction
import Mathlib.Tactic

public section

namespace PrimeCarry

/-- Arithmetic derivative (OEIS A003415). Each occurrence of a prime p in n
contributes n/p, so repeated factors contribute with their multiplicities. -/
@[expose] def derivative (n : ℕ) : ℕ :=
  (n.primeFactorsList.map fun p => n / p).sum

@[simp] theorem derivative_zero : derivative 0 = 0 := by simp [derivative]
@[simp] theorem derivative_one : derivative 1 = 0 := by simp [derivative]

theorem derivative_prime {p : ℕ} (hp : p.Prime) : derivative p = 1 := by
  simp [derivative, Nat.primeFactorsList_prime hp, Nat.div_self hp.pos]

/-- The defining product rule holds also when either factor is zero. -/
theorem derivative_mul (a b : ℕ) :
    derivative (a*b) = b * derivative a + a * derivative b := by
  by_cases ha : a = 0
  · simp [ha]
  by_cases hb : b = 0
  · simp [hb]
  have reorder := (Nat.perm_primeFactorsList_mul ha hb).map (fun p => a*b/p)
  have L : a.primeFactorsList.map (fun p => a*b/p) =
      a.primeFactorsList.map (fun p => b*(a/p)) := by
    apply List.map_congr_left
    intro p hp
    rw [Nat.mul_comm a b, Nat.mul_div_assoc b (Nat.dvd_of_mem_primeFactorsList hp)]
  have R : b.primeFactorsList.map (fun p => a*b/p) =
      b.primeFactorsList.map (fun p => a*(b/p)) := by
    apply List.map_congr_left
    intro p hp
    exact Nat.mul_div_assoc a (Nat.dvd_of_mem_primeFactorsList hp)
  unfold derivative
  rw [reorder.sum_eq, List.map_append, List.sum_append, L, R,
    List.sum_map_mul_left, List.sum_map_mul_left]

/-- The prime values and Leibniz rule characterize the source sequence uniquely. -/
theorem derivative_unique (f : ℕ → ℕ) (hzero : f 0 = 0) (hone : f 1 = 0)
    (hprime : ∀ p, Nat.Prime p → f p = 1)
    (hmul : ∀ a b, f (a*b) = a*f b + b*f a) : f = derivative := by
  funext n
  induction n using Nat.recOnMul with
  | zero => simpa using hzero
  | one => simpa using hone
  | prime p hp => rw [hprime p hp, derivative_prime hp]
  | mul a b ia ib => rw [hmul, derivative_mul, ia, ib, Nat.add_comm]

/-- Differentiate a positive prime power using the product rule. -/
theorem derivative_prime_pow_succ {p : ℕ} (hp : p.Prime) (e : ℕ) :
    derivative (p^(e+1)) = (e+1)*p^e := by
  induction e with
  | zero => simp [derivative_prime hp]
  | succ e ih =>
    rw [pow_succ p (e+1), derivative_mul, ih, derivative_prime hp, pow_succ p e]
    ring

theorem derivative_core_left : derivative 1024 = 5120 := by
  rw [show (1024 : ℕ) = 2^(9+1) by decide, derivative_prime_pow_succ Nat.prime_two]
  decide
theorem derivative_core_right : derivative 3916 = 4316 := by
  rw [show (3916 : ℕ) = (2^(1+1) * 11) * 89 by decide, derivative_mul,
    derivative_mul, derivative_prime_pow_succ Nat.prime_two,
    derivative_prime (by norm_num : Nat.Prime 11), derivative_prime (by norm_num : Nat.Prime 89)]
  decide

theorem scaled_derivatives :
    derivative (1024 * 241^67) = derivative (3916 * 241^67) := by
  rw [derivative_mul, derivative_mul, derivative_core_left, derivative_core_right,
    derivative_prime_pow_succ (by norm_num : Nat.Prime 241) 66]
  decide

end PrimeCarry
