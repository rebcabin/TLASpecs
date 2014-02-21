---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392940679454301000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392940679465302000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392940679476303000 ==
A2!Spec
----
=============================================================================
\* Modification History
\* Created Thu Feb 20 15:57:59 PST 2014 by bbeckman
