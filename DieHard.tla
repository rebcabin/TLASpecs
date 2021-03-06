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
\* Last modified Fri Feb 14 09:00:08 PST 2014 by bbeckman
\* Created Fri Feb 14 08:11:11 PST 2014 by bbeckman
