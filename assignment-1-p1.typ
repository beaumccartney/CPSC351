#set text(size: 10pt)
#let list_indent = 1.5em



#set enum(numbering: "i.", indent: list_indent)
#set list(indent: list_indent)

#let sigstar = $Sigma^star$
#let arbstring = $omega in sigstar$
#let s0  = $S_0$
#let sa  = $S_a$
#let sc  = $S_c$
#let sab = $S_(a b)$
#let sac = $S_(a c)$
#let sL  = $S_L$
#let q0 = $q_0$
#let qa = $q_a$
#let qc = $q_c$
#let qab = $q_(a b)$
#let qac = $q_(a c)$
#let ql = $q_L$
#let qi = $q_i$
#let si = $S_i$

= CPSC 351 F2025 Assignment 1 Part 1

*Group:* 16\
*Members:* Beau McCartney (30095634), Sargun Kaur (30268472), Luis Hernandez (30241559)

== Question 1

// REVIEW(beau): I think we don't need any of this
// Goal: DFA that accepts strings containing at least one "c", and containing at
// least one "b" after one "a".

// $ L = { arbstring | "A copy of 'a' is eventually followed by a copy of 'b' in " omega " and " omega, \ " includes at least one of of 'c'." } $

// We need to remember whether the string, so far, belongs to L. The deterministic finite automata must remember that, the string so far, might be the whole string -- so it is necessary to remember at least this information. We must also remember by definition of L whether the string seen so far, includes a copy of 'a' that is eventually followed by a copy of 'b' and has at least one copy of 'c'.


//S: where should we mention that λ ∈ S0? 
For us to properly handle this deterministic finite automaton (DFA) with the language L (as defined in the assignment document) we must identify six cases to processes any string #arbstring. These cases will help us clearly illustrate all possible scenarios of $omega$.

Our goal is to construct a deterministic finite automaton (DFA) with the alphabet $Sigma = {a, b, c}$, and the language $L$ defined below:

$ L = { arbstring | "A copy "&"of \"a\"  is eventually followed by a copy of \"b\" in" \ &omega "and" omega "includes at least one of of \"c\"." } $


To that end, the DFA will have to remember which of the following six cases the string (seen so far) belongs to:

+ The string does not contain any copies of "a" or "c". 
+ The string contains at least one copy of "a", and no copies of "c". In the string, no copy of "a" is eventually followed by a copy of "b".
+ The string contains a copy of "a" eventually followed by a copy of "b", but no copies of "c".
+ The string contains a copy of "c" and no copies of "a".
+ The string contains a copy of "a", and a copy of "c". No copy of "a" is eventually followed by a copy of "b" in the string.
+ The string is in $L$. That is, a copy of "a" is eventually followed by a copy of "b" in the string, and the string includes at least one copy of "c".

We can define the set of states $Q$ that will be included in our deterministic finite automaton:

$ Q = { q0, qa, qc, qab, qac, ql } $

Each state corresponds to exactly one case defined above:

- #q0 corresponds to case _i_.
- #qa corresponds to case _ii_.
- #qab corresponds to case _iii_.
- #qc corresponds to case _iv_.
- #qac corresponds to case _v_.
- #ql corresponds to case _vi_.

For every state $qi in Q$, we define a corresponding set $si subset.eq sigstar$ such that for every string $mu in si$, processing $mu$ ends in state $qi$. In particular, each set has the same subscript as its corresponding state $qi in Q$.


// - $s0  &= { arbstring | omega "does not contain any copies of \"a\" or \"c\"" }$ e.g. the empty string, $lambda$
// - $sa  &= { arbstring | omega "contains at least one copy of \"a\", no copies of \"c\", and no copy of \"a\" is eventually followed by a copy of \"b\"" }$ e.g. $omega$ = "a"
// - $sab &= { arbstring | omega "contains a copy of \"a\" eventually followed by a copy of \"b\", and no copies of \"c\"" }$ e.g. $omega$ = "ab"
// - $sc  &= { arbstring | omega "contains at least one copy of \"c\" and no copies of \"a\"" }$ e.g. $omega$ = "bc"
// - $sac &= { arbstring | omega "contains a copy of \"a\", a copy of \"c\" and no copy of \"a\" is eventually followed by a copy of \"b\"" }$ e.g. $omega$ = "ac"
// - $sL  &= L$  e.g. $omega$ = "abc"

$ s0  = { arbstring | omega "does not contain any copies of \"a\" or \"c\"" }  "e.g. The empty string, "lambda $
$ sa  = { arbstring | &omega "contains at least one copy of \"a\", no copies of \"c\"," \ &"and no copy of \"a\" is eventually followed by a copy of \"b\"" } "e.g. "omega = "\"a\"" $
$ sab &= { arbstring | &omega "contains a copy of \"a\" eventually followed by a copy of \"b\", and no copies of \"c\"" } "e.g. "omega = "\"ab\"" $
$ sc  = { arbstring | &omega "contains at least one copy of \"c\" and no copies of \"a\"" } "e.g. "omega = "\"bc\"" $
$ sac = { arbstring | &omega "contains a copy of \"a\", a copy of \"c\" and no copy of \"a\" is eventually followed by a copy of \"b\"" } "e.g. "omega = "\"ac\"" $
$ sL  = L "e.g. "omega = "\"abc\"" $
