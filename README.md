# README #

### Coursework Description ###

Your ARM assembly program, which you must name cw2, must accept two command line arguments. 
<br>
Firstargument must be 0 or 1 denoting encrypt/decrypt. The second argument must be a string representing the private
key. The actual text to be encrypted/decrypted must be passed to the program using standard input. Your program
must first convert the upper case letters to lower case before encryption. Further, it must strip the input text from
any characters and whitespaces other than the 26 lower case English alphabet letters. The program must return its
output i.e. depending on the first argument encrypted/decrypted text using standard output. You should test your
program with the following syntax:
```
cat textfile.txt | ./cw2 0 <privatekeystring> | ./cw2 1 <privatekeystring>
```
This should return the original text from textfile.txt, albeit lower case and without white spaces and punctuation

### Running ###

Clone the repo to your PC.
In the cloned directory, run the command line arguments:

```
 as -o cw2.o cw2.s
 gcc -o cw2 cw2.s
```
this will leave you with the cw2 file. 

After this, create `textfile.txt` and enter the message you wish to have encrypted/decrypted.

### Encryption and Decryption ###
To do both encryption and decryption in one enter the command :
```
cat textfile.txt | ./cw2 0 <privatekeystring> | ./cw2 1 <privatekeystring>
```
this will output the original `textfile.txt` contents following encryption and decryption.

### Encryption Only ###
To just encrypt the contents of `textfile.txt`, enter the command : 
```
cat textfile.txt | ./cw2 0 <privatekeystring>
```
this will output the original `textfile.txt` contents following encryption.

### Decryption only ###
To just decrypt the contents of `textfile.txt`, enter the command :
```
cat textfile.txt | ./cw2 0 <privatekeystring> | ./cw2 1 <privatekeystring>
```
this will output the original `textfile.txt` contents following encryption and decryption.

### Example ###
`<privatekeystring>` is the string you wish to use for the encryption. 
A good example is the command:
```
cat textfile.txt | ./cw2 0 lock | ./cw2 1 lock
```
with the contents of textfile.txt being 
```
message
```
this will encrypt it to `apphorb` then decrypt it to `message`.

### Grade Received ###

Percentage Grade : 80% 
Grade : First 