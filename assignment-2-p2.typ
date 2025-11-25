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

#let LTM = $L_"TM"$
#let SigTM = $Sigma_"TM"$
#let SigstarTM = $Sigstar_"TM"$

#let arbstringTM = $mu in SigstarTM$

#let LTMI = $L_"TM+I"$
#let ATM = $A_"TM"$
#let ATMC = $ATM^complement$

#let MUTM = $M_"UTM"$

#let reduc  = $scripts(prec.eq)_"Q"$
#let Oreduc = $scripts(prec.eq)_"O"$

#let NATM = $italic("NA")_"TM"$

#let MOreducfunc = $f: #Sigstar1 arrow.r #Sigstar2$
#let MOreduc = $scripts(prec.eq)_M$

#let xyes = $x_"Yes"$
#let xno  = $x_"No"$

#let LTMSTATE = $L_"TM+State"$

#let Lempty   = $L_"Empty"$
#let Luseless = $L_"Useless"$

#let AllTM   = $italic("All")_"TM"$

#let Inonacc = $I_"non-accept" in LTMI$

#let Mhat = $hat(M)$
#let qhat = $hat(q)$

#let MTM = $M_"TM"$

#let iff = $arrow.l.r.long.double$

#let mappedstr(var) = $\""("\" dot var dot \"",qY)"\"$

= CPSC 351 F2025 Assignment 2 Part 2

*Group:* 16\
*Members:* Beau McCartney (30095634), Sargun Kaur (30268472), Luis Hernandez (30241559)

// I THINK QUESTION 5, AND 8 ARE ROCK SOLID SO FAR. 4 and 6 could use some work.


== Question 4

// AFTER THINkING ABOUT IT i think that lecture 16 completed notes has a better example as to how to state a mapping and will try and work it into this problem later! - LUIS
// Tutorial 15 solins is good as well

To show that the "Useless State" problem is undecidable, we will reduce the
"Accepting Nothing" problem to the "Useless State" problem. That is, show that
$Lempty MOreduc Luseless$. Since the "Accepting Nothing" problem is
undecidable, showing that it reduces to the "Useless State" problem is
sufficient to show that the latter problem is also undecidable.

Consider a Turing machine $ M = (Q, Sigma, Gamma, delta, q0, qacc, qrej). $
Note that $M$ is an instance of the "Accepting Nothing" problem.

The goal is to map $M$ to an instance of the "Useless State" problem
#sym.dash.em including a Turing machine #Mhat and one #Mhat's states #qhat,
such that $M$ is a Yes-instance of the "Accepting Nothing" problem if and only
if #Mhat and #qhat constitute a Yes-instance of the "Useless State" problem.

Given $M$ as the input to our mapping, our mapping sets $Mhat = M$ and $qhat =
qacc$. In other words, we map a given Turing machine to itself and its
accepting state.

Any Turing machine that's a Yes-instance of the "Accepting Nothing" problem
will never reach its accepting state for any input, making its accepting state
"useless" (as described in the definition of the "Useless State" problem), and
making that Turing machine and its accepting state a Yes-instance of the
"Useless State" problem.

Similarly, for any Turing machine that's a No-instance of the "Accepting
Nothing" problem, there exists some string that's accepted by that Turing
machine, meaning its accepting state is _not_ useless. Thus, that Turing machine
and its accepting state is a No-instance of the "Useless State" problem.

The two preceding paragraphs are informal commentary, written to communicate
the "basic idea" behind our choice of mapping. The correctness of our mapping
is shown in our answer to question 5.

// Our group will be using the "Accepting Nothing" problem, when proving the "Useless State" problem, a mapping can be given as follows:

// Our scheme for mapping an instance of the "Accepting Nothing" problem to an instance
// of the "Useless State" problem is simple:
// - Put an opening parenthesis "(" in the first character of the mapping output.
// - Copy the Turing machine encoding in the "Accepting Nothing" instance to the
//   mapping output, in the cells immediately to the right of the first cell.
// - Put a comma "," in the first cell after the Turning machine encoding, to
//   delimit the Turing machine from the "target state" of the "useless state"
//   check.
// - In the cells directly to the right of the "," that was just written, copy the
//   string "qY)". This sets the "target state" of the "useless state" check to
//   the accepting state, and closes the parenthesis that surround the encoding of
//   an instance of the "useless state" problem.

== Question 5

Let $M = (Q, Sigma, Gamma, delta, q0, qacc, qrej)$ be a Turing machine (and
therefore an instance of the "Accepting Nothing" problem). The following claims
hold:

*Claim 1:* If $M$ is a Yes-instance of the "Accepting Nothing" problem, then
$M$ and #qacc constitute a Yes-instance of the "Useless State" problem. That
is, our mapping maps Yes-instances of the "Accepting Nothing" problem to
Yes-instances of the "Useless State" problem.

