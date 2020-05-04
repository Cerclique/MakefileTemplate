# Makefile Template

Simple Makefile template to build C/C++ application easily.

## How to use

#### Architecture
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

#### Customization

The file is composed of mainly 3 parts : 
- **General Settings** : No modification are needed there (99% of the time). These are settings to make the compilation possible and pretty.
- **Project Settings** : All the modification concerning your project are to me made here. More information below.
- **Build Step** : Compilation steps to build the project. No modification needed.

##### About Project Settings

- `CXX` : Compiler to use.
- `CXXFLAGS` : Compilation options such as `-Wall` or `-O3`, etc ...
- `PROCESS_NAME` : Name of the final executable/library.
- `LOGFILE` : Path to the compilation logfile. By default, the file is generated at the root of the project.

To simplify use/configuration of external module/library in your project, you can use `INCLUDE_MODULE_XXX` and `LINK_MODULE_XXX` (replace `XXX` with the name of the library). This allow to have separate declaration for each library.

For instance, if we have a project that use OpenCV and FFmpeg :

```Makefile
# OpenCV
INCLUDE_MODULE_OPENCV=`pkg-config --cflags opencv`
LINK_MODULE_OPENCV=`pkg-config --libs opencv`

# FFmpeg
INCLUDE_MODULE_FFMPEG=-I/usr/lib
LINK_MODULE_FFMPEG= -lavformat -lavcodec
```

After defining each module, you just have to call them in `INCLUDE_FLAGS` and `LDFLAGS` that are used during compilation.

```Makefile
INCLUDE_FLAGS= -I$(INCLUDE_DIR) $(INCLUDE_MODULE_OPENCV) $(INCLUDE_MODULE_FFMPEG) 
LDFLAGS= $(LINK_MODULE_OPENCV) $(LINK_MODULE_FFMPEG)
```

*Note : `INCLUDE_FLAGS` contains `-I$(INCLUDE_DIR)` by default in order to use header defined in `include` folder.*
#### Usage 
Command avaiblable are :
- `make` : Build the project based on modified file since last compilation
- `make clean` : Delete all object files inside `bin` folder, the executable/library and the logfile. Can be used if you want to recompilation the whole project.

*Note : Logfile is deleted before each compilation.*