----------------------------- MODULE Handshake -----------------------------
EXTENDS Integers, Sequences
 
Put(s) == Append(s, "widget")
Get(s) == Tail(s)

a (+) b == (a + b) % 2 
 
(*****************************************************************
--algorithm Handshake {
 
    variable p = 0, c = 0, box = << >> ;
 
    process (Producer = 0)
      { p1: while (TRUE)
              { await p = c ;
                box := Put(box) ;
                p := p (+) 1
              }
      }
 
    process (Consumer = 1)
      { c1: while (TRUE)
              { await p /= c ;
                box := Get(box) ;
                c := c (+) 1
              }
      }
}
 *****************************************************************)
\* BEGIN TRANSLATION
VARIABLES p, c, box

vars == << p, c, box >>

ProcSet == {0} \cup {1}

Init == (* Global variables *)
        /\ p = 0
        /\ c = 0
        /\ box = << >>

Producer == /\ p = c
            /\ box' = Put(box)
            /\ p' = p (+) 1
            /\ c' = c

Consumer == /\ p /= c
            /\ box' = Get(box)
            /\ c' = c (+) 1
            /\ p' = p

Next == Producer \/ Consumer

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Sat Feb 15 19:20:48 PST 2014 by rebcabin
\* Created Sat Feb 15 19:18:04 PST 2014 by rebcabin
