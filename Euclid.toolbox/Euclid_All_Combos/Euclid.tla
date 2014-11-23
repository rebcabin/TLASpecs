------------------------------- MODULE Euclid -------------------------------
EXTENDS Integers, GCD, TLC

CONSTANTS M, N

ASSUME {M, N} \subseteq Nat \ {0} \* `subset' doesn't seem to work

(***************************************************************************
--fair algorithm Euclid
  {  variables x \in 1..N, y \in 1..N, x0 = x, y0 = y;
    { while_step: while (x /= y)
      \* The Greek word for the following process of repeated subtraction
      \* is `antanaresis.'               
      { if (x < y) 
        { antanaresis_x: y := y - x; } 
        else       
        { antanaresis_y: x := x - y; }
      };
      assert (x = y) /\ (x = GCD(x0, y0));
  } }
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLES x, y, x0, y0, pc

vars == << x, y, x0, y0, pc >>

Init == (* Global variables *)
        /\ x \in 1..N
        /\ y \in 1..N
        /\ x0 = x
        /\ y0 = y
        /\ pc = "while_step"

while_step == /\ pc = "while_step"
              /\ IF x /= y
                    THEN /\ IF x < y
                               THEN /\ pc' = "antanaresis_x"
                               ELSE /\ pc' = "antanaresis_y"
                    ELSE /\ Assert((x = y) /\ (x = GCD(x0, y0)), 
                                   "Failure of assertion at line 19, column 7.")
                         /\ pc' = "Done"
              /\ UNCHANGED << x, y, x0, y0 >>

antanaresis_x == /\ pc = "antanaresis_x"
                 /\ y' = y - x
                 /\ pc' = "while_step"
                 /\ UNCHANGED << x, x0, y0 >>

antanaresis_y == /\ pc = "antanaresis_y"
                 /\ x' = x - y
                 /\ pc' = "while_step"
                 /\ UNCHANGED << y, x0, y0 >>

Next == while_step \/ antanaresis_x \/ antanaresis_y
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)

Termination == <>(pc = "Done")

\* END TRANSLATION

PartialCorrectness == (pc = "Done") => (x = y) /\ (x = GCD(x0, y0))
=============================================================================
\* Modification History
\* Last modified Sun Nov 09 12:19:53 PST 2014 by rebcabin
\* Last modified Sun Feb 16 10:12:36 PST 2014 by bbeckman
\* Created Fri Feb 14 15:53:12 PST 2014 by bbeckman