*_Proof:_*

Suppose that $M$ is a Yes-instance of the "Accepting Nothing" problem, meaning
$L(M) = emptyset$.

Then there _does not exist_ any input string #arbstring, and strings $mu, nu in
Gamstar$ such that $ q0 space omega tackstar mu space qacc space nu. $ Thus, by
the definition of a useless state, #qacc _is_ useless, and thus $M$ and #qacc
constitute a Yes-instance of the "Useless State" problem, as claimed.

$qed$

*Claim 2:* If $M$ is a No-instance of the "Accepting Nothing" problem, then $M$
and #qacc constitute a No-instance of the "Useless State" problem. That is, our
mapping maps No-instances of the "Accepting Nothing" problem to No-instances of
the "Useless State" problem.

*_Proof:_*

Suppose that $M$ is a No-instance of the "Accepting Nothing" problem. Then
$L(M) != emptyset$ meaning there exists at least one string $omega in L(M)$.

This implies that there also exists strings $mu, nu in Gamstar$ such that $ q0
space omega tackstar mu space qacc space nu. $ Then, by the definition of a
useless state, $qacc$ is _not_ useless, and thus $M$ and #qacc constitute a
No-instance of the "Useless State" problem, as claimed.

$qed$

== Question 6

*A note concerning our notation:* To make notating strings containing
punctuation more clear, we enclose such strings in double quotes. The quotes
are _not_ part of the string, they're simply there to delimit the string
referred to. We occasionally use the "dot" symbol to concatenate strings
together, including strings enclosed by quotes. In this case, the quotes are
still delimiters not included in the string being referred to. For example, if
$omega in SigstarTM$ the string $\""("\" dot omega dot \"",ab)"\"$ is $omega$
enclosed by an opening parenthesis on the left, and a comma, the letter "a",
the letter "b", then a closing parenthesis on the right.

*Considering Encodings.* Recall that instances of the "Accepting Nothing"
problem are strings that belong to $LTM subset.eq SigstarTM$ (and therefore
encode a Turing machine). Also recall that $LTMSTATE subset.eq SigstarTM$ is
the language of instances of the "Useless State" problem. In particular, any
string $omega in LTMSTATE$ (that is, an instance of the "Useless State"
problem) has an encoding $mu in LTM$ of a Turing machine $M$, and an encoding
$nu in SigstarTM$ of one of $M$'s states, separated by a comma and enclosed by
parentheses.

Since $mu in LTM$, the Turing machine encoded in an instance of the "Accepting
Nothing" problem is perfectly valid as the encoding of a Turing machine in the
"Useless State" problem. Additionally, every Turing machine that is an instance
of the "Accepting Nothing" problem has an accepting state, and this is always
encoded as the string "qY".

It follows that for any instance of the "Accepting Nothing" problem $mu in
LTM$, the string $ hat(mu) = mappedstr(mu) $ is a valid instance of the
"Useless State" problem (and thus a member of #LTMSTATE). In particular,
$hat(mu)$ encodes the same Turing machine $M$ encoded by $mu$, and its
accepting state #qacc. This is precisely the instance of the "Useless State"
problem that our mapping defined in our answer to question 4 maps $M$ to. Thus,
for any instance of the "Accepting Nothing" problem $mu in LTM$, the encoding
of our mapping defined in step 4 is the string $hat(mu) = mappedstr(mu)$.

*Confirming that the "usual situation" arises.* Recall that #LTM is the
language of instances of the "Accepting Nothing" problem, #LTMSTATE is the
language of instances of the "Useless State" problem, and that both are
decidable. Also recall that $lambda in.not LTMSTATE$, since all members of
#LTMSTATE contain parentheses and a comma (as well as the encoding of a Turing
machine and a state). We will use $lambda$ as our "junk" string.

*Completing the Definition of $f$.* Let $f: SigstarTM arrow.r SigstarTM$ be the
total function that is defined as follows, for every string #arbstringTM: $
f(mu) = cases(
  mappedstr(mu) &"if" mu in LTM,
  lambda        &"if" mu in.not LTM,
)
$

In particular, in the case that $mu in LTM$, $f(mu)$ is the encoding of our
mapping $hat(mu)$ as described above.

// As established in the assignment document, the language of instances of the
// "Accepting Nothing" problem is the decidable language $L_"TM"$ and the language
// of instances of the "Useless State" problem is the decidable language $L_"TM +
// State" subset.eq Sigma_"TM"^*$. Let $x_"no"$be strings in $Sigma_2^*$ such that
// it does not exist in the language $L_"TM + State"$. Consider the total function
// $f: Sigma^*_1 arrow Sigma^*_2$, such that for every string $mu in Sigma_1^*$
//
// // NOTE(beau): state at some point that lambda isn't in sigmastar tm (the language of encodings of turing machines), so we can choose xno = lambda
// //
// $
// f(mu) = cases(
//   "Encoding of turing machine and it's accpetance state" &"if" mu in L_"TM", // NOTE(beau): this is the mapping described in my solin, where we basically copy in the encoded turing machine plus a bit of boilerplate to check if the accepting state is useless
//   x_"no" &"if" mu in.not L_"TM"
// )
// $

