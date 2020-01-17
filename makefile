# Задаем имя проекта, в результате получатся файлы test.hex test.bin
TARG=test
 
CC = avr-gcc
OBJCOPY = avr-objcopy
 
# Задаем из каких файлов собирать проект, можно указать несколько файлов
SRCS= test.c 
 
OBJS = $(SRCS:.c=.o)
 
# Задаем для какого микроконтроллера будем компилировать (atmega8)
MCU=atmega8
 
# Флаги компилятора, при помощи F_CPU определяем частоту на которой будет работать контроллер,
CFLAGS = -mmcu=$(MCU) -Wall -g -Os -Werror -lm  -mcall-prologues -DF_CPU=11059200
LDFLAGS = -mmcu=$(MCU)  -Wall -g -Os  -Werror 
 
all: $(TARG)
 
$(TARG): $(OBJS)
	$(CC) $(LDFLAGS) -o $@.elf  $(OBJS) -lm
	$(OBJCOPY) -O binary -R .eeprom -R .nwram  $@.elf $@.bin
	$(OBJCOPY) -O ihex -R .eeprom -R .nwram  $@.elf $@.hex
 
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $&lt;
 
clean:
	rm -f *.elf *.bin *.hex  $(OBJS) *.map