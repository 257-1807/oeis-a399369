module

public import Mathlib.Data.Nat.Factors
public import Mathlib.NumberTheory.Primorial
import Mathlib.NumberTheory.Bertrand
import Mathlib.Tactic.NormNum.Prime

@[expose] public section

namespace PrimeCarry

/-- The weight of the digit indexed by a prime p is the product of all smaller primes. -/
def weight : ℕ → ℕ
  | 0 => 1
  | p + 1 => weight p * (if p.Prime then p else 1)

theorem weight_eq_prod (p : ℕ) :
    weight p = ∏ q ∈ Finset.range p with q.Prime, q := by
  simp only [Finset.prod_filter]
  induction p with
  | zero => simp [weight]
  | succ p ih => rw [weight, Finset.prod_range_succ, ih]

/-- Agreement with the standard primorial at the index immediately below p. -/
theorem weight_eq_primorial {p : ℕ} (hp : 0 < p) : weight p = primorial (p - 1) := by
  rw [weight_eq_prod, primorial, Nat.sub_add_cancel hp]

/-- A276085 adds the primorial weight of every prime factor, with multiplicity. -/
def primorialLog (n : ℕ) : ℕ := (n.primeFactorsList.map weight).sum

/-- Test consecutive candidates, stopping at the first prime. -/
def scanPrime : ℕ → ℕ → ℕ
  | 0, first => first
  | fuel + 1, first => if first.Prime then first else scanPrime fuel (first + 1)

private theorem scanPrime_spec (fuel first q : ℕ) (hlo : first ≤ q)
    (hhi : q ≤ first + fuel) (hq : q.Prime) :
    first ≤ scanPrime fuel first ∧ (scanPrime fuel first).Prime ∧
      ∀ z, first ≤ z → z.Prime → scanPrime fuel first ≤ z := by
  induction fuel generalizing first with
  | zero =>
    have : first = q := by omega
    subst first
    exact ⟨le_rfl, hq, fun _ h _ => h⟩
  | succ fuel ih =>
    rw [scanPrime]
    split
    next hp =>
      exact ⟨le_rfl, hp, fun _ h _ => h⟩
    next hp =>
      have hne : first ≠ q := fun heq => hp (heq ▸ hq)
      obtain ⟨ha, hb, hc⟩ := ih (first + 1) (by omega) (by omega)
      refine ⟨by omega, hb, fun z hz hzp => hc z ?_ hzp⟩
      have hne' : first ≠ z := fun heq => hp (heq ▸ hzp)
      omega

/-- The least prime strictly larger than p. Bertrand supplies a finite search bound. -/
def nextPrime (p : ℕ) : ℕ := scanPrime (p + 1) (p + 1)

theorem nextPrime_spec (p : ℕ) : p < nextPrime p ∧ (nextPrime p).Prime ∧
    ∀ q, p < q → q.Prime → nextPrime p ≤ q := by
  obtain ⟨q, hq, hlt, hle⟩ := Nat.exists_prime_lt_and_le_two_mul (p + 1) (by omega)
  exact scanPrime_spec (p + 1) (p + 1) q (by omega) (by omega) hq

/-- Read mixed-radix digits from right to left and turn them into prime exponents. -/
def decode (p code : ℕ) (_hp : 2 ≤ p) : ℕ :=
  if _hc : code = 0 then 1 else
    p ^ (code % p) * decode (nextPrime p) (code / p) (nextPrime_spec p).2.1.two_le
termination_by code
decreasing_by exact Nat.div_lt_self (Nat.pos_of_ne_zero _hc) _hp

/-- A276086 uses the consecutive primes beginning at 2 as its digit radices. -/
def primorialExp (code : ℕ) : ℕ := decode 2 code (by decide)

/-- A392878 in its defining form A276086(A276085(n)). -/
def reduced (n : ℕ) : ℕ := primorialExp (primorialLog n)

/-- A376418. -/
def gap (n : ℕ) : ℕ := n - reduced n

/-- Common scaling factor in the counterexample. -/
def scale : ℕ := 241 ^ 67

/-- A structurally recursive evaluator used to check finite mixed-radix certificates. -/
def decodePrefix : ℕ → ℕ → ℕ → ℕ
  | 0, _, _ => 1
  | fuel + 1, p, code => if code = 0 then 1 else
      p ^ (code % p) * decodePrefix fuel (nextPrime p) (code / p)

theorem decodePrefix_eq (fuel p code : ℕ) (hp : 2 ≤ p) (h : code < 2 ^ fuel) :
    decodePrefix fuel p code = decode p code hp := by
  induction fuel generalizing p code with
  | zero =>
    have hc : code = 0 := by simpa using h
    simp [hc, decodePrefix, decode]
  | succ f ih =>
    by_cases hc : code = 0
    · simp [hc, decodePrefix, decode]
    · rw [decodePrefix, decode]
      simp only [hc, ↓reduceIte, ↓reduceDIte]
      congr 1
      apply ih
      apply (Nat.div_lt_iff_lt_mul (by omega : 0 < p)).2
      calc code < 2 ^ f * 2 := by simpa [pow_succ] using h
           _ ≤ 2 ^ f * p := Nat.mul_le_mul_left _ hp

end PrimeCarry
