---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_141554243818019000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_141554243819120000 == 
DivisorsOf(493)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_141554243819120000>>)
----

=============================================================================
\* Modification History
\* Created Sun Nov 09 06:13:58 PST 2014 by rebcabin
