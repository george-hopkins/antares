TOOL_PREFIX=$(call unquote,$(CONFIG_TOOLCHAIN_PREFIX))

CC       := $(TOOL_PREFIX)gcc
CXX      := $(TOOL_PREFIX)g++
LD       := $(TOOL_PREFIX)ld -v
AR       := $(TOOL_PREFIX)ar
AS       := $(TOOL_PREFIX)gcc
OBJCOPY  := $(TOOL_PREFIX)objcopy
DISAS    := $(TOOL_PREFIX)objdump
OBJDUMP  := $(TOOL_PREFIX)objdump
SIZE     := $(TOOL_PREFIX)size

export CC CXX LD AS AR AS OBJCOPY OBJDUMP SIZE DISAS

#We're targeting an ELF and an LSS (disassembly) by default.
#Arch for avr adds us a hex and eep files for flashing

OUTPUT_TARGETS= $(TARGET_ELFFILE) $(TARGET_LSSFILE)

CFLAGS=$(call unquote,$(CONFIG_CFLAGS))
LDFLAGS=$(call unquote,$(CONFIG_LDFLAGS))
ASFLAGS=$(call unquote,$(CONFIG_ASFLAGS))
#TODO: Sort the deps stuff out
#CFLAGS += -MD -MP -MT $(*F).o -MF dep/$(@F).d 

#Let's parse optimisations from .config
ifeq ($(CONFIG_CC_OPT1),y)
CFLAGS+=-O1
endif

ifeq ($(CONFIG_CC_OPT0),y)
CFLAGS+=-O0
endif

ifeq ($(CONFIG_CC_OPT2),y)
CFLAGS+=-O2
endif

ifeq ($(CONFIG_CC_OPT3),y)
CFLAGS+=-O3
endif

ifeq ($(CONFIG_CC_OPTSZ),y)
CFLAGS+=-Os
endif




CFLAGS+=-Wall
ifeq ($(CONFIG_GCC_PARANOID_WRN),y)
CFLAGS+=-Werror
endif
