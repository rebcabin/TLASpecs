---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392523119055200000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392523119065201000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392523119075202000 ==
A!Spec
----
=============================================================================
\* Modification History
\* Created Sat Feb 15 19:58:39 PST 2014 by rebcabin
