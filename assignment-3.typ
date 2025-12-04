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
#let hsigma = $hat(sigma)$
#let hB = $hat(B)$

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


// In the assignment document, we are told explicitly that Ken and Barbie's shot's are mutually independent.

We can confirm that the random variables listed above are mutually independent, since the sample space, $Omega$, is built from independent coordinate trials; where each outcome is a list of independent results. ( $K_1, K_2, dots, K_(2n), Bhat_1, Bhat_2, dots, Bhat_n$) Due to this fact the probability of any outcome is the product of the probabilities of each given attempt. In each random variable given, $B_(n)$ is only dependent on the $n^"th"$ attempt taken by Barbie , and $K_(2n)$ is only dependent on the $(2n)^"th"$ attempt taken by ken. Since any of these events are independent and the probability of any combination of them factors into a product, any combination of $K_1, K_2, dots, K_(2n), Bhat_1 $ and $ Bhat_2, dots, Bhat_n$ also has a probability that factors into a product. Satisfying the definition of what it means for random variables to be mutually independent.

= Question 3

== 3 (a)
To solve this problem we will be using the Theorem introduced in lecture 21
that states the following:

Let $Omega$ be a finite sample space with probability distribution $P : Omega
-> RR $ and let $X_1, X_2, ... X_n : Omega -> RR$ be random variables (for some
positive integer $n$). If $X_1, X_2, ... X_n$ are pairwise independent then $
var( X_1 + X_2 + ... + X_n) = var(X_1) + var(X_2) + ... + var(X_n). $

Since we know that the variables are mutually independent this also means that
they are pairwise independent, so we can use the theorem given above.

As stated in the document given,



$W : Omega -> RR $ such that, for every outcome $hsigma in Omega$  as shown at
line (2),

$ W(hsigma) = K_1(hsigma) + K_2(hsigma) + ... + K_(2n)(hsigma) + hB_1(hsigma) +
hB_2(hsigma) + ... + hB_n (hsigma) $

So to solve for $var(W)$,  using theorem stated above:

$ var(W) = var(K_1(hsigma)) + var(K_2(hsigma)) + ... + var(K_(2n)h(sigma)) +
var(hB_1(sigma)) + var(hB_2(hsigma)) + ... + var(hB_n (hsigma))  $

Which can be simplified to:

$ var(W) =  sum_(i=1)^(2n)(var(K_i)) + sum_(j=1)^n (var(hB_j)) $

Where $i$ and $j$ are both integers in the range $1 <= i <= 2n$ and $1 <= j <=
n$ respectively. In 1 (b), we established that for integers $i$ where $1 <= i
<= 2n$ (that is, the above bound on $i$), $"var"(K_i) = 2/9.$ In 1 (d), we
established that for integers $j$ where $1 <= j <= n$ (that is, the above bound
on $j$), $"var"(Bhat_j) = 3/16.$ Substituting into $"var"(W)$, we have:

$
var(W) &=  sum_(i=1)^(2n)(var(K_i)) + sum_(j=1)^n (var(hB_j))\
var(W) &= 2n times 2/9 + n times 3/16 \
var(W) &= (91n)/144
$

== 3 (b)

To solve this problem we will be using the Theorem introduced in lecture 21
that states the following:

Let $Omega$ be a finite sample space, let $P : Omega -> RR$ be a probability
distribution for $Omega$, and let $X$ be a random variable. Then $X^2$ is also
a random variable, and

$ var(X) = Ex[X^2] - Ex[X]^2 $

Adding $Ex[X]^2$ to both sides, we have

// For our purposes, we will be using simple algebra to rearrange this theorem, to
// solve for $Ex[X^2]$, which will make it the following:

$ Ex[X^2] = var(X) + Ex[X]^2. $

From previous answers we know that: $var(W) =  (91n)/144$ and $Ex[W] =
(11n)/12$. Applying these to the above equation, we have:
$
Ex[W^2] &= var(W) + Ex[W]^2                   \
Ex[W^2] &= (91n)/144 + ((11n)/12)^2           \
Ex[W^2] &= (91n)/144 + (121n^2)/144           \
Ex[W^2] &= (91n + 121n^2)/144                 \
Ex[W^2] &= (121n^2 + 91n)/144
$

= Question 4

Let $alphaar in Omega$ be an arbitrary outcome. Suppose that Barbie and Ken
take more than zero shots. That is, $n > 0$.

To proceed, it is necessary to find $abs(W)$. Recall the definition of $W$: $
W(alphaar) = K_(1)(alphaar) + K_(2)(alphaar) + dots + K_(2n)(alphaar) + Bhat_(1)(alphaar) +  Bhat_(2)(alphaar) + dots + Bhat_(n)(alphaar)
$

