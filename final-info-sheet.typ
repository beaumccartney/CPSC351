// TODO:
//  mark everywhere where the sample space being finite matters (tail bounds, etc.)

#set document(
  author: "Beau McCartney",
  title:  "CPSC 351 Final Exam Info Sheet",
)

#set page(
  paper: "us-letter",
  margin: 0.15cm,
  columns: 4,
)
#set columns(
  gutter: 10pt,
)

#set par(
  justify: true,
)

#set text(
  size: 5.00pt
)

#let blank = $union.sq$

#let q0      = $q_0$
#let q0multi = $q0 " "omega " "sharp " "q0 " "sharp " "q0 " "sharp " "dots " "sharp " "q0$
#let qacc    = $q_"accept"$
#let qrej    = $q_"reject"$
#let qhalt   = $q_"halt"$

#let Sig1 = $Sigma_1$
#let Sig2 = $Sigma_2$
#let Sig3 = $Sigma_3$

#let Sigstar  = $Sigma^star$
#let Sigstar1 = $Sigstar_1$
#let Sigstar2 = $Sigstar_2$
#let Sigstar3 = $Sigstar_3$

#let Gamstar = $Gamma^star$

#let arbstring = $omega in Sigstar$
#let arbstring1 = $omega in Sigstar1$
#let arbstring2 = $omega in Sigstar2$

#let om1 = $omega_1$
#let om2 = $omega_2$

#let Qtran = $Q without {qacc, qrej}$
#let Qnohalt = $Q without {qhalt}$

#let tackstar = $scripts(tack)^star$

#let turing = $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$

#let L1 = $L_1$
#let L2 = $L_2$
#let L3 = $L_3$

#let LSig1 = $L1 subset.eq Sigstar1$
#let LSig2 = $L2 subset.eq Sigstar2$
#let LSig3 = $L3 subset.eq Sigstar3$

= Alphabets, Strings, and Languages

Definitions:
- *Alphabet:* a finite nonempty set, typically denoted by $Sigma.$
- *Symbol:* an element of an alphabet.
- *String:* a *_string_* over an alphabet $Sigma$ is a finite sequence of symbols in $Sigma$. Strings are *_not_* sets i.e. order matters and duplicates may be present.
  - *Length*: the *_length_* of a string $omega$ over an alphabet $Sigma$ (denoted by $abs(omega)$) is the number of symbols in the sequence. The empty string over any alphabet is denoted by $lambda$. All strings have natural length.
  - For any alphabet $Sigma$, *#Sigstar* is the set of _all_ strings over $Sigma$.
- *String concatenation:* the concatenation of two strings $mu$ and $nu$ is just the $nu$ appended to $mu$, notated as $mu dot nu$. Its length is the sum of the length of the two strings $abs(mu dot nu) = abs(mu) + abs(nu)$.
- *Substring:* a string $mu$ is a *_substring_* of $omega$ if $omega = om1 dot mu dot om2$, where $om1, om2, mu in Sigstar$.
  - *Prefix:* a string $mu$ is a *_prefix_* of another string $omega$ if there exists some string $nu$ such that $omega = mu dot nu$ (where $mu, nu, omega in Sigstar$).
  - *Suffix:* a string $mu$ is a *_suffix_* of another string $omega$ if there exists some string $nu$ such that $omega = nu dot mu$ (where $mu, nu, omega in Sigstar$).
- *Language:* a *_language_* over an alphabet $Sigma$ is a subset of #Sigstar.

= DFA Design + Correctness:

A DFA is a 5-tuple $M = (Q, Sigma, delta, q0, F)$ where $Q$ is the set of
states, $Sigma$ is the alphabet defining what symbols the DFA can process ($Q
inter Sigma = emptyset$), $F$ is the set of "accepting states" (thus $F
subset.eq Q$), $q0 in Q$ is the start state, and $delta : Q times Sigma
arrow.r Q$ is the transition function.

== Correctness Steps:

+ What should the DFA remember about the string seen so far - make a set for each case
+ Sanity checks:
  + Finite number of sets
  + Each string, including $lambda$, belongs to exactly one of the sets. The set that corresponds to the start state contains $lambda$.
  + Each set is either a subset of $L$, or disjoint from $L$. Subsets of $L$ correspond to accepting states.
  + Transitions are well defined. Does appending a symbol (check for each symbol) to an arbitrary member of any of the sets guarantee the new string is in exactly one of the sets. Check for all sets, and all symbols.
+ Apply "Correctness of a DFA" theorem. It requires these properties:
  - Every string in #Sigstar belongs to *exactly* one of the sets
  - $lambda in S_0$ (the set corresponding to the start state)
  - For every accepting state, its corresponding set is a subset of $L$
  - For every non-accepting state, its corresponding set is disjoint with $L$
  - Transitions are well defined and line up with sets i.e. if $d(q_i, sigma) = q_j$ then ${omega dot sigma | omega in S_i} subset.eq S_j$

= NFA:

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
: Q times Sigstar arrow.r cal(P)(Q)$ defined for $q in Q$ and $omega in
Sigstar$ as follows: $

deltastar(q, omega) = cases(
  lclosure(q) &"if" omega = lambda",",
  union.big_(r in deltastar(q, mu))(union.big_(s in delta(r, sigma))lclosure(s)) &"if" omega = mu dot sigma "for" mu in Sigstar "and" sigma in Sigma".",
)
$
An NFA accepts a string $omega in Sigstar$ iff *_$deltastar(q0, omega) inter F
!= emptyset$_*, and rejects the string otherwise.

Processing an input string can be thought of as *keeping track of _all_ the
states that can be reached as symbols are processed*.

== NFA from DFA:

