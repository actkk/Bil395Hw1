Bil395 HW1
Ahmet Cemil Tarık Keskinkılıç
191101051

This project is a simple calculator implemented with Lex (Flex) and Yacc (Bison). 

I am using macOS, so I installed Bison and Flex with Homebrew:
  brew install bison
  brew install flex

FILES:
- calculator.l       (Lex specification)
- calculator.y       (Yacc specification)
- test.sh            (Script to build and test the calculator)

HOW TO BUILD (MANUAL STEPS):
1. bison -d -o calculator.tab.c calculator.y
2. flex -o lex.yy.c calculator.l
3. gcc lex.yy.c calculator.tab.c -o calculator -lm
4. ./calculator

TEST INPUTS:
You can use the following example expressions to test manually:
1) 3 + 5
2) (1 + 2) * 4
3) 10 / 2
4) 10 / 0  (Division by zero error)
5) (3 + 5) * (2 - 1) / 4
6) 2 ^ 3
7) 2.5 * 2
8) garbage (Invalid expression)

AUTOMATED TESTING:
You can simply run the test.sh script:
  chmod u+x test.sh
  ./test.sh
This will generate all necessary files, compile them, feed the test inputs to 
the calculator, show their outputs, and then remove the temporary files.

