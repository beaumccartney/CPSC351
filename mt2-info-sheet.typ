#set document(
  author: "Beau McCartney",
  title:  "CPSC 351 MT 2 Info Sheet",
)

#set page(
  paper: "us-letter",
  margin: 0.5cm,
)

#set text(
  size: 7.0pt
)

#let blank = $union.sq$

#let q0    = $q_0$
#let q0multi = $q0 " "omega " "sharp " "q0 " "sharp " "q0 " "sharp " "dots " "sharp " "q0$
#let qacc  = $q_"accept"$
#let qrej  = $q_"reject"$
#let qhalt = $q_"halt"$

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


== Alphabets, Strings, and Languages

Definitions:
- *Alphabet:* a finite non-empty set. Usually called $Sigma$ here.
- *Symbol:* an element of an alphabet.
- *String:* a *_string_* over an alphabet $Sigma$ is a finite sequence of symbols in $Sigma$. Strings are *_not_* sets i.e. order matters and duplicates may be present.
  - *length*: the *_length_* of a string $omega$ over an alphabet $Sigma$ (denoted by $abs(omega)$) is the number of symbols in the sequence. The empty string over any alphabet is denoted by $lambda$. All strings have natural length.
  - For any alphabet $Sigma$, *#Sigstar* is the set of _all_ strings over $Sigma$.
- *String concatenation:* the concatenation of two strings $mu$ and $nu$ is just the $nu$ appended to $mu$, notated as $mu dot nu$. Its length is the sum of the length of the two strings $abs(mu dot nu) = abs(mu) + abs(nu)$.
- *Substring:* a string $mu$ is a *_substring_* of $omega$ if $omega = om1 dot mu dot om2$, where $om1, om2, mu in Sigstar$.
  - *Prefix:* a string $mu$ is a *_prefix_* of another string $omega$ if there exists some string $nu$ such that $omega = mu dot nu$ (where $mu, nu, omega in Sigstar$).
  - *Suffix:* a string $mu$ is a *_suffix_* of another string $omega$ if there exists some string $nu$ such that $omega = nu dot mu$ (where $mu, nu, omega in Sigstar$).
- *Language:* a *_language_* over an alphabet $Sigma$ is a subset of #Sigstar.

== Turing Machines

A *_Turing machine_* is a 7-tuple #turing where $Q$ is the (finite and
nonempty) set of *_states_* (known as the *_finite control_* of $M$), $Sigma$
is the (finite and nonempty) *_input alphabet_* (which does *_not_* include the
*_blank symbol_* "#blank"), $Gamma$ is the (finite and nonempty) *_tape
alphabet_* such that $Sigma union {blank} subset.eq Gamma$ and $Q inter Gamma =
emptyset$ (i.e. $Gamma$ includes the alphabet and the blank symbol, but no
states), $delta : (Qtran) times Gamma arrow.r Q times Gamma times {"L", "R"}$
is the transition function, $q0 in Q$ is the *_start state_*, $qacc in Q$ is
the *_accept state_*, and $qrej in Q$ is the *_reject state_.*

A Turing Machine $M$ accesses and stores on a one-way *_tape_*, consisting of
an infinite sequence of "cells" that each store a symbol in $Gamma$. $M$ also
has a *_tape head_* which points to one cell of the tape.

=== Configurations

The *_configuration_* of a Turing machine can be represented as a string of
the form $om1 q om2$ where $om1, om2 in Gamstar$ and $q in Q$. The cells left
of the tape head store the symbols $om1$, the cells starting at the tape head
and going to the store the symbols in $om2$, and the cells to the right of the
last symbol of $om2$ store infinitely many copies of #blank. The tape head
points to a cell $abs(om1)$ cells away from the leftmost cell.

Let $omega in Sigstar$. When $M$'s execution on the input $omega$ begins, $M$
is in its start state #q0, the string $omega$ is written on the leftmost cells
of the tape, and all other cells of the tape store copies of "#blank". The tape
head points to the leftmost cell, meaning $M$'s *_initial configuration_* for
$omega$ is *_$q0 omega$_*.

=== Moves of $M$ #sym.dash.em Applying the Transition Function

If the machine is in state #qacc or #qrej, then it's execution is "completed"
and it cannot take transitions #sym.dash.em note that the transition function
isn't defined for states #qacc or #qrej.

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
  Then the configuration #conf1 *_yields_* configuration #conf2 (notated $conf1
  tack conf2$) if #conf2 is reached from #conf1 by taking a *_single step_* of
  $M$ (i.e. applying $M$'s transition function once at #conf1).

  Configuration #conf1 *_derives_* configuration #conf2 (notated $conf1
  tackstar conf2$) if #conf2 is reached from #conf1 by taking *_zero or more_*
  (finitely many) steps of $M$.

]

=== Processing Strings

Let #arbstring, and $M$ be a Turing machine.

$M$ *_accepts_* $omega$ if $M$ reaches an *_accepting configuration_* (i.e. $M$
ends up in #qacc) after a finite number of steps i.e. $q0 omega tackstar om1
qacc om2$, for some $om1, om2 in Gamstar$.

$M$ *_rejects_* $omega$ if $M$ reaches a *_rejecting configuration_* (i.e. $M$
ends up in #qrej) after a finite number of steps i.e. $q0 omega tackstar om1
qrej om2$, for some $om1, om2 in Gamstar$.

$M$ *_loops on_* $omega$ if $M$ does not accept *_or_* reject $omega$ i.e.
$M$'s computation on $omega$ never halts.

=== Processing Languages

Let $L subset.eq Sigstar$.

$M$ *_recognizes_* $L$ if $M$ accepts every string $omega in L$ and $M$ either
*_rejects_* or *_loops_* on every string $omega in.not L$.

$L$ is the *_language, L(M), of $M$_* if $M$ recognizes $L$.

$L$ is *_Turing-recognizable_* (or just "recognizable") if there exists a
Turing machine that recognizes $L$.

$M$ *_decides L_* if $M$ *_accepts_* every string $omega in L$ and $M$
*_rejects_* every string $omega in.not L$.

$L$ is *_Turing-decidable_* (or just "decidable") if there exists a Turing
machine that recognizes $L$. It follows from these definitions that decidable
languages are also recognizable.

=== Turing Machines That Compute Functions

#let functype = $f : Sigstar1 arrow.r Sigstar2$

Consider the problem of computing a (partial or total) function #functype for
alphabets #Sigstar1 and #Sigstar2.

A *_one-tape Turing machine that computes a partial or total function_*
#functype can be modelled as a 7-tuple $M = (Q, Sig1, Sig2, Gamma, delta, q0,
qhalt)$ where:
- $Q$ is the *_finite control_* of $M$ and is similar to standard Turing
  machines that recognize languages
- #Sig1 is the *_input alphabet_* of $M$, is _disjoint_ from $Q$, and $blank
  in.not Sig1$. It's similar to the input alphabet of standard Turing machines.
- #Sig2 is the *_output alphabet_*, is possibly different from #Sig1, is
  _disjoint_ from $Q$, and $blank in.not Sig2$.
- $Gamma$ is the *_alphabet_* or *_tape alphabet_* of $M$, used in a similar
  manner to the tape alphabet of a standard Turing machine. In particular, $Sig1
  union Sig2 union {blank} subset.eq Gamma$ and $Gamma$ can contain more other
  symbols too.
- $q0 in Q$ is the *_start state_*, similar to standard Turing machines.
- $qhalt in Q$ is the *_halt state_*, similar to the accept and reject states
  of standard Turing machines.
- $delta$ is similar to standard Turing machines with a slightly different type: $delta : (Qnohalt) times Gamma arrow.r Q times Gamma times {"L", "R"}$.

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

=== Nondeterministic Turing Machines

Same 7-tuple $M$ as standard Turing machines - just different type on the
transition function.

Similar to NFAs, where the type of the transition is just a set of possible
outputs of a reqular Turing machine i.e. $delta: Q times Gamma arrow.r cal(P)(Q
times Gamma times {"L", "R"})$ such that $delta(qacc, sigma) = delta(qrej,
sigma) = emptyset$ for all symbols $sigma in Sigma$.

Let $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$ be a nondeterministic Turing machine and let $omega in Sigstar$.
- $M$ *_accepts_* $omega$ if there's at least one finite sequence of moves from $q0 omega$ that ends with $M$ in $qacc$
- $M$ *_rejects_* $omega$ if every finite sequence of moves of $M$ from $q0 omega$ is finite and none end in $qacc$
- $M$ *_loops_* on $omega$ otherwise

Nondeterministic Turing machines and standard Turing machines can simulate
each other - meaning they recognize and decide the same languages.

== Simulations


TODO: give a more concrete set of steps, perhaps from an example like lecture #11

#[
  #set enum(numbering: "(a)")
  #let Mhat = $hat(M)$
  #let C1 = $cal(C)_1$
  #let C2 = $cal(C)_2$

  To show that a *_second_* model of computation is at least as powerful as a
  *_first_* model of computation:
  + consider an arbitrary machine $M$ of the *_first_* model of computation
  + define a machine #Mhat of the *_second_* model of computation that does what $M$ does
    - describe how a configuration of $M$ is represented when #Mhat is being used
    - often includes how many tapes, what they're used for, and possibly #Mhat's tape alphabet $hat(Gamma)$
  + prove that #Mhat solves the same problem as $M$

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

== Multi-Tape Turing Machines

For any fixed integer $k >= 1$, a *_$k$-tape Turing Machine_* is a Turing
machine with $k$ tapes with heads that can move independently, and transitions
allow left, right and stay moves. Like the 7-tuple $M = (Q, Sigma, Gamma,
delta, q0, qacc, qrej)$ where everything is the same as standard Turing machines
except the transition function has the type $delta : Qtran times Gamma^k arrow.r
Q times (Gamma times {"L","R","S"})^k$.

=== Representing Configurations and Moves

Configurations of a $k$-tape Turing machine $M$ are represented like this:

$
omega_(1,L) " " q " " omega_(1,R) " " sharp " " omega_(1,L) " " q " " omega_(1,R) " " sharp " " dots " " sharp " " omega_(k,L) " " q " " omega_(k,R)
$

Where $M$ is in state $q$ (meaning $q$ is in $M$'s finite control), the symbol
$sharp$ does not belong to $Q union Gamma$, $omega_(i, L)$ is the string of
symbols stored to the _left_ of the tape head on the $i^("th")$ tape,
$omega_(i, R)$ is the string of symbols stored starting at, and to the _right_
of the tape head ending with the rightmost non-blank symbol on or to the right
of the tape head.

=== Processing Strings

The initial configuration for a $k$-tape Turing machine $M$ with input string
#arbstring is when $M$ is in its start state $q0$, the input string $omega$ is
copied into the first tape starting at the leftmost cell, and every other tape
is left blank. Represented as follows:

$
cal(C)_"init" = q0multi
$

Accepting, rejecting, and looping work as they do in standard Turing machines
(i.e. is an accepting or rejecting state derived from the initial configuration
for $omega$).

=== Processing Languages

Multi-tape Turing machines and standard Turing machines can simulate each
other - meaning they recognize and decide the same languages.

The *_language_* $L$ of a multi-tape Turing machine $M$, as well as whether M
*_decides_* or *_recognizes_* $L$, is similar to standard Turing machines.

=== Multi-Tape Turing Machines That Compute Functions

Let $k$ be a postive integer. A *_$k$-tape Turing machine that computes a
function_* can be modelled as a 7-tuple $M = (Q, Sig1, Sig2, Gamma, delta,
q0, qhalt)$ where $Q, Sig1, Sig2, Gamma, q0$, and $qhalt$ are similar to
standard Turing machines that compute functions, but where the transition
function $delta$ has the type $delta : (Qnohalt) times Gamma^k arrow.r Q
times (Gamma times {L, R, S})^k$.

Configurations (including initial configurations) and transitions/moves are the
same as for standard Turing machines.

A $k$-tape Turing machine that computes functions $M$ computes a function
#functype if the followint proerties are satisfied, for every string
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

=== Universal Turing Machines

#let LTM = $L_"TM"$
#let SigTM = $Sigma_"TM"$
#let SigstarTM = $Sigstar_"TM"$

#let LTMI = $L_"TM+I"$
#let ATM = $A_"TM"$
#let ATMC = $ATM^complement$

#let MUTM = $M_"UTM"$

Consider only "non-trivial" Turing machines where $q0 != qacc$ and $q0 != qrej$.

An *_encoding_* of a standard Turing machine #turing is a string over the
alphabet $SigTM = {s,q,0,1,2,3,4,5,6,7,8,9,L,R,Y,N,(,),"(a literal ',')",;}$.

- $LTM subset.eq SigstarTM$ is the language of encodings of Turing machines.
- $LTMI subset.eq SigstarTM$ is the language of encodings of Turing machines
  $M$ (with some input alphabet $Sigma$) and input strings #arbstring (one
  input string and Turing machine per string $mu in LTMI$).

#LTM and #LTMI are both *_decideable._*

#[
  #let arbstringTM = $mu in SigstarTM$

  A *_universal Turing machine_* is a (standard or multi-tape) Turing machine
  #MUTM, with input alphabet #SigTM such that for every string #arbstringTM,
  the following properties are satisfied:
  - if $mu in.not LTMI$, #MUTM *_rejects_* $mu$.
  Otherwise, $mu in LTMI$ so that $mu$ encodes a Turing machine $M$ (with some
  input alphabet $Sigma$) and an input string #arbstring.
  - #MUTM *_accepts_* $mu$ *_if and only if_* $M$ *_accepts_* $omega$
  - #MUTM *_rejects_* $mu$ *_if and only if_* $M$ *_rejects_* $omega$
  - #MUTM *_loops_* on $mu$ *_if and only if_* $M$ *_loops_* on $omega$

  // #MUTM begins by checking its input string #arbstringTM belongs to #LTMI,
  // *_rejecting_* $mu$ if $mu in.not LTMI$. If $mu in LTMI$, $mu$ is an encoding
  // of some (standard) Turing machine $M = (Q, Sigma, Gamma, delta, q0, qacc,
  // qrej)$ and an input string #arbstring. #MUTM continues by *_simulating_*
  // execution of $M$ on $omega$.


  $ATM subset.eq LTMI$ is the language of encodings of Turing machines #turing
  (with some input alphabet $Sigma$) and input strings #arbstring such that $M$
  *_accepts_* $omega$. In particular, it is the language of any universal
  Turing machine i.e. $ATM = L(MUTM)$.

  Since UTMs exist, #ATM is *_recognizeable_*. However, #ATM *_is not
  decidable._*

  The complement of #ATM, #ATMC is *_unrecognizeable._*

]

