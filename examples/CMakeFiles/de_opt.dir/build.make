# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/timber30/Documents/research/mpo

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/timber30/Documents/research/mpo

# Include any dependencies generated for this target.
include examples/CMakeFiles/de_opt.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/de_opt.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/de_opt.dir/flags.make

examples/CMakeFiles/de_opt.dir/de_opt.cpp.o: examples/CMakeFiles/de_opt.dir/flags.make
examples/CMakeFiles/de_opt.dir/de_opt.cpp.o: examples/de_opt.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/timber30/Documents/research/mpo/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/de_opt.dir/de_opt.cpp.o"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/de_opt.dir/de_opt.cpp.o -c /home/timber30/Documents/research/mpo/examples/de_opt.cpp

examples/CMakeFiles/de_opt.dir/de_opt.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/de_opt.dir/de_opt.cpp.i"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/timber30/Documents/research/mpo/examples/de_opt.cpp > CMakeFiles/de_opt.dir/de_opt.cpp.i

examples/CMakeFiles/de_opt.dir/de_opt.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/de_opt.dir/de_opt.cpp.s"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/timber30/Documents/research/mpo/examples/de_opt.cpp -o CMakeFiles/de_opt.dir/de_opt.cpp.s

examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.requires:

.PHONY : examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.requires

examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.provides: examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.requires
	$(MAKE) -f examples/CMakeFiles/de_opt.dir/build.make examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.provides.build
.PHONY : examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.provides

examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.provides.build: examples/CMakeFiles/de_opt.dir/de_opt.cpp.o


# Object files for target de_opt
de_opt_OBJECTS = \
"CMakeFiles/de_opt.dir/de_opt.cpp.o"

# External object files for target de_opt
de_opt_EXTERNAL_OBJECTS =

bin/de_opt: examples/CMakeFiles/de_opt.dir/de_opt.cpp.o
bin/de_opt: examples/CMakeFiles/de_opt.dir/build.make
bin/de_opt: lib/libmpo.a
bin/de_opt: bayesopt/lib/libbayesopt.a
bin/de_opt: /usr/local/lib/libnlopt.so
bin/de_opt: inih/extra/libinih.a
bin/de_opt: lib/libde_interface.a
bin/de_opt: /usr/local/lib/libmpicxx.so
bin/de_opt: /usr/local/lib/libmpi.so
bin/de_opt: examples/CMakeFiles/de_opt.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/timber30/Documents/research/mpo/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/de_opt"
	cd /home/timber30/Documents/research/mpo/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/de_opt.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/de_opt.dir/build: bin/de_opt

.PHONY : examples/CMakeFiles/de_opt.dir/build

examples/CMakeFiles/de_opt.dir/requires: examples/CMakeFiles/de_opt.dir/de_opt.cpp.o.requires

.PHONY : examples/CMakeFiles/de_opt.dir/requires

examples/CMakeFiles/de_opt.dir/clean:
	cd /home/timber30/Documents/research/mpo/examples && $(CMAKE_COMMAND) -P CMakeFiles/de_opt.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/de_opt.dir/clean

examples/CMakeFiles/de_opt.dir/depend:
	cd /home/timber30/Documents/research/mpo && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/timber30/Documents/research/mpo /home/timber30/Documents/research/mpo/examples /home/timber30/Documents/research/mpo /home/timber30/Documents/research/mpo/examples /home/timber30/Documents/research/mpo/examples/CMakeFiles/de_opt.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/de_opt.dir/depend

