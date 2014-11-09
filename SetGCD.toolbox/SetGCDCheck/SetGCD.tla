------------------------------- MODULE SetGCD -------------------------------

EXTENDS GCD, Integers, FiniteSets

CONSTANTS Input

ASSUME /\ Input \subseteq Nat \ {0}
       /\ Input /= {}
       /\ IsFiniteSet(Input)
       
(***************************************************************************
--fair algorithm SetGCD
  { variables S = Input;
    { while (\E x, y \in S : x /= y)
      { with (x \in S, y \in {s \in S : s > x})
        { S := (S \ {y}) \cup {y - x};
  } } } }
  
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLES S, pc

vars == << S, pc >>

Init == (* Global variables *)
        /\ S = Input
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF \E x, y \in S : x /= y
               THEN /\ \E x \in S:
                         \E y \in {s \in S : s > x}:
                           S' = ((S \ {y}) \cup {y - x})
                    /\ pc' = "Lbl_1"
               ELSE /\ pc' = "Done"
                    /\ S' = S

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION

PC == (pc = "Done") => (S = {SetGCD(Input)})

TypeOK == /\ S \subseteq Nat \ {0}
          /\ S /= {}
          /\ IsFiniteSet(S)
          
SInv == /\ TypeOK
        /\ SetGCD(S) = SetGCD(Input)
        /\ PC
        
\* Proving Termination: section 4.9.3 of hyperbook.
W  == 1
L1 == SInv => (W \in Nat) \/ (pc = "Done")
L2 == (SInv /\ Next) => (W > W') \/ (pc' = "Done")
=============================================================================
\* Modification History
\* Last modified Mon Feb 17 08:30:01 PST 2014 by bbeckman
\* Created Sun Feb 16 16:14:10 PST 2014 by bbeckman