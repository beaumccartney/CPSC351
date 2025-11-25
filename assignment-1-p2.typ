#set text(size: 10pt)
#set enum(numbering: "i.")
#let list_indent = 1.5em

#set list(indent: list_indent)

#let sigstar = $Sigma^star$
#let arbstring = $omega in sigstar$
#let notExists = $omega in.not$
#let emp = $emptyset$

// de-duplicate subscripts
#let subENO  = $emp,"no"$
#let subANO  = $a, "no"$
#let subABNO  = $a + b, "no"$
#let subEYES = $emp, "yes"$
#let subAYES = $a, "yes"$
#let subABYES  = $a + b, "yes"$
#let sI= $S_i$

#let qENO  = $q_subENO$
#let qANO  = $q_subANO$
#let qABNO = $q_subABNO$
#let qEYES = $q_subEYES$
#let qAYES = $q_subAYES$
#let qABYES = $q_subABYES$

#let sENO  = $S_subENO$
#let sANO  = $S_subANO$
#let sABNO  = $S_subABNO$
#let sEYES = $S_subEYES$
#let sAYES = $S_subAYES$
#let sABYES  = $S_subABYES$

#let sUNION = $sENO union sANO union sABNO union sEYES union sAYES union sABYES$

= CPSC 351 F2025 Assignment 1 Part 2

*Group:* 16\
*Members:* Beau McCartney (30095634), Sargun Kaur (30268472), Luis Hernandez (30241559)

== Question 2
We will be using the instructor's solution for the rest of the assignment. That is, the DFA includes a set of states

$
Q = {qENO, qANO, qABNO, qEYES, qAYES, qABYES}.
$

The corresponding subsets of #sigstar are given below. Each set corresponds to the state with the same subscript.

$
sENO = {arbstring | omega "does not include any copies of \"a\", and omega does not include any copies of \"c\""}
$
$
sANO = {arbstring | omega "includes at least one copy of \"a\", but no copy of \"b\" in" omega "appears"\ "anywhere after any copy of \"a\"; and" omega "does not include any copies of \"c\""}
$
$
sABNO = {arbstring | "a copy of \"a\" is eventually followed by a copy of \"b\" in" omega "and" omega "does not include any copies of \"c\""}
$
$
sEYES = {arbstring | omega "does not include any copies of \"a\" and" omega "includes at least one copy of \"c\""}
$
$
sAYES = {arbstring | omega "includes at least one copy of \"a\", but no copy of \"b\" in" omega\ "appears anywhere after a copy of \"a\"; and" omega "includes at least one copy of \"c\""}
$
$
sABYES = {arbstring | "a copy of \"a\" is eventually followed by a copy of \"b\" in" omega, "and" omega "includes at least one copy of \"c\""}
$

== Question 3

// THERE IS ALOT OF NESTED STATEMENTS HERE, MAYBE WE SHOULD REFORMAT
// beau: I'd like to, but every attempt I've made to flatten things has worsened the clarity of the writing. I'm not sure how to do so

Show that every string is in exactly one of the sets.

Let us first show that every string in #sigstar belongs to _at least_ one of the sets #sENO, #sANO, #sABNO, #sEYES, #sAYES, and #sABYES. That is

$
sUNION = sigstar
$

Let #arbstring. Then either $omega in sENO$, or $omega in.not sENO$. These cases are considered separately below.
- If $omega in sENO$ then trivially $omega in sENO subset.eq sUNION$, as desired.
- If $omega in.not sENO$, then $omega$ includes an "a" or a "c" (or both). One of the following must be true: $omega$ contains an "a" and no "c"s, $omega$ contains a "c" but no "a"s, or $omega$ contains both "a" and "c". Each case is considered separately below.
  - If $omega$ contains an "a" and no "c"s, then either a copy of "a" is followed by a copy of "b" in $omega$, or not. Each subcase is considered separately below.
    - If a copy of "a" is followed by a copy of "b" in $omega$, then $omega in sABNO subset.eq sUNION$, as desired (recall that $omega$ does not contain any "c"s).
    - If there are no copies of "a" is followed by a  copy of "b" in $omega$, then $omega in sANO subset.eq sUNION$
  - If $omega$ contains at least one "c" and no "a"s, then $omega in sEYES subset.eq sUNION$, as desired.
  - If $omega$ contains both "a" and "c", then either a copy of "a" is eventually followed by a copy of "b" in $omega$, or not. Each subcase is considered separately below.
    - If a copy of "a" is eventually followed by a copy of "b" in $omega$, then $omega in sABYES subset.eq sUNION$, as desired (recall that $omega$ contains both "a" and "c").
    - If no copy of "a" is eventually followed by a copy of "b" in $omega$, then $omega in sAYES subset.eq sUNION$, as desired (recall that $omega$ contains both "a" and "c").

