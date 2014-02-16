---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_13925250852894000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_13925250852995000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_13925250853106000 ==
A!Spec
----
=============================================================================
\* Modification History
\* Created Sat Feb 15 20:31:25 PST 2014 by rebcabin