Suppose the DFA is $M = (Q, Sigma, delta, q0, F)$, then an NFA with the same
language $hat(M)$ is just $hat(M) = (Q, Sigma, hat(delta), q0, F) "where" hat(delta)(q, sigma) = cases({delta(q, sigma)} &"if" sigma in Sigma",", emptyset &"if" sigma = lambda.)$

== DFA from NFA:

About the string seen so far $mu$, DFA needs to remember $deltastar(q0, mu)$
i.e. the set of states that can be reached from #q0 by processing $mu$. This
means *_the DFA has a state for every possible output of the NFA's extended
transition function._* I.e. state for every element in $delta$'s *_range_*.

Let $M = (Q, Sigma, delta, q0, F)$ be an NFA. To construct a DFA with the same
language $hat(M) = (hat(q), Sigma, hat(delta), hat(q0), hat(F))$.

We construct the function $phi : hat(Q) arrow.r cal(P)(Q)$, which maps states in
our DFA to elements in the range of our NFA's transition function $delta$.

Getting started:
- $deltastar(q0, lambda) = lclosure(q0))$ which implies that #lclosure(q0)
  is in the range of $delta$, meaning there's a DFA state for it.
- Call this state $hat(q0)$. Since it corresponds to #lclosure(q0), we have $phi(hat(q0) = lclosure(q0))$

Continuing:
- Suppose $V$ is an element in the range of $delta$, and as such $V =
  deltastar(q0, mu) = phi(hat(q_k))$ for some state $hat(q_k) in hat(Q)$ and
  some $mu in Sigstar$.
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

