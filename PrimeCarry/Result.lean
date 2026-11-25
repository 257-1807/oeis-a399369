module

public import PrimeCarry.Derivative
public import PrimeCarry.Certificate
import Mathlib.Tactic

public section

namespace PrimeCarry

/-- The membership condition in A399369, together with the chosen earlier positive index. -/
def GapPair (j k : ℕ) : Prop :=
  0 < j ∧ j < k ∧ (∃ p : ℕ, p.Prime ∧ p^p ∣ k) ∧ gap j = gap k

/-- The uniqueness claim in Conjecture 2.  There is no maximality condition on j. -/
def Conjecture2 : Prop :=
  ∀ j k : ℕ, GapPair j k → derivative j = derivative k → j = 16 ∧ k = 28

/-- Both arguments have the same positive gap and the same arithmetic derivative. -/
theorem collision :
    GapPair (1024*scale) (3916*scale) ∧
    gap (1024*scale) = 979*scale ∧ 0 < gap (1024*scale) ∧
    derivative (1024*scale) = derivative (3916*scale) ∧ 16 < 1024*scale := by
  have sc : 0 < scale := by unfold scale; positivity
  have leftGap : gap (1024*scale) = 979*scale := by
    rw [gap, reduced_left, ← Nat.sub_mul]
  have rightGap : gap (3916*scale) = 979*scale := by
    rw [gap, reduced_right, ← Nat.sub_mul]
  refine ⟨⟨by omega, by omega, ⟨2,Nat.prime_two,?fromTwo⟩, leftGap.trans rightGap.symm⟩,
    leftGap, by rw [leftGap]; positivity, scaled_derivatives, by omega⟩
  exact ⟨979 * scale, by ring⟩

/-- Refutation of the author’s unbounded uniqueness conjecture. -/
theorem refute_A399369_conjecture2 : ¬ Conjecture2 := by
  intro claim
  obtain ⟨hp, _, _, hd, hgt⟩ := collision
  have heq := (claim _ _ hp hd).1
  omega

end PrimeCarry

#print axioms PrimeCarry.refute_A399369_conjecture2
