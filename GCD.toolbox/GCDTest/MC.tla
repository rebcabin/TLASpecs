---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_139265463758028000 ==
-100..100
----
\* CONSTANT definition @modelParameterDefinitions:1
def_ov_139265463759029000 ==
0..15
----
\* Constant expression definition @modelExpressionEval
const_expr_139265463760230000 == 
<<GCD1, GCD2, GCD3>>
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_139265463760230000>>)
----

=============================================================================
\* Modification History
\* Created Mon Feb 17 08:30:37 PST 2014 by bbeckman
