@Date-16/01/18
@Author - Sophie Rollo
@Student Code - 100021268
@
@Register Uses
@r1 - Byte information of console input, later used to provide ASCII value for print output 
@r2 - Unused due to deletion when accessing getChar
@r3 - Unused due to deletion when accessing getChar
@r4 - Char from inputted message
@r5 - Key for encrypt/decryption
@r6 - Character from getchar fucntion
@r7 - unused to due system constraints
@r8 - used during validity checker to maintain original character
@r9 - Holds Byte information of message
@r10 - Counter for itterating through chars in message
@ cw2.s

.data
	result: .asciz "%c"

.text
	.balign 4
	.global main
	.extern printf
	.extern getchar

main:
	PUSH {r4, lr}
	LDR r5, [r1, #4]	@Transfer 0/1 encrypt/decrypt choice to r5
	LDRB r5, [r5]		@Loads Byte information from r5 onto r5
	LDR r9, [r1, #8]	@Transfers byte data in message to r9
	MOV r10, #0		@Initialises key counter to position 0
	B charLoop		@Sends to charLoop
charLoop:

	BL getchar		@GetChar, writes to r1,r2,r3
	MOV r6, r0		@Move the ASCII value of character found via getChar to r6, done so that its not deleted when traversing functions 
	B validityChecker	@Branch to validity Checker, to check if the current character of the text is valid for encryption/decryption

validityChecker:
	CMP r6, #-1		@Checks the current character in the message is not null
	BEQ end			@If it is null the message encryption/decryption has been completed so ends
	CMP r6, #122		@Checks if current char against 122, z in the ASCII table
	MOVLT r8, r6		@If the char is less than 122, it moves to r8 register so further changes don't affect it
	BGT charLoop		@If greater than, character invalid for encryption/decryption, loops to next char in message
	CMP r8, #65		@Compares the char now held in r8 against 65
	BLT charLoop  		@If lower than 65, character invalid for encryption/decryption, loops to next char in message
	CMP r8, #91		@Checks char against ASCII value 91
	ADDLT r6, #32		@If less than 91, adds 32 to the ASCII value stored  in r6
	CMP r6, #97		@Compares char held in r6 against 97
	BLT charLoop 		@If the character is still less than 97, it is a invalid for encryption/decryption, loops to next char in message
	LDRB r4, [r9, r10]	@Transfers the current encipher/decipher key to r4
	CMP r4, #0		@Compares this against ASCII value 0 - null
	MOVEQ r10, #0		@If null restarts the counter stored in r10 to 0 to reitterate through the key for  the total message length
	LDRB r4, [r9, r10]	@Loads the new encipher key character into r4
	B operationChoice	@Branches to operation choice

operationChoice:
	CMP r5, #48		@Checks if ASCII value stored in r5 is equal to 48, meaning if equal 0 was entered
	BEQ encrypt		@If equal, branches to encryption path
	CMP r5, #49		@Checks if ASCII value stored in r5 is equal to 49, meaning if equal 1 was entered
	BEQ decrypt		@If equal, branches to decryption path
	B end			@Inclusion of 2CMPs and B end means if user entered invalid encrypt/decrypt choice, it would terminate the programe. 

encrypt:
	SUB r6, r6, r4		@Subtracts ASCII value of r4 from ASCII value of r6
	ADD r6, r6, #96		@Adds 96 to ASCII value of r6 to bring back to a-z range
	CMP r6, #97		@Compares r6 against 97
	ADDLT r6, r6, #26	@If r6 is < 97, adds 26 to ASCII value in r6, bringin back into a-z range
	ADD r10, r10, #1	@Increment the character counter stored in r10 by one, so next loop will increment the message
	B printer		@branch to printer 

decrypt:
	ADD r6, r6, r4		@Adds ASCII value of r6 to ASCII value of r4
	SUB r6, r6, #96		@Subtracts 96 from ASCII value in r6, to bring back to a-z range
	CMP r6, #122		@Compares r6 against 122
	SUBGT r6, r6, #26	@Subtracts 26 from ASCII value in r6, to bring it back into a-z range if > 122
	ADD r10, r10, #1	@Increment the character counter stored in r10 by one, to allow next loop to increment the message
	B printer		@Branches to printer

printer:
	MOV r1, r6		@Moves the encrypted/decrypted ASCII value stored in r6 to r1 to allow printf function to print it
	LDR r0, =result		@Loads print formatting for the result
	BL printf		@Prints out the result
	B charLoop		@Reroutes back to charLoop to allow for next char if present.

end:
	POP {r4, lr}		@POPs result
	BX lr			@Exits programme
