---- MODULE MC ----
EXTENDS Euclid, TLC

\* CONSTANT definitions @modelParameterConstants:0M
const_1415564403329151000 == 
30
----

\* CONSTANT definitions @modelParameterConstants:1N
const_1415564403340152000 == 
18
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1415564403350153000 ==
1..N
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_1415564403361154000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1415564403372155000 ==
(pc = "Done") => (x = y) /\ (x = GCD(x0, y0))
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_1415564403383156000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Sun Nov 09 12:20:03 PST 2014 by rebcabin
