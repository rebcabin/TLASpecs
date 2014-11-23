-------------------------------- MODULE GCD --------------------------------
EXTENDS Integers

Divides(p, n) ==          (**********************************)
      \E q \in Int :      (* For integers p and n, equals   *)
              n = q * p   (* TRUE iff p divides n -- which  *)
                          (* I think is really neat; don't  *)
                          (* you?                           *)
                          (**********************************)

DivisorsOf(n) == {p \in Int : Divides(p, n)}

(*

SetMax(S) ==                               (* CHOOSE produces elements rather than sets. *)
    CHOOSE i \in S : \A j \in S : i >= j
    
GCD(m, n) ==
    SetMax(DivisorsOf(m) \cap DivisorsOf(n))

SetGCD(T) == SetMax({d \in Int : \A t \in T : Divides(d, t)})

RECURSIVE SetSum(_)
SetSum(T) == IF T = {} THEN 0
                       ELSE LET t == CHOOSE x \in T : TRUE
                            IN  t + SetSum(T \ {t})

GCD1 == \A m \in Nat \ {0} : GCD(m, m) = m
GCD2 == \A m, n \in Nat \ {0} : GCD(m, n) = GCD(n, m)
GCD3 == \A m, n \in Nat \ {0} : (n > m) => (GCD(m, n) = GCD(m, n-m))
*)
   
=============================================================================
\* Modification History
\* Last modified Sun Nov 09 06:13:52 PST 2014 by rebcabin
\* Last modified Mon Feb 17 08:30:30 PST 2014 by bbeckman
\* Created Fri Feb 14 11:26:38 PST 2014 by bbeckman