- We pick some $hat(q) in hat(R)$ and find $hat(delta) (hat(q), sigma)$ for every symbol $sigma in Sigma$.
- If for some $q in Q$ and $sigma in Sigma$, some set $delta (q, sigma)$ is not in the co-domain of $phi$ (i.e. doesn't correspond to an existing DFA state), add a new state $hat(q)$ to $hat(R)$ and set $phi (hat(q)) = delta (q, sigma)$.
- Move elements from $hat(R)$ to $hat(Q)$ when all their transitions have been defined.
- Eventually $hat(R) = emptyset$, and both $Q$ and $hat(delta)$ have been completed.
- *REMEMBER THIS:* For all $hat(q) in hat(Q)$, $hat(q)$ should be in $hat(F)$ iff $phi(hat(q)) inter F != emptyset$.

= Regex:

== Language operations:
- language union $A union B = {omega in Sigstar | omega in A "or" omega in B}$,
- language concat $A compose B = {omega_1 dot omega_2 | omega_1 in A "and" omega_2 in B}$
- language Kleene star $A^star = {omega_1 dot omega_2 dot dot dot omega_k | k >= 0 "and" omega_i in A "for" 1 <= i <= k}$

== Closure properties:
- If $A$ and $B$ are regular languages then $A union B$ is regular.
- If $A$ and $B$ are regular languages then $A compose B$ is regular.
- If $A$ is a regular language then $A^*$ is regular.

Recall that the contrapositive of these statements is also true.

== Regex and languages:

Alphabet $Sigma$ cannot include any of these: $lambda, emptyset, Sigma, (, ), union, compose, star$.

Regex alphabet is $Sigma_"regexp" = Sigma union {lambda, emptyset, Sigma, (, ), union, compose, star}$.

Regex is a string in $Sigma_"regexp"^star$ subject to the following rules:
- For every *_symbol_* $omega in Sigma$, the *string* $omega$ is a regex with language $L(sigma) = {sigma}$.
- The regex $lambda$ (the literal character $lambda$, _*not*_ the empty string) has language $L(lambda) = {lambda}$.
- The regex $emptyset$ has language $L(emptyset) = emptyset$.
- The regex $Sigma$ has language $L(Sigma) = Sigma$ (i.e. every character in the alphabet).
- If $R_1$ and $R_2$ are regexes, then:
  - The regex $(R_1 union R_2)$ (parens are important) has language $L((R_1 union R_2)) = L(R_1) union L(R_2)$.
  - The regex $(R_1 compose R_2)$ (parens are important) has language $L((R_1 compose R_2)) = L(R_1) compose L(R_2)$.
  - The regex $(R_1)^star$ (parens are important) has language $L((R_1)^star) = L(R_1)^star$.

A language is regular iff there exists a regex that has that language.

== Showing the language/correctness of a regex:

Identify the languages of the
smallest regexes, then go up from there, finding the languages of regexes
composed of other regexes. Eventually you'll end up with the desired language.
- think DFS of a parse tree
- statements justifying why it's a regex and what language it has
  - e.g. "Since $a in Sigma$, 'a' is a regex with language $L(a) = {a}$"
  - e.g. "Since $(b union c)$ is a regex, $((b union c))^star$ is a regex with language ${b, c}^star$."


= Pumping lemma / non-regular languages:

== Pumping Lemma

Let $L subset.eq Sigstar$.

If $L$ is regular, then there exists an integer $p >= 1$ (called the "pumping
length" for $L$) s.t. if $s in L$ and $abs(s) >= p$, $s$ can be split into three
pieces $s = x y z$ ($x, y, z in Sigstar$) satisfying the three
following conditions:

+ $x y^i z in L$ for every integer $i >= 0$
+ $abs(y) > 0$ i.e. $y != lambda$
+ $abs(x y) <= p$

Note that $y^i$ is the concatenation of $i$ copies of $y$.

== Proving language is not regular with pumping lemma:
+ Assume (to obtain a contradiction) language is regular
+ Observe that the pumping lemma holds for the language and write down its conditions
+ Introduce the "pumping length" $p$
+ Introduce a string in the language $s$ ($s$ is the string in the lemma) with length $abs(s) >= p$
  - $s$ usually depends on $p$
+ Show that $s$ is in the language and $abs(s) >= p$
+ Infer that there exists strings $x, y, z in Sigstar$ such that $s = x y z$ and
  the above pumping lemma properties hold
+ Use the pumping lemma properties to get a contradiction *_without making any other assumptions_*
+ Conclude that since assuming the language is regular led to a contradiction,
  the language must not be regular

Notes:
- $i$ can be chosen, since $x y^i z in L$ for every integer $i >= 0$, so
  counterexample is sufficient
- $i = 0$ and $i = 2$ are good starting choices
- observe how proof follows lemma's structure

= Turing Machines

A *_Turing machine_* is a 7-tuple #turing where:
- $Q$ is the (finite and nonempty) set of *_states_* (known as the *_finite
  control_* of $M$)
- $Sigma$ is the (finite and nonempty) *_input alphabet_* such that $Sigma
  inter Q = emptyset$ and $blank in.not Sigma$
- $Gamma$ is the (finite and nonempty) *_tape alphabet_* such that $Sigma union
  {blank} subset.eq Gamma$ and $Q inter Gamma = emptyset$ (i.e. $Gamma$
  includes the alphabet and the blank symbol, but no states)
- $delta : (Qtran) times Gamma arrow.r Q times Gamma times {"L", "R"}$ is the
  transition function
- $q0 in Q$ is the *_start state_*
- $qacc in Q$ is the *_accept state_*
- $qrej in Q without {qacc}$ is the *_reject state_.*

A Turing Machine $M$ accesses and stores on a one-way *_tape_*, consisting of
an infinite sequence of "cells" that each store a symbol in $Gamma$. $M$ also
has a *_tape head_* which points to one cell of the tape.

== Configurations

The *_configuration_* of a Turing machine is a string of the form $om1 " "q "
"om2$ where $om1, om2 in Gamstar$ and $q in Q$. The cells left of the tape head
store the symbols $om1$, the cells starting at the tape head and going to the
right store the symbols in $om2$, and the cells to the right of the last symbol
of $om2$ store infinitely many copies of #blank. The tape head points to a cell
$abs(om1)$ cells away from the leftmost cell.

Let $M$ be a Turing machine, and #arbstring be the input string. $M$'s
*_initial configuration_* for $omega$ is *_$q0 omega$_*, where #q0 is the start
state of $M$.

== Moves of $M$ #sym.dash.em Applying the Transition Function

If the machine is in state #qacc or #qrej, then it's execution is "completed"
(its execution has *_halted_*) and it cannot take transitions #sym.dash.em note
that the transition function isn't defined for states #qacc or #qrej.

Otherwise, a transition must be taken. Let $M$ be a Turing machine in the
configuration $om1 q om2$, where $om1, om2 in Gamstar$ and $q in Qtran$, and
let $sigma in Gamma$ be the symbol contained in the cell the tape head is
pointing at. Since $q in Qtran$, $M$ takes another transition
defined by $delta$. Suppose $delta(q, sigma) = r, tau, d$ where $r in Q, tau in
Gamma$, and $d in {"L", "R"}$, then the copy of $sigma$ in the cell the tape
head is pointing at is replaced with $tau$, and $M$ goes into state $r$. If $d
= "R"$, the tape head moves one cell to the right. Otherwise, $d = "L"$, and
the tape head moves one cell to the left (unless its pointing at the leftmost
cell, in which case it doesn't move at all).

#[

  #let om1hat = $hat(om1)$
  #let om2hat = $hat(om2)$
  #let rhat   = $hat(r)$
  #let conf1  = $om1 r om2$
  #let conf2  = $om1hat rhat om2hat$

  Let $r in Qtran, rhat in Q$, and let $om1, om2, om1hat, om2hat in Gamstar$.
  - Configuration #conf1 *_yields_* configuration #conf2 (notated $conf1
    tack conf2$) if #conf2 is reached from #conf1 by taking a *_single step_*
    of $M$ (i.e. applying $M$'s transition function once at #conf1).
  - Configuration #conf1 *_derives_* configuration #conf2 (notated $conf1
    tackstar conf2$) if #conf2 is reached from #conf1 by taking *_zero or
    more_* (finitely many) steps of $M$.

]

== Processing Strings

Let #arbstring, and $M$ be a Turing machine.

- $M$ *_accepts_* $omega$ if $M$ reaches an *_accepting configuration_* (i.e.
  $M$ ends up in #qacc) after a finite number of steps i.e. $q0 omega tackstar
  om1 qacc om2$, for some $om1, om2 in Gamstar$.
- $M$ *_rejects_* $omega$ if $M$ reaches a *_rejecting configuration_* (i.e.
  $M$ ends up in #qrej) after a finite number of steps i.e. $q0 omega tackstar
  om1 qrej om2$, for some $om1, om2 in Gamstar$.
- $M$ *_loops on_* $omega$ if $M$ does not accept *_or_* reject $omega$ i.e.
  $M$'s computation on $omega$ never halts.

== Processing Languages

Let $L subset.eq Sigstar$, and $M$ be a Turing machine.

- $M$ *_recognizes_* $L$ if $M$ accepts every string that belongs to $L$ and
  $M$ either *_rejects_* or *_loops_* on every string that doesn't belong to
  $L$. $L$ is the *_language, L(M), of $M$_* if $M$ recognizes $L$. $L$ is
  *_Turing-recognizable_* (or just "recognizable") if there exists a Turing
  machine that recognizes $L$.
- $M$ *_decides L_* if $M$ *_accepts_* every string that belongs to $L$ and $M$
  *_rejects_* every string that doesn't belong to $L$. $L$ is
  *_Turing-decidable_* (or just "decidable") if there exists a Turing machine
  that recognizes $L$. It follows from these definitions that decidable
  languages are also recognizable.

Thus, a language can be proved to be recognizable or decidable by constructing a
Turing machine that decides or recognizes that language respectively.

== Nondeterministic Turing Machines

Same 7-tuple $M$ as standard Turing machines - just different type on the
transition function.

Similar to NFAs, where the type of the transition is just a set of possible
outputs of a standard Turing machine i.e. $delta: Q times Gamma arrow.r
cal(P)(Q times Gamma times {"L", "R"})$ such that $delta(qacc, sigma) =
delta(qrej, sigma) = emptyset$ for all symbols $sigma in Sigma$.

Let $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$ be a nondeterministic Turing machine and let #arbstring.
- $M$ *_accepts_* $omega$ if there's at least one finite sequence of moves from $q0 omega$ that ends with $M$ in $qacc$
- $M$ *_rejects_* $omega$ if every finite sequence of moves of $M$ from $q0 omega$ is finite and none end in $qacc$
- $M$ *_loops_* on $omega$ otherwise

Nondeterministic Turing machines and standard Turing machines can simulate
each other - meaning they recognize and decide the same languages.

= Simulations

#[
  #set enum(numbering: "(a)")
  #let Mhat = $hat(M)$
  #let C1 = $cal(C)_1$
  #let C2 = $cal(C)_2$

  To show that a *_second_* model of computation is at least as powerful as a
  *_first_* model of computation:
  + Consider an arbitrary machine $M$ of the *_first_* model of computation.
  + Use $M$ to define another machine #Mhat of the *_second_* model of
    computation (that does what $M$ does)
    - Describe how a configuration of $M$ is represented when #Mhat is being used
    - Often includes how many tapes, what they're used for, and possibly #Mhat's tape alphabet $hat(Gamma)$
  + Prove that #Mhat solves the same problem as $M$

  Then describe the following:
  - *_Initialization:_* Let $Sigma$ be the input alphabet for $M$ (and thus for
    #Mhat). Describe how #Mhat begins with its initial config for an input
    string #arbstring and moves to a representation of $M$'s initial
    configuration for the same input string.
  - *_Step-by-Step Simulation:_* For configurations #C1 and #C2 of $M$ where
    $C1 tack C2$, describe how #Mhat moves from a representation of #C1 to #C2
  - *_Cleanup:_* describe anything that #Mhat must do to end its computation,
    after simulating $M$'s final step
      - Turing machines that recognize languages may not need anything

  Finally (if not obvious), a *_proof of correctness_* should be given. When
  both $M$ and #Mhat are Turing machine variants with the same input alphabet
  $Sigma$, the following should be shown:

  For every string #arbstring and every $t in NN$, if the execution of $M$ on
  input $omega$ uses at least $t$ steps, and $M$ is in configuration $cal(C)$
  after $t$ steps of its execution on input $omega$, then #Mhat's execution on
  input $omega$ includes a simulation of at least $t$ steps of $M$, and after
  simulation of at least $t$ steps of $M$, #Mhat is in a configuration that
  gives a representation of $cal(C)$.

]

= Multi-Tape Turing Machines

For any fixed integer $k >= 1$, a *_$k$-tape Turing Machine_* is a Turing
machine with $k$ tapes with heads that can move independently, and transitions
allow left, right, and stay moves. Like the 7-tuple $M = (Q, Sigma, Gamma,
delta, q0, qacc, qrej)$ where everything is the same as standard Turing
machines except the transition function has the type $delta : (Qtran) times
Gamma^k arrow.r Q times (Gamma times {"L","R","S"})^k$.

== Representing Configurations and Moves

Let $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$ be a k-tape Turing machine.

Configurations of $M$ are strings of the form *$omega_(1,L) " " q " "
omega_(1,R) " " sharp " " omega_(1,L) " " q " " omega_(1,R) " " sharp " " dots
" " sharp " " omega_(k,L) " " q " " omega_(k,R)$* where:
- $sharp in.not Q$ and $sharp in.not Gamma$
- $M$ is in state $q$ (meaning $q in Q$)
- $omega_(i, L)$ is the string of symbols stored to the _left_ of the tape head
  on the $i^("th")$ tape
- $omega_(i, R)$ is the string of symbols stored starting at, and to the
  _right_ of the tape head ending with the rightmost non-blank symbol on or to
  the right of the tape head.

== Processing Strings

The initial configuration for a $k$-tape Turing machine $M$ with input string
#arbstring is when $M$ is in its start state $q0$, the input string $omega$ is
copied into the first tape starting at the leftmost cell, and every other tape
is left blank i.e. $cal(C)_"init" = q0multi$

Accepting, rejecting, and looping work as they do in standard Turing machines
(i.e. is an accepting or rejecting state derived from the initial configuration
for $omega$).

== Processing Languages

Multi-tape Turing machines and standard Turing machines can simulate each
other - meaning they recognize and decide the same languages.

The *_language_* $L$ of a multi-tape Turing machine $M$, as well as whether M
*_decides_* or *_recognizes_* $L$, is similar to standard Turing machines.

= Computability

== Turing Machines That Compute Functions

#let functype = $f : Sigstar1 arrow.r Sigstar2$

Consider the problem of computing a (partial or total) function #functype for
alphabets #Sigstar1 and #Sigstar2.

A *_one-tape Turing machine that computes a partial or total function_*
#functype can be modelled as a 7-tuple $M = (Q, Sig1, Sig2, Gamma, delta, q0,
qhalt)$ where:
- $Q$ is the *_finite control_* of $M$ (similar to standard Turing machines
  that recognize languages)
- #Sig1 is the *_input alphabet_* of $M$, is _disjoint_ from $Q$, and $blank
  in.not Sig1$ (similar to the input alphabet of standard Turing machines)
- #Sig2 is the *_output alphabet_*, is possibly different from #Sig1, is
  _disjoint_ from $Q$, and $blank in.not Sig2$
- $Gamma$ is the *_alphabet_* or *_tape alphabet_* of $M$, (similar to the tape
  alphabet of a standard Turing machine), $Sig1 union Sig2 union {blank}
  subset.eq Gamma$ and $Gamma$ can contain more other symbols too
- $q0 in Q$ is the *_start state_*
- $qhalt in Q$ is the *_halt state_*
- $delta : (Qnohalt) times Gamma arrow.r Q times Gamma times {"L", "R"}$ is
  the transition function (similar to standard Turing machines).

Configurations (including initial configurations) and transitions/moves are the
same as for standard Turing machines.

If a Turing machine computes a partial function #functype then the following
properties are satisfied, for every string #arbstring1:
- If $f$ is defined at $omega$ then, for $M$, $q0 omega tackstar qhalt f(omega)$,
  i.e. the computation halts with the head at the left and the output written
  to the tape starting at the leftmost cell
- If $f$ is undefined at $omega$ then $M$ loops on $omega$


A function #functype is *_computable_* if there exists a one-tape Turing
machine that computes functions, as defined above, with input alphabet #Sig1
and output alphabet #Sig2 that computes $f$.

== Multi-Tape Turing Machines That Compute Functions

Let $k$ be a positive integer. A *_$k$-tape Turing machine that computes a
function_* can be modelled as a 7-tuple $M = (Q, Sig1, Sig2, Gamma, delta,
q0, qhalt)$ where $Q, Sig1, Sig2, Gamma, q0$, and $qhalt$ are similar to
standard Turing machines that compute functions, but where the transition
function $delta$ has the type $delta : (Qnohalt) times Gamma^k arrow.r Q
times (Gamma times {L, R, S})^k$.

Configurations (including initial configurations) and transitions/moves are the
same as for standard Turing machines.

A $k$-tape Turing machine that computes functions $M$ computes a function
#functype if the following properties are satisfied, for every string
#arbstring1:
- If $f(omega)$ is defined then $q0multi tackstar qhalt " " sharp " " qhalt " "
  sharp " " qhalt " " sharp " " dots " " sharp " " qhalt " " f(omega)$ i.e. the
  last tape contains $f(omega)$ written in the leftmost cells (and blanks
  after), all other tapes are blank, and all tapeheads point at the leftmost
  cell of their respective tapes.
- If $f$ is undefined at $omega$, then $M$ *_loops_* on $omega$.

Multi-tape Turing machines that can compute functions and standard Turing
machines that compute functions can simulate each other - meaning they
recognize and decide the same functions.

== Universal Turing Machines

#let LTM = $L_"TM"$
#let SigTM = $Sigma_"TM"$
#let SigstarTM = $Sigstar_"TM"$

#let LTMI = $L_"TM+I"$
#let ATM = $A_"TM"$
#let ATMC = $ATM^complement$

#let MUTM = $M_"UTM"$

Consider only "nontrivial" Turing machines where $q0 != qacc$ and $q0 != qrej$.

An *_encoding_* of a standard Turing machine #turing is a string over the
alphabet $SigTM = {s,q,0,1,2,3,4,5,6,7,8,9,L,R,Y,N,(,),"(a literal ',')",;}$.

More generally, encodings are functions that map things to strings e.g. Turing
machines and input strings to input strings of another Turing machine.

- $LTM subset.eq SigstarTM$ is the language of encodings of Turing machines.
- $LTMI subset.eq SigstarTM$ is the language of encodings of Turing machines
  $M$ (with some input alphabet $Sigma$) and input strings #arbstring (one
  input string and Turing machine per string $mu in LTMI$).

#LTM and #LTMI are both *_decidable._*

#[
  #let arbstringTM = $mu in SigstarTM$

  A *_universal Turing machine_* ("UTM") is a (standard or multi-tape) Turing machine
  #MUTM, with input alphabet #SigTM such that for every string #arbstringTM,
  the following properties are satisfied:
  - if $mu in.not LTMI$, #MUTM *_rejects_* $mu$.
  Otherwise, $mu in LTMI$ so that $mu$ encodes a Turing machine $M$ (with some
  input alphabet $Sigma$) and an input string #arbstring.
  - #MUTM *_accepts_* $mu$ *_if and only if_* $M$ *_accepts_* $omega$
  - #MUTM *_rejects_* $mu$ *_if and only if_* $M$ *_rejects_* $omega$
  - #MUTM *_loops_* on $mu$ *_if and only if_* $M$ *_loops_* on $omega$

  #MUTM begins by checking its input string #arbstringTM belongs to #LTMI,
  *_rejecting_* $mu$ if $mu in.not LTMI$. If $mu in LTMI$, $mu$ is an encoding
  of some (standard) Turing machine $M = (Q, Sigma, Gamma, delta, q0, qacc,
  qrej)$ and an input string #arbstring. #MUTM continues by *_simulating_*
  execution of $M$ on $omega$.


  $ATM subset.eq LTMI$ is the language of encodings of Turing machines #turing
  (with some input alphabet $Sigma$) and input strings #arbstring such that $M$
  *_accepts_* $omega$. In particular, it is the language of any universal
  Turing machine i.e. $ATM = L(MUTM)$. Since UTMs exist, #ATM is
  *_recognizable_*. However, #ATM *_is not decidable_* and the complement of #ATM,
  #ATMC is *_unrecognizable._*

]

