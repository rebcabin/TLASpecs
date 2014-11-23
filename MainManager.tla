---------------------------- MODULE MainManager ----------------------------

EXTENDS Naturals

VARIABLES hr

HCini == hr \in (1..12)

HCnxt == hr' = IF (hr /= 12) THEN hr + 1 ELSE 1

HC == HCini /\ [][HCnxt]_hr

-----------------------------------------------------------------------------

THEOREM HC => []HCini

=============================================================================
\* Modification History
\* Last modified Sun Nov 09 11:59:38 PST 2014 by rebcabin
\* Created Sun Nov 09 06:19:08 PST 2014 by rebcabin
