---- MODULE MC ----
EXTENDS Euclid, TLC

\* CONSTANT definitions @modelParameterConstants:0M
const_1392430689409410000 == 
30
----

\* CONSTANT definitions @modelParameterConstants:1N
const_1392430689420411000 == 
100
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1392430689431412000 ==
1..N
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1392430689442413000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1392430689453414000 ==
(pc = "Done") => (x = y) /\ (x = GCD(x0, y0))
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1392430689464415000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Fri Feb 14 18:18:09 PST 2014 by bbeckman
