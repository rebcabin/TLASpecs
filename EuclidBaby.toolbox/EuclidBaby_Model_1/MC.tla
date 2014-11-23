---- MODULE MC ----
EXTENDS EuclidBaby, TLC

\* CONSTANT definitions @modelParameterConstants:0M
const_141561754547257000 == 
30
----

\* CONSTANT definitions @modelParameterConstants:1N
const_141561754548258000 == 
18
----

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_141561754549459000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_141561754550560000 == 
GCD(M, N)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_141561754550560000>>)
----

\* SPECIFICATION definition @modelBehaviorSpec:0
spec_141561754551561000 ==
Spec
----
\* PROPERTY definition @modelCorrectnessProperties:0
prop_141561754552662000 ==
PartialCorrectness
----
=============================================================================
\* Modification History
\* Created Mon Nov 10 03:05:45 PST 2014 by rebcabin
