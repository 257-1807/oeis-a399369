module

public import PrimeCarry.Encoding
import Mathlib.Tactic.NormNum.Prime

public section

namespace PrimeCarry

set_option exponentiation.threshold 350
set_option maxRecDepth 12000
set_option maxHeartbeats 2000000

private theorem weight_11 : weight 11 = 210 := by
  norm_num [weight]

private theorem weight_89 : weight 89 = 267064515689275851355624017992790 := by
  norm_num [weight]

private theorem weight_241 : weight 241 = 1062411448280052319722448549835623701226301211611796930357321893850294264731624591303255041960530 := by
  norm_num [weight]

/-- A code of fewer than 350 bits can be decoded with 350 prime digits,
because each radix is at least two. -/
private theorem verify (code value : ℕ) (h : code < 2 ^ 350)
    (certificate : decodePrefix 350 2 code = value) : primorialExp code = value :=
  (decodePrefix_eq 350 2 code (by decide) h).symm.trans certificate

/-- The surviving factors of 1024 after the carries are 3² and 5. -/
theorem reduced_left : reduced (1024 * scale) = 45 * scale := by
  unfold reduced
  rw [encoding_left, weight_241]
  apply verify
  · decide
  · decide +kernel

/-- One carry changes the factor 2² in 3916 to 3, leaving 11 and 89. -/
theorem reduced_right : reduced (3916 * scale) = 2937 * scale := by
  unfold reduced
  rw [encoding_right, weight_11, weight_89, weight_241]
  apply verify
  · decide
  · decide +kernel

end PrimeCarry
