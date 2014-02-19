------------------------------ MODULE AltSpec ------------------------------
EXTENDS Integers, Sequences
 
Put(s) == Append(s, "widget")
Get(s) == Tail(s)
 
(*****************************************************************
--algorithm AltSpec
  { variable b = 0 , box = << >> ;
    process (Producer = 0)
    { pe: while (TRUE)
          { await b = 0 ;
            p:  box := Put(box) ;
            px: b := 1
    }     }
    (* fair *) process (Consumer = 1)
    { ce: while (TRUE)
          { await b = 1 ;
            c:  box := Get(box) ;
            cx: b := 0
    }     }
}
 *****************************************************************)
\* BEGIN TRANSLATION
VARIABLES b, box, pc

vars == << b, box, pc >>

ProcSet == {0} \cup {1}

Init == (* Global variables *)
        /\ b = 0
        /\ box = << >>
        /\ pc = [self \in ProcSet |-> CASE self = 0 -> "pe"
                                        [] self = 1 -> "ce"]

pe == /\ pc[0] = "pe"
      /\ b = 0
      /\ pc' = [pc EXCEPT ![0] = "p"]
      /\ UNCHANGED << b, box >>

p == /\ pc[0] = "p"
     /\ box' = Put(box)
     /\ pc' = [pc EXCEPT ![0] = "px"]
     /\ b' = b

px == /\ pc[0] = "px"
      /\ b' = 1
      /\ pc' = [pc EXCEPT ![0] = "pe"]
      /\ box' = box

Producer == pe \/ p \/ px

ce == /\ pc[1] = "ce"
      /\ b = 1
      /\ pc' = [pc EXCEPT ![1] = "c"]
      /\ UNCHANGED << b, box >>

c == /\ pc[1] = "c"
     /\ box' = Get(box)
     /\ pc' = [pc EXCEPT ![1] = "cx"]
     /\ b' = b

cx == /\ pc[1] = "cx"
      /\ b' = 0
      /\ pc' = [pc EXCEPT ![1] = "ce"]
      /\ box' = box

Consumer == ce \/ c \/ cx

Next == Producer \/ Consumer

Spec == Init /\ [][Next]_vars

\* END TRANSLATION
=============================================================================
\* Modification History
\* Last modified Wed Feb 19 11:07:16 PST 2014 by bbeckman
\* Created Wed Feb 19 11:03:36 PST 2014 by bbeckman
