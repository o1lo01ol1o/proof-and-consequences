---
layout: post
---

# The Uninteresting Waiter
```agda

module Hegal.Waiter.ZFC where 
open import Agda.Primitive using (Level; lsuc)
open import Relation.Binary.PropositionalEquality.Core using (_≡_; _≢_; refl)
open import Data.List

```
We'll go through the motions of the naive, quasi set-theortic model of a waiter considering the difference between coffee-without-milk and coffee-without-cream.
```agda
module Uninteresting where

```
We're effectively going to treat "a coffee" as a finite set (of "stuff in a mug").  However, we're going to implement the finite set as an inductive list of types so that all stuff is not the same type.
```agda

data FinSet {a} : List (Set a) → Set (lsuc a) where
  []  : FinSet []
  _∷_ : {firstElement : Set a}{remainder : List (Set a)}
        (x : firstElement) (xs : FinSet remainder) → FinSet (firstElement ∷ remainder)
infixr 5 _∷_
```
 We'll take "coffee" as a primative type with only one constructor.
```agda
data Coffee : Set where
  coffee : Coffee

```
Cream and milk are similarly defined.
```agda
data Cream : Set where
  cream : Cream
  
data Milk : Set where
  milk : Milk

```
Equality (≡) between types is proven when you can provide evidence with the `refl` constructor. Since our types are constructed with a single constructor proving self-equality is trivial:
```agda
proof₁ : Coffee ≡ Coffee
proof₁ = refl

proof₂ : Milk ≡ Milk
proof₂ = refl

```
However, we cannot say that milk is not equal to cream since relations are only possible between terms of the same type.
```agda
-- impossible : Milk ≢ Cream

```
We'll treat the semantics of "with" as a union of finite sets. 
```agda
infixr 5 _with'_

_with'_ : ∀ {l : Level} {m n : List (Set l)} →  FinSet m →  FinSet n → FinSet (m ++ n)
[] with' xs = xs
(x₁ ∷ x₂) with' x = x₁ ∷ (x₂ with' x)
```
Coffee with milk is just a set of coffee and milk squished together

```agda
CoffeeWithMilk = (Coffee ∷ []) with' (Milk ∷ [])
CoffeeWithCream = (Coffee ∷ []) with' (Cream ∷ [])

proof₃ : CoffeeWithMilk ≡ CoffeeWithMilk
proof₃ = refl
```
And, as before, we cannot produce a proof of relation between different types, so neither equality nor inequality can be proved.
```agda
-- impossilble₂ : CoffeeWithMilk ≡ CoffeeWithCream


```
Will take the semantics of "without" to be a specialization of the constant map that simply returns the domain.
```agda
_without_ :  ∀ {l : Level} {m n : List (Set l)} →  FinSet m →  FinSet n → FinSet m
a without b = a
```
And now we have all the machinery to show that coffee-without-milk is equal to coffee-without-cream:
```agda

proof₄ : ((Coffee ∷ []) without (Cream ∷ [])) ≡ ((Coffee ∷ []) without (Milk ∷ []))
proof₄ = refl

```

This is all fairly trivial.  However, the forgoing demonstrations rest on the assumption that (at least some) linguistic signifiers relative to a context can be transparent with respect to a structure that they are said to represent.  One of course can make such an assumption, however, interesting things happen when one instead treats the signifiers as opaque.

Next time we'll look at catagorical distributional semantics which take signifiers as objects in the categoy of finite vectorspaces and, later, we'll look at how Lawvere approaches the Hegalian Aufhebung more generally via adjunction.

