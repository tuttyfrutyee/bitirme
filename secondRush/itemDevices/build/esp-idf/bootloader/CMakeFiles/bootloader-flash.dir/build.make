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

# Utility rule file for bootloader-flash.

# Include the progress variables for this target.
include esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/progress.make

esp-idf/bootloader/CMakeFiles/bootloader-flash:
	cd /home/tuttyfrutyee/esp/esp-idf/components/bootloader && /usr/bin/cmake -D IDF_PATH="/home/tuttyfrutyee/esp/esp-idf" -D ESPTOOLPY="/home/tuttyfrutyee/.espressif/python_env/idf4.3_py3.6_env/bin/python /home/tuttyfrutyee/esp/esp-idf/components/esptool_py/esptool/esptool.py --chip esp32" -D ESPTOOL_ARGS="--before=default_reset --after=hard_reset write_flash @bootloader-flash_args" -D WORKING_DIRECTORY="/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build" -P /home/tuttyfrutyee/esp/esp-idf/components/esptool_py/run_esptool.cmake

bootloader-flash: esp-idf/bootloader/CMakeFiles/bootloader-flash
bootloader-flash: esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/build.make

.PHONY : bootloader-flash

# Rule to build all files generated by this target.
esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/build: bootloader-flash

.PHONY : esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/build

esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/clean:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/bootloader && $(CMAKE_COMMAND) -P CMakeFiles/bootloader-flash.dir/cmake_clean.cmake
.PHONY : esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/clean

esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/depend:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices /home/tuttyfrutyee/esp/esp-idf/components/bootloader /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/bootloader /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/secondRush/itemDevices/build/esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : esp-idf/bootloader/CMakeFiles/bootloader-flash.dir/depend

