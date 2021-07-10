TARGET := kernel

LINK_FLAGS := \
	-T src/linker.ld \
	-z max-page-size=4096 \
	-nostdlib \
	-Wl,--print-memory-usage \
	-Wl,-Map,kernel.map

LIBS := -L../libc -lc -lgcc

INCLUDES := -I../libc/include

CXX_FLAGS := \
	$(INCLUDES) \
	-Wall \
	-Wextra \
	-Werror \
	-ffreestanding \
	-fno-exceptions \
	-fno-rtti \
	-mno-red-zone \
	-mcmodel=kernel

SOURCES := $(shell find . -name "*.cpp" -o -name "*.asm")
OBJECTS := $(SOURCES:.cpp=.o)
OBJECTS := $(OBJECTS:.asm=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CROSS_CXX) $(LINK_FLAGS) $(OBJECTS) $(LIBS) -o $@

%.o: %.cpp
	$(CROSS_CXX) $(CXX_FLAGS) -c $< -o $@

%.o: %.asm
	nasm -felf64 $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)