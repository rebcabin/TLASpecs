------------------------- MODULE ExtraSimpleEuclid -------------------------

EXTENDS Integers, GCD

CONSTANTS M, N

ASSUME {M, N} \subseteq Nat \ {0} \* `subset' doesn't seem to work

(***************************************************************************
--fair algorithm Euclid
  {  variables x = M, y = N;
    { while (x /= y)
      \* The Greek word for the following process of repeated subtraction
      \* is `antanaresis.'               
      { if (x < y) { y := y - x; } 
        else       { x := x - y; }
      }
  } }
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLES x, y, pc

vars == << x, y, pc >>

Init == (* Global variables *)
        /\ x = M
        /\ y = N
        /\ pc = "Lbl_1"

Lbl_1 == /\ pc = "Lbl_1"
         /\ IF x /= y
               THEN /\ IF x < y
                          THEN /\ y' = y - x
                               /\ x' = x
                          ELSE /\ x' = x - y
                               /\ y' = y
                    /\ pc' = "Lbl_1"
               ELSE /\ pc' = "Done"
                    /\ UNCHANGED << x, y >>

Next == Lbl_1
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION

\* PC means `PartialCorrectness,' but it's a lot easier to write and read.

PC == (pc = "Done") => (x = y) /\ (x = GCD(M, N))

Inv == PC

I1 == Init => Inv
I2 == Inv /\ Next => Inv'
I3 == Inv => PC


=============================================================================
\* Modification History
\* Last modified Sun Feb 16 10:37:47 PST 2014 by bbeckman
\* Created Sun Feb 16 10:15:18 PST 2014 by bbeckman
