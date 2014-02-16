-------------------------------- MODULE GCD --------------------------------
EXTENDS Integers

Divides(p, n) ==          (**********************************)
      \E q \in Int :      (* For integers p and n, equals   *)
              n = q * p   (* TRUE iff p divides n -- which  *)
                          (* I think is really neat; don't  *)
                          (* you?                           *)
                          (**********************************)

DivisorsOf(n) == {p \in Int : Divides(p, n)}

SetMax(S) ==                               (* CHOOSE produces elements rather than sets. *)
    CHOOSE i \in S : \A j \in S : i >= j
    
GCD(m, n) ==
    SetMax(DivisorsOf(m) \cap DivisorsOf(n))
    
=============================================================================
\* Modification History
\* Last modified Sun Feb 16 09:44:33 PST 2014 by bbeckman
\* Created Fri Feb 14 11:26:38 PST 2014 by bbeckman
