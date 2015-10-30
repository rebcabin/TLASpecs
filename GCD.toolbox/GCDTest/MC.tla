---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_14461514460452000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_14461514460563000 == 
GCD(42*83, 42*94)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_14461514460563000>>)
----

=============================================================================
\* Modification History
\* Created Thu Oct 29 13:44:06 PDT 2015 by bbeckman
