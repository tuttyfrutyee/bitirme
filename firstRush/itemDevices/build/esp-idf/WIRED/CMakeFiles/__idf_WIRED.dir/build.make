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
CMAKE_SOURCE_DIR = /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build

# Include any dependencies generated for this target.
include esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/depend.make

# Include the progress variables for this target.
include esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/progress.make

# Include the compile flags for this target's objects.
include esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/flags.make

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/flags.make
esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj: ../components/WIRED/wired.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_WIRED.dir/wired.c.obj   -c /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/components/WIRED/wired.c

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_WIRED.dir/wired.c.i"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/components/WIRED/wired.c > CMakeFiles/__idf_WIRED.dir/wired.c.i

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_WIRED.dir/wired.c.s"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/components/WIRED/wired.c -o CMakeFiles/__idf_WIRED.dir/wired.c.s

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.requires:

.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.requires

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.provides: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.requires
	$(MAKE) -f esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/build.make esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.provides.build
.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.provides

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.provides.build: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj


# Object files for target __idf_WIRED
__idf_WIRED_OBJECTS = \
"CMakeFiles/__idf_WIRED.dir/wired.c.obj"

# External object files for target __idf_WIRED
__idf_WIRED_EXTERNAL_OBJECTS =

esp-idf/WIRED/libWIRED.a: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj
esp-idf/WIRED/libWIRED.a: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/build.make
esp-idf/WIRED/libWIRED.a: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libWIRED.a"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && $(CMAKE_COMMAND) -P CMakeFiles/__idf_WIRED.dir/cmake_clean_target.cmake
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/__idf_WIRED.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/build: esp-idf/WIRED/libWIRED.a

.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/build

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/requires: esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/wired.c.obj.requires

.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/requires

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/clean:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED && $(CMAKE_COMMAND) -P CMakeFiles/__idf_WIRED.dir/cmake_clean.cmake
.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/clean

esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/depend:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/components/WIRED /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : esp-idf/WIRED/CMakeFiles/__idf_WIRED.dir/depend