Since both cases have been considered, it now follows that if #arbstring, then $omega in sUNION$. That is

$
sigstar subset.eq sUNION.
$

On the other hand, since #sENO, #sANO, #sABNO, #sEYES, #sAYES, and #sABYES are all subsets of #sigstar, clearly #sUNION must be a subset of #sigstar as well. Thus

$
sUNION = sigstar,
$

and every string in #sigstar belongs to at least one of #sENO, #sANO, #sABNO, #sEYES, #sAYES, or #sABYES.

It remains only to show that every in #sigstar belongs to _at most_ one of #sENO, #sANO, #sABNO, #sEYES, #sAYES, or #sABYES. This can be proved by establishing each of the following, for every string #arbstring\.

// (Note: Due to the commutative law for intersection, when we prove for A $inter$ B, for any set A and B, it is equal to B $inter$ A. Later on in this proof we will be referencing pervious intersection statements, where these two statements are equal. We will refer to them using figures i. - figure v.)

#[
  #set enum(numbering: "(a)") // NOTE IMPORTANT (beau), if you change the lettering, make sure to change the references to cases below!!
  + If $omega in sENO$, then $omega$ does not belong to any of #sANO, #sABNO, #sEYES, #sAYES, or #sABYES
  + If $omega in sANO$, then $omega$ does not belong to any of #sENO, #sABNO, #sEYES, #sAYES, or #sABYES
  + If $omega in sABNO$, then $omega$ does not belong to any of #sENO, #sANO, #sEYES, #sAYES, or #sABYES
  + If $omega in sEYES$, then $omega$ does not belong to any of #sENO, #sANO, #sABNO, #sAYES, or #sABYES
  + If $omega in sAYES$, then $omega$ does not belong to any of #sENO, #sANO, #sABNO, #sEYES, or #sABYES
  + If $omega in sABYES$, then $omega$ does not belong to any of #sENO, #sANO, #sABNO, #sEYES, or #sAYES
  
  Each case is considered separately below.
  
  + Let $omega in sENO$ so that $omega$ does not include "a"s or "c"s. Then all the following must hold:
    - $omega in.not sANO, omega in.not sAYES, omega in.not sABNO$, and $omega in.not sABYES$, since all strings in #sANO, #sAYES, #sABNO, and #sABYES include at least one "a".
    - $omega in.not sEYES$, since every string in #sEYES includes at least one "c".
    Thus no string in $sENO$ belongs to any of $sANO, sABNO, sEYES, sAYES$, or $sABYES$. That is, $ sENO inter sANO = sENO inter sABNO = sENO inter sEYES = sENO inter sAYES = sENO inter sABYES = emptyset. $
  + Let $omega in sANO$ so that $omega$ includes at least one "a", no "c"s, and no "b" eventually follows any "a" in $omega$. Then all the following must hold:
    - $omega in.not sENO$, since $sENO inter sANO = emptyset$, as shown in the above case (a).
    - $omega in.not sABNO$, since all strings in #sABNO contain at least one "b" that eventually follows an "a".
    - $omega in.not sEYES$, since all strings in #sEYES don't contain "a".
    - $omega in.not sAYES$, since all strings in #sAYES include at least one "c".
    - $omega in.not sABYES$, since all strings in #sABYES contain at least one "b" that eventually follows an "a".
    Thus no string in $sANO$ belongs to any of $sENO, sABNO, sEYES, sAYES$, or $sABYES$. That is, $ sANO inter sENO = sANO inter sABNO = sANO inter sEYES = sANO inter sAYES = sANO inter sABYES = emptyset. $
  + Let $omega in sABNO$ so that $omega$ contains a "b" after an "a", and no "c"s. Then all the following must hold:
    - $omega in.not sENO$, since $sENO inter sABNO = emptyset$, as shown in the above case (a).
    - $omega in.not sANO$, since $sANO inter sABNO = emptyset$, as shown in the above case (b).
    - $omega in.not sEYES, omega in.not sAYES$ and $omega in.not sABYES$, since all strings in #sEYES, #sAYES, and #sABYES include at least one "c".
    Thus no string in $sABNO$ belongs to any of $sENO, sANO, sEYES, sAYES$, or $sABYES$. That is, $ sABNO inter sENO = sABNO inter sANO = sABNO inter sEYES = sABNO inter sAYES = sABNO inter sABYES = emptyset. $
  + Let $omega in sEYES$, so that $omega$ includes at least one "c" and no "a"s. Then all the following must hold:
    - $omega in.not sENO$, since $sENO inter sEYES = emptyset$, as shown in the above case (a).
    - $omega in.not sANO$, since $sANO inter sEYES = emptyset$, as shown in the above case (b).
    - $omega in.not sABNO$, since $sABNO inter sEYES = emptyset$, as shown in the above case (c).
    - $omega in.not sAYES$ and $omega in.not sABYES$, since all strings in #sAYES and #sABYES include at least one "a".
    Thus no string in $sEYES$ belongs to any of $sENO, sANO, sABNO, sAYES$, or $sABYES$. That is, $ sEYES inter sENO = sEYES inter sANO = sEYES inter sABNO = sEYES inter sAYES = sEYES inter sABYES = emptyset $
  + Let $omega in sAYES$, so that $omega$ contains at least one "a", at least one "c", and no "b" eventually follows any "a" in $omega$. Then all the following must hold:
    - $omega in.not sENO$, since $sENO inter sAYES = emptyset$, as shown in the above case (a).
    - $omega in.not sANO$, since $sANO inter sAYES = emptyset$, as shown in the above case (b).
    - $omega in.not sABNO$, since $sABNO inter sAYES = emptyset$, as shown in the above case (c).
    - $omega in.not sEYES$, since $sEYES inter sAYES = emptyset$, as shown in the above case (d).
    - $omega in.not sABYES$, since all strings in #sABYES contain a "b" that eventually follows an "a".
    Thus no string in $sAYES$ belongs to any of $sENO, sANO, sABNO, sEYES$, or $sABYES$. That is, $ sAYES inter sENO = sAYES inter sANO = sAYES inter sABNO = sAYES inter sEYES = sAYES inter sABYES = emptyset $
  + Let $omega in sABYES$, so that $omega$
    - $omega in.not sENO$, since $sENO inter sABYES = emptyset$, as shown in the above case (a).
    - $omega in.not sANO$, since $sANO inter sABYES = emptyset$, as shown in the above case (b).
    - $omega in.not sABNO$, since $sABNO inter sABYES = emptyset$, as shown in the above case (c).
    - $omega in.not sEYES$, since $sEYES inter sABYES = emptyset$, as shown in the above case (d).
    - $omega in.not sAYES$, since $sAYES inter sABYES = emptyset$, as shown in the above case (e).
    Thus no string in $sABYES$ belongs to any of $sENO, sANO, sABNO, sEYES$, or $sAYES$. That is, $ sABYES inter sENO = sABYES inter sANO = sABYES inter sABNO = sABYES inter sEYES = sABYES inter sAYES = emptyset $
]


