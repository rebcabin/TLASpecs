---------------------------- MODULE OneBitClock ----------------------------
EXTENDS Integers

VARIABLE b

TypeOK == b \in {0, 1}

Init1 == (b = 0) \/ (b = 1)

Next3 == b' = (b + 1) % 2

Next4 == /\ (b = 0) => (b' = 1)
         /\ (b = 1) => (b' = 0)

Next1 == \/ /\ (b  = 0)
            /\ (b' = 1)
         \/ /\ (b  = 1)
            /\ (b' = 0)

=============================================================================
\* Modification History
\* Last modified Fri Feb 14 08:01:40 PST 2014 by bbeckman
\* Created Fri Feb 14 06:47:02 PST 2014 by bbeckman