= Reductions

#let reduc  = $scripts(prec.eq)_"Q"$
#let Oreduc = $scripts(prec.eq)_"O"$

A *_reducibility_* is any binary relation #reduc between languages (possibly
over different alphabets) with the following properties:
- $L reduc L$ for every language $L subset.eq Sigstar$, for every alphabet
  $Sigma$ i.e. #reduc is *_reflexive._*
- For all languages #LSig1, #LSig2, and #LSig3, (and alphabets #Sig1, #Sig2,
  and #Sig3) if $L1 reduc L2$ and $L2 reduc L3$, then $L1 reduc L3$ i.e. #reduc
  is *_transitive._*

== Oracle Reductions

NOTE: here, "algorithm", "subroutine", and "procedure" are all Turing
machines that compute the required function.

An *_oracle for a language $L subset.eq Sigstar_L$_* is a device capable of
reporting whether any string $omega in Sigstar_L$ is a member of $L$. Think of
a black box or *_library procedure available to call_* that can be relied on to
decide membership in $L$.

Let #LSig1 and #LSig2. Then #L1 is *_oracle reducible_* to #L2 (notated $L1
Oreduc L2$) if there exists an algorithm that decides membership in #L1 that
uses an oracle (i.e. a procedure or subroutine) that decides membership in #L2.

