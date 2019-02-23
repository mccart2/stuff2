/*
 * AssemblerApplication1.asm
 *
 *  Created: 2/22/2019 4:07:01 PM
 *   Author: mccart2
 */ 


 LDI XH,HIGH(0X0200) // This is where we will be storing in memory our numbers
 LDI XL,HIGH(0X0200)

 LDI YH,HIGH(0X0400) // Here is where we are storing the number that is divisible by 3
 LDI YL,HIGH(0X0400)

 LDI ZH,HIGH(0X0600) // And finally this is where we store the rest of the values after division. 
 LDI ZL,HIGH(0X0600)

 LDI R22,109 // Highest number in our array
 LDI R23,10 // Starting number
 LDI R20,0 // Register to hold zero for later
 
 // Main loop
LOOP_DE_LOOP:
 INC R23 // Increment our starting number now it starts at 11
 ST X+,R23 // Store in X and increment
 MOV R25,R23 // Copy the value of R23 into R25
 RJMP INNER_LOOP  // Jump to our division loop
 
 INNER_LOOP: // Division Loop
	SUBI R25,3 //Subtract 3 from our number
	  BRMI OTHER_STORE // If the number sets a negitive flag exit loop to
	CP R25,R20  // Compare if the result is equal to zero
	BREQ THREE_STORE // If R25 is equal to zero then we exit to the 3 store loop
  RJMP INNER_LOOP  // Jump to the next subroutine
	
	THREE_STORE: // 3 store subroutine
		ST Y+,R23  // Store in Y and increment
		ADD R16,R23 // Adds the value into R16
		ADC R17,R20 // Adds the carry to R17
		RJMP JUMPING_BEAN // Jump to our next Label
		
	OTHER_STORE:  // Alternative loop
		ST Z+,R23 // Store all numbers not divisible by 3 in our Z 
		ADD R18,R23 // Add the value to R18
		ADC R19,R20 // Add the carry to R19
		RJMP JUMPING_BEAN // Exit the subroutine and goto label

JUMPING_BEAN: CP R23,R22  // If these numbers match our loop is over
 BRNE LOOP_DE_LOOP  // Branch statement to start again

DONE: // Done Label

RJMP DONE // Infinity Loop