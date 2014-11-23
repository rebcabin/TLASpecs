---------------------------- MODULE MainManager ----------------------------

VARIABLES states, commands, requests, responses, outputs, 
          currentState, startState, command, output


TypeOK == /\ states       = {"poweredOff", "checkIfInAir"}
          /\ currentState = "poweredOff"
          /\ startState   = "poweredOff"

inSomeState == ( currentState \in states )

inStartState == ( currentState = "poweredOff" )

Init == inStartState

Next == /\ states'       = states        
        /\ currentState' = currentState  
        /\ startState'   = startState    


=============================================================================
\* Modification History
\* Last modified Sun Nov 09 11:45:48 PST 2014 by rebcabin
\* Created Sun Nov 09 06:19:08 PST 2014 by rebcabin
