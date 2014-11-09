---- MODULE MC ----
EXTENDS Euclid, TLC

\* CONSTANT definitions @modelParameterConstants:0M
const_139336759307634000 == 
30
----

\* CONSTANT definitions @modelParameterConstants:1N
const_139336759308735000 == 
100
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139336759309836000 ==
1..N
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139336759310837000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139336759311938000 ==
(pc = "Done") => (x = y) /\ (x = GCD(x0, y0))
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_139336759312939000 ==
Termination
----
=============================================================================
\* Modification History
\* Created Tue Feb 25 14:33:13 PST 2014 by bbeckman
