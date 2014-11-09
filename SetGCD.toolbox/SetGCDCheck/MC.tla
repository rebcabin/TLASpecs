---- MODULE MC ----
EXTENDS SetGCD, TLC

\* CONSTANT definitions @modelParameterConstants:0Input
const_139274921692890000 == 
{18, 30, 6*73}
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139274921693991000 ==
-50..500
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139274921694992000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139274921696093000 ==
PC
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_139274921697194000 ==
SInv
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_139274921698395000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Tue Feb 18 10:46:56 PST 2014 by bbeckman
