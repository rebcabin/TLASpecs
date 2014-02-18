---- MODULE MC ----
EXTENDS Handshake, TLC

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139274519644778000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139274519645879000 ==
Len(box) <= 1
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_139274519646980000 ==
A!Spec
----
=============================================================================
\* Modification History
\* Created Tue Feb 18 09:39:56 PST 2014 by bbeckman
