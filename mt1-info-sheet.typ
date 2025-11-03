#set document()

#set page(
  paper: "us-letter",
  margin: 0.5cm,
)

#set text(
  size: 7.0pt
)

#let sigstar = $Sigma^star$
#let q0      = $q_0$

== Alphabets, Strings, and Languages:

Definitions:
- *Alphabet:* a finite non-empty set. Usually called $Sigma$ here.
- *Symbol:* an element of an alphabet.
- *String:* a *_string_* over an alphabet $Sigma$ is a finite sequence of symbols in $Sigma$. Strings are *_not_* sets i.e. order matters and duplicates may be present.
  - *length*: the *_length_* of a string $omega$ over an alphabet $Sigma$ (denoted by $abs(omega)$) is the number of symbols in the sequence. The empty string over any alphabet is denoted by $lambda$. All strings have natural length.
  - For any alphabet $Sigma$, *#sigstar* is the set of _all_ strings over $Sigma$.
- *String concatenation:* the concatenation of two strings is just the second string appended to the first. Its length is the sum of the length of the two strings.
- *Substring:* a string $mu$ is a *_substring_* of $omega$ if $omega = omega_1 dot mu dot omega_2$ for some $omega_1, omega_2 in sigstar$.
  - prefix if $omega_1 = lambda$
  - suffix if $omega_2 = lambda$
- *Language:* a *_language_* over an alphabet $Sigma$ is a subset of #sigstar.

== DFA Design + Correctness:

A DFA is a 5-tuple $M = (Q, Sigma, delta, q0, F)$ where $Q$ is the set of
states, $Sigma$ is the alphabet defining what symbols the DFA can process ($Q
inter Sigma = emptyset$), $F$ is the set of "accepting states" (thus $F
subset.eq Q$), $q0 in Q$ is the start state, and $delta : Q times Sigma
arrow.r Q$ is the transition function.

=== Correctness Steps:
+ What should the DFA remember about the string seen so far - make a set for each case
+ Sanity checks:
  + Finite number of sets
  + Each string, including $lambda$, belongs to exactly one of the sets. The set that corresponds to the start state contains $lambda$.
  + Each set is either a subset of $L$, or disjoint from $L$. Subsets of $L$ correspond to accepting states.
  + Transitions are well defined. Does appending a symbol (check for each symbol) to an arbitrary member of any of the sets guarantee the new string is in exactly one of the sets. Check for all sets, and all symbols.
+ Apply "Correctness of a DFA" theorem. It requires these properties:
  - Every string in #sigstar belongs to *exactly* one of the sets
  - $lambda in S_0$ (the set corresponding to the start state)
  - For every accepting state, its corresponding set is a subset of $L$
  - For every non-accepting state, its corresponding set is disjoint with $L$
  - Transitions are well defined and line up with sets i.e. if $d(q_i, sigma) = q_j$ then ${omega dot sigma | omega in S_i} subset.eq S_j$

== NFA:

#let deltastar = $delta^star$
#let lclosure(arg) = {
  return $C l_lambda (arg)$
}

NFA is 5-tuple $M = (Q, Sigma, delta, q0, F)$ where $Q, F, Sigma$, and $q0$
are the same as a DFA but the transition function $delta$ is different.

Let $Sigma_lambda = Sigma union {lambda}$. The transition function $delta : Q
times Sigma_lambda -> cal(P)(Q)$ maps states (and $lambda$) to a set of states.

The "_*$lambda$-closure*_" of a state $q$, $lclosure(q)$, is the *_set of
states_* reachable from $q$ by following *_zero or more_* $lambda$-transitions.

The *_extended transition function_* of an NFA is the total function $deltastar
: Q times sigstar arrow.r cal(P)(Q)$ defined for $q in Q$ and $omega in
sigstar$ as follows: $

deltastar(q, omega) = cases(
  lclosure(q) &"if" omega = lambda",",
  union.big_(r in deltastar(q, mu))(union.big_(s in delta(r, sigma))lclosure(s)) &"if" omega = mu dot sigma "for" mu in sigstar "and" sigma in Sigma".",
)
$
An NFA accepts a string $omega in sigstar$ iff *_$deltastar(q0, omega) inter F
!= emptyset$_*, and rejects the string otherwise.

Processing an input string can be thought of as *keeping track of _all_ the
states that can be reached as symbols are processed*.

=== NFA from DFA:

