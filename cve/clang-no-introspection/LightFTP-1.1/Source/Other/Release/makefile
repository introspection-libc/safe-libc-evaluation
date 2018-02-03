################################################################################
# Automatically-generated file. Do not edit!
################################################################################

CC := $(HOME)/git/llvm-build/bin/clang
CFLAGS := -O3 -g
LDFLAGS := -O3 -g -Wl,-E

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: fftp

# Tool invocations
fftp: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC C Linker'
	$(CC) $(LDFLAGS) -o "fftp" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) fftp
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
