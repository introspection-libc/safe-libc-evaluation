################################################################################
# Automatically-generated file. Do not edit!
################################################################################

CC := gcc
CFLAGS := -mmpx -fcheck-pointer-bounds -g
LDFLAGS := -Wl,--no-as-needed -lmpx -lmpxwrappers -g 

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

LIBS +=

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: fftp

# Tool invocations
fftp: $(OBJS) $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC C Linker'
	$(CC) -o "fftp" $(OBJS) $(USER_OBJS) $(LIBS) $(LDFLAGS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(C_DEPS) fftp
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
