---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_1392429006393340000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_1392429006403341000 == 
GCD(42*83, 42*94)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_1392429006403341000>>)
----

\* INIT definition @modelBehaviorNoSpec:0
init_1392429006414342000 ==
FALSE/\x = 0
----
\* NEXT definition @modelBehaviorNoSpec:0
next_1392429006425343000 ==
FALSE/\x' = x
----
=============================================================================
\* Modification History
\* Created Fri Feb 14 17:50:06 PST 2014 by bbeckman
