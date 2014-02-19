---------------------------- MODULE Alternation ----------------------------
EXTENDS Integers, Sequences
 
Put(s) == Append(s, "widget")
Get(s) == Tail(s)
 
(*****************************************************************
--algorithm Alternate
  { variable b = 0 , box = << >> ;
    process (Producer = 0)
    { p1: while (TRUE)
          { await b = 0 ;
            box := Put(box) ;
            b := 1
    }     }
    fair process (Consumer = 1)
    { c1: while (TRUE)
          { await b = 1 ;
            box := Get(box) ;
            b := 0
    }     }
}
 *****************************************************************)
\* BEGIN TRANSLATION
VARIABLES b, box

vars == << b, box >>

ProcSet == {0} \cup {1}

Init == (* Global variables *)
        /\ b = 0
        /\ box = << >>

Producer == /\ b = 0
            /\ box' = Put(box)
            /\ b' = 1

Consumer == /\ b = 1
            /\ box' = Get(box)
            /\ b' = 0

Next == Producer \/ Consumer

Spec == /\ Init /\ [][Next]_vars
        /\ WF_vars(Consumer)

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Wed Feb 19 09:36:51 PST 2014 by bbeckman
\* Last modified Sat Feb 15 19:57:03 PST 2014 by rebcabin
\* Created Sat Feb 15 19:08:21 PST 2014 by rebcabin
