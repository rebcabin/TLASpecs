------------------------- MODULE OneBitTwoProcesses -------------------------
EXTENDS Integers

(******************************************************************
--algorithm OneBit 
  { variable x = [i \in {0,1} |-> FALSE] ;
    fair process (Proc \in {0,1})
    { ncs: while (TRUE)
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
           }
  } }
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
        /\ \A self \in {0,1} : WF_vars(Proc(self))

\* END TRANSLATION

(*

Question 7.6

Analyzing weak fairness:
Candidate Definition 1:
Action A is weakly fair in behavior B if 

~\E suffix of B : \A state \in B A is enabled /\ ~\E A step. 
<=> 
\A suffix of B : (\E state \in B : A is disabled) \/ (\E A step).

we define <<A>>_vars as a non-stuttering step: a step that changes
at least one of the variables in "vars." 

WF_vars(A) is satisfied by behavior B if every suffix of B has 
either a non-stuttering <<A>>_vars step or at least one state where
<<A>>_vars is disabled.

<<Proc(i)>>_vars is a non-stuttering step and it's disabled for every
suffix of a deadlocked behavior because there does not exist a non-
stuttering action of Proc(i). Therefore, Proc(i) is weakly fair for 
the deadlocked behavior.

*)

PC0Labels   == {"ncs", "f", "e1", "e2", "cs"}
ExtraLabels == {"e3", "e4"}
PC1Labels   == PC0Labels \cup ExtraLabels

TypeOK == \* /\ pc[0] \in PC0Labels (* Does not define pc *)
          \* /\ pc[1] \in PC1Labels
          \* pc \in [{0, 1} -> PC0Labels] (* Does not work; don't know why not *) 
          (* I would like to have a more precise TypeOK, but don't know how 
             to write it. My more precise one would not let pc be "e3" or "e4." *)
          /\ pc \in [{0, 1} -> {"ncs", "f", "e1", "e2", "e3", "e4", "cs"}]
          /\ x  \in [{0, 1} -> BOOLEAN]
          
InCS(i) == pc[i] = "cs"

MutualExclusion == ~(InCS(0) /\ InCS(1))

Inv == /\ Init 
       /\ TypeOK
       /\ MutualExclusion
       /\ pc[0] \notin {"e3", "e4"}
       /\ \A i \in {0,1} : WF_vars(Proc(i))
       /\ \A i \in {0,1} : InCS(i) \/ (pc[i] = "e2") => x[i]
       
ISpec == Inv /\ [][Next]_<<x, pc>>

(* If we check ISpec in this algorithm and only Spec in that protocol, 
   the checker will generate states that cannot be properly mapped to
   protocol states, such as this one: 

   Property line 134, col 12 to line 134, col 42 of module 
   OneBitProtocol is violated by the initial state:
     /\ x = (0 :> FALSE @@ 1 :> FALSE)
     /\ pc = (0 :> "ncs" @@ 1 :> "e1")
     
   If we check Spec in this algorithm, we may check A!Spec or 
   A!ISpec or both in the protocol. If we check ISpec in this 
   algorithm, we may not check A!Spec in the protocol.   
*)
A == INSTANCE OneBitProtocol 
     WITH pc <- [i \in {0, 1} |-> 
       IF pc[i] \in {"ncs", "f"} THEN "r" ELSE pc[i]]

\* Trying == /\ pc[0] \in {"e1", "e2"}
\*           /\ pc[1] \in {"e1", "e2"}
          
Trying(i) == pc[i] \in {"e1", "e2"}          
             
DeadlockFree == (Trying(0) \/ Trying(1)) ~> (InCS(0) \/ InCS(1))
=============================================================================
\* Modification History
\* Last modified Fri Feb 21 19:44:17 PST 2014 by bbeckman
\* Created Thu Feb 20 13:10:58 PST 2014 by bbeckman