Suppose the DFA is $M = (Q, Sigma, delta, q0, F)$, then an NFA with the same
language $hat(M)$ is just $hat(M) = (Q, Sigma, hat(delta), q0, F) "where" hat(delta)(q, sigma) = cases({delta(q, sigma)} &"if" sigma in Sigma",", emptyset &"if" sigma = lambda.)$

=== DFA from NFA:

About the string seen so far $mu$, DFA needs to remember $deltastar(q0, mu)$
i.e. the set of states that can be reached from #q0 by processing $mu$. This
means *_the DFA has a state for every possible output of the NFA's extended
transition function._* i.e. state for every element in $delta$'s *_range_*.

Let $M = (Q, Sigma, delta, q0, F)$ be an NFA. To construct a DFA with the same
language $hat(M) = (hat(q), Sigma, hat(delta), hat(q0), hat(F))$.

We construct the function $phi : hat(Q) arrow.r cal(P)(Q)$, which maps states in
our DFA to elements in the range of our NFA's transition function $delta$.

Getting started:
- $deltastar(q0, lambda) = lclosure(q0))$ which implies that #lclosure(q0)
  is in the range of $delta$, meaning there's a DFA state for it.
- call this state $hat(q0)$. Since it corresponds to #lclosure(q0), we have $phi(hat(q0) = lclosure(q0))$

Continuing:
- Suppose $V$ is an element in the range of $delta$, and as such $V =
  deltastar(q0, mu) = phi(hat(q_k))$ for some state $hat(q_k) in hat(Q)$ and
  some $mu in sigstar$.
- Let $omega in Sigma$. Then the state in the DFA that should be reached from
  $hat(q_k)$ (the state corresponding to $V$) by processing $sigma$ corresponds
  to the set as follows:

$
phi(hat(delta)(hat(q_k), sigma)) = deltastar (q0, mu dot sigma) &= union.big_(r in deltastar (q0, mu))(union.big_(s in delta (r, sigma)) lclosure(s))\
                                                    &= union.big_(r in V)(union.big_(s in delta (r, sigma)) lclosure(s))\
                                                    &= union.big_(r in phi(hat(q_k)))(union.big_(s in delta (r, sigma)) lclosure(s))
$

We will keep track of two sets:
+ $hat(Q)$ - states corresponding to elements in the range of $delta$, where every transition has been defined. Initially $hat(Q) = emptyset$.
+ $hat(R)$ - states corresponding to elements in the range of $delta$, where not all transitions have been defined. Initially $hat(R) = {hat(q0)}$, where $phi(hat(q0)) = lclosure(hat(q0))$