=== Describing an Oracle Reduction Between Languages

To describe an oracle reduction from a language #LSig1 to a language #LSig2:
+ Give pseudocode for an algorithm that decides membership in #L1 using a
  separate *_Boolean method_* that decides membership in #L2. _No need to write
  an algorithm that decides #L2, just assume one exists and is correct_.
+ If not obvious, _prove the correctness_ of the algorithm that decides
  membership in #L1, assuming the correctness of the algorithm that decides
  membership in #L2. Often a proof by induction.
+ Adding more detail (only) as needed, show that _if there exists_ a multi-tape
  Turing machine $M_2$ that decides membership in #L2, then this can be used as
  a component in a multi-tape Turing machine $M_1$ that would decide membership
  in #L1.

The set of oracle reductions forms a *_reducibility_* as defined above.

Let #LSig1 and #LSig2, for alphabets #Sig1 and #Sig2:
- If $L1 Oreduc L2$ and #L2 is *_decidable_*, then #L1 is *_decidable_* as
  well (i.e. the set of decidable languages is *_closed_* under oracle
  reductions).
- If $L1 Oreduc L2$ and #L1 is *_undecidable_*, then #L2 is
  *_undecidable_*.


=== "Closure-like" Properties

Oracle reductions *_cannot_* be used to prove that languages are unrecognizable
(i.e. #L2 being recognizable and $L1 Oreduc L2$ does *_not imply that #L1 is
recognizable_*).