Since $n$ is finite, there are a finite number of summands in $W$.
Additionally, we know from the definitions of $K_i$ and $Bhat_i$ that they both
have range ${0, 1}$. That is, every element of the range is *_not_* negative.
Thus $W$ is a finite sum of non-negative integers, and so $W(alphaar) >= 0$, for
every $alphaar in Omega$. This implies that $abs(W(alphaar)) = W(alphaar)$, for
every outcome $alphaar in Omega$ and so $abs(W) = W$.

== 4 (a)

Since $Omega$ is finite and $n > 0$, we can apply Markov's inequality to bound
the probability that $W >= n$.

$
#intertext[Starting with the definition of Markov's inequality, applied to $W$ and $n$:]
P(abs(W) >= n) &<= Ex[abs(W)]/n \
#intertext[Applying $abs(W) = W$:]
P(W >= n) &<= Ex[W]/n           \
#intertext[We've already established that $Ex[W] = (11n)/12$. Subbing in:]
P(W >= n) &<= ((11n)/12) times 1/n      \
P(W >= n) &<= 11/12
$

== 4 (b)

Since $Omega$ is finite and $n > 0$, we can apply Chebychev's Inequality to
bound the probability that $W >= n$.

$
#intertext[Starting with the definition of Chebychev's inequality, applied to $W$ and $n$:]
P(abs(W) >= n) &<= Ex[W^2]/n^2                      \
#intertext[Applying $abs(W) = W$:]
P(W >= n) &<= Ex[W^2]/n^2                           \
#intertext[We've already established that $Ex[W^2] = $. Subbing in:]
P(W >= n) &<= ((121n^2 + 91n)/144) times 1/n^2      \
P(W >= n) &<= 121/144 + 91/(144n)
$

== 4 (c)

Since $Omega$ is finite and $n > 0$, we can apply Cantelli's Inequality to bound
the probability that $W >= n$.

$
#intertext[First, we need to turn our probability into the form used in
Cantelli's inequality. We begin by subtracting $Ex[W]$ from both sides of $W >=
n$: ]
P(W >= n) &= P(W - Ex[W] >= n - Ex[W])   \
          &= P(W - Ex[W] >= n - (11n)/12)\
          &= P(W - Ex[W] >= n/12)        \
$
$
#intertext[We can now apply Cantelli's inequality to bound this probability:]
P(W - Ex[W] >= n/12) &<= var(W)/((n/12)^2 + var(W))\
#intertext[We've already established that $var(W) = (91n)/144$. Substituting into the above equation:]
P(W - Ex[W] >= n/12) &<= ((91n)/144)/(n^2/144 + (91n)/144)\
#intertext[Multiplying the numerator and the denominator by $144/n$, we have:]
P(W - Ex[W] >= n/12) &<= 91/(n + 91)\
#intertext[Since $P(W - Ex[W] >= n/12) = P(W >= n)$, we have:]
P(W >= n) <= 91/(n + 91)
$

// (a)* Markov's Inequality:* Since $Ex[W] = (11n)/12 $ and W is a non-negative random variable( that is, $W(mu)>= 0 $ for all $mu in Omega $, so that $W=|W|$), Markov's Inequality implies that $  P(W>=n) &= P(|W|>=n) $
// $        &<= (Ex[|W|])/n $
//   $      &= ((11n)/12)/n $
//   $       &= 11/12 $
//
// (b) *Chebyshev's Inequality:* In order to apply this, we need $Ex[W^2]$, which we calculated above as
// $Ex[W^2] = (91n + 121n^2)/144 $
// It follows by Chebyshev's Inequality that:
// $ P(W >= n) &= P( |W| >= n) $$ <= (Ex[W^2])/n^2 $
// $          &= ((91n + 121n^2)/144)/(n^2)       $
// $          &= (91 + 121n)/(144n) $
//
// (c) *Cantelli's Inequality:* Since $Ex[W] = (11n)/12, W >= n $ iff $W - Ex[W] >= n - (11n)/(12)$
//   $&= n/12 $
//
//   It follows by Cantelli's Inequality that:
//
//   $ P(W >= n) &= P( W - Ex[W] >= (n)/(12) ) $
//             $  & <= (var(W))/((n/12)^2 + var(W)) $
//             $ &=  (91n"/"144)/((n^2"/"144)+(91n"/"144)) $
//             $ &= 91/( 91+ n) $
//   We can also notice that this limit approaches zero as _n_ approaches infinity, so that this is a much better bound than the others that have been obtained when _n_ is large.

= Question 5

// I think this is to be done by chernoff bound, but I'm still figuring out how to do that- Sargun
We want to find P(W>n). W>n can happen only if at east one of these holds for some $lambda$ such that $0<= lambda<= 1$:
 - K1(~α) + K2(~α) + · · · + K2n(~α) > 2/3n + δ/12n .
 -  ̂B1(~α) + ̂ B2(~α) + · · · + ̂ Bn(~α) > 1/4n + (1−δ)/12n
// applying chernoff to eq1 and then to eq2 and then a union of them?

= Question 6
