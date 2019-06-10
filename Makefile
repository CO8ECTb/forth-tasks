ASM=nasm
OUT_NAME=MyForthApp
ASMFLAGS= -f elf64 -Isources/
LD=ld

all: $(OUT_NAME) 

sources/io_lib.o: sources/io_lib.asm
	$(ASM) $(ASMFLAGS) sources/io_lib.asm

sources/words_util.o: sources/words.inc
	$(ASM) $(ASMFLAGS) sources/words_util.asm

sources/main.o: sources/main.asm sources/io_lib.inc sources/fmachine.inc
	$(ASM) $(ASMFLAGS) sources/main.asm 

$(OUT_NAME): sources/io_lib.o sources/main.o sources/words_util.o
	$(LD) $(LFAGS) -o $(OUT_NAME) sources/io_lib.o sources/main.o sources/words_util.o


clean: 
	$(RM) sources/$(OUT_NAME) $(RM) sources/*.o

