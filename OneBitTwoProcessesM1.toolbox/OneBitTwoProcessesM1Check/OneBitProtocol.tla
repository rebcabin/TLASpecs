(* PROTOCOL ACTIONS *)
e1: x[self] := TRUE; 
e2: if (~x[1-self]) { cs: critical_section }

(* other actions *)
CS(i):   1. enabled only when control is in the critical section
         2. leaves control either in the critical section or outside
            the protocol
         3. leaves x[i] unchanged
         4. does not make TypeOK false

REST(i): 1. enabled only when control is outside the protocol
         2. leaves control either outside the protocol or at "e1"
         3. does not change x[1 - i]
         4. does not make TypeOK false

Next == (\E i \in {0, 1} : e1(i) \/ e2(i) \/ CS(i) \/ Rest(i))

MutualExclusion == ~(InCS(0) /\ InCS(1))

Inv == /\ TypeOK 
       /\ MutualExclusion 
       /\ \A i \in {0, 1} : InCS(i) \/ (pc[i] == "e2") => x[i]

Init1 == TypeOK 
(* System starts outside the protocol code *)
Init2 == /\ \A i \in {0, 1} : ~InCS(i)
         /\ pc[i] /= "e1"
         /\ pc[i] /= "e2" 

I1 == Init => Inv
I2 == Inv /\ Next => Inv'
I3 == Inv => MutualExclusion

(*
Proof of Condition I1
Init => Inv
1. Init => TypeOK
   Proof: By Init1.
2. Init => MutualExclusion
   Proof: By the definition of MutualExclusion and Init2, which implies
   InCS(i) is false for both processes i.
3. Init => \A \in {0, 1} : InCS(i) \/ (pc[i] = "e2") => x [i]
   Proof: By Init2, which implies InCS(i) is false and pc[i] /= "e2", for each i.
   (Of course, we are using the fact that FALSE => P is true for any formula P.
4. Q.E.D.
   Proof: By steps 1-3 and the definition of Inv
*)

I2 == /\ Inv (* the following line is 'Next' *) 
      /\ (\E i \in {0, 1} : e1(i) \/ e2(i) \/ CS(i) \/ Rest(i))
         => Inv'
(*
Proof of Condition I2
Inv /\ Next => Inv'

First, it suffices to prove
\E i \in {0, 1} : Inv /\ (e1(i) \/ e2(i) \/ CS(i) \/ Rest(i)) => Inv'
because, with P(i) = (e1(i) \/ e2(i) \/ CS(i) \/ Rest(i)), 
the fact that i does not occur free in Inv or P(i) implies 
Inv /\ (\E i \in {0, 1} : P(i)) === (\E i \in {0, 1} : Inv /\ P(i)).

Further, it suffices to prove (i \in {0,1} /\ Inv /\ P(i)) => Inv'
because i does not occur free in Inv'.

Finally, the term (i \in {0,1}) /\ Inv distributes across the 
disjunction in P(i), therefore we need only prove the following four
terms:  

1. ASSUME: Inv /\ (i \in {0, 1}) /\ e1(i)
   PROVE:  Inv' 
   (* TODO *)
2. ASSUME: Inv /\ (i \in {0, 1}) /\ e2(i)
   PROVE:  Inv' = /\TypeOK' 
                  /\ MutualExclusion' 
                  /\ \A i \in {0,1} : 
                     InCS(i)' \/ (pc'[i]= "e2") => x'[i]
   2.1. TypeOK'
   2.2. MutualExclusion' == ~(InCS(0)' /\ InCS(1)')
        2.2.1. same as = (~InCS(0)' \/ ~InCS(1)'), therefore it
               suffices to assume one InCS(i)' and prove the other 
               ~InCS(1-i)'.
        2.2.2. Prove ~x[1-i]:
               Assumption 2 => e2(i), i.e. if (~x[1-i]) { InCS(i) }.
               Assumption 2 => InCS(i)
               Therefore ~x[1-i]
        2.2.3. Prove ~InCS(1-i):
               Assumption 2 => Inv /\ (i \in {0, 1})
               Inv => (\A i \in {0, 1} : InCS(1-i) => x[1-i])
               2.2.2 => ~x[1-i]
               Therefore ~InCS(1-i)
        2.2.4. Q.E.D.
               e2(i) => pc[1-i] is unchanged, therefore InCS(1-i)' 
               equals InCS(1-i)
   2.3. ASSUME: j \in {0, 1}
        PROVE:  InCS(j)' \/ (pc'[j]= "e2") => x'[j]
   2.4. Q.E.D.
        PROOF: By 2.1-2.3 and definition of Inv. 
3. ASSUME: Inv /\ (i \in {0, 1}) /\ CS(i)
   PROVE:  Inv' 
   (* TODO *)
4. ASSUME: Inv /\ (i \in {0, 1}) /\ Rest(i)
   PROVE:  Inv'
   (* TODO *)
5. Q.E.D.
   (* TODO *)
*)

--------------------------- MODULE OneBitProtocol ---------------------------
EXTENDS Integers
(***************************************************************************
--algorithm OneBitProtocol 
  { variable x \in [{0,1} -> BOOLEAN] ;
    process (P \in {0,1})
    { r: while (TRUE)
         {     either { with (v \in BOOLEAN) { x[self] := v };
                        goto r
                      }
               or skip;
           e1: x[self] := TRUE;
           e2: if (~x[1-self]) { cs: skip };
         }
  } }
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLES x, pc

vars == << x, pc >>

ProcSet == ({0,1})

Init == (* Global variables *)
        /\ x \in [{0,1} -> BOOLEAN]
        /\ pc = [self \in ProcSet |-> "r"]

r(self) == /\ pc[self] = "r"
           /\ \/ /\ \E v \in BOOLEAN:
                      x' = [x EXCEPT ![self] = v]
                 /\ pc' = [pc EXCEPT ![self] = "r"]
              \/ /\ TRUE
                 /\ pc' = [pc EXCEPT ![self] = "e1"]
                 /\ x' = x

e1(self) == /\ pc[self] = "e1"
            /\ x' = [x EXCEPT ![self] = TRUE]
            /\ pc' = [pc EXCEPT ![self] = "e2"]

e2(self) == /\ pc[self] = "e2"
            /\ IF ~x[1-self]
                  THEN /\ pc' = [pc EXCEPT ![self] = "cs"]
                  ELSE /\ pc' = [pc EXCEPT ![self] = "r"]
            /\ x' = x

cs(self) == /\ pc[self] = "cs"
            /\ TRUE
            /\ pc' = [pc EXCEPT ![self] = "r"]
            /\ x' = x

P(self) == r(self) \/ e1(self) \/ e2(self) \/ cs(self)

Next == (\E self \in {0,1}: P(self))

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
TypeOK == /\ pc \in [{0, 1} -> {"r", "e1", "e2", "cs"}]
          /\ x  \in [{0, 1} -> BOOLEAN]
          
InCS(i) == pc[i] = "cs"

MutualExclusion == ~(InCS(0) /\ InCS(1))

Inv == /\ TypeOK
       /\ MutualExclusion
       /\ \A i \in {0, 1} : InCS(i) \/ (pc[i] = "e2") => x[i]
       
ISpec == Inv /\ [][Next]_<<x, pc>>
TSpec == TypeOK /\ [][Next]_<<x, pc>>
=============================================================================
\* Modification History
\* Last modified Thu Feb 20 16:58:09 PST 2014 by bbeckman
\* Created Wed Feb 19 19:02:08 PST 2014 by bbeckman
