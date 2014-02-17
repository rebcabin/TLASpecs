---- MODULE MC ----
EXTENDS SetGCD, TLC

\* CONSTANT definitions @modelParameterConstants:0Input
const_139265466566031000 == 
{18, 30, 6*73}
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139265466567132000 ==
-50..500
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139265466568233000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139265466569334000 ==
PC
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_139265466570435000 ==
SInv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_139265466571636000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Mon Feb 17 08:31:05 PST 2014 by bbeckman
