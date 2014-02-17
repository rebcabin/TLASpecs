---- MODULE MC ----
EXTENDS ExtraSimpleEuclid, TLC

\* CONSTANT definitions @modelParameterConstants:0M
const_1392599998252855000 == 
30
----

\* CONSTANT definitions @modelParameterConstants:1N
const_1392599998263856000 == 
18
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1392599998275857000 ==
-100..100
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392599998286858000 ==
Specl2
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392599998297859000 ==
Inv
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_1392599998307860000 ==
InductiveInv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392599998317861000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Sun Feb 16 17:19:58 PST 2014 by bbeckman