// To prove that every string $arbstring$ belongs to exactly one of our states, it can not belong to any other states. We will prove this for every state. One can see by the definitions of $sANO$, $sABNO$, $sEYES$, $sAYES$, $sABYES$, that if $arbstring$ such that $notExists sANO$, $notExists sABNO$, $notExists sEYES$, $notExists sAYES$ and $notExists sABYES$, then $omega$ does not include any copies of "a", and $omega$ does not include any copies of "c". So it follows, by the definition of $sENO$, that $omega in sENO$.

// Thus $sENO union sANO union sABNO union sEYES union sAYES union sABYES = sigstar$ : Every string in $sigstar$ belongs to at #underline[least] one of $sENO$,$sANO$ $sABNO$, $sEYES$, $sAYES$ or $sABYES$.



// NOTE IMPORTANT (beau):
// - we need to refer to the letters or numbers for each case above
// - once we do so we need to replace all instances of "by the above" with a reference to the case it was proved e.g. "as shown in case (a, 1)"
// \


/*
- Let $omega in sENO$ so that $omega$ does not include "a"s or "c"s. Then $omega in.not sANO$ since all strings in #sANO include at least one "a"; $omega in.not sABNO$, since every string in $sABNO$ includes at least "a"; $omega in.not sEYES$, since every string in #sEYES includes at least one "c"; $omega in.not sAYES$, since every string in #sAYES includes at least one "a"; and $omega in.not sABYES$, since every string in #sABYES includes at least one "a". Thus $ sENO inter sANO = sENO inter sABNO = sENO inter sEYES = sENO inter sAYES = sENO inter sABYES = emptyset, $ that is, no string in $sENO$ belongs to any of $$

 - $notExists sABNO$ since $omega$ does not include at least one copy of "a" and therefor there can never be a copy of "b" that eventually follows a copy of "a" in $omega$ : $sENO inter sABNO = emptyset$ 
 
 - $notExists sEYES$ since $omega$ does not include at least one copy of "c" : $sENO inter sEYES = emptyset$ 
 
 - $notExists sAYES$ since $omega$ does not include at least one copy of "a" or c" : $sENO inter sAYES = emptyset$ 
 
 - $notExists sABYES$ since $omega$ does not include at least one copy of "a" or "c", and therefor there can never be a copy of "b" that eventually follows a copy of "a" in $omega$ : $sENO inter sABYES = emptyset$ 


- Let $omega in sANO$
  - $sANO inter sENO = sENO inter sANO =  emptyset$ (as shown by figure i.)
  
  - $sANO inter sABNO =  emptyset$ since no string can contain at least one copy of "a" and no copies of "b" eventually follows a copy of "a "#underline[and] at least one copy of "a" and at least one copy of "b" eventually follows a copy of "a". (figure ii.)

  - $sANO inter sEYES =  emptyset$ since no string can contain at least one copy of "c" #underline[and] does not contain at least one copy of "c".

  - $sANO inter sAYES =  emptyset$ since no string can contain at least one copy of c" #underline[and] does not contain at least one copy of "c".

  - $sANO inter sABYES =  emptyset$ since no string can contain at least one copy of c" #underline[and] does not contain at least one copy of "c".

- Consider the strings in $sABNO$
  - $sABNO inter sENO = sENO inter sABNO =  emptyset$ (as shown by figure i.)
  
  - $sABNO inter sANO = sANO inter sABNO =  emptyset$ (as shown by figure ii.)

  - $sABNO inter sEYES =  emptyset$ since no string can contain at least one copy of "c" #underline[and] does not contain at least one copy of "c". (figure iii.)

  - $sABNO inter sAYES =  emptyset$ since no string can contain at least one copy of "c" #underline[and] does not contain at least one copy of "c".

  - $sABNO inter sABYES =  emptyset$ since no string can contain at least one copy of "c" #underline[and] does not contain at least one copy of "c".

- Consider the strings in $sEYES$
  - $sEYES inter sENO = sENO inter sEYES =  emptyset$ (as shown by figure i.)
  
  - $sEYES inter sANO = sANO inter sEYES =  emptyset$ (as shown by figure ii.)

  - $sEYES inter sABNO = sABNO inter sEYES =  emptyset$ (as shown by figure iii.)

  - $sEYES inter sAYES =  emptyset$ since no string can contain no copies of "a" #underline[and] contain a copy of "a" and no copy of "b" that eventually follows a copy of "a". (figure iv.)

  - $sEYES inter sABYES =  emptyset$ since no string can contain no copies of "a" #underline[and] contain a copy of "a" and a copy of "b" that eventually follows a copy of "a".

- Consider the strings in $sAYES$
  - $sAYES inter sENO = sENO inter sAYES =  emptyset$ (as shown by figure i.)
  
  - $sAYES inter sANO = sANO inter sAYES =  emptyset$ (as shown by figure ii.)

  - $sAYES inter sABNO = sABNO inter sAYES =  emptyset$ (as shown by figure iii.)

  - $sAYES inter sEYES = sEYES inter sAYES =  emptyset$ (as shown by figure iv.)

  - $sAYES inter sABYES =  emptyset$ since no string can contain at least one copy of "a" and no copies of "b" eventually following any copy of "a" #underline[and] contains at least one copy of "a" and a copy of "b" eventually follows a copy of "a".(figure v.)

- Consider the strings in $sAYES$
  - $sABYES inter sENO = sENO inter sABYES =  emptyset$ (as shown by figure i.)
  
  - $sABYES inter sANO = sANO inter sABYES =  emptyset$ (as shown by figure ii.)

  - $sABYES inter sABNO = sABNO inter sABYES =  emptyset$ (as shown by figure iii.)

  - $sABYES inter sEYES = sEYES inter sABYES =  emptyset$ (as shown by figure iv.)

  - $sABYES inter sAYES = sAYES inter sABYES =  emptyset$ (as shown by figure v.)
*/
 
