#set document(
  author: "Beau McCartney",
  title:  "CPSC 351 Final Exam Info Sheet",
)

== Discrete Probability

#let Pd = $upright(P)$
#let PB = $upright(P)_B$
#let powom = $cal(P)(Omega)$

#let Ex = $upright(E)$

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
that:
- $forall x in Omega, 0 <= Pd(x) <= 1$, and
- $sum_(x in Omega)Pd(x) = 1.$

If $Omega$ is countable, then a probability distribution #Pd is "extended" to a
function over the events of a sample space $Pd : powom arrow.r RR$ by assuming
$ forall A in powom, Pd(A) = sum_(x in A)Pd(x). $

If $Omega$ is finite, then the *_uniform probability distribution_* of $Omega$
is a distribution such that $forall x in Omega, Pd(x) = 1 /
abs(Omega).$#footnote[Recall that elements of a sample space $Omega$ are called
*_outcomes._*] If #Pd is a uniform distribution, then for any event $A
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


=== Conditional Probability

Let $Omega$ be a sample space, $Pd : Omega arrow.r RR$ be a probability
distribution over $Omega$, and $A, B subset.eq Omega$ be events such that
$Pd(B) > 0$.

The *_conditional probability_* of $A$ given $B$ is $ Pd(A|B) = Pd(A inter B)
/ Pd(B). $ Note that $Pd(A|B)$ is not defined when $Pd(B) = 0$.

Law of total probability:
$ Pd(A) = Pd(A inter B) + Pd(A inter overline(B)) = Pd(A|B) dot Pd(B) + Pd(A|overline(B)) dot Pd(overline(B)) $

#[

  #set enum(numbering: "(a)")

  Extended partition rule: suppose $k in NN$, and $B_1, B_2, dots, B_k$ such that:
  + $B_1, B_2, dots, B_k$ are pairwise disjoint. That is, $forall i, j in {1,
    2, dots, k}, i != j arrow.r B_i inter B_j = emptyset.$
  + $A subset.eq B_1 union B_2 union dots union B_k.$

]

Then: $ Pd(A) = sum_(i = 1)^k Pd(A inter B_i) = sum_(i = 1)^k Pd(A|B_i) dot Pd(B_i) $

Baye's theorem: Let $k in NN$, and suppose $Pd(A) > 0$ and $Pd(B) > 0$. Then:
$
Pd(A bar B) /*= Pd(B inter A) / Pd(B)*/ = (Pd(B|A) dot Pd(A)) / Pd(B)
$

Conditional probability distribution: The function $PB : Omega arrow.r RR$ such that
for every outcome $x in Omega$,
$
PB(x) = Pd({x}|B)
      = Pd({x} inter B)
      = cases(
        Pd(x) / Pd(B) &"if" x in     B,
        0             &"if" x in.not B,
      )
$

=== Independence

Events $A$ and $B$ are said to be *_independent_* if $Pd(A inter B) = Pd(A)
times Pd(B)$. The notion of independence can be generalized for events $A_1,
A_2, dots, A_k$ (where $k >= 2$) in two ways.
+ *Pairwise Independence:* $forall i, j in {1, 2, dots, k}, i != j arrow.r
  Pd(A_i inter A_j) = Pd(A_i) times Pd(A_j)$.
+ *Mutual Independence:* $forall S in cal(P)({1, 2, dots, k}), abs(S) >= 2
  arrow.r Pd(inter.big_(i in S)A_i) = product_(i in S) Pd(A_i)$.
  - Note that mutual independence implies pairwise independence.
  - Checking mutual independence constitutes checking the above product for every larger-than-two subset of the indices.

=== Random Variables

Let $Omega$ be a sample space.
- A *_random variable over $Omega$_* is a (total) function $X : Omega arrow.r RR$.
  - these are outcomes with some assosciated value e.g. the height of someone or something else
  - often, random variables have a range $V subset.eq RR$, meaning that the
    co-domain of the random variable can be thought of as $V$ i.e. $X : Omega
    arrow.r V$
- An *_indicator variable over $Omega$_* is a random variable $X$ with range
  ${0, 1}$. That is, $forall sigma in Omega, X(sigma) in {0, 1} subset.eq NN$.
  The "indicated" event is $X = 1$ i.e. ${sigma in Omega | X(sigma) = 1}
  subset.eq Omega$.

Let $X : Omega arrow.r RR$ be a random variable over $Omega$.
- The name "$X  = r$" refers to the event ${sigma in Omega | X(sigma)  = r} subset.eq Omega$.
- The name "$X >= r$" refers to the event ${sigma in Omega | X(sigma) >= r} subset.eq Omega$.
- And similar for the relations on the real numbers $<=, >, <, "and" !=.$

==== Expected Value of a Random Variable

Let $Pd : Omega arrow.r RR$ be a probability distribution over $Omega$.

Suppose that $ sum_(sigma in Omega)Pd(sigma) times abs(X(sigma)) $ is finite
i.e. "less than $+infinity$".#footnote[This is satisfied whenever $Omega$ is
finite]
- The *_expected value_ of $X$, with respect to $Pd$,* is the value $ Ex[X] =
  sum_(sigma in Omega) Pd(sigma) times X(sigma) $
- Let $B subset.eq Omega$ be an event. The *_conditional expectation_ of $X$
  given $B$* is the expected value of $X$ with respect to the conditional
  probability distribution $Pd_B$: $ Ex[X|B] = sum_(sigma in Omega)
  Pd_B (sigma) times X(sigma) $