// TODO: add choosing L hat such that its undecidable\
To prove that a language $L$ is *_undecidable_*, prove that some undecidable
language $hat(L)$ is *_oracle reducible_* to $L$, then conclude by the second
fact above that $L$ must also be undecidable.

#let NATM = $italic("NA")_"TM"$

Let $NATM subset.eq SigstarTM$ be the language of Turing machines $M$ and input
strings $omega$ for $M$ s.t. $M$ does *_not_* accept $M$:
- $ATM union NATM = LTMI$ and $ATM inter NATM = emptyset$
- $ATM Oreduc NATM$ meaning that #NATM is *_undecidable_*.


== Many-One Reductions

#let MOreducfunc = $f: #Sigstar1 arrow.r #Sigstar2$
#let MOreduc = $scripts(prec.eq)_M$

Let #Sig1 and #Sig2 be two (possibly identical) alphabets, and let #LSig1 and
#LSig2 be two languages over these alphabets.

A *_many-one reduction_* from #L1 to #L2 is a *_total_* function #MOreducfunc
such that for every string #arbstring1, $omega in L1$ _if and only if_
$f(omega) in L2$ and the function $f$ is computable (i.e. a there exists a
*_multi-tape Turing machine that computes $f$_*). If a many-one reduction
exists from #L1 to #L2, we say that #L1 is *_many-one reducible_* to #L2 and
write $#L1 MOreduc #L2$ The set of many-one reductions forms a *_reducibility_*
as defined above.

NOTE: define functions, not algorithms i.e. piecewise not pseudocode.

Steps prove that a language #LSig1 is many-one reducible to a language #LSig2:
+ Clearly and precisely describe the *_total_* function #MOreducfunc that will
  be shown to be a many-one reduction. Show that $f$ is total.
+ *_Prove_* that if $omega in L1$ then $f(omega) in L2$ for every string
  #arbstring1.
+ *_Prove_* that if $omega in.not L1$ then $f(omega) in.not L2$ for every
  string #arbstring1.
+ *_Sketch a proof_* that $f$ is computable, including enough detail for it to
  be reasonably clear that you really _could_ write a python or java program
  that computes this function from strings to strings.

Common pitfalls include
- vague/ambiguous/unreadable definition of $f$
- $f$ is *_partial_*
- forgetting step 3 above, and not including enough detail to show that $f$ is
  computable.

=== "Closure-like" Properties

Let #Sig1 and #Sig2 be two (possibly identical) alphabets, and let #LSig1 and
#LSig2 be two languages over these alphabets. If $L1 MOreduc L2$. then the
following properties hold:
- if #L2 is decidable, then #L1 is also decidable
- if #L2 is recognizable, then #L1 is recognizable
- if #L1 is undecidable, then #L2 is undecidable
- if #L1 is unrecognizable, then #L2 is unrecognizable
- $L1 Oreduc L2$

Note that $L1 Oreduc L2$ does *_not_* imply that $L1 MOreduc L2$.

To prove that a language $L$ is *_undecidable_*, prove that some
*_undecidable_* language $hat(L)$ is *_many-one reducible_* to $L$, then
conclude by the third fact above that $L$ must also be undecidable.

