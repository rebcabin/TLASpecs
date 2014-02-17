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
    
GCD1 == \A m \in Nat \ {0} : GCD(m, m) = m
GCD2 == \A m, n \in Nat \ {0} : GCD(m, n) = GCD(n, m)
GCD3 == \A m, n \in Nat \ {0} : (n > m) => (GCD(m, n) = GCD(m, n-m))
    
=============================================================================
\* Modification History
\* Last modified Sun Feb 16 15:25:38 PST 2014 by bbeckman
\* Created Fri Feb 14 11:26:38 PST 2014 by bbeckman
