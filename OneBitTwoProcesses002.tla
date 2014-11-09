------------------------- MODULE OneBitTwoProcesses002 ----------------------

EXTENDS Integers
(******************************************************************
--algorithm OneBit 
  { variable x = [i \in {0,1} |-> FALSE] ;
    fair process (P = 0)
    { ncs0: while (TRUE)
                  \* model for non-critical processing
            {      skip ; 
              \* Ok, I'm done with that and I want in!
              e01: x[0] := TRUE ;
              e02: if (~x[1]) 
                   \* If the other guy isn't in, I'm in!
                   { cs0: skip (* This is my critical code! *) }
                   else 
                   \* ok, the other guy is in. What do I do?
                   \* if I'm process 0, I'll keep trying.
                   { goto e2 } 
               \* Ok, I'm done. I don't need the critical section now.
               f0: x[0] := FALSE
            }
    } 
    fair process (P = 1)
    { ncs: while (TRUE)
                 \* model for non-critical processing
           {     skip ; 
             \* Ok, I'm done with that and I want in!
             e1: x[self] := TRUE ;
             e2: if (~x[1-self]) 
                 \* If the other guy isn't in, I'm in!
                 { cs: skip (* This is my critical code! *) }
                 else 
                 \* ok, the other guy is in. What do I do?
                 { if (self = 0) 
                   \* if I'm process 0, I'll keep trying.
                   { goto e2 } 
                   \* else, if I'm process 1, I'll be the nice guy;
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

P(self) == ncs(self) \/ e1(self) \/ e2(self) \/ cs(self) \/ e3(self)
              \/ e4(self) \/ f(self)

Next == (\E self \in {0,1}: P(self))

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in {0,1} : WF_vars(P(self))

\* END TRANSLATION

TypeOK == /\ pc \in [{0, 1} -> {"ncs", "f", "e1", "e2", "e3", "e4", "cs"}]
          /\ x  \in [{0, 1} -> BOOLEAN]
          
InCS(i) == pc[i] = "cs"

MutualExclusion == ~(InCS(0) /\ InCS(1))

Inv == /\ TypeOK
       /\ MutualExclusion
       /\ \A i \in {0, 1} : InCS(i) \/ (pc[i] = "e2") => x[i]
       
ISpec == Inv /\ [][Next]_<<x, pc>>

(* If we check ISpec
   in this algorithm and only Spec in that protocol, the checker
   will generate states that cannot be properly mapped to protocol
   states, such as this one: 
   
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

Trying == /\ pc[0] \in {"e1", "e2"}
          /\ pc[1] \in {"e1", "e2", "e3", "e4"}
             
DeadlockFree == Trying ~> (InCS(0) \/ InCS(1))
=============================================================================
\* Modification History
\* Last modified Fri Feb 21 08:52:26 PST 2014 by bbeckman
\* Created Thu Feb 20 13:10:58 PST 2014 by bbeckman