== Oracle Reductions

#[

  #let reduc  = $scripts(prec.eq)_"Q"$
  #let oreduc = $scripts(prec.eq)_"O"$

  #let L1 = $L_1$
  #let L2 = $L_2$
  #let L3 = $L_3$

  #let LSig1 = $L1 subset.eq Sigstar1$
  #let LSig2 = $L2 subset.eq Sigstar2$
  #let LSig3 = $L3 subset.eq Sigstar3$

  A *_reducibility_* is any binary relation #reduc between languages (possibly
  over different alphabets) with the following properties:
  - $L reduc L$ for every language $L subset.eq Sigstar$, for every alphabet
    $Sigma$ i.e. #reduc is *_reflexive._*
  - For all languages #LSig1, #LSig2, and #LSig3, (and alphabets #Sig1, #Sig2,
    and #Sig3) if $L1 reduc L2$ and $L2 reduc L3$, then $L1 reduc L3$ i.e.
    #reduc is *_transitive._*

  An *_oracle for a language $L subset.eq Sigstar_L$_* is a device capable of
  reporting whether any string $arbstring_L$ is a member of $L$. Think of a
  black box or *_library procedure available to call_* that can be relied on to
  decide membership in $L$.

  Let #LSig1 and #LSig2. Then #L1 is *_oracle reducible_* to #L2 (notated $L1
  oreduc L2$) if there exists an algorithm that decides membership in #L1 that
  uses an oracle (i.e. a procedure or subroutine) deciding membership in #L2.

  === Describing an Oracle Reduction Between Languages

  TO describe an oracle reduction from a language #LSig1 to a language #LSig2:
  + Give pseucode for an algorithm that decides membership in #L1 using a
    separate *_Boolean method_* that decides membership in #L1.
    - _No need to write an algorithm that decides #L2, just assume one exists
      and is correct_.
  + If not obvious, _prove the correctness_ of the algorithm that decides
    membership in #L1, assuming the correctness of the algorithm that decides
    membership in #L2
  + Show that _if there exists_ a multi-tape Turing machine $M_2$ that decides
    membership in #L2, then this can be used as a component in a multi-tape
    Turing machine $M_1$ that would decide membership in #L1

  The set of oracle reductions forms a *_reducibility_* as defined above.

  Let #LSig1 and #LSig2, for alphabets #Sig1 and #Sig2. If $L1 oreduc L2$ and
  #L2 is *_decidable_*, then #L1 is *_decidable_* as well i.e. the set of decidable
  languages is *_closed_* under oracle reductions.

  If $L1 oreduc L2$ and #L1 is *_undecideable_*, then #L2 is *_undecideable_*.

]


== Church Turing Thesis

Many abstract models of computation have been proposed, and shown to be
equivalent to Turing machines with *_simulations_* - its widely believed that
Turing machines are the "most powerful possible" computers.

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
- state that every string $omega in Sigstar$ has a length $abs(omega) in NN$. Can call the length $n$.
- state induction on the length of the string $omega$
  - state standard or strong form of induction
- base case is $abs(omega) = 0$, which implies that $omega = lambda$ (since $lambda$ is the only member of #Sigstar with length 0)
- inductive step is every string $omega in Sigstar$ with length $abs(omega) = k + 1$ has property $P(k)$.
  - show that $omega$ isn't empty, and in particular $omega = mu dot sigma$ for some $mu in Sigstar$ and $sigma in Sigma$
- proof should end with a conclusion e.g. "It now follows, by induction on length of the string $omega$, that every string $omega in Sigstar$ \<has desired property\>"

== Misc notes:

- $lambda in Sigstar$, always.
- write answers in *_heavy, dark pencil_*, and *_leave at least a one-inch margin_*.
