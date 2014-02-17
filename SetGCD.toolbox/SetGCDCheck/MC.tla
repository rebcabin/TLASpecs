---- MODULE MC ----
EXTENDS SetGCD, TLC

\* CONSTANT definitions @modelParameterConstants:0Input
const_1392599068860801000 == 
{18, 30, 6*73}
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1392599068871802000 ==
-50..500
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392599068882803000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392599068893804000 ==
PC
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_1392599068904805000 ==
SInv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392599068915806000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Sun Feb 16 17:04:28 PST 2014 by bbeckman
