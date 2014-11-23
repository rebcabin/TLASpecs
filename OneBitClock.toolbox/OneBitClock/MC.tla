---- MODULE MC ----
EXTENDS OneBitClock, TLC

\* INIT definition @modelBehaviorInit:0
init_141560806903418000 ==
TypeOK
----
\* NEXT definition @modelBehaviorNext:0
next_141560806904519000 ==
Next5
----
\* INVARIANT definition @modelCorrectnessInvariants:0
inv_141560806905620000 ==
TypeOK
----
\* INVARIANT definition @modelCorrectnessInvariants:1
inv_141560806906621000 ==
b # 2
----
\* INVARIANT definition @modelCorrectnessInvariants:2
inv_141560806907822000 ==
b /= 2
----
=============================================================================
\* Modification History
\* Created Mon Nov 10 00:27:49 PST 2014 by rebcabin