From above, it follows that every string in $sigstar$ belongs to at #underline[most] one of $sENO$, $sANO$, $sABNO$, $sEYES$, $sAYES$ or $sABYES$.

Since every string #arbstring belongs at least AND at most one of $sENO$, $sANO$, $sABNO$, $sEYES$, $sAYES$ or $sABYES$, it must be the case that every string $arbstring$ belongs to #underline[exactly] one the aforementioned sets.

== Question 4

// Prove for each of the sets $S in {sENO, sANO, sABNO, sEYES, sAYES, sABYES}$, that either $S subset.eq L$, or $S inter L = emptyset$. 

Recall the definition of L:

$
L = {arbstring | "a copy of \"a\" is eventually followed by a copy of \"b\" in" omega, "and" omega "includes at least one copy of \"c\""}.
$

We will prove that $sENO inter L = emptyset$, $sANO inter L = emptyset$, $sABNO inter L = emptyset$, $sEYES inter L = emptyset$, $sAYES inter L = emptyset$, $sABYES subset.eq L$. Each of these claimed relationships can be established by considering the definitions of the subset of $sigstar$ as mentioned.

- Let $omega in sENO$. Then $omega$ has no copies of "a" or "c", this implies that $omega$ is not a string in the above language $L$. Since $omega$ is arbitrarily chosen from $sENO$ it follows that $sENO inter L = emptyset$.
- Let $omega in sANO$. Then $omega$ has at least one copy of "a", no copies of "c", and no copy of "b" eventually follows any copy of "a" in $omega$. This implies that $omega$ is not a string in the above language $L$. Since $omega$ is arbitrarily chosen from $sANO$ it follows that $sENO inter L = emptyset$.
- Let $omega in sABNO$. Then $omega$ has at least one copy of "b" that eventually follows a copy of "a", but it doesn't have a copy of c, this implies that $omega$ is not a string in the above language $L$. Since $omega$ is arbitrarily chosen from $sABNO$ it follows that $sABNO inter L = emptyset$.
- Let $omega in sEYES$. Then it follows by the definition of $sEYES$ that $omega$ has at least one copy of "c" and no copies of "a", which this implies that $omega in.not L$. Since $omega$ was arbitrarily chosen from $sEYES$, it follows that $sEYES inter L = emptyset$. 
- Let $omega in sAYES$. Then $omega$ has at least one copy of "a" and at least one copy of "c" but no copy of "b" eventually follows a copy of "a". This implies that $omega$ is not a string in the above language $L$. Since $omega$ is arbitrarily chosen from $sAYES$ it follows that $sAYES inter L = emptyset$.
- Let $omega in sABYES$. Then $omega$ has a copy of "a" that's eventually followed by a copy of "b" and at least one copy of "c", this implies that $omega$ is a string in the above language $L$. Since $omega$ is arbitrarily chosen from $sABYES$ it follows that $sABYES subset.eq L$.

 // NEED TO WRTIE WHY THEY TRNASITION BUT THE TRNASITIONS ARE DEFINED :>
