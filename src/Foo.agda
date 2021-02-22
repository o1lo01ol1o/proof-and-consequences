module Foo where
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl)



data Bool : Set where
  true : Bool
  false : Bool
  

not : Bool → Bool
not true = false
not false = true

¬¬ : Bool → Bool
¬¬ b = not (not b)

proof_doublenegation₁ : ∀ {b : Bool} → not (not b) ≡ b
proof_doublenegation₁ = {!!}
