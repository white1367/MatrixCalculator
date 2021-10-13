#compile bison
bison -d -o MatrixCalculator.tab.c MatrixCalculator.y	
gcc -c -g -I.. MatrixCalculator.tab.c
#compile flex
flex -o MatrixCalculator.yy.c MatrixCalculator.l
gcc -c -g -I.. MatrixCalculator.yy.c
#compile and link bison and flex
gcc -o MatrixCalculator MatrixCalculator.tab.o MatrixCalculator.yy.o -ll