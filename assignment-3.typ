#import "@preview/intextual:0.1.1": *

#set document(
  title: "CPSC 351 F2025 Assignment 3",
  author: ("Beau McCartney", "Sargun Kaur", "Luis Hernandez"),
)

// #set heading(numbering: "Part 1.(a)") // REVIEW: automate headings for questions?
#show: intertext-rule

#let Ex = $upright(E)$

#let alphaar = $arrow(alpha)$

#let var(x) = $"var"(#x)$

#let Bhat = $hat(B)$

#title()

*Group:* 16\
*Members:* Beau McCartney (30095634), Sargun Kaur (30268472), Luis Hernandez (30241559)

We will use $Omega$ to refer to the sample space of this experiment.

Recall that if $X$ is a random variable over $Omega$, the notation $X = a$
denotes the set $ { sigma in Omega | X(sigma) = a } $ for some $a in RR$.

= Question 1

// Barbie and Ken's basketball game can be modelled using the below *_sample space:_* $
// Omega = {chevron.l beta_1, gamma_1, gamma_2, beta_2, gamma_3, gamma_4, ... beta_n, gamma_(2n - 1), gamma_(2n) chevron.r | beta_i, gamma_i in {"S", "F"} "for" 1 <= i <= n "and" 1 <= j <= 2n}
// $
//
// Here, $ arrow(alpha) = $
//
// Recall the sample space of this experiment: $
// Omega = {chevron.l beta_1, gamma_1, gamma_2, beta_2, gamma_3, gamma_4, ... beta_n, gamma_(2n - 1), gamma_(2n) chevron.r | beta_i, gamma_i in {"S", "F"} "for" 1 <= i <= n "and" 1 <= j <= 2n}.
// $


== 1 (a)

Let $i$ be an arbitary integer such that $1 <= i <= 2n$ so that $P(K_i = 1) =
1/3$.

By definition, the event $K_i != 1$ is the complement of the event $K_i = 1$.
Therefore they are disjoint, and their union is just the sample space $Omega$.
// REVIEW: is this complicating things, or clarifying them? Can set builder
// notation be used instead
That is,
$
\"K_i = 1\" inter \"K_i != 1\" = emptyset "and" \"K_i = 1\" union \"K_i != 1\" = Omega.
$
Additionally, since the range of $K_i$ is ${0, 1}$, it follows that $K_i !=
1$ and $ K_i = 0$  are the same event.

Since the probability of an event is the sum of the probabilities of the
outcomes belonging to that event, and $K_i = 1$ is an event, it follows that: $
P(K_i = 1) = sum_(alphaar in (K_i = 1))P(alphaar) = 1/3.
$

We can now derive $Ex[K_i]$:
$
#intertext[Starting with the definition of expectation:]
&Ex[K_i] = sum_(alphaar in Omega)P(alphaar) times K_i (alphaar)                                                                                          \
#intertext[Since $K_i = 1$ and $K_i != 1$ are disjoint and their union is the
sample space $Omega$, we can just sum across each set and add the two sums:]
&Ex[K_i] = sum_(alphaar in (K_i = 1))(P(alphaar) times K_(i)(alphaar)) + sum_(alphaar in (K_i != 1))(P(alphaar) times K_(i)(alphaar))                         \
#intertext[We can substitute in $K_i = 0$ for $K_i != 1$ since they're the same
set. The definitions of the sets being summed over trivially gives the value of
$K_(i)(alphaar)$ in each sum:]
&Ex[K_i] = sum_(alphaar in (K_i = 1))(P(alphaar) times 1) + sum_(alphaar in (K_i = 0))(P(alphaar) times 0)                                       \
#intertext[Multiplying out the ones and zeros:]
&Ex[K_i] = sum_(alphaar in (K_i = 1))P(alphaar)                                                                                                             \
#intertext[As we've already established, this is just $P(K_i = 1)$. Subbing in:]
&Ex[K_i] = P(K_i = 1)\
&Ex[K_i] = 1/3
$

Since $i$ is an arbitrary integer and $1 <= i <= 2n$, it follows that for all
integers $i$ where $1 <= i <= 2n$, $Ex[K_i] = 1/3.$