== Question 5

=== Part (a)

To show that the transition function $delta$ is well-defined, it is necessary to prove each of the following claims:

+ ${ mu dot a | mu in sENO} subset.eq sANO$, where $delta (qENO, a) = qANO$
+ ${ mu dot b | mu in sENO} subset.eq sENO$, where $delta (qENO, b) = qENO$
+ ${ mu dot c | mu in sENO} subset.eq sEYES$, where $delta (qENO, c) = qEYES$
+ ${ mu dot a | mu in sANO} subset.eq sANO$, where $delta (qANO, a) = qANO$
+ ${ mu dot b | mu in sANO} subset.eq sABNO$, where $delta (qANO, b) = qABNO$
+ ${ mu dot c | mu in sANO} subset.eq sAYES$, where $delta (qANO, c) = qAYES$
+ ${ mu dot a | mu in sABNO} subset.eq sABNO$, where $delta (qABNO, a) = qABNO$
+ ${ mu dot b | mu in sABNO} subset.eq sABNO$, where $delta (qABNO, b) = qABNO$
+ ${ mu dot c | mu in sABNO} subset.eq sABYES$, where $delta (qABNO, c) = qABYES$
+ ${ mu dot a | mu in sEYES} subset.eq sAYES$, where $delta (qEYES, a) = qAYES$
+ ${ mu dot b | mu in sEYES} subset.eq sEYES$, where $delta (qEYES, b) = qEYES$
+ ${ mu dot c | mu in sEYES} subset.eq sEYES$, where $delta (qEYES, c) = qEYES$
+ ${ mu dot a | mu in sAYES} subset.eq sAYES$, where $delta (qAYES, a) = qAYES$
+ ${ mu dot b | mu in sAYES} subset.eq sABYES$, where $delta (qAYES, b) = qABYES$
+ ${ mu dot c | mu in sAYES} subset.eq sAYES$, where $delta (qAYES, c) = qAYES$
+ ${ mu dot a | mu in sABYES} subset.eq sABYES$, where $delta (qABYES, a) = qABYES$
+ ${ mu dot b | mu in sABYES} subset.eq sABYES$, where $delta (qABYES, b) = qABYES$
+ ${ mu dot c | mu in sABYES} subset.eq sABYES$, where $delta (qABYES, c) = qABYES$

