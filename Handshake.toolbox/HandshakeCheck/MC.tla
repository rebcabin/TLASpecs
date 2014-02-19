---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392832083198163000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392832083209164000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392832083219165000 ==
A2!Spec
----
=============================================================================
\* Modification History
\* Created Wed Feb 19 09:48:03 PST 2014 by bbeckman
