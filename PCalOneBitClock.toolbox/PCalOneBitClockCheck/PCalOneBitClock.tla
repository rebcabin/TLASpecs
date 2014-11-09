-------------------------- MODULE PCalOneBitClock --------------------------
EXTENDS Integers

(***************************************************************************
--algorithm Clock {
    variable b \in {0, 1};
    {   while (TRUE)
        {   b := (b + 1) % 2;
        }
    }
}
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLE b

vars == << b >>

Init == (* Global variables *)
        /\ b \in {0, 1}

Next == b' = (b + 1) % 2

Spec == Init /\ [][Next]_vars

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Sun Feb 16 08:57:00 PST 2014 by bbeckman
\* Created Sun Feb 16 08:53:40 PST 2014 by bbeckman
