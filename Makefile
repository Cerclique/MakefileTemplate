#########################
##  PROJECT SETTINGS   ##
#########################

# THIS PART HAS TO BE MODIFIED IN ORDER TO FIT YOUR PROJECT. CHECK README FOR MORE INFORMATION.

# Compilation type : EXECUTABLE / STATIC_LIB / SHARED_LIB
TARGET_TYPE =

# Name of the executable/library
TARGET_NAME =

# Source file extension
SRC_EXTENSION =

# Compiler
CXX =

# Compilation flags (-c for .o object generation)
CXXFLAGS = -c 

# Module XXX
INCLUDE_DIR_MODULE_XXX =
LIB_DIR_MODULE_XXX =
LIB_MODULE_XXX =

# Module YYY
INCLUDE_DIR_MODULE_YYY =
LIB_DIR_MODULE_YYY =
LIB_MODULE_YYY =

# Include and link/lib flags composed of INCLUDE_DIR (default) and modules defined previously
INCLUDE_FLAGS = -I $(INCLUDE_DIR) # -I $(INCLUDE_DIR_MODULE_XXX)
LDFLAGS = # -L $(LIB_DIR_MODULE_XXX) $(LIB_MODULE_XXX)

# Logfile containing compilation log
LOGFILE = build.log

#########################
##	GENERAL SETTINGS   ##
#########################

# Color code
BOLD_B = \033[1m
BOLD_E = \033[0m
RED = \033[0;31m
GREEN = \033[0;32m
NC = \033[0m

# Macro for better display
PRINT_NAME = @printf "%50s\t" $<
PRINT_STATUS = @if [ $$? -eq 0 ]; then echo -e '$(GREEN)$(BOLD_B)[SUCCESS]$(BOLD_E)$(NC)'; else echo -e '$(RED)$(BOLD_B)[FAIL]$(BOLD_E)$(NC)'; fi
PRINT_TARGET_NAME = @printf "\n%50s\t" $@

# Name of source, include and object folder (relative to Makefile path)
SOURCE_DIR = src
INCLUDE_DIR = include
OBJECT_DIR = bin

# Reference to source and object files.
SOURCES = $(wildcard $(SOURCE_DIR)/*.$(SRC_EXTENSION))
OBJECTS = $(patsubst $(SOURCE_DIR)/%.$(SRC_EXTENSION),$(OBJECT_DIR)/%.o,$(SOURCES))

##################
##  BUILD STEP  ##
##################

ifeq ($(TARGET_TYPE), SHARED_LIB)
	LDFLAGS += -shared
	CXXFLAGS += -fPIC
endif

.PHONY: all
.ONESHELL:
all: compil

.PHONY: debug
.ONESHELL:
debug: CXXFLAGS += -g
debug: compil

compil: CLEAN_BEFORE_BUILD $(TARGET_NAME)

.PHONY: clean
clean: CLEAN_BEFORE_BUILD
	@rm -f $(OBJECTS)


$(TARGET_NAME): $(OBJECTS)
	@$(PRINT_TARGET_NAME)
	@if [ $(TARGET_TYPE) = STATIC_LIB ]; then
		@ar -rcs $@ $(LDFLAGS) $^ >> $(LOGFILE) 2>&1
	@else
		@$(CXX) $(LDFLAGS) $^ -o $@  >> $(LOGFILE) 2>&1
	@fi
	@$(PRINT_STATUS)

$(OBJECT_DIR)/%.o: $(SOURCE_DIR)/%.$(SRC_EXTENSION)
	@$(PRINT_NAME)
	@$(CXX) $(CXXFLAGS) $(INCLUDE_FLAGS) $< -o $@ >> $(LOGFILE) 2>&1
	@$(PRINT_STATUS)

CLEAN_BEFORE_BUILD:
	@rm -f $(LOGFILE)
	@rm -f $(TARGET_NAME)
	@if [ ! -d "$(OBJECT_DIR)" ]; then
	@	mkdir $(OBJECT_DIR)
	@fi
