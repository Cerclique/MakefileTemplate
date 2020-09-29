# Makefile Template

Simple Makefile template to build C/C++ application easily.

## Description :

### Architecture :

In order to use this Makefile, your project need to respect a specific (but yet classical) architecture described as follow :

```bash
ProjectFolder
├── Makefile
├── bin/
├── include/
└── src/
```

Here :
- `src` folder contains source files (`*.c/*.cpp`) of the project.
- `include` folder contains header files (`*.h/*.hpp`) of the project.
- `bin` folder will contains object files (`*.o`) generated during compilation

The final executable (or library) is generated in `ProjectFolder`, next to the Makefile. Of course, this location and other settings can be customize directly in the Makefile to fit perfectly your need.

### Customization :

The file is composed of mainly 3 parts : 
- **General Settings** : No modification are needed there (99% of the time). These are settings to make the compilation possible and pretty.
- **Project Settings** : All the modification concerning your project are to me made here. More information below.
- **Build Step** : Compilation steps to build the project. No modification needed.

### About Project Settings :

The following paramater are specific to the project and need to be changed accordingly.

- `CXX` : Compiler to use.
- `CXXFLAGS` : Compilation options such as `-Wall` or `-O3`. By default, `-c` is added.
- `PROCESS_NAME` : Name of the final executable/library.
- `LOGFILE` : Path to the compilation logfile. By default, the file is generated at the root of the project.

#### Modules :

To simplify use/configuration of external module/library in your project, you can use `INCLUDE_MODULE_XXX`, `LINK_MODULE_XXX` and `LIB_MODULE_XXX` (replace `XXX` with the name of the library). This allow to have separate declaration for each library.

For instance, if you have an external module `ExtModule`

```
INCLUDE_MODULE_EXTMODULE= /path/to/ExtModule/include
LINK_MODULE_EXTMODULE= /path/to/ExtModule/lib
LIB_MODULE_EXTMODULE= -lextmodule
```

After defining each module, you just have to call them in `INCLUDE_FLAGS` and `LDFLAGS` that are used during compilation.

```
INCLUDE_FLAGS= -I$(INCLUDE_DIR) -I$(INCLUDE_MODULE_EXTMODULE)
LDFLAGS= -L$(LINK_MODULE_EXTMODULE) $(LIB_MODULE_EXTMODULE)
```

*Note : `INCLUDE_FLAGS` contains `-I$(INCLUDE_DIR)` by default in order to use header defined in `include` folder.*

## Usage 
Command avaiblable are :
- `make` : Build the project in release mode.
- `make debug` : Build the project in debug mode.
- `make clean` : Delete all object files inside `bin` folder, the executable/library and the logfile. Can be used if you want to recompilation the whole project.

At compile time, either `SUCCESS` or `FAIL` is displayed for each source file to indicate compilation status. The last one refer to the executable.

*Note : Logfile is deleted before each compilation.* 