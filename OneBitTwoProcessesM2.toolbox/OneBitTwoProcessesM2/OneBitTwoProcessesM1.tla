------------------------ MODULE OneBitTwoProcessesM1 ------------------------
EXTENDS Integers

(******************************************************************
--algorithm OneBitM1 
  { variable x = [i \in {0,1} |-> FALSE] ;
    fair process (Proc \in {0,1})
    { ncs:- while (TRUE)
                 \* This is the model for my non-critical processing.
           {     skip ; 
             \* Ok, I'm done with that and I want in to the 
             \* critical section!
             e1: x[self] := TRUE ;
             e2: if (~x[1-self]) 
                 \* If the other guy isn't in, I'm in!
                 { cs: skip (* Model for my critical code! *) }
                 else 
                 \* Oops, the other guy is in. What do I do?
                 { if (self = 0) 
                   \* If I'm process 0, I'll keep trying.
                   { goto e2 } 
                   \* But, if I'm process 1, I'll be the nice guy;
                   \* I'll stop trying and spin while process 0 is in.
                   else 
                   { e3: x[1] := FALSE ;
                     e4: while ( x[0] ) 
                         { skip (* spin *) } ;
                         goto e1
                 } } ;
             \* Ok, I'm done. I don't need the critical section now.
             f:  x[self] := FALSE
  } }      }
******************************************************************)
\* BEGIN TRANSLATION
VARIABLES x, pc

vars == << x, pc >>

ProcSet == ({0,1})

Init == (* Global variables *)
        /\ x = [i \in {0,1} |-> FALSE]
        /\ pc = [self \in ProcSet |-> "ncs"]

ncs(self) == /\ pc[self] = "ncs"
             /\ TRUE
             /\ pc' = [pc EXCEPT ![self] = "e1"]
             /\ x' = x

e1(self) == /\ pc[self] = "e1"
            /\ x' = [x EXCEPT ![self] = TRUE]
            /\ pc' = [pc EXCEPT ![self] = "e2"]

e2(self) == /\ pc[self] = "e2"
            /\ IF ~x[1-self]
                  THEN /\ pc' = [pc EXCEPT ![self] = "cs"]
                  ELSE /\ IF self = 0
                             THEN /\ pc' = [pc EXCEPT ![self] = "e2"]
                             ELSE /\ pc' = [pc EXCEPT ![self] = "e3"]
            /\ x' = x

cs(self) == /\ pc[self] = "cs"
            /\ TRUE
            /\ pc' = [pc EXCEPT ![self] = "f"]
            /\ x' = x

e3(self) == /\ pc[self] = "e3"
            /\ x' = [x EXCEPT ![1] = FALSE]
            /\ pc' = [pc EXCEPT ![self] = "e4"]

e4(self) == /\ pc[self] = "e4"
            /\ IF x[0]
                  THEN /\ TRUE
                       /\ pc' = [pc EXCEPT ![self] = "e4"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "e1"]
            /\ x' = x

f(self) == /\ pc[self] = "f"
           /\ x' = [x EXCEPT ![self] = FALSE]
           /\ pc' = [pc EXCEPT ![self] = "ncs"]

Proc(self) == ncs(self) \/ e1(self) \/ e2(self) \/ cs(self) \/ e3(self)
                 \/ e4(self) \/ f(self)

Next == (\E self \in {0,1}: Proc(self))

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in {0,1} : WF_vars((pc[self] # "ncs") /\ Proc(self))

\* END TRANSLATION

A == INSTANCE OneBitProtocol 
     WITH pc <- [i \in {0, 1} |-> 
       IF pc[i] \in {"ncs", "f", "e3", "e4"} THEN "r" ELSE pc[i]]

\* Other == INSTANCE OneBitTwoProcessesM2 WITH x <-x, pc <- pc
=============================================================================
\* Modification History
\* Last modified Sun Feb 23 16:03:54 PST 2014 by bbeckman
\* Created Sun Feb 23 10:40:36 PST 2014 by bbeckman
