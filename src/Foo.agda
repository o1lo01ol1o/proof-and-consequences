module Foo where
import Relation.Binary.PropositionalEquality as Eq
open Eq using (_≡_; refl; cong)
open import Data.Nat using (ℕ; zero; suc; _+_)
open import Data.Nat.Properties using (+-comm; +-identityʳ)


data Bool : Set where
  true : Bool
  false : Bool

not : Bool → Bool
not true = false
not false = true


¬¬ : Bool → Bool
¬¬ b = not (not b)



doublenegation : ∀ {b : Bool} → not (not b) ≡ b
doublenegation = {!!}