- we pick some $hat(q) in hat(R)$ and find $hat(delta) (hat(q), sigma)$ for every symbol $sigma in Sigma$.
- if for some $q in Q$ and $sigma in Sigma$, some set $delta (q, sigma)$ is not in the co-domain of $phi$ (i.e. doesn't correspond to an existing DFA state), add a new state $hat(q)$ to $hat(R)$ and set $phi (hat(q)) = delta (q, sigma)$.
- move elements from $hat(R)$ to $hat(Q)$ when all their transitions have been defined.
- eventually $hat(R) = emptyset$, and both $Q$ and $hat(delta)$ have been completed.
- *REMEMBER THIS:* For all $hat(q) in hat(Q)$, $hat(q)$ should be in $hat(F)$ iff $phi(hat(q)) inter F != emptyset$.

#pagebreak()
== Regex:

=== Language operations:
- language union $A union B = {omega in sigstar | omega in A "or" omega in B}$,
- language concat $A compose B = {omega_1 dot omega_2 | omega_1 in A "and" omega_2 in B}$
- language Kleene star $A^star = {omega_1 dot omega_2 dot dot dot omega_k | k >= 0 "and" omega_i in A "for" 1 <= i <= k}$

=== Closure properties:
- if $A$ and $B$ are regular languages then $A union B$ is regular
- if $A$ and $B$ are regular languages then $A compose B$ is regular
- if $A$ is a regular language then $A^*$ is regular

Recall that the contrapositive of these statements is also true.

=== Regex and languages:

Alphabet $Sigma$ cannot include any of these: $lambda, emptyset, Sigma, (, ), union, compose, star$.

Regex alphabet is $Sigma_"regexp" = Sigma union {lambda, emptyset, Sigma, (, ), union, compose, star}$.

Regex is a string in $Sigma_"regexp"^star$ subject to the following rules:
- for every *_symbol_* $omega in Sigma$, the *string* $omega$ is a regex with language $L(sigma) = {sigma}$
- the regex $lambda$ (the literal character $lambda$, _*not*_ the empty string) has language $L(lambda) = {lambda}$
- the regex $emptyset$ has language $L(emptyset) = emptyset$
- the regex $Sigma$ has language $L(Sigma) = Sigma$ (i.e. every character in the alphabet)
- if $R_1$ and $R_2$ are regexes, then:
  - the regex $(R_1 union R_2)$ (parens are important) has language $L((R_1 union R_2)) = L(R_1) union L(R_2)$
  - the regex $(R_1 compose R_2)$ (parens are important) has language $L((R_1 compose R_2)) = L(R_1) compose L(R_2)$
  - the regex $(R_1)^star$ (parens are important) has language $L((R_1)^star) = L(R_1)^star$

A language is regular iff there exists a regex that has that language.

=== Showing the language/correctness of a regex:

Identify the languages of the
smallest regexes, then go up from there, finding the languages of regexes
composed of other regexes. Eventually you'll end up with the desired language.
- think DFS of a parse tree
- statements justifying why it's a regex and what language it has
  - e.g. "Since $a in Sigma$, 'a' is a regex with language $L(a) = {a}$"
  - e.g. "Since $(b union c)$ is a regex, $((b union c))^star$ is a regex with language ${b, c}^star$."


== Pumping lemma / non-regular languages:

=== Pumping Lemma

Let $L subset.eq sigstar$.

If $L$ is regular, then there exists an integer $p >= 1$ (called the "pumping
length" for $L$) s.t. if $s in L$ and $abs(s) >= p$, $s$ can be split into three
pieces $s = x y z$ ($x, y, z in sigstar$) satisfying the three
following conditions:

+ $x y^i z in L$ for every integer $i >= 0$
+ $abs(y) > 0$ i.e. $y != lambda$
+ $abs(x y) <= p$

Note that $y^i$ is the concatenation of $i$ copies of $y$.

=== Proving language is not regular with pumping lemma:
+ Assume (to obtain a contradiction) language is regular
+ Observe that conditions in the pumping lemma are satisfied (write them down)
+ Introduce the "pumping length" $p$
+ Introduce a string in the language $s$ ($s$ is the string in the lemma) with length $abs(s) >= p$
  - $s$ usually depends on $p$
+ Show that $s$ is in the language and $abs(s) >= p$
+ Infer that there exists strings $x, y, z in sigstar$ such that $s = x y z$ and
  the above pumping lemma properties hold
+ Use the pumping lemma properties to get a contradiction *_without making any other assumptions_*
+ Conclude that since assuming the language is regular led to a contradiction,
  the language must not be regular

Notes:
- $i$ can be chosen, since $x y^i z in L$ for every integer $i >= 0$, so
  counterexample is sufficient
- $i = 0$ and $i = 2$ are good starting choices
- observe how proof follows lemma's structure

== Induction on the length of a string

It's useful to do induction on the length of a string. The idea that enables is
incrementing the length of a string is just appending a symbol $sigma in Sigma$
to the string i.e. there's one case for each symbol $sigma in Sigma$.

Standard induction steps:
+ state intent to prove by induction
+ base case with some integer $n_0$
+ Suppose $P(n)$ is some property of $n$, the inductive step is proof that for all integers $n >= n_0, P(n) arrow.r P(n + 1)$
  - i.e. let $n >= n_0$ be arbitrary, and assume $P(n)$. Prove $P(n + 1)$.
  - often $k$ is used as the inductive integer instead of $n$
+ conclude that since base and inductive steps, thing you're proving is true for all $n >= n_o$ (INCLUDE THE FOLLOWING) *_by induction_*.

For induction on the length of a string:
- state that every string $omega in sigstar$ has a length $abs(omega) in NN$. Can call the length $n$.
- state induction on the length of the string $omega$
  - state standard or strong form of induction
- base case is $abs(omega) = 0$, which implies that $omega = lambda$ (since $lambda$ is the only member of #sigstar with length 0)
- inductive step is every string $omega in sigstar$ with length $abs(omega) = k + 1$ has property $P(k)$.
  - show that $omega$ isn't empty, and in particular $omega = mu dot sigma$ for some $mu in sigstar$ and $sigma in Sigma$
- proof should end with a conclusion e.g. "It now follows, by induction on length of the string $omega$, that every string $omega in sigstar$ \<has desired property\>"

== Misc notes:

$lambda in sigstar$, always
