---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139257268493340000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_139257268494441000 == 
GCD(42*83, 42*94)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_139257268494441000>>)
----

=============================================================================
\* Modification History
\* Created Sun Feb 16 09:44:44 PST 2014 by bbeckman
