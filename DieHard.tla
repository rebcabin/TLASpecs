------------------------------ MODULE DieHard ------------------------------
EXTENDS Integers

VARIABLES big, small

TypeOK == big \in 0..5 /\ small \in 0..3

Init == /\ big   = 0
        /\ small = 0

FillSmall == /\ small' = 3
             /\ big'   = big
             
FillBig   == /\ small' = small
             /\ big'   = 5
             
EmptySmall == small' = 0 /\ big'   = big
EmptyBig   == big'   = 0 /\ small' = small

Min(n, m) == IF m < n THEN m ELSE n

(***************************************************************************)
(* When pouring from small to big, we first ask if big + small > 5.  If    *)
(* so, we make big' = 5 and small' = small - (5 - big); if not, we make    *)
(* big' = big + small and small' = 0.  In the former case, the amount      *)
(* poured is 5 - big; in the latter case, the amount poured is small,      *)
(* which equals (big + small) - big.  In both cases, the amount poured is  *)
(* Min(big + small, 5) - big.                                              *)
(*                                                                         *)
(* Symmetric reasoning applies to pouring from big to small.               *)
(***************************************************************************)

SmallToBig == LET poured == Min(big + small, 5) - big
              IN  /\ big'   = big   + poured
                  /\ small' = small - poured

BigToSmall == LET poured == Min(big + small, 3) - small
              IN  /\ big'   = big   - poured
                  /\ small' = small + poured

Next == \/ FillSmall
        \/ FillBig
        \/ EmptySmall
        \/ EmptyBig
        \/ SmallToBig
        \/ BigToSmall

=============================================================================
\* Modification History
\* Last modified Sun Feb 16 09:34:25 PST 2014 by bbeckman
\* Created Fri Feb 14 08:11:11 PST 2014 by bbeckman
