---------------------------- MODULE OneBitClock ----------------------------
EXTENDS Integers

VARIABLE b

TypeOK == b \in {0, 1}

Init1 == (b = 0) \/ (b = 1)

Next3 == b' = (b + 1) % 2

Next2 == b' = IF b = 0 THEN 1 ELSE 0

Next4 == /\ (b = 0) => (b' = 1)
         /\ (b = 1) => (b' = 0)

Next1 == \/ /\ (b  = 0)
            /\ (b' = 1)
         \/ /\ (b  = 1)
            /\ (b' = 0)

=============================================================================
\* Modification History
\* Last modified Sun Feb 16 08:51:04 PST 2014 by bbeckman
\* Created Fri Feb 14 06:47:02 PST 2014 by bbeckman
