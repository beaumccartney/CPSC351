#set text(size: 10pt)
#set enum(numbering: "i.")
#let list_indent = 1.5em

#set list(indent: list_indent)

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

#let iff = $arrow.l.r.long.double$

= CPSC 351 F2025 Assignment 2 Part 1

*Group:* 16\
*Members:* Beau McCartney (30095634), Sargun Kaur (30268472), Luis Hernandez (30241559)

== Question 1

// modify proof of accepting all in Lecture 16 - I suspect this is literally
// substituting the rejecting state in for the accepting state in the accepting
// all proof

Since #NATM is undecidable, if $NATM MOreduc Lempty$, then #Lempty (and thus
the "accepting nothing" problem) must also be undecidable.

The "accepting all" problem is shown to be undecidable by showing that $ATM
MOreduc AllTM$. The given proof can be modified to instead show that $NATM
MOreduc Lempty$, as desired.

The mapping, $phi$, now must map instances of the "non-acceptance" problem to
instances of the "accepting nothing" problem (as in the original proof, $phi$
maps $LTMI$ to $LTM$). To use $phi$ in a many-one reduction, $phi$ must map
yes-instances of the "non-acceptance" problem to yes-instances of the
"accepting nothing" problem, and no-instances of the former to no-instances in
the later. From the definitions of the two problems:
- $phi$ must map a Turing machine and an input string the machine *_rejects or
  loops on_* to a Turing to a Turing machine that *_rejects or loops on every
  string_*
- $phi$ must map a Turing machine and an input string the machine *_accepts_*
  to a Turing machine that *_accepts at least one string._*
Equivalently, using the definitions for $M$, $Mhat$, and $omega$ from the definition of $phi$ in the proof of #AllTM's decidability, $ M "rejects or loops on" omega iff
L(Mhat) = emptyset. $ The actual scheme for generating output Turing machine is
identical, and in fact satisfies the required properties described above.
Recall for a Turing machine $M$ and an input string $omega$, $phi$ generates a
Turing machine $Mhat$ that ignores its input and instead simulates $M$'s
execution on $omega$, accepting if $M$ eventually accepts $omega$, rejecting if
$M$ eventually rejects $omega$ and looping otherwise. Then:
- If $M$ _rejects or loops on_ $omega$ (meaning $M$ and $omega$ constitute a
  _yes-instance_ of the "non-acceptance problem"), then $Mhat$ _rejects or
  loops on every string_, as desired.
- If $M$ _accepts_ $omega$ (meaning $M$ and $omega$ constitute a _no-instance_
  of the "non-acceptance problem"), then $Mhat$ _accepts all strings_ (and thus
  accepts at least one string) as desired.

The only changes to the $ATM MOreduc AllTM$ proof required are the changes to
$phi$ and the following amendments to the proof's completion:
- It follows from above that, for every string $arbstringTM, mu in NATM iff
  f(mu) in Lempty$.
- Thus, $f$ is a *_many-one reduction_* from #NATM to #Lempty #sym.dash.em and
  from the "non-acceptance" problem to the "accepting nothing" problem.
- Since #NATM is undecidable, this implies that #Lempty is undecidable too.
  Thus, the "accepting nothing" problem is undecidable.

In particular, the instance languages of the "accepting" and "non-accepting"
problems are the same, and similar for the "accepting all" and "accepting
nothing" problems, so the encodings and choice of $xno$ are all the same.

// - instead of showing that $ATM MOreduc AllTM$, show that $NATM MOreduc Lempty$
//   -
//   - yes instance of #NATM - $M$ doesn't accept $omega$ and so new Turing machine
//     doesn't accept its "only input string" ($omega$), so new Turing machine
//     accepts nothing and is a yes instance of "accepting nothing"
//   - no instance of #NATM - $M$ _does_ accept $omega$ and so new Turing machine
//     accepts its "only input string" ($omega$) so new Turing machine accepts
//     everything and is a no instance of "accepting nothing"
//   // - $M "does not accept" omega arrow.l.r L(Mhat) = emptyset$

== Question 2

Recall that $f : SigstarTM arrow.r SigstarTM$ is defined as shown below, for
every string #arbstringTM:

$
f(mu) = cases(
  xyes &"if" mu in ATM,
  xno  &"if" mu in.not ATM,
)
$

