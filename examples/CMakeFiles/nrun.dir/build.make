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
include examples/CMakeFiles/nrun.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/nrun.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/nrun.dir/flags.make

examples/CMakeFiles/nrun.dir/nrun.cpp.o: examples/CMakeFiles/nrun.dir/flags.make
examples/CMakeFiles/nrun.dir/nrun.cpp.o: examples/nrun.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/timber30/Documents/research/mpo/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/nrun.dir/nrun.cpp.o"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/nrun.dir/nrun.cpp.o -c /home/timber30/Documents/research/mpo/examples/nrun.cpp

examples/CMakeFiles/nrun.dir/nrun.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/nrun.dir/nrun.cpp.i"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/timber30/Documents/research/mpo/examples/nrun.cpp > CMakeFiles/nrun.dir/nrun.cpp.i

examples/CMakeFiles/nrun.dir/nrun.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/nrun.dir/nrun.cpp.s"
	cd /home/timber30/Documents/research/mpo/examples && mpicxx $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/timber30/Documents/research/mpo/examples/nrun.cpp -o CMakeFiles/nrun.dir/nrun.cpp.s

examples/CMakeFiles/nrun.dir/nrun.cpp.o.requires:

.PHONY : examples/CMakeFiles/nrun.dir/nrun.cpp.o.requires

examples/CMakeFiles/nrun.dir/nrun.cpp.o.provides: examples/CMakeFiles/nrun.dir/nrun.cpp.o.requires
	$(MAKE) -f examples/CMakeFiles/nrun.dir/build.make examples/CMakeFiles/nrun.dir/nrun.cpp.o.provides.build
.PHONY : examples/CMakeFiles/nrun.dir/nrun.cpp.o.provides

examples/CMakeFiles/nrun.dir/nrun.cpp.o.provides.build: examples/CMakeFiles/nrun.dir/nrun.cpp.o


# Object files for target nrun
nrun_OBJECTS = \
"CMakeFiles/nrun.dir/nrun.cpp.o"

# External object files for target nrun
nrun_EXTERNAL_OBJECTS =

bin/nrun: examples/CMakeFiles/nrun.dir/nrun.cpp.o
bin/nrun: examples/CMakeFiles/nrun.dir/build.make
bin/nrun: lib/libmpo.a
bin/nrun: bayesopt/lib/libbayesopt.a
bin/nrun: /usr/local/lib/libnlopt.so
bin/nrun: inih/extra/libinih.a
bin/nrun: lib/libde_interface.a
bin/nrun: /usr/local/lib/libmpicxx.so
bin/nrun: /usr/local/lib/libmpi.so
bin/nrun: examples/CMakeFiles/nrun.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/timber30/Documents/research/mpo/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/nrun"
	cd /home/timber30/Documents/research/mpo/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/nrun.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/nrun.dir/build: bin/nrun

.PHONY : examples/CMakeFiles/nrun.dir/build

examples/CMakeFiles/nrun.dir/requires: examples/CMakeFiles/nrun.dir/nrun.cpp.o.requires

.PHONY : examples/CMakeFiles/nrun.dir/requires

examples/CMakeFiles/nrun.dir/clean:
	cd /home/timber30/Documents/research/mpo/examples && $(CMAKE_COMMAND) -P CMakeFiles/nrun.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/nrun.dir/clean

examples/CMakeFiles/nrun.dir/depend:
	cd /home/timber30/Documents/research/mpo && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/timber30/Documents/research/mpo /home/timber30/Documents/research/mpo/examples /home/timber30/Documents/research/mpo /home/timber30/Documents/research/mpo/examples /home/timber30/Documents/research/mpo/examples/CMakeFiles/nrun.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/nrun.dir/depend

