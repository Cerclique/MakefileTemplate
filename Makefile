#########################
##	GENERAL SETTINGS   ##
#########################

# Color code
BOLD_B=\033[1m
BOLD_E=\033[0m
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m

# Macro for better display
PRINT_NAME=@printf "%30s\t" $<
PRINT_STATUS=@if [ $$? -eq 0 ]; then echo -e '$(GREEN)$(BOLD_B)[SUCCESS]$(BOLD_E)$(NC)'; else echo -e '$(RED)$(BOLD_B)[FAIL]$(BOLD_E)$(NC)'; fi
PRINT_PROCESS_NAME=@printf "\n%30s\t" $@

# Name of source, include and object folder (relative to Makefile path)
SOURCES_DIR=src
INCLUDE_DIR=include
OBJECTS_DIR=bin

# Reference to source and object files.
SOURCES=$(wildcard $(SOURCES_DIR)/*.cpp)
OBJECTS=$(patsubst $(SOURCES_DIR)/%.cpp,$(OBJECTS_DIR)/%.o,$(SOURCES))

# Logfile containing compilation log
LOGFILE=build.log

#########################
##	PROJECT SETTINGS   ##
#########################

# THIS PART HAS TO BE MODIFIED IN ORDER TO FIT YOUR PROJECT. CHECK README FOR MORE INFORMATION.

# Module XXX
INCLUDE_MODULE_XXX=
LINK_MODULE_XXX=

# Module YYY
INCLUDE_MODULE_YYY=
LINK_MODULE_YYY=

# Compiler
CXX=

# Compilation flags
CXXFLAGS=

# Include and link flags based on INCLUDE_DIR (default) and modules defined previously
INCLUDE_FLAGS= -I$(INCLUDE_DIR)
LDFLAGS=

# Name of the executable/library
PROCESS_NAME=

##################
##	BUILD STEP  ##
##################

.PHONY: all
.ONESHELL:
all: CLEAN_BEFORE_BUILD $(PROCESS_NAME) 

$(PROCESS_NAME): $(OBJECTS)
	@$(PRINT_PROCESS_NAME)
	@$(CXX) $(LDFLAGS) $^ -o $@  >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

$(OBJECTS_DIR)/%.o: $(SOURCES_DIR)/%.cpp
	@$(PRINT_NAME)
	@$(CXX) $(CXXFLAGS) $(INCLUDE_FLAGS) $< -o $@ >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

.PHONY: clean
clean: CLEAN_BEFORE_BUILD
	@rm -f $(OBJECTS)

CLEAN_BEFORE_BUILD:
	@rm -f $(LOGFILE)
	@rm -f $(PROCESS_NAME)
