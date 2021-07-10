TARGET := libc.a

INCLUDES := -I./include

CFLAGS := \
	$(INCLUDES) \
	-Wall \
	-Wextra \
	-Werror \
	-ffreestanding \
	-mno-red-zone \
	-mcmodel=kernel \
	-O3

SOURCES := $(shell find . -name "*.c")
OBJECTS := $(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	ar rcs $@ $(OBJECTS)

%.o: %.c
	$(CROSS_CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)