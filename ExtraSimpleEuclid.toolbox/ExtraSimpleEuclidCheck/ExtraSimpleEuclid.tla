------------------------- MODULE ExtraSimpleEuclid -------------------------

EXTENDS Integers, GCD

CONSTANTS M, N

ASSUME {M, N} \subseteq Nat \ {0} \* `subset' doesn't seem to work

(***************************************************************************
--fair algorithm Euclid
  { variables x = M, y = N;
    { loop: while (x /= y)
      \* The Greek word for the following process of repeated subtraction
      \* is `antanaresis.'               
      { antanaresis: if (x < y) { y := y - x; } 
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
        /\ pc = "loop"

loop == /\ pc = "loop"
        /\ IF x /= y
              THEN /\ pc' = "antanaresis"
              ELSE /\ pc' = "Done"
        /\ UNCHANGED << x, y >>

antanaresis == /\ pc = "antanaresis"
               /\ IF x < y
                     THEN /\ y' = y - x
                          /\ x' = x
                     ELSE /\ x' = x - y
                          /\ y' = y
               /\ pc' = "loop"

Next == loop \/ antanaresis
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Next)
        
Termination == <>(pc = "Done")

\* END TRANSLATION

\* PC means `PartialCorrectness,' but it's a lot easier to write and read.

\* PC == (pc = "Done") => (x = y) /\ (x = GCD(M, N))

TypeOK == /\ x \in 1..M
          /\ y \in 1..N
          /\ pc \in {"loop", "antanaresis", "Done"}

Inv == /\ TypeOK
       /\ GCD(x, y) = GCD(M, N) 
       /\ (pc = "Done") => (x = y)
       
InductiveInv == /\ Inv
                /\ (pc = "antanaresis") => (x /= y)

Specl2 == /\ InductiveInv /\ [][Next]_vars
          /\ WF_vars(Next)


I1 == Init => Inv
I2 == (~Init) /\ Inv /\ Next => Inv'
\* I3 == Inv => PC

\* Proving Termination: section 4.9.3 of hyperbook.
W  == x + y
L1 == (~Init /\ Inv) => (W \in Nat) \/ (pc = "Done")
L2 == (~Init /\ Inv /\ Next) => (W > W') \/ (pc' = "Done")


=============================================================================
\* Modification History
\* Last modified Sun Feb 16 17:19:51 PST 2014 by bbeckman
\* Created Sun Feb 16 10:15:18 PST 2014 by bbeckman