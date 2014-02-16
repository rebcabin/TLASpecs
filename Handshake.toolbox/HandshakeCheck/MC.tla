---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392522880643192000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392522880654193000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392522880665194000 ==
A!Spec
----
=============================================================================
\* Modification History
\* Created Sat Feb 15 19:54:40 PST 2014 by rebcabin
