#set document(
  author: "Beau McCartney",
  title:  "CPSC 351 Final Exam Info Sheet",
)

== Discrete Probability

#let Pd = $upright(P)$
#let PB = $upright(P)_B$
#let powom = $cal(P)(Omega)$

Let $Omega$ be some set.
- #powom is the powerset of some set $Omega$.
- If $Omega$ is finite, $abs(powom) = 2^abs(Omega)$

=== Experiments, Sample Spaces, and Events

- *Experiment:* a procedure that yields one of a given set of possible
  *_outcomes._*
- *Sample Space:* the set of possible *_outcomes_* of a given *_experiment_*.
  Often notated as $Omega$.
  - For this class, the sample space being considered is usually countable
    (i.e. discrete probability theory).
- *Event:* a subset of an experiment's *_sample space_*. Events of size one are
  known as *_elementary events_*, or sometimes just outcomes.
  - For the sample space $Omega$ of some experiment, $powom$ is *_the set of
    all events _* for that experiment.

=== Probability Distributions

Consider an experiment with a sample space $Omega$.

A *probability distribution* is a (total) function $Pd : Omega arrow.r RR$ such
that $forall x in Omega, 0 <= Pd(x) <= 1$, and $ sum_(x in Omega)Pd(x) = 1. $

If $Omega$ is countable, then a probability distribution #Pd is "extended" to a
function over the events of a sample space $Pd : powom arrow.r RR$ by assuming
$ forall A in powom, Pd(A) = sum_(x in A)Pd(x). $

If $Omega$ is finite, then the *_uniform probability distribution_* of $Omega$
is a distribution such that $forall x in Omega, Pd(x) = 1 /
abs(Omega)$#footnote[Recall that elements of a sample space $Omega$ are called
*_outcomes._*]. If #Pd is a uniform distribution, then for any event $A
subset.eq Omega$:
$
Pd(A) = sum_(x in A) Pd(x) = sum_(x in A) 1 / abs(Omega) = abs(A) / abs(Omega).
$

=== Complement and Union of Events

Let $Omega$ be the sample space of some experiment, and $A, B subset.eq Omega$ be
events in that sample space.
- The *_complement_* of $A$, $overline(A)$ is the set of outcomes _not_ in $A$
  i.e. $overline(A) = {x in Omega | x in.not A}$. In particular,
  $Pd(overline(A)) = 1 - Pd(A)$
- $Pd(A union B) = Pd(A) + Pd(b) - Pd(A inter B)$. This implies $Pd(A union B) <= Pd(A) + Pd(b)$.
- The above point can be generalized to more than two events. Suppose $k in NN$,
  and $E_1, E_2, dots, E_k subset.eq Omega$. Then $ Pd(E_1 union E_2 union dots union E_k) <= sum_(i = 1)^k Pd(E_i). $


=== Conditional Probability and Independence

Let $Omega$ be a sample space, $Pd : Omega arrow.r RR$ be a probability
distribution over $Omega$, and $A, B subset.eq Omega$ be events such that
$Pd(B) > 0$#footnote.

The *_conditional probability_* of $A$ given $B$ is $ Pd(A | B) = Pd(A inter B)
/ Pd(B). $ Note that $Pd(A | B)$ is not defined when $Pd(B) = 0$.

Law of total probability:
$ Pd(A) = Pd(A inter B) + Pd(A inter overline(B)) = Pd(A | B) dot Pd(B) + Pd(A | overline(B)) dot Pd(overline(B)) $

#[

  #set enum(numbering: "(a)")

  Extended partition rule: suppose $k in NN$, and $B_1, B_2, dots, B_k$ such that:
  + $B_1, B_2, dots, B_k$ are pairwise disjoint. That is, $forall i, j in [1,
    k], i != j arrow.r B_i inter B_j = emptyset.$
  + $A subset.eq B_1 union B_2 union dots union B_k.$

]

Then: $ Pd(A) = sum_(i = 1)^k Pd(A inter B_i) = sum_(i = 1)^k Pd(A | B_i) dot Pd(B_i) $

Baye's theorem: Let $k in NN$, and suppose $Pd(A) > 0$ and $Pd(B) > 0$. Then:
$
Pd(A bar B) /*= Pd(B inter A) / Pd(B)*/ = (Pd(B | A) dot Pd(A)) / Pd(B)
$

Conditional probability distribution: The function $PB : Omega arrow.r RR$ such that
for every outcome $x in Omega$,
$
PB(x) &= Pd({x} | B)    \
      &= Pd({x} inter B)\
      &= cases(
        Pd(x) / Pd(B) &"if" x in     B,
        0            &"if" x in.not B,
      )
$

=== Independence

Events $A$ and $B$ are said to be *_independent_* if $Pd(A inter B) = Pd(A) times Pd(B)$.
