---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392929708319260000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392929708330261000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392929708341262000 ==
A2!Spec
----
=============================================================================
\* Modification History
\* Created Thu Feb 20 12:55:08 PST 2014 by bbeckman
