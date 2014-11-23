-------------------------------- MODULE Tiny --------------------------------
EXTENDS Integers

VARIABLE b

Init == b = 1
Next == b' = (b + 1) % 2

=============================================================================
\* Modification History
\* Last modified Mon Nov 10 00:26:47 PST 2014 by rebcabin
\* Created Mon Nov 10 00:24:12 PST 2014 by rebcabin
