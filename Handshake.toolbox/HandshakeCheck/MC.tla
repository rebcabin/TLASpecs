---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_13925614797747000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_13925614797848000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_13925614797949000 ==
A!Spec
----
=============================================================================
\* Modification History
\* Created Sun Feb 16 06:37:59 PST 2014 by rebcabin
