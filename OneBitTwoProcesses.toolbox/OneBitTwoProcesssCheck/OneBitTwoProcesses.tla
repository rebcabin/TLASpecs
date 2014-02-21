------------------------- MODULE OneBitTwoProcesses -------------------------

EXTENDS Integers
(******************************************************************
--algorithm OneBit 
  { variable x = [i \in {0,1} |-> FALSE] ;
    fair process (P \in {0,1})
    { ncs: while (TRUE)
           {     skip;
             e1: x[self] := TRUE ;
             e2: if (~x[1-self]) { cs: skip }
                 else { goto e2 } ;
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
                  ELSE /\ pc' = [pc EXCEPT ![self] = "e2"]
            /\ x' = x

cs(self) == /\ pc[self] = "cs"
            /\ TRUE
            /\ pc' = [pc EXCEPT ![self] = "f"]
            /\ x' = x

f(self) == /\ pc[self] = "f"
           /\ x' = [x EXCEPT ![self] = FALSE]
           /\ pc' = [pc EXCEPT ![self] = "ncs"]

P(self) == ncs(self) \/ e1(self) \/ e2(self) \/ cs(self) \/ f(self)

Next == (\E self \in {0,1}: P(self))

Spec == /\ Init /\ [][Next]_vars
        /\ \A self \in {0,1} : WF_vars(P(self))

\* END TRANSLATION

TypeOK == /\ pc \in [{0, 1} -> {"ncs", "f", "e1", "e2", "cs"}]
          /\ x  \in [{0, 1} -> BOOLEAN]
          
InCS(i) == pc[i] = "cs"
MutualExclusion == ~(InCS(0) /\ InCS(1))

Inv == /\ TypeOK
       /\ MutualExclusion
       /\ \A i \in {0, 1} : InCS(i) \/ (pc[i] = "e2") => x[i]
       
ISpec == Inv /\ [][Next]_<<x, pc>>
(* If we model-check this algorithm for ISpec, then the one-bit
   protocol must also check its ISpec lest the checking of this
   algorithm try more states than the protocol. If we check ISpec
   in the algorithm and only Spec in the protocol, the checker
   will generate states that cannot be properly mapped to protocol
   states, such as this one: 
   
   Property line 134, col 12 to line 134, col 42 of module 
   OneBitProtocol is violated by the initial state:
     /\ x = (0 :> FALSE @@ 1 :> FALSE)
     /\ pc = (0 :> "ncs" @@ 1 :> "e1")   
*)
A == INSTANCE OneBitProtocol 
     WITH pc <- [i \in {0, 1} |-> 
       IF pc[i] \in {"ncs", "f"} THEN "r" ELSE pc[i]]
(**)


=============================================================================
\* Modification History
\* Last modified Fri Feb 21 05:33:41 PST 2014 by bbeckman
\* Created Thu Feb 20 13:10:58 PST 2014 by bbeckman