To prove that a language $L$ is *_unrecognizable_*, prove that some
*_unrecognizable_* language $hat(L)$ is *_many-one reducible_* to $L$, then
conclude by the third fact above that $L$ must also be unrecognizable.

== Decision Problems

A *_decision problem_* is a computational problem that asks a question with a
"Yes/No" (think boolean) answer. An *_instance_* is an input to a decision
problem.

When an _alphabet_ $Sigma$ and an _encoding_ (a mapping of instances to strings
in #Sigstar) is chosen, _three languages_ are associated with the problem:
- _Language of Instances:_ the set of strings in #Sigstar that are valid
  encodings of an instance of the problem. Partitioned by lang Yes-Instances and
  lang No-Instances
- _Language of Yes-Instances:_ the subset of lang Instances for which the
  answer to the decision problem is "Yes"
- _Language of No-Instances:_ the subset of lang Instances for which the answer
  to the decision problem is "No"

The "usual situation" for this class:
- Every instance of the decision problem is encoded by some string in #Sigstar,
  and every encoding encodes *_exactly one instance_*.
- We're interested in decision problems whose languages of instances are
  *_decidable_*.
- The phrase "reducing one decision problem to another" means we are giving a
  *_many-one reduction_* from the *_language of Yes-instances for the first
  decision problem_* to the *_language of Yes-instances of the second decision
  problem_*.

#let e1 = $e_1$
#let e2 = $e_2$

#let LI1 = $L_(I_1)$
#let LI2 = $L_(I_2)$

#let mujunk = $mu_"Junk"$

Steps for Reductions with decision problems for the "usual situation" above:
+ Describe a mapping $phi$ from instances of the first problem to instances of
  the second problem.
+ Show that the mapping $phi$ maps each Yes-instance of the first problem to a
  Yes-instance of the second problem, and that $phi$ maps each No-instance of
  the first problem to a No-instance of the second problem.
+ Consider encoding schemes: one, #e1, maps instances of the first problem to
  strings over an alphabet #Sig1, and another, #e2, maps instances of the
  second problem to strings over an alphabet #Sig2. Will generally be given.
+ Let $LI1 subset.eq #Sigstar1$ be the language of encodings of instances of
  the first problem, and let $LI2 subset.eq #Sigstar2$ be the language of
  encodings of instances of the second problem.
+ Confirm the *_Usual Situation:_* Prove (often, by stating a previously
  established result) that #LI1 is decidable, and confirm that $LI2 !=
  Sigstar2$ so that there exists a string $mujunk in Sigstar2$ such that
  $mujunk in.not LI2$. *_Say, clearly, what string #mujunk you are going to
  use._*
+ Let #functype be defined as follows for every string $mu in Sigstar1$:
  - If $mu in LI1$ so that $mu$ is the encoding of some instance, $alpha$, of
    the first problem, then $f(mu)$ is the encoding of the corresponence
    instance $f(alpha)$ of the second problem where $phi$ is the mapping from
    instances of the first problem to instances of the second problem, chosen
    at the beginning of this process.
  - If $mu in.not LI1$ then $f(mu) = mujunk$
  NOTE: completing the steps above ensures that $omega in L1$ *_if and only if_* $f(omega) in L2$ for every string #arbstring1.
+ Give an algorithm to compute the function $f$ and prove that it is correct
  - Often advisable to start at the high level, using the mapping $phi$ and
    the encoding schemes for problems, to give an algorithm to compute $f$ that
    can be described using pseudocode.
  - Details can be added, as needed, to confirm that there is a multi-tape
    Turing machine that computes the function $f$ as well

= Church Turing Thesis

Many abstract models of computation have been proposed, and shown to be
equivalent to Turing machines with *_simulations_* - its widely believed that
Turing machines are the "most powerful possible" computers.

= Induction on the length of a string

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
+ State that every string #arbstring has a length $abs(omega) in NN$. Can call
  the length $n$.
+ State induction on the length of the string $omega$.
  - State standard or strong form of induction.
+ Base case is $abs(omega) = 0$, which implies that $omega = lambda$ (since
  $lambda$ is the only member of #Sigstar with length 0).
+ Inductive step is every string #arbstring with length $abs(omega) = k + 1$
  has property $P(k)$.
  - Show that $omega$ isn't empty, and in particular $omega = mu dot sigma$ for
    some $mu in Sigstar$ and $sigma in Sigma$.
+ Proof should end with a conclusion e.g. "It now follows, by induction on
  length of the string $omega$, that every string #arbstring \<has desired
  property\>".

= Misc notes:

- $lambda in Sigstar$, always.
- write answers in *_heavy, dark pencil_*, and *_leave at least a one-inch margin_*.

= Discrete Probability

#let Pd = $upright(P)$
#let PB = $upright(P)_B$
#let powom = $cal(P)(Omega)$

#let Ex = $upright(E)$

Let $Omega$ be some set.
- #powom is the powerset of some set $Omega$.
- If $Omega$ is finite, $abs(powom) = 2^abs(Omega)$

== Experiments, Sample Spaces, and Events

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

== Probability Distributions

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

== Complement and Union of Events

Let $Omega$ be the sample space of some experiment, and $A, B subset.eq Omega$ be
events in that sample space.
- The *_complement_* of $A$, $overline(A)$ is the set of outcomes _not_ in $A$
  i.e. $overline(A) = {x in Omega | x in.not A}$. In particular,
  $Pd(overline(A)) = 1 - Pd(A)$
- $Pd(A union B) = Pd(A) + Pd(b) - Pd(A inter B)$. This implies $Pd(A union B) <= Pd(A) + Pd(b)$.
- The above point can be generalized to more than two events. Suppose $k in NN$,
  and $E_1, E_2, dots, E_k subset.eq Omega$. Then $ Pd(E_1 union E_2 union dots union E_k) <= sum_(i = 1)^k Pd(E_i). $


== Conditional Probability

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

== Independence

Events $A$ and $B$ are said to be *_independent_* if $Pd(A inter B) = Pd(A)
times Pd(B)$. The notion of independence can be generalized for events $A_1,
A_2, dots, A_k$ (where $k >= 2$) in two ways.
+ *Pairwise Independence:* $forall i, j in {1, 2, dots, k}, i != j arrow.r
  Pd(A_i inter A_j) = Pd(A_i) times Pd(A_j)$.
+ *Mutual Independence:* $forall S in cal(P)({1, 2, dots, k}), abs(S) >= 2
  arrow.r Pd(inter.big_(i in S)A_i) = product_(i in S) Pd(A_i)$.
  - Note that mutual independence implies pairwise independence.
  - Checking mutual independence constitutes checking the above product for every larger-than-two subset of the indices.

== Random Variables

Let $Omega$ be a sample space.
- A *_random variable over $Omega$_* is a (total) function $X : Omega arrow.r RR$.
  - These are outcomes with some assosciated value e.g. the height of someone or something else
  - Often, random variables have a range $V subset.eq RR$, meaning that the
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
- $Ex[X_1 + X_2 + dots + X_n] = Ex[X_1] + Ex[X_2] + dots + Ex[X_n]$
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

== Tail Bounds

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
(X(mu) - Ex[X])^2 times Pd(mu). $

If the sample space $Omega$ is finite, then the following conditions hold:
- $"var"(X) = Ex[X^2] - Ex[X]^2$, where $X^2$ is the random variable such that
  $forall sigma in Omega, X^2(sigma) = (X(sigma))^2$.
- Let $n in NN$, and $X_1, X_2, dots, X_n$ be random variables. If $X_1, X_2,
  dots, X_n$ are *_pairwise independent_* then $ "var"(X_1 + X_2 + dots + X_n)
  = sum_(i = 1)^n "var"(X_i). $

The *_standard deviation_ of $X$*, denoted $sigma(X)$, is $sqrt("var"(X))$.


Chebyshev's Inequality: Let $a in RR$ s.t. $a > 0$. Then $ Pd(abs(X) >= a) <= Ex[X^2]/a^2. $

Cantelli's Inequality: Let $a in RR$ s.t. $a > 0$. Then $ Pd(X - Ex[X] >= a) <= "var"(X)/(a^2 + "var"(X)). $

Chernoff Bound: Suppose $X_1, X_2, dots, X_n$ (for some $n in NN$) are
mutually independent indicator random variables (that is, range ${0, 1}$) such
that
$
exists p in [0,1] subset.eq RR "s.t." forall X in {X_1, X_2, dots, X_n}, Pd(X =
1) = p
$

Let $X_Sigma = X_1 + X_2 + dots + X_n$. Then, $ forall theta in [0, 1]
subset.eq RR, Pd(X_Sigma >= (1 + theta) p n) <= e^(-theta^2/3 p n). $

== Algorithm Analysis

=== Average-Case Analysis of Deterministic Algorithms

Consider a deterministic algorithm that solves a given computational problem.
Let $n in NN.$
- A *_sample space_* consists of instances of this problem of size $n$, or
  *_sets_* of these inputs where for any given set all the inputs in that set
  result in the same trace of execution of the algorithm.
- A *_probability distribution_* is formed, to model assumptions about the
  _likelihood_ of the (types of) inputs in the sample space.
- The number of steps used by the algorithm, on each (type of) input in the
  sample space, is used to defined a *_random variable._*
- The *_expected running time_* of the algorithm, for input size $n$, is the
  *_expected_* value of this random variable with respect to this probability
  distribution.

== Randomized Algorithms

A *_Randomized algorithm_* uses random number generators during execution
#sym.dash.em so that the neither the generated output, nor the number of steps
used to generate it, are necessarily _fixed_, even when the algorithm's input
is.

=== Analysis for a Fixed Input

Consider the execution(s) of a randomized algorithm, for a given computational
problem, on a given instance of this problem.
- A *_sample space_* consists of sequences of values that are produced during
  the algorithm's execution by a random number generator.
- A *_probability distribution_* is formed, to model the assumption about the
  RNG being used. Assume that the RNG is a "perfect" source of random values.
  When a value from a finite and nonempty set is requested, each element of the
  set is produced with the same probability, independently of all choices made
  before this (or anything else).
- The number of steps that are used by the algorithm, for this input and for
  this sequence of random variables, is used to define a *_random variable._*
- The *_expected running time_* for this input, is the expected value of this
  random variable with respect to this probability distribution.


=== Running Time as a Function of Input Size

- Assuming the _expected running time_ of a randomized algorithm is as defined
  above, the *_worst-case running time_* of that algorithm (w.r. to the prob
  distrib) is a function $T : NN arrow.r RR.$

  If there are finitely many instances of problems with size $n$ #sym.dash.em
  or only finitely many values that the expected running time can assume for
  instances of the problem with size $n$, then the worst-case expected running
  time, $T(n)$ is the _maximum_ of the expected running times of the algorithm
  for all inputs of size $n$.

=== Randomized Algorithms That Can Fail

- A *_Las Vegas_* algorithm for a decision problem is a randomized algorithm
  that can never give a wrong answer.
- A *_Monte Carlo_* algorithm for a decision problem is a randomized algorithm
  can can fail but the probability of failing is small.
  - The algorithm returns `true` only for inputs where the answer is
    "Yes"/`true`. That is, the algorithm *_returns `false` for all inputs where
    the answer is "No"/`false`._*
  - For inputs where the answer is "Yes"/`true`, the algorithm returns `false`
    with _at most_ probability $1/2.$
  - i.e. "no false-positives" and "false negatives are rare"
