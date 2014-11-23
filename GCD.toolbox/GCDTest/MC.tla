---- MODULE MC ----
EXTENDS GCD, TLC

\* CONSTANT definition @modelParameterDefinitions:0
def_ov_14156067291735000 ==
-100..100
----
\* CONSTANT definition @modelParameterDefinitions:1
def_ov_14156067291846000 ==
0..15
----
\* Constant expression definition @modelExpressionEval
const_expr_14156067291957000 == 
<<GCD1, GCD2, GCD3>>
----

\* Constant expression ASSUME statement @modelExpressionEval
ASSUME PrintT(<<"$!@$!@$!@$!@$!",const_expr_14156067291957000>>)
----

=============================================================================
\* Modification History
\* Created Mon Nov 10 00:05:29 PST 2014 by rebcabin