Expectation via cases: $Ex[X] = Ex[X|B] times Pd(B) + Ex[X|B^complement] times
Pd(B^complement)$

==== Linearity of Expectation

Let $n in NN$, and, $X : Omega arrow.r R$ and $X_1, X_2, dots, X_n: Omega
arrow.r RR$ be random variables.
- "$X_1 + X_2 + dots + X_n$" Denotes a random variable (i.e. a _function_)
  where $ forall sigma in Omega, (X_1 + X_2 + dots + X_n)(sigma) = sum_(i =
  1)^n X_i (sigma). $
- Let $a, b in RR$. Then "$a dot X + b$" denotes a random variable (i.e.
  _function_) where $ forall sigma in Omega, (a dot X + b)(sigma) = a dot
  X(sigma) + b. $

Linearity of expectation:
- $Ex[X_1 + X_2 + dots + X_n] = sum_(i = 1)^n X_i (sigma)$
- $Ex[a dot X + b] = a dot Ex[X] + b$
- It is *_not_* generally true that $Ex[X_1 times X_2] = Ex[X_1] times Ex[X_2]$

==== Independent Random Variables

Consider random variables $X : Omega -> V_x$ and $Y : Omega -> V_y$, where
$V_x, V_y subset.eq RR$. Recall that $\"X = a and Y = b\" = {sigma in Omega |
X(sigma) = a "and" Y(sigma) = b}.$
- $X$ and $Y$ are *_independent_* if $Pd(X = a and Y = b) = Pd(X = a) times
  Pd(Y = b).$
- If $X$ and $Y$ are independent, then $Ex[X times Y] = Ex[X] times Ex[Y]$


Let $n in NN$, and let $X_1 : Omega arrow V_1, X_2 : Omega arrow V_2, dots, X_n:
Omega arrow V_n$ where $V_1, V_2, dots, V_n subset.eq RR$ be random variables.
- $X_1, X_2, dots, X_n$ are *_pairwise independent_* if $ forall i, j in {1, 2,
  dots, n}, i != j arrow X_i "and" X_j "are independent". $
- $X_1, X_2, dots, X_n$ are *_mutually independent_* if for all $S subset.eq
  {1, 2, dots, n}$, and for all combinations $a_i in V_i$ for all $i in S$, $
  Pd(and.big_(i in S) (X_i = a_i)) = product_(i in S) Pd(X_i = a_i) $
  - Note that mutual independence implies pairwise independence.

=== Tail Bounds

Let $Omega$ be a *_finite_* sample space, with a probability distribution $Pd:
Omega arrow RR$, let $X : Omega arrow V subset.eq RR$ be a random variable, and
$g : RR arrow V prime subset.eq RR$ be a total function. "$g(X)$" is the
*_composition_* of $X$ and $g$ and itself a random variable. Then
$
Ex[g(X)] &= sum_(mu in Omega) g(X(mu)) times Pd(mu)\
         &= sum_(v in V) g(v) times Pd(X = v)      \
         &= sum_(w in V prime) w times Pd(g(X) = w).
$

Let $a, b in V$.
- $Pd(X = b) = 1 arrow Ex[X] = b$
- $Pd(a < X <= b) = 1 arrow a < Ex[X] <= b$
- if $g, h: RR arrow RR$ and are total, then $Ex[g(X) + h(X)] = Ex[g(X)] + Ex[h(X)]$

Let $h : RR arrow RR$ be a total function with range $[0, infinity)$.

Basic inequality: $ forall a in RR, a > 0 arrow Pd(h(X) >= a) <= Ex[h(X)]/a $

Markov's Inequality: $ forall a in RR, a > 0 arrow Pd(abs(X) >= a) <= Ex[abs(X)]/a $

The *_variance_ of $X$, with respect to $P$* is $ "var"(X) = sum_(mu in Omega)
(X(mu) - Ex[X])^2 times Pd(mu). $ If the sample space is finite, then $"var"(X)
= Ex[X^2] - Ex[X]^2$, where $X^2$ is the random variable such that $forall
sigma in Omega, X^2(sigma) = (X(sigma))^2$.

The *_standard deviation_ of $X$*, denoted $sigma(X)$, is $sqrt("var"(X))$.

Let $n in NN$, and $X_1, X_2, dots, X_n$ be random variables. If $X_1, X_2,
dots, X_n$ are *_pairwise independent_* then $ "var"(X_1 + X_2 + dots + X_n) =
sum_(i = 0)^n "var"(X_i). $

Chebyshev's Inequality: Let $a in RR$ s.t. $a > 0$. Then $ Pd(abs(X) >= a) <= Ex[X^2]/a^2. $

Cantelli's Inequality: Let $a in RR$ s.t. $a > 0$. Then $ Pd(X - Ex[X] >= a) <= "var"(X)/(a^2 + "var"(X)). $

Chernoof Bound: Suppose that $X_1, X_2, dots, X_n$ (for some $n in NN$) are
mutually independent indicator (that is, range ${0, 1}$) random variables such
that $exists p in RR,
0 <= Pd(X = 1) = p <= 1$. Let $X_Sigma = sum_(i = 1)^n X_i$. Then, $ forall
  theta in [0, 1], P(X >= (1 + theta) p n) <= e^(-theta^2/3 p n). $
