---- MODULE MC ----
EXTENDS DieHarder, TLC

\* MV CONSTANT declarations@modelParameterConstants
CONSTANTS
big, small
----

\* MV CONSTANT definitions Jugs
const_139265415635917000 == 
{big, small}
----

\* CONSTANT definitions @modelParameterConstants:1Goal
const_139265415637018000 == 
4
----

\* CONSTANT definitions @modelParameterConstants:2Capacity
const_139265415638119000 == 
(big :> 5) @@ (small :> 3)
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_139265415639220000 ==
Spec
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_139265415640321000 ==
\A j \in Jugs : injug[j] /= Goal
----
=============================================================================
\* Modification History
\* Created Mon Feb 17 08:22:36 PST 2014 by bbeckman
