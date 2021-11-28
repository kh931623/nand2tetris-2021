// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// loop length
@8192
D=A
@length
M=D

// init fill
@fill
M=0

// check user input and decide what to fill to the screen
(CHECK)
  // loop count
  @i
  M=0

  // read the input
  @KBD
  D=M

  // if there's no input, goto WHITE
  @WHITE
  D;JEQ

  // if there's input, goto BLACK
  @BLACK
  0;JMP


(WHITE)
  
  @fill
  D=M
  // if 'fill' is alreay 0, it means user's input never changes so go back to CHECK
  @CHECK
  D;JEQ

  // set fill to white (0)
  @fill
  M=0
  
  // goto LOOP
  @LOOP
  0;JMP


(BLACK)
  @fill
  D=M
  // if 'fill' is alreay -1, it means user's input never changes so go back to CHECK
  @CHECK
  D+1;JEQ

  // set fill to black (-1)
  @fill
  M=-1

  // goto LOOP
  @LOOP
  0;JMP

(LOOP)
  // if i >= 8192 goto CHECK
  @i
  D=M
  @length
  D=D-M
  @CHECK
  D;JGE

  // set SCREEN + i to -1
  // compute desired address and store it to 'address' var
  @i
  D=M
  @SCREEN
  D=D+A
  @address
  M=D

  // set RAM[address] to 'fill' var
  @fill
  D=M
  @address
  A=M
  M=D

  // i++
  @i
  M=M+1

  // back to top of LOOP
  @LOOP
  0;JMP

(END)
  @END
  0;JMP