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
CMAKE_SOURCE_DIR = /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build

# Include any dependencies generated for this target.
include esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/depend.make

# Include the progress variables for this target.
include esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/progress.make

# Include the compile flags for this target's objects.
include esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/flags.make

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/flags.make
esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj: ../components/DETECTION/detection.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_DETECTION.dir/detection.c.obj   -c /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/components/DETECTION/detection.c

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_DETECTION.dir/detection.c.i"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/components/DETECTION/detection.c > CMakeFiles/__idf_DETECTION.dir/detection.c.i

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_DETECTION.dir/detection.c.s"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/components/DETECTION/detection.c -o CMakeFiles/__idf_DETECTION.dir/detection.c.s

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.requires:

.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.requires

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.provides: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.requires
	$(MAKE) -f esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/build.make esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.provides.build
.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.provides

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.provides.build: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj


# Object files for target __idf_DETECTION
__idf_DETECTION_OBJECTS = \
"CMakeFiles/__idf_DETECTION.dir/detection.c.obj"

# External object files for target __idf_DETECTION
__idf_DETECTION_EXTERNAL_OBJECTS =

esp-idf/DETECTION/libDETECTION.a: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj
esp-idf/DETECTION/libDETECTION.a: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/build.make
esp-idf/DETECTION/libDETECTION.a: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libDETECTION.a"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && $(CMAKE_COMMAND) -P CMakeFiles/__idf_DETECTION.dir/cmake_clean_target.cmake
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/__idf_DETECTION.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/build: esp-idf/DETECTION/libDETECTION.a

.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/build

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/requires: esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/detection.c.obj.requires

.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/requires

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/clean:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION && $(CMAKE_COMMAND) -P CMakeFiles/__idf_DETECTION.dir/cmake_clean.cmake
.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/clean

esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/depend:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/components/DETECTION /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : esp-idf/DETECTION/CMakeFiles/__idf_DETECTION.dir/depend

