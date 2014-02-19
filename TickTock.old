------------------------------ MODULE TickTock ------------------------------
(***************************************************************************
--algorithm TickTock 
  { variable b = 0 ;
    process (Tick = 0)
    { t0: while (TRUE)
          { await b = 0 ;
            b := 1
    }     }
    process (Tock = 1)
    { t1: while (TRUE)
          { await b = 1 ;
            b := 0
    }     }
}
 ***************************************************************************)
\* BEGIN TRANSLATION
VARIABLE b

vars == << b >>

ProcSet == {0} \cup {1}

Init == (* Global variables *)
        /\ b = 0

Tick == /\ b = 0
        /\ b' = 1

Tock == /\ b = 1
        /\ b' = 0

Next == Tick \/ Tock

Spec == Init /\ [][Next]_vars

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Tue Feb 18 10:10:59 PST 2014 by bbeckman
\* Last modified Sat Feb 15 19:09:08 PST 2014 by rebcabin
\* Created Sat Feb 15 19:02:39 PST 2014 by rebcabin
