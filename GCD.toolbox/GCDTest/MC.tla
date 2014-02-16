---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1392593336521400000 ==
-100..100
----
\* CONSTANT definition @modelParameterDefinitions:1
def_ov_1392593336532401000 ==
0..15
----
\* Constant expression definition @modelExpressionEval
const_expr_1392593336543402000 == 
<<GCD1, GCD2, GCD3>>
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_1392593336543402000>>)
----

=============================================================================
\* Modification History
\* Created Sun Feb 16 15:28:56 PST 2014 by bbeckman
