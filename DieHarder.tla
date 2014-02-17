----------------------------- MODULE DieHarder -----------------------------
EXTENDS Integers

CONSTANTS Goal, Jugs, Capacity

ASSUME /\ Goal \in Nat
       /\ Capacity \in [Jugs -> Nat \ {0}]

Min(m,n) == IF m < n THEN m ELSE n
(***************************************************************************
--algorithm DieHarder 
  { variable injug = [j \in Jugs |-> 0];
    { while (TRUE)
      { either with (j \in Jugs) \* fill Jug[j]
               { injug[j] := Capacity[j] }
        or     with (j \in Jugs) \* empty Jug[j]
               { injug[j] := 0 }
(***************************************************************************)
(* When pouring from j to k, we first ask if In[j] + In[k] > In[k].  If    *)
(* so, we make In[k]' = Cap[k] and In[j]' = In[j] - (Cap[k] - In[k]); if   *)
(* not, we make In[k]' = In[k] + In[j] and In[j]' = 0. In the former case, *)
(* the amount poured is Cap[k] - In[k]; in the latter case, the amount     *)
(* poured is In[j], which equals (In[k] + In[j]) - In[k].  In both cases,  *)
(* the amount poured is Min(In[k] + In[j], In[k]) - In[k].                 *)
(***************************************************************************)               
        or     with (j \in Jugs, k \in Jugs \ {j}) \* pour from j to k
               { with (poured = Min(injug[j] + injug[k], Capacity[k])
                                - injug[k])
                 {  injug[j] := injug[j] - poured
                 || injug[k] := injug[k] + poured
   } } }       } }
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLE injug

vars == << injug >>

Init == (* Global variables *)
        /\ injug = [j \in Jugs |-> 0]

Next == \/ /\ \E j \in Jugs:
                injug' = [injug EXCEPT ![j] = Capacity[j]]
        \/ /\ \E j \in Jugs:
                injug' = [injug EXCEPT ![j] = 0]
        \/ /\ \E j \in Jugs:
                \E k \in Jugs \ {j}:
                  LET poured == Min(injug[j] + injug[k], Capacity[k])
                                - injug[k] IN
                    injug' = [injug EXCEPT ![j] = injug[j] - poured,
                                           ![k] = injug[k] + poured]

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Mon Feb 17 08:28:08 PST 2014 by bbeckman
\* Created Mon Feb 17 07:51:51 PST 2014 by bbeckman