=== Part (b)

Transitions out of $qENO$ (the state corresponding to $sENO$ )

Let $mu in sENO$ so that $mu$ doesn't contain "a"s or "c"s.
- Since $mu$ doesn't contain "a"s or "c"s, $mu dot a$ contains exactly one "a" at the end of the string, and no "c"s; that is, $mu dot a in sANO$. Exchanging role of "a" and "c" in the argument, its clear that $mu dot b in sEYES$.
- Since $mu$ doesn't contain any "a"s or "c"s, $mu dot b$ doesn't contain any "a"s or "c"s either. That is, $mu dot b in sENO$.

/*
Let $mu in sENO$ so that $mu$
  - Then $mu dot a$ contains a copy of "a", no copies of "c", and no copies of "b" after, so $mu dot a in sANO$. Since $mu$ was arbitrarily chosen from $sENO$: ${mu dot a | mu in sENO} subset.eq sANO$
  - Then the string $mu dot b$ does not add any copies of "a" or "c", so by definition the string $mu dot b in sENO$. Since $mu$ was arbitrarily chosen from $sENO$: ${mu dot a | mu in sENO} subset.eq sENO $
  - Then the string $mu dot c$ ends with a "c" and therefore contains a copy of "c", so $mu dot c in sEYES$. Since $mu$ was arbitrarily chosen from $sENO$: ${mu dot a | mu in sENO} subset.eq sEYES $

  Let $mu in sANO$
  - Then $mu dot a$ will append an "a" string at the end. Since this means no "b" or "c" string is added, the string will remain with only "a" strings with no "b" string eventually following after an "a" string, so $mu in sANO$. Since $mu$ was arbitrarily chosen from $sANO$: ${mu dot a | mu in sANO} subset.eq sANO$
  - Then the string $mu dot b$ will append a "b" string at the end. This means that an "a" string is eventually followed by a "b" string with no "c" strings, therefore $mu in sABNO$ Since $mu$ was arbitrarily chosen from $sANO$: ${mu dot a | mu in sANO} subset.eq sABNO $
  - Then the string $mu dot c$ appends a "c" string at the end. Since by definition of $sANO$ there is no "a" string eventually followed by a "b" string and their exists a "c" string, $mu in sAYES$  Since $mu$ was arbitrarily chosen from $sANO$: ${mu dot a | mu in sANO} subset.eq sAYES $

  Let $mu in sABNO$
  - Then $mu dot a$ appends an "a" string at the end, since the string already contains an "a" string eventually followed by a "b" string, and no "c" string is appended, the string $mu in sABNO$. Since $mu$ was arbitrarily chosen from $sABNO$: ${mu dot a | mu in sABNO} subset.eq sABNO$
  - Then the string $mu dot b$ appends an "b" string at the end, since the string already contains an "a" string eventually followed by a "b" string, and no "c" string is appended, the string $mu in sABNO$. Since $mu$ was arbitrarily chosen from $sABNO$: ${mu dot a | mu in sABNO} subset.eq sABNO $
  - Then the string $mu dot c$ appends a "c" string. Since mu already contains an "a" string that is eventually followed by a "b" string, and now a "c" string is appended, by definition $mu in sABYES$. Since $mu$ was arbitrarily chosen from $sABNO$: ${mu dot a | mu in sABNO} subset.eq sABYES $

  Let $mu in sEYES$
  - Then $mu dot a$ appends an "a" string at the end, since there is no "a" string that is eventually followed by a "b" string, and $mu$ already contains a "c" string, then by definition, $mu in sAYES$. Since $mu$ was arbitrarily chosen from $sEYES$: ${mu dot a | mu in sEYES} subset.eq sAYES$
  - Then the string $mu dot b$ appends a "b" string at the end, since there is no "a" string, and $mu$ already contains a "c" string, then $mu in sEYES$. Since $mu$ was arbitrarily chosen from $sEYES$: ${mu dot a | mu in sEYES} subset.eq sEYES $
  - Then the string $mu dot c$ appends a "c" string at the end, since there is no "a" string, and $mu$ already contains a "c" string, then $mu in sEYES$. Since $mu$ was arbitrarily chosen from $sEYES$: ${mu dot a | mu in sEYES} subset.eq sEYES $

  Let $mu in sAYES$
  - Then $mu dot a$ appends an "a" string at the end. Since there is already no "a" string that is eventually followed by a "b" string and $mu$ contains a "c" string; adding an "a" string does not change this, $mu in sAYES$. Since $mu$ was arbitrarily chosen from $sAYES$: ${mu dot a | mu in sAYES} subset.eq sAYES$
  - Then the string $mu dot b$ appends a "b" string at the end. Since the $mu$ already contains an "a" and "c" string, appending a "b" string at the end satisfies the condition that an "a" string is eventually followed by a "b" string, therefore $mu in sABYES$.Since $mu$ was arbitrarily chosen from $sAYES$: ${mu dot a | mu in sAYES} subset.eq sABYES $
  - Then the string $mu dot c$ appends a "c" string at the end. Since there is already no "a" string that is eventually followed by a "b" string and $mu$ contains a "c" string; adding a "c" string does not change this, $mu in sAYES$. Since $mu$ was arbitrarily chosen from $sAYES$: ${mu dot a | mu in sAYES} subset.eq sAYES $

  Let $mu in sABYES$
  - Then $mu dot a$ appends an "a" string at the end, since by definition, $mu$ already satisfies all the conditions needed, appending any character in $Sigma$ does not change the the needed conditions, therefore $mu in sABYES$. Since $mu$ was arbitrarily chosen from $sABYES$: ${mu dot a | mu in sABYES} subset.eq sABYES$
  - Then the string $mu dot b$ appends a "b" string at the end, since by definition, $mu$ already satisfies all the conditions needed, appending any character in $Sigma$ does not change the the needed conditions, therefore $mu in sABYES$. Since $mu$ was arbitrarily chosen from $sABYES$ : ${mu dot a | mu in sABYES} subset.eq sABYES $
  - Then the string $mu dot c$ appends a "c" string at the end, since by definition, $mu$ already satisfies all the conditions needed, appending any character in $Sigma$ does not change the the needed conditions, therefore $mu in sABYES$. Since $mu$ was arbitrarily chosen from $sABYES$ : ${mu dot a | omega in sABYES} subset.eq sABYES $

*/