== Question 7

Let $mu in SigstarTM$.

To show that $f$ is a many-one reduction from #Lempty to #Luseless, we need to
prove the following claims:

- *Claim 3:* If $mu in Lempty$, then $f(mu) in Luseless$.
- *Claim 4:* If $mu in.not Lempty$, then $f(mu) in.not Luseless$
- *Claim 5:* $f$ is computable.

*Proof of claim 3.*

Suppose $mu in Lempty$.

Since $Lempty subset.eq LTM$, it follows that $mu in LTM$ and therefore $f(mu)
= mappedstr(mu)$. As established in our discussion of encodings, $f(mu)$
encodes an instance of the "Useless State" problem (that is,\ $f(mu) in
LTMSTATE$), as defined in our answer to question 4. In particular, $f(mu)$
encodes a Turing machine $M$, and its accept state #qacc.

Claim 1, above, implies that $M$ and #qacc constitute a Yes-instance of the
"Useless State" problem, and so $f(mu) in Luseless$, as claimed.

$qed$

*Proof of claim 4.*

Suppose $mu in.not Lempty$.

Either $mu in LTM$ or $mu in.not LTM$. Each case is considered separately
below:
- *$mu in LTM$:* Since $mu in LTM$, it follows that $f(mu) = mappedstr(mu)$. As
  established in our discussion of encodings, $f(mu)$ encodes an instance of
  the "Useless State" problem (that is, $f(mu) in LTMSTATE$), as defined in our
  answer to question 4. In particular, $f(mu)$ encodes a Turing machine $M$,
  and its accept state #qacc.

  Claim 2, above, implies that $M$ and #qacc constitute a No-instance of the
  "Useless State" problem, and so $f(mu) in.not Luseless$.
- *$mu in.not LTM$:* Since $mu in.not LTM$, $f(mu) = lambda in.not Luseless$.

In every case, $f(mu) in.not Luseless$, as claimed.

$qed$

*Proof of claim 5.*

Recall that #LTM is decidable. Thus, there exists a one-tape Turing machine
#MTM that decides #LTM, and "cleans up after itself" (that is, fills its
tape with copies of "#blank" and moves its tape head to the leftmost cell
before halting).

Consider a 3-tape Turing machine $M_f$, with input alphabet #SigTM, with an
"embedded" copy of #MTM (that only changes symbols and moves the tapehead on
the second tape) whose tapes are used as follows.
- The first tape is the input tape.
- The second tape is used by the copy of #MTM to decide if the machine's input belongs to #LTM.
- The third tape is the output tape.

When executed on an input string $omega in SigstarTM$, the computation proceeds
as follows.
+ The Turing machine begins by copying $omega$ onto the second tape (marking
  the symbol at the leftmost cell of the tape at the start, then moving tapes
  back to their leftmost cells and "unmarking" the symbol at the leftmost cell)
  #sym.dash.em and then it enters the start state for the copy of #MTM.

  Transitions to #MTM's accept state are redirected to a state that begins Step
  2, below. Transitions to #MTM's reject state are redirected to a state that
  begins Step 3, below.
+ The symbol "(" is copied onto the leftmost cell of the third tape, then the
  tape head is moved one cell to the right. Then, "sweeping right" over the
  first tape from the first cell (and therefore over $omega$), the symbols of
  $omega$ are copied onto the third tape, starting at the "second-to-leftmost"
  cell. After copying the last symbol of $omega$, the tape head is moved one cell
  to the right, to point at the first cell just past what has been copied so
  far. Then the string ",qY)" is copied onto the third tape. Thus, the string
  $f(omega) = mappedstr(omega)$ has been copied to the third tape. Then
  execution proceeds at step 3.
+ Finally, the machine "cleans up" its first tape (the second was cleaned in
  the execution of #MTM in step 1) in a similar manner to #MTM cleaning up its
  tape, then halts. Note that if #MTM rejected $omega$ (that is, $omega in.not
  LTM$), step 2 was skipped and therefore the third tape was left blank and its
  tapehead was never moved from the leftmost cell, meaning that it contains
  only blanks and so encodes\ $lambda = f(omega)$.

An examination of the definition of $f$ will confirm that $M_f$ as described
above, computes $f$. Thus, $f$ is computable, as claimed.

$qed$

== Question 8

It follows from claims 3, 4, and 5, that $f$ is a *_many-one reduction_* from
#Lempty to #Luseless, and so $ Lempty MOreduc Luseless. $

Since #Lempty is undecidable, it follows that #Luseless is undecidable.

$qed$