For $f$ to be a many-one reduction from #ATM to #Luseless, $f$ must be
_computable_ (by the definition of a many-one reduction). For $f$ to be
computable, there must exist a Turing machine that computes $f$. From the
definition of $f$, its clear that such a Turing machine would need to decide
#ATM to compute $f$. However, #ATM is undecidable, meaning that no Turing
machine that decides (and computes) $f$ exists, and so $f$ is *_not_*
computable.


// To prove that $L_"useless"$ is many-one reducible form $A_"TM"$, it must satisfy 4 conditions.
// -  We must clearly and precisely describe the total function $f: SigstarTM -> SigstarTM $ that will be shown to be a “many-one reduction.”
// - We must prove that if $omega in L_"useless" $ then $f(x) in A_"TM"$ for every string $omega in SigstarTM$
// - We must prove that if $omega in.not L_"useless"  $ then $f(x) in.not A_"TM"$ for every string $omega in SigstarTM$
// - We must sketch a Proof that $f$ is computable
//
// We can show that $f$ is not a many-one reducible from $A_"TM"$   to $L_"useless"$ by a proof by contradiction. In the question, $f$ is described to be dependent on weather or not a string imputed, $mu$ exists in $A_"TM"$. Since $f$ is dependent on $A_"TM"$, for $f$ to be computable, $A_"TM"$ must also be computable. For $A_"TM"$ to be computable, every input string must result in a halting state, and can not loop on forever. As described in the supplemental document, the language of $A_"TM"$ is undecidable, so by definition, there exists cases where $A_"TM"$ does not hault on an input string. Therefore $A_"TM"$ is not computable, and by extension $f$ can not be computable. This proves that $f$ does not satisfy all the conditions need to be many-one reducible from $A_"TM"$ to $L_"useless"$, and therefore $f$ is not a many-one reduction from $A_"TM"$ to $L_"useless"$.

== Question 3


// We think we can map this to the non acceptance problem since if it is not accepted, by definition it does not reach the accepting state.

The "accepting nothing" problem asks if a given Turing machine reject all input
strings. In other words, is the language of the given Turing machine
simply the empty set?

The "useless state" problem asks if a given Turing machine can never be in a
given state in that Turing machine's finite control.


// TODO: explain that instances contain Turing machine plus state or input string
Recall the following:
- $LTM subset.eq SigstarTM$ is the language of strings that encode a Turing
  machine, and thus is the language of instances of the "accepting nothing"
  problem.
- $Lempty subset.eq LTM$ is the language of yes-instances of the "accept
  nothing" problem.
- $LTMSTATE subset.eq SigstarTM$ is the language of strings that encode a
  Turing machine and a state in that Turing machine's finite control, and thus
  is the language of instances of the "useless state" problem
- $Luseless subset.eq LTMSTATE$ is the language of yes-instances of the
  "useless state" problem.

The "accepting nothing" problem can be used to prove that the "useless state"
problem is undecidable, by showing that $Lempty MOreduc Luseless$.

Our scheme for mapping an instance of the "accepting nothing" problem to an instance
of the "useless state" problem is simple:
- Put an opening parenthesis "(" in the first character of the mapping output.
- Copy the Turing machine encoding in the "accepting nothing" instance to the
  mapping output, in the cells immediately to the right of the first cell.
- Put a comma "," in the first cell after the Turning machine encoding, to
  delimit the Turing machine from the "target state" of the "useless state"
  check.
- In the cells directly to the right of the "," that was just written, copy the
  string "qY)". This sets the "target state" of the "useless state" check to
  the accepting state, and closes the parenthesis that surround the encoding of
  an instance of the "useless state" problem.

This procedure will map yes-instances of the "accepting nothing" problem to
yes-instances of the "useless state" problem, and no-instances of the former to
no-instances of the latter.

In particular, by the definition of the "accepting nothing" problem:
- Any yes-instance of the "accepting nothing" problem encodes a
  Turing machine that doesn't accept any string and therefore never enters its
  accepting state. Thus by the definition of the "useless state" problem, the
  encoded Turing machine's accept state is "useless".
- Any no-instance of the "accepting nothing" problem encodes a Turing machine
  that with a non-empty language. That is, the encoded Turing machine accepts
  at least one string and therefore enters its accepting state, provided that
  string is the input. Thus by the definition of the "useless state" problem,
  the encoded Turing machine's accept state is not "useless".

From above, and since our encodings of the "useless state" problem always have
the accept state as the state to check, it follows that yes-instances of the
"accepting nothing" problem map to yes-instances of the "useless state"
problem, and no-instances of the former map to no-instances of the latter.