== Question 6

Let $M = (Q, Sigma, delta, qENO, F)$ be a DFA. Note that #qENO is the start state.

$ Q = {qENO, qANO, qABNO, qEYES, qAYES, qABYES} $

$ Sigma = {a, b, c} $

$ F = {qABYES} $

The transition function $delta: Q crossmark Sigma arrow.r Q$ is shown in the below transition table:

#align(center)[
  #table(
    columns: 4,
    "", $a$, $b$, $c$,
    qENO, qANO, qENO, qEYES,
    qANO, qANO, qABNO, qAYES,
    qABNO, qABNO, qABNO, qABYES,
    qEYES, qAYES, qEYES, qEYES,
    qAYES, qAYES, qABYES, qAYES,
    qABYES, qABYES, qABYES, qABYES,
  )
]

The following figure is the transition diagram of $M$

#figure(
  image("CPSC 351 Assignment 1 DFA.png"),
  caption: "Transition diagram for M.",
)

== Question 7 
/*
Sketch a proof that your deterministic finite automaton has language L, i.e we need to prove that L(M) = L.
To do so we will be applying the "Correctness of DFA" theorem. As per the theorem, it is sufficient to show that each of the properties listed below aree satisfied in order to confirm that L(M) = L: 
*/

To prove that our DFA has the language $L$, it is necessary to apply the "correctness of a DFA" theorem introduced in the document "L04_proof_of_key_result.pdf". In order to apply the aforementioned theorem, the following properties must be proven:

