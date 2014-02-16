This text is ignored.
-------------------------------- MODULE GCD --------------------------------
EXTENDS Integers

(*************************************)
(* test box comments not typesetting *)
(*************************************)

Divides(p, n) ==          (**********************************)
      \E q \in Int :      (* For integers p and n, equals   *)
              n = q * p   (* TRUE iff p divides n -- which  *)
                          (* I think is really neat; don't  *)
                          (* you?                           *)
                          (**********************************)

DivisorsOf(n) == {p \in Int : Divides(p, n)}

SetMax(S) == 
    CHOOSE i \in S : \A j \in S : i >= j
    
GCD(m, n) ==
    SetMax(DivisorsOf(m) \cap DivisorsOf(n))
    
=============================================================================
\* Modification History
\* Last modified Fri Feb 14 15:52:41 PST 2014 by bbeckman
\* Created Fri Feb 14 11:26:38 PST 2014 by bbeckman
This text is also ignored.