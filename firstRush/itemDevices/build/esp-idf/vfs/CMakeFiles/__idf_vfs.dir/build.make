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
include esp-idf/vfs/CMakeFiles/__idf_vfs.dir/depend.make

# Include the progress variables for this target.
include esp-idf/vfs/CMakeFiles/__idf_vfs.dir/progress.make

# Include the compile flags for this target's objects.
include esp-idf/vfs/CMakeFiles/__idf_vfs.dir/flags.make

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/flags.make
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj: /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_vfs.dir/vfs.c.obj   -c /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs.c

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_vfs.dir/vfs.c.i"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs.c > CMakeFiles/__idf_vfs.dir/vfs.c.i

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_vfs.dir/vfs.c.s"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs.c -o CMakeFiles/__idf_vfs.dir/vfs.c.s

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.requires:

.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.requires

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.provides: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.requires
	$(MAKE) -f esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build.make esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.provides.build
.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.provides

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.provides.build: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj


esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/flags.make
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj: /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_uart.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj   -c /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_uart.c

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_vfs.dir/vfs_uart.c.i"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_uart.c > CMakeFiles/__idf_vfs.dir/vfs_uart.c.i

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_vfs.dir/vfs_uart.c.s"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_uart.c -o CMakeFiles/__idf_vfs.dir/vfs_uart.c.s

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.requires:

.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.requires

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.provides: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.requires
	$(MAKE) -f esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build.make esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.provides.build
.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.provides

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.provides.build: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj


esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/flags.make
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj: /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_semihost.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj   -c /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_semihost.c

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/__idf_vfs.dir/vfs_semihost.c.i"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_semihost.c > CMakeFiles/__idf_vfs.dir/vfs_semihost.c.i

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/__idf_vfs.dir/vfs_semihost.c.s"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && /home/tuttyfrutyee/.espressif/tools/xtensa-esp32-elf/esp-2020r2-8.2.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/tuttyfrutyee/esp/esp-idf/components/vfs/vfs_semihost.c -o CMakeFiles/__idf_vfs.dir/vfs_semihost.c.s

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.requires:

.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.requires

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.provides: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.requires
	$(MAKE) -f esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build.make esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.provides.build
.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.provides

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.provides.build: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj


# Object files for target __idf_vfs
__idf_vfs_OBJECTS = \
"CMakeFiles/__idf_vfs.dir/vfs.c.obj" \
"CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj" \
"CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj"

# External object files for target __idf_vfs
__idf_vfs_EXTERNAL_OBJECTS =

esp-idf/vfs/libvfs.a: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj
esp-idf/vfs/libvfs.a: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj
esp-idf/vfs/libvfs.a: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj
esp-idf/vfs/libvfs.a: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build.make
esp-idf/vfs/libvfs.a: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library libvfs.a"
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && $(CMAKE_COMMAND) -P CMakeFiles/__idf_vfs.dir/cmake_clean_target.cmake
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/__idf_vfs.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build: esp-idf/vfs/libvfs.a

.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/build

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/requires: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs.c.obj.requires
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/requires: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_uart.c.obj.requires
esp-idf/vfs/CMakeFiles/__idf_vfs.dir/requires: esp-idf/vfs/CMakeFiles/__idf_vfs.dir/vfs_semihost.c.obj.requires

.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/requires

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/clean:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs && $(CMAKE_COMMAND) -P CMakeFiles/__idf_vfs.dir/cmake_clean.cmake
.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/clean

esp-idf/vfs/CMakeFiles/__idf_vfs.dir/depend:
	cd /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices /home/tuttyfrutyee/esp/esp-idf/components/vfs /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs /home/tuttyfrutyee/Documents/BitirmeProjesi/SecondTerm/ItemDevices/backtoESP/bitirme/firstRush/itemDevices/build/esp-idf/vfs/CMakeFiles/__idf_vfs.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : esp-idf/vfs/CMakeFiles/__idf_vfs.dir/depend

