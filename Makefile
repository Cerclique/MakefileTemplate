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
PRINT_NAME=@printf "%50s\t" $<
PRINT_STATUS=@if [ $$? -eq 0 ]; then echo -e '$(GREEN)$(BOLD_B)[SUCCESS]$(BOLD_E)$(NC)'; else echo -e '$(RED)$(BOLD_B)[FAIL]$(BOLD_E)$(NC)'; fi
PRINT_PROCESS_NAME=@printf "\n%50s\t" $@

# Name of source, include and object folder (relative to Makefile path)
SOURCES_DIR=src
INCLUDE_DIR=include
OBJECTS_DIR=bin

# Reference to source and object files.
SOURCES=$(wildcard $(SOURCES_DIR)/*.cpp)
OBJECTS=$(patsubst $(SOURCES_DIR)/%.cpp,$(OBJECTS_DIR)/%.o,$(SOURCES))

#########################
##  PROJECT SETTINGS   ##
#########################

# THIS PART HAS TO BE MODIFIED IN ORDER TO FIT YOUR PROJECT. CHECK README FOR MORE INFORMATION.

# Compiler
CXX=

# Compilation flags (-c for .o object generation)
CXXFLAGS= -c

# Module XXX
INCLUDE_MODULE_XXX=
LINK_MODULE_XXX=
LIB_MODULE_XXX=

# Module YYY
INCLUDE_MODULE_YYY=
LINK_MODULE_YYY=
LIB_MODULE_YYY=

# Include and link/lib flags composed of INCLUDE_DIR (default) and modules defined previously
INCLUDE_FLAGS= -I$(INCLUDE_DIR)
LDFLAGS=

# Name of the executable/library
PROCESS_NAME=

# Logfile containing compilation log
LOGFILE=build.log

##################
##  BUILD STEP  ##
##################

.PHONY: all
.ONESHELL:
all: compil

.PHONY: debug
.ONESHELL:
debug: CXXFLAGS += -g
debug: compil

compil: CLEAN_BEFORE_BUILD $(PROCESS_NAME)

.PHONY: clean
clean: CLEAN_BEFORE_BUILD
	@rm -f $(OBJECTS)


$(PROCESS_NAME): $(OBJECTS)
	@$(PRINT_PROCESS_NAME)
	@$(CXX) $(LDFLAGS) $^ -o $@  >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

$(OBJECTS_DIR)/%.o: $(SOURCES_DIR)/%.cpp
	@$(PRINT_NAME)
	@$(CXX) $(CXXFLAGS) $(INCLUDE_FLAGS) $< -o $@ >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

CLEAN_BEFORE_BUILD:
	@rm -f $(LOGFILE)
	@rm -f $(PROCESS_NAME)
	@if [ ! -d "$(OBJECTS_DIR)" ]; then
	@	mkdir $(OBJECTS_DIR)
	@fi
