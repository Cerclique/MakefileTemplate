#########################
##	GENERAL SETTINGS   ##
#########################

# Color code
BOLD_B=\033[1m
BOLD_E=\033[0m
RED=\033[0;31m
WHITE=\033[1;37m
NC=\033[0m

# Macro for better display
PRINT_NAME=@printf "%30s\t" $<
PRINT_STATUS=@if [ $$? -eq 0 ]; then echo -e '$(WHITE)$(BOLD_B)[DONE]$(BOLD_E)$(NC)'; else echo -e '$(RED)$(BOLD_B)[FAIL]$(BOLD_E)$(NC)'; fi
PRINT_EXECUTABLE=@printf "\n%30s\t" $@

# Name of source and object folder (relative to Makefile path)
SOURCES_DIR=src
OBJECTS_DIR=bin

# Reference to source and object files.
SOURCES=$(wildcard $(SOURCES_DIR)/*.cpp)
OBJECTS=$(patsubst $(SOURCES_DIR)/%.cpp,$(OBJECTS_DIR)/%.o,$(SOURCES))
LOGFILE=build.log

#########################
##	PROJECT SETTINGS   ##
#########################

CXX=
CXXFLAGS=
INCLUDE_DIR=
LDFLAGS=

EXECUTABLE=playVideo

##################
##	BUILD STEP  ##
##################

all: $(CLEAN_BEFORE_BUILD) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(PRINT_EXECUTABLE)
	@$(CXX) $(LDFLAGS) $^ -o $@ >> $(LOGFILE) 2>&1
	$(PRINT_STATUS)

$(OBJECTS_DIR)/%.o: $(SOURCES_DIR)/%.cpp
	$(PRINT_NAME)
	@$(CXX) $(CXXFLAGS) $(INCLUDE_DIR) $< -o $@ >> $(LOGFILE) 2>&1
	$(PRINT_STATUS)

clean:
	@rm -f $(OBJECTS)

CLEAN_BEFORE_BUILD:
	@rm -f $(EXECUTABLE)
	@rm -f $(LOGFILE)