== 1 (b)

Let $i$ be an arbitary integer such that $1 <= i <= 2n$ so that $P(K_i = 1) =
1/3$, and $Ex[K_i] = 1/3$, as established in part (a).

Since the sample space is finite, we can use the finite form of variance: $
var(K_i) = Ex[(K_i)^2] - Ex[K_i]^2
$

However, we first must find $Ex[(K_i)^2]$.

Recall that the range of $K_i$ is ${0, 1}$. Since zero and one (that is,
*_every element_* in the range of $K_i$) are idempotent under multiplication,
it follows that for every outcome $alphaar in Omega$, $ (K_i)^2(alphaar) = (K_i
(alphaar))^2 = K_i (alphaar), $ and so $Ex[(K_i)^2] = Ex[K_i] = 1/3.$


We can now derive $var(K_i)$.

$
#intertext[Starting with the finite form of variance:]
var(K_i) = Ex[(K_i)^2] - Ex[K_i]^2\
#intertext[Subbing in the values for $Ex[(K_i)^2]$ and $Ex[K_i]$, we can immediately compute the variance:]
var(K_i) = 1/3 - (1/3)^2\
= 2/9
$

Since $i$ is an arbitrary integer and $1 <= i <= 2n$, it follows that for all
integers $i$ where $1 <= i <= 2n$, $var(K_i) = 2/9.$

== 1 (c)

Let $j$ be an abitrary integer such that $1 <= j <= n$, so that $P(B_j = 1) =
3/4$.

Since $Bhat_j = 1 - B_j$, it follows that $B_j = 1$ and $Bhat_j = 0$ are the
same event, and so $
P(Bhat_j = 0) = P(B_j = 1) = 3/4.
$

By definition, the event $Bhat_j != 0$ is the complement of $Bhat_j = 0$. Therefore,
they are disjoint, and their union is just the sample space. That is, $
\"Bhat_j = 0\" inter \"Bhat_j != 0\" = emptyset "and" \"Bhat_j = 0\" union \"Bhat_j != 0\" = Omega.
$

Additionally, since the range of $Bhat_j$ is ${0, 1}$, it follows that $Bhat_j
!= 0$ and $Bhat_j = 1$ are the same event.

Since $Bhat_j = 1$ is the complement of $Bhat_j = 0$, it follows that $
P(Bhat_j = 1) = 1 - P(Bhat_j = 0) = 1 - 3/4\
= 1/4.
$

Since the probability of an event is the sum of the probabilities of the outcomes
belonging to that event, and $Bhat_j = 1$ is an event, it follows that: $
P(Bhat_j = 1) = sum_(alpha in (Bhat_j = 1))P(alphaar) = 1/4.
$

We can now derive $Ex[Bhat_j]$.
$
#intertext[Starting with the definition of expectation:]
&Ex[Bhat_j] = sum_(alphaar in Omega)P(alphaar) times Bhat_j (alphaar)                                                                                          \
#intertext[Since $Bhat_j = 1$ and $Bhat_j = 0$ are disjoint and their union is the
sample space $Omega$, we can just sum across each set and add the two sums:]
&Ex[Bhat_j] = sum_(alphaar in (Bhat_j = 1))(P(alphaar) times Bhat_(j)(alphaar)) + sum_(alphaar in (Bhat_j = 0))(P(alphaar) times Bhat_(j)(alphaar))                         \
#intertext[The definitions of the sets being summed trivially gives the value
of $Bhat_(j)(alphaar)$ in each sum:]
&Ex[Bhat_j] = sum_(alphaar in (Bhat_j = 1))(P(alphaar) times 1) + sum_(alphaar in (Bhat_j = 0))(P(alphaar) times 0)                                       \
#intertext[Multiplying out the ones and zeros:]
&Ex[Bhat_j] = sum_(alphaar in (Bhat_j = 1))P(alphaar)                                                                                                             \
#intertext[As we've already established, this is just $P(Bhat_j = 1)$. Subbing in:]
&Ex[Bhat_j] = P(Bhat_j = 1)\
&Ex[Bhat_j] = 1/4
$