#[
  #set enum(numbering: "(a)")
  + Every string in #sigstar belongs to *_exactly one_* of #sENO, #sANO, #sABNO, #sEYES, #sAYES, or #sABYES (needed since $Q = {qENO, qANO, qABNO, qEYES, qAYES, qABYES}$ and the given sets are subsets of #sigstar corresponding to the DFA state with the same subscript).
  + $lambda in sENO$ (needed since #sENO corresponds to the start state, #qENO).
  + $sABYES subset.eq L$ (needed since the state #qABYES, corresponding to the set #sABYES is the only state in $F$).
  + $sENO inter L = sANO inter L = sABNO inter L = sEYES inter L = sAYES inter L = emptyset$ (needed since the states $qENO, qANO, qABNO, qEYES$ and $qAYES$, corresponding to the sets $sENO, sANO, sABNO, sEYES$, and $sAYES$ respectively, are all *not* in $F$).
  + The claims in question 5 part (a) are satisfied.
]

A proof of the correctness of our DFA can be structured as follows:

+ Begin with an introduction of the "correctness of a DFA" theorem, 
+ Stating the above properties.
+ Our proof that #sENO, #sANO, #sABNO, #sEYES, #sAYES, and #sABYES partition #sigstar, given in this document in our answer for question 3.
+ A proof that $lambda in sENO$. Since $lambda$ cannot contain "a" or "c", this proof is straightforward.
+ Proofs that each of #sENO, #sANO, #sABNO, #sEYES, and #sAYES are disjoint from $L$, and a proof that #sABYES is a subset of $L$. These are given in this document, in our answer to question 4.
+ Proofs for each of the claims detailed this document in our answer for question 5,a. While the claims for the transitions from #qENO are given, the rest would also need to be provided (obviously). The same technique used in the #qENO proofs can be used in the rest of the claims. That is, for each set $S in {#sENO, #sANO, #sABNO, #sEYES, #sAYES, #sABYES}$, suppose an arbitrary string $mu in S$, then for each $sigma in Sigma$, consider which set the string $mu dot sigma$ belongs to.
+ Conclude the proof with a reminder that each of the properties required by the "correctness of a DFA theorem" is satisfied, and apply the theorem to show that our DFA has the language $L$.

/*
1. Every string in $sigstar$ belongs to exactly one of the subsets ($sENO$,$sEYES$,$sANO$,$sAYES$,$sABNO$,$sABYES$), and $sENO$,$sEYES$,$sANO$,$sAYES$,$sABNO$,$sABYES$ are subsets of $sigstar$ corresponding to the states $qENO$,$qEYES$,$qANO$,$qAYES$,$qABNO$,$qABYES$ respectively. This was proved in solution to question 3.
2. $ lambda in sENO$, where $sENO$ corresponds to $qENO$- the start state. Since the empty string $lambda$ does not have any copy of a or c, it belongs to $sENO$. So the property- $ lambda in sENO$ in satisfied. 
3. For each of the subsets $sI$,either $sI subset.eq L$ or $sI inter L = emptyset$. This has been proved in the solution to question 4.
4. The following properties are satisfied, as was proved in solution to question 5: 
 //actually question 5(b) where we had to prove these properties asked to prove them just for start state q0, and assume the rest were also proved in that way. uhm so idk how should we mention that, if we have to
(i) ${omega dot a | omega in sENO} subset.eq sANO}$ (needed since $delta(qENO, a) = qANO)$

(ii) ${omega dot b | omega in sENO} subset.eq sENO} $ (needed since $delta(qENO, b) = qENO$

(iii) ${omega dot c | omega in sENO} subset.eq sEYES} $ (needed since $delta(qENO, b) = qEYES$

(iv) ${omega dot a | omega in sEYES} subset.eq sAYES} $ (needed since $delta(qEYES, a) = qAYES)$

(v)  ${omega dot b | omega in sEYES} subset.eq sEYES} $ (needed since $delta(qEYES, b) = qEYES)$

(vi)  ${omega dot c | omega in sEYES} subset.eq sEYES} $ (needed since $delta(qEYES, c) = qEYES)$

(vii) ${omega dot a | omega in sANO} subset.eq sANO} $ (needed since $delta(qANO, a) = qANO)$

(viii) ${omega dot b | omega in sANO} subset.eq sABNO} $ (needed since $delta(qANO,b) = qABNO)$

(ix) ${omega dot c | omega in sANO} subset.eq sAYES} $(needed since $delta(qANO, c) = qAYES)$

(x) ${omega dot a | omega in sAYES} subset.eq sAYES} $ (needed since $delta(qAYES, a) = qAYES)$

(xi) ${omega dot b | omega in sAYES} subset.eq sABYES} $ (needed since $delta(qAYES, b) = qABYES)$

(xii) ${omega dot c | omega in sAYES} subset.eq sAYES} $ (needed since $delta(qAYES, c) = qAYES)$

(xiii) ${omega dot a | omega in sABNO} subset.eq sABNO} $ (needed since $delta(qABNO, a) = qABNO)$

(xiv) ${omega dot b | omega in sABNO} subset.eq sABNO} $ (needed since $delta(qABNO, b) = qABNO)$

(xv) ${omega dot c | omega in sABNO} subset.eq sABYES} $ (needed since $delta(qABNO, c) = qABYES)$

(xvi) ${omega dot a | omega in sABYES} subset.eq sABYES} $ (needed since $delta(qABYES, a) = qABYES)$

(xvii) ${omega dot b | omega in sABYES} subset.eq sABYES} $ (needed since $delta(qABYES, b) = qABYES)$

(xviii) ${omega dot c | omega in sABYES} subset.eq sABYES} $ (needed since $delta(qABYES, c) = qABYES)$
*/
