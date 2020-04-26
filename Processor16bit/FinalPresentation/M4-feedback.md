# M4
## 3B

## Design document:

- Control unit spec
I reviewed your beq instruction: Changes pc to immediate if rs and rd are equal  

RTL:
Appears to be correct.

Datapath:  
Datapath cannot do PC+1! Fix this. Otherwise, seems ok.

Control:  
Datapath is not label- I cannot tell what control does to muxes. Fix!  
Unclear what RegR1/RegR2 do.  
Unclear what the compeq signal does and it seems to change name.  
-0.5

- Control unit test plan  
Test all permutations for a FSM? I don't think this is a good test.  
- Updated control signals  
Mostly seems to be ok. You have so many control signals. Is there any way to simplify them so you have a more manageable number?
- Any changes to RTL or integration ?

## Partial implementation:

- All parts (except control)  
Most seem to be done.  
- All test-benches
Most seem to be done.  
- Some parts integrated  
Only one integration step?
- Most of the integration tests  
Only one done.

## Other:

- Team journal ✓  
- Individual journals  
Josh only worked once?  
You guys are working too much. Is there a way to use your time more efficiently? You will go crazy working this much.



