
#builds all executable files at once instead of individually building each 
all: task1 task1.2 task2_nameprint task2_arraysum task2_arrayrange


#task 1 build commands 
#checks if object files already exist. once all object files exist the gcc command is used to link them into 1 executable file
task1: task1.o driver.o asm_io.o	
	gcc -m32 -o task1 task1.o driver.o asm_io.o 
#if object files haven't been created yet they are created here
task1.o: task1.asm	
	nasm -f elf32 task1.asm -o task1.o


#task 1.2 build commands 
task1.2: task1.2.o driver.o asm_io.o
	gcc -m32 -o task1.2 task1.2.o driver.o asm_io.o

task1.2.o: task1.2.asm
	nasm -f elf32 task1.2.asm -o task1.2.o


#task 2 part 1 build commands
task2_nameprint: task2_nameprint.o driver.o asm_io.o
	gcc -m32 -o task2_nameprint task2_nameprint.o driver.o asm_io.o

task2_nameprint.o: task2_nameprint.asm
	nasm -f elf32 task2_nameprint.asm -o task2_nameprint.o


#task 2 part 2 build commands
task2_arraysum: task2_arraysum.o driver.o asm_io.o
	gcc -m32 -o task2_arraysum task2_arraysum.o driver.o asm_io.o

task2_arraysum.o: task2_arraysum.asm
	nasm -f elf32 task2_arraysum.asm -o task2_arraysum.o


#task 2 part 3 build commands
task2_arrayrange: task2_arrayrange.o driver.o asm_io.o
	gcc -m32 -o task2_arrayrange task2_arrayrange.o driver.o asm_io.o

task2_arrayrange.o: task2_arrayrange.asm
	nasm -f elf32 task2_arrayrange.asm -o task2_arrayrange.o


#removes/wipes any object files so can be built again
ObjectWipe:
	rm -f *.o task1 task1.2 task2_nameprint task2_arraysum task2_arrayrange 
