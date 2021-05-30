```

module Hegal.Waiter.ZFC where 
open import Data.Nat.Base as ℕ using (ℕ; zero; suc; z≤n; s≤s)
open import Data.Nat using (_≤?_)
open import Data.Empty using (⊥)
open import Agda.Primitive using (Level; lsuc)
open import Relation.Binary.PropositionalEquality.Core using (_≡_; _≢_; refl; cong)
open import Relation.Nullary using (¬_ ; Dec; yes; no)
open import Data.Empty using (⊥-elim)
open import Data.List

```
We'll go through the motions of the naive, set-theortic model of a waiter considering the difference between coffee-without-milk and coffee-without-cream.
```
module ClassicalWaiter where

```
We're effectively going to treat "a coffee" as a finite set (of contents).  However, we're going to implement the finite set as an inductive list of types.
```

data FinSet {a} : List (Set a) → Set (lsuc a) where
  []  : FinSet []
  _∷_ : {firstElement : Set a}{remainder : List (Set a)}
        (x : firstElement) (xs : FinSet remainder) → FinSet (firstElement ∷ remainder)
infixr 5 _∷_
```
 We'll take "coffee" as a primative type with only one constructor.
```
data Coffee : Set where
  coffee : Coffee

```
Cream and milk are similarly defined.
```
data Cream : Set where
  cream : Cream
  
data Milk : Set where
  milk : Milk

```
Equality (≡) between types is proven when you can provide evidence with the `refl` constructor. type Let's check to see that we can show coffee equivalent to coffee and milk is equivalent milk.
```
proof₁ : Coffee ≡ Coffee
proof₁ = refl

proof₂ : Milk ≡ Milk
proof₂ = refl
```
However, we cannot say that milk is not equal to cream since the relation of equality is only possible between terms of the same type.
```
-- impossible : Milk ≢ Cream

```
We treat the semantics of "with" as a union of finite sets. 
```
infixr 5 _with'_

_with'_ : ∀ {l : Level} {m n : List (Set l)} →  FinSet m →  FinSet n → FinSet (m ++ n)
[] with' xs = xs
(x₁ ∷ x₂) with' x = x₁ ∷ (x₂ with' x)
```
Coffee with milk is just a set of coffee and milk squished together
```
CoffeeWithMilk = (Coffee ∷ []) with' (Milk ∷ [])
CoffeeWithCream = (Coffee ∷ []) with' (Cream ∷ [])

proof₃ : CoffeeWithMilk ≡ CoffeeWithMilk
proof₃ = refl
```
And, as before, we cannot produce a proof of relation between different types, so neither equality nor inequality can be proved.
```
-- impossilble₂ : CoffeeWithMilk ≡ CoffeeWithCream


```
Will take the semantics of "without" to be a specialization of the constant morphism that simply returns the first argument.
```
_without_ :  ∀ {l : Level} {m n : List (Set l)} →  FinSet m →  FinSet n → FinSet m
a without b = a
```
And now we all the machinery to show that  coffee-without-milk is equal to coffee-without-cream:
```

proof₄ : ((Coffee ∷ []) without (Cream ∷ [])) ≡ ((Coffee ∷ []) without (Milk ∷ []))
proof₄ = refl


