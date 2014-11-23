---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_141554889390322000 ==
-1000..1000
----
\* Constant expression definition @modelExpressionEval
const_expr_141554889391423000 == 
GCD(72*42, 72*83)
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_141554889391423000>>)
----

=============================================================================
\* Modification History
\* Created Sun Nov 09 08:01:33 PST 2014 by rebcabin