Since $j$ is an arbitrary integer and $1 <= j <= n$, it follows that for all
integers $j$ where $1 <= j <= n$, $Ex[Bhat_j] = 1/4.$

== 1 (d)

Let $j$ be an arbitary integer such that $1 <= j <= n$ so that $P(Bhat_j = 1) =
1/4$, and $Ex[Bhat_j] = 1/4$, as established in part (c).

Since the sample space is finite, we can use the finite form of variance: $
var(K_i) = Ex[(Bhat_j)^2] - Ex[Bhat_j]^2
$

However, we first must find $Ex[(Bhat_j)^2]$.

Recall that the range of $Bhat_j$ is ${0, 1}$. Since zero and one (that is,
*_every element_* in the range of $Bhat_j$) are idempotent under
multiplication, it immediately follows that for every outcome $alphaar in
Omega$, $(Bhat_j)^2(alphaar) = (Bhat_j (alphaar))^2 = Bhat_j (alphaar)$ and so
$Ex[(Bhat_j)^2] = Ex[Bhat_j] = 1/3.$


We can now derive $var(Bhat_j)$.

$
#intertext[Starting with the finite form of variance:]
var(Bhat_j) = Ex[(Bhat_j)^2] - Ex[Bhat_j]^2\
#intertext[Subbing in the values for $Ex[(Bhat_j)^2]$ and $Ex[Bhat_j]$, we can immediately compute the variance:]
var(Bhat_j) = 1/4 - (1/4)^2\
= 3/16
$

Since $j$ is an arbitrary integer and $1 <= j <= n$, it follows that for all
integers $j$ where $1 <= j <= n$, $var(Bhat_j) = 3/16.$

== 1 (e)

Let $alphaar in Omega$ be an arbitrary outcome in the experiment. Recall the definition
of $W : Omega arrow RR$: $
W(alphaar) = K_1(alphaar) + K_2(alphaar) + dots + K_(2n)(alphaar) + Bhat_1(alphaar) + Bhat_2(alphaar) + dots + Bhat_(n)(alphaar)
$

Since each of the summands is a random variable, can apply linearity of expectation to find $Ex[W]$:
$
Ex[W] &= Ex[K_1(alphaar) + K_2(alphaar) + dots + K_(2n)(alphaar) + Bhat_1(alphaar) + Bhat_2(alphaar) + dots + Bhat_(n)(alphaar)] \
      &= Ex[K_1(alphaar)] + Ex[K_2(alphaar)] + dots + Ex[K_(2n)(alphaar)] + Ex[Bhat_1(alphaar)] + Ex[Bhat_2(alphaar)] + dots + Ex[Bhat_(n)(alphaar)]\
$

In part (a), we showed that $Ex[K_(i)(alphaar)] = 1/3$ for all
integers in [1, 2n] (that is, each subscript of $K$ present in the above sum).
Similary we showed in part (c) that $Ex[Bhat_(j)(alphaar) = 1/4]$ for all
integers in [1, n] (that is, each subscript of #Bhat present in the above sum).
Subsituting in:
$
Ex[W] &= sum_(i = 1)^(2n)1/3 + sum_(i = 1)^(n)1/4\
      &= (2n)/3 + n/4\
      &= (11n)/12
$

= Question 2

The random variables $K_1, K_2, dots, K_(2n), Bhat_1, Bhat_2, dots, Bhat_n$
mutually independent if an only if the following condition holds: For every
subset $S_K subset.eq {1, 2, dots, 2n}$ and for every subset $S_Bhat subset.eq
{1,2,dots,n}$, and for all combinations $a_i in {0, 1}$ for all $i in S_K$ and
for all combinations $b_j in {0, 1}$ for all $j in S_Bhat$,

$
P((and.big_(i in S_K)(K_i = a_i)) and (and.big_(j in S_Bhat)(Bhat_j = b_j)) ) = product_(i in S_K)(P(K_i = a_i)) times product_(j in S_Bhat)(P(Bhat_j) = b_j).
$


In the assignment document, we are told explicitly that Ken and Barbie's shot's
are mutually independent.
