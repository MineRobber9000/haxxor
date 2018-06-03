all: game.gb

SRC:=$(wildcard src/*.asm)
OBJ:=$(SRC:asm=o)

%.o: %.asm
	rgbasm -iinc/ -o $*.o $*.asm

game.gb: $(OBJ)
	rgblink -n game.sym -m $*.map -o $@ $(OBJ)
	rgbfix -jv -k XX -l 0x33 -m 0x01 -p 0 -r 0 -t HAXXORGB $@

clean:
	rm -f game.gb game.sym
	rm -f $(OBJ)
