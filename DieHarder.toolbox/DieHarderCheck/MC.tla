---- MODULE MC ----
EXTENDS DieHarder, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
big, small
----

\* MV CONSTANT definitions Jugs
const_139265735993263000 == 
{big, small}
----

\* CONSTANT definitions @modelParameterConstants:1Goal
const_139265735994264000 == 
4
----

\* CONSTANT definitions @modelParameterConstants:2Capacity
const_139265735995465000 == 
(big :> 5) @@ (small :> 3)
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139265735996466000 ==
-50..100
----
\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139265735997567000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139265735998768000 ==
\A j \in Jugs : injug[j] /= Goal
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_139265735999869000 ==
NecessaryCondition
----
=============================================================================
\* Modification History
\* Created Mon Feb 17 09:15:59 PST 2014 by bbeckman
