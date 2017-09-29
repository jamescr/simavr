#Ejemplo de * Makefile*

all: ensamblar linker hexadecimal
	@echo $@ OK

#Ensamblador:
ensamblar:
	avr-as -g -mmcu=atmega328p -o 01-led-parpadeo.o 01-led-parpadeo.asm

#Linker:
linker:
	avr-ld -g -o 01-led-parpadeo.elf 01-led-parpadeo.o --entry=0x0000

#avr-objcopy
hexadecimal:
	avr-objcopy -O ihex -R .eeprom 01-led-parpadeo.elf 01-led-parpadeo.hex

#avr-dude
subir_programa: all
	avrdude -F -V -c arduino -p ATMEGA328P -P /dev/ttyACM0 -b 115200 -U flash:w:01-led-parpadeo.hex


clean:
	rm 01-led-parpadeo.o 01-led-parpadeo.hex 01-led-parpadeo.elf
