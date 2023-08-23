##=============================================================================
## CMAKE: Master/Root
##=============================================================================
## @Brief: This CMakeLists.txt sets up the entire build project, and ensures the
## proper libraries are used as required

# Get Global Project Variables
file(STRINGS "build_info/BUILD_CXX_APP_NAME.txt" STRING_PROJECT_NAME)
file(STRINGS "build_info/BUILD_CXX_APP_NAME.txt" STRING_PROJECT_VERSION)
file(STRINGS "build_info/BUILD_CXX_APP_TYPE.txt" STRING_BUILD_TYPE)
file(STRINGS "build_info/BUILD_CXX_APP_VERSION.txt" BOOL_VERBOSE_MAKEFILES)
file(STRINGS "build_info/BOOL_CREATE_TESTS.txt" BOOL_CREATE_TESTS)
file(STRINGS "build_info/BOOL_CREATE_LIBRARY.txt" BOOL_CREATE_LIBRARY)
file(STRINGS "build_info/BOOL_CREATE_EXECUTABLE.txt" BOOL_CREATE_EXECUTABLE)
file(STRINGS "build_info/BOOL_CREATE_INSTALLER.txt" BOOL_CREATE_INSTALLER)
file(STRINGS "build_info/BOOL_INDIVIDUAL_PROJECT_FILES.txt" BOOL_INDIVIDUAL_PROJECT_FILES)
file(STRINGS "build_info/BUILD_CXX_APP_STANDARD_VERSION.txt" STRING_CXX_STANDARD)
file(STRINGS "build_info/BOOL_PERFORMANCE_TEST.txt" BOOL_CREATE_PERFORMANCE_PROFILE)

file(STRINGS "build_info/BUILD_CXX_APP_STANDARD_VERSION.txt" STRING_CXX_STANDARD)
file(STRINGS "build_info/BOOL_USE_OPENGL.txt" BOOL_USE_OPENGL)

file(STRINGS "build_info/BOOL_LOG_INFORMATION.txt" BOOL_LOG_INFORMATION)


##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## SECTION: Function Declarations for use
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## @Brief: Function that will output coloured messages on different platforms
function(log_message VAR_NAME MESSAGE)
    # Ensure Colour Use
    if(WIN32)
        # Windows doesn't natively support ANSI escape codes
        set(COLOUR_RESET "")
        set(COLOUR_RED "")
        set(COLOUR_GREEN "")
        set(COLOUR_YELLOW "")        

    else()
        # ANSI escape codes for COLOUR
        set(COLOUR_RESET "\033[0m")
        set(COLOUR_RED "\033[1;31m")
        set(COLOUR_GREEN "\033[1;32m")
        set(COLOUR_YELLOW "\033[1;33m")
        #set(COLOUR_RESET "${Esc}[m")
        #set(COLOUR_RED "${Esc}[31m")
        #set(COLOUR_GREEN "${Esc}[32m")
        #set(COLOUR_YELLOW "${Esc}[33m")
    endif()

    if(VAR_NAME)
        message(STATUS "${COLOUR_GREEN} >> ${MESSAGE} << ${COLOUR_RESET}")
    endif()
endfunction()


## @Brief: Function that will print a list of files out in order, each on a 
##          different line
function(iterate_files)
    # Iterate through the list and print each value on a separate line
    foreach(value ${ARGV})
        log_message(TRUE "  + ${value}")
    endforeach()
endfunction()



#file(STRINGS "build_info/.txt" BOOL_)
##==============================================================================
## SECTION: Project Settings
##==============================================================================
log_message(BOOL_LOG_INFORMATION "Setting Main Project Settings")
# Project Settings
SET(CMAKE_VERBOSE_MAKEFILE ${BOOL_VERBOSE_MAKEFILES})
# Project Settings
cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
project(${STRING_PROJECT_NAME} LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD ${STRING_CXX_STANDARD})
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(PROJECT_VERSION ${STRING_PROJECT_VERSION})
set(CMAKE_BUILD_TYPE ${STRING_BUILD_TYPE})

# Set the Debug or Release version
if(CMAKE_BUILD_TYPE MATCHES "Debug")
    # Debug
    log_message(BOOL_LOG_INFORMATION "Build Type Set: -debug")
    set(CMAKE_BUILD_TYPE Debug)
    set(CMAKE_DEBUG_POSTFIX "-debug")
    
else()
    # Release in all other cases
    log_message(BOOL_LOG_INFORMATION "Build Type Set: -release")
    set(CMAKE_BUILD_TYPE Release)
    set(CMAKE_RELEASE_POSTFIX "-release")
endif()

# Variables
set(DEPENDENCIES_DIR ${CMAKE_SOURCE_DIR}/dependencies)
set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
set(TST_DIR ${CMAKE_SOURCE_DIR}/test)
set(INC_DIR ${CMAKE_SOURCE_DIR}/include)

## Set the required C++ Standard
set(CMAKE_CXX_STANDARD ${STRING_CXX_STANDARD})
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Enable Coloured Compilation and Linking for certain compilers
option(CMAKE_COLOR_DIAGNOSTICS ON)
option(CLICOLOR_FORCE 1)
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR 
    CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR 
    CMAKE_CXX_COMPILER_ID STREQUAL "AppleClang")
    # Not really recommended, but adding anyway.
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdiagnostics-color")
endif()


##------------------------------------------------------------------------------
## SECTION: Add the required files to source for executable creation
##------------------------------------------------------------------------------
## Add the source files to the executable
# include_directories(include)
# include_directories(dependencies)
# add_subdirectory(src)


##==============================================================================
## SECTION: Ensure Latest Libraries Available
##==============================================================================
# log_message(BOOL_LOG_INFORMATION "TODO: Add in Version Support for Latest Packages/Source Versions")
# log_message(BOOL_LOG_INFORMATION "      will probably be vcpkg.                                   ")



##=============================================================================
## SECTION: Find All Necessary Files
##=============================================================================
## @Brief: This section will find all the necessary source files using either
##         manual specification or GLOB to find things automatically.
if(${BOOL_INDIVIDUAL_PROJECT_FILES})
    log_message(BOOL_LOG_INFORMATION "Added project files manually")
    # For Tighter Build Control and to help with proper version control, specify
    # the files manually
    # List your source files explicitly
    set(SRC_FILES
        ${SRC_DIR}/main.cpp
        ${SRC_DIR}/TestingClass.cpp
        # Add more source files here
    )

    set(TST_FILES
        ${TST_DIR}/tests_main.cpp
        ${SRC_DIR}/TestingClass.cpp
    )
else()
    log_message(BOOL_LOG_INFORMATION "Saving time; Using Glob")
    # Save time: specify files with Glob!
    # Only this directory
        #file(GLOB SRC_FILES ${SRC_DIR}/*.cpp)

    # Recursively!
        log_message(BOOL_LOG_INFORMATION "Finding Source Files")
        file(GLOB_RECURSE SRC_FILES LIST_DIRECTORIES false ${SRC_DIR}/*.cpp ${SRC_DIR}/*.c ${SRC_DIR}/*.cxx)

    

    
    if(${BOOL_CREATE_TESTS})
        log_message(BOOL_LOG_INFORMATION "Also finding Test Files")
        ## Find a list of all files in the current CMake Directory
        file(GLOB_RECURSE TST_FILE_SRCS LIST_DIRECTORIES false ${INC_DIR}/*.h ${SRC_DIR}/*.h ${SRC_DIR}/*.cpp ${SRC_DIR}/*.c ${TST_DIR}/*.cpp ${TST_DIR}/*.c)


        set(TST_FILES ${TST_FILE_SRCS} ${HEADER_FILE_SOURCES} ${HEADER_SRC_FILE_SOURCES})
        list(REMOVE_DUPLICATES TST_FILE_SRCS)

        ## Remove the main.cpp from the list of files
        list(REMOVE_ITEM TST_FILES "${SRC_DIR}/main.cpp")
        list(REMOVE_ITEM TST_FILES "${SRC_DIR}/TestingClass.cpp")

    endif()

    
endif()




##==============================================================================
## SECTION: Add Extra CMake Build Projects
##==============================================================================

if(${BOOL_USE_OPENGL})
    log_message(BOOL_LOG_INFORMATION "Enabling OpenGL Programming")
    # Should OpenGL be enabled, use the appropriate libraries provided to enable
    # OpenGL use. Later will include other libraries
    # Find and link OpenGL
    log_message(BOOL_LOG_INFORMATION "Adding OpenGL")
    # Find and link OpenGL
    find_package(OpenGL REQUIRED)
    set(BUILD_SHARED_LIBS OFF)
    set(CMAKE_MODULE_PATH "")
    set(GLEW_ROOT /build/bin/)

    # Add GLEW as a subproject
    log_message(BOOL_LOG_INFORMATION "Adding GLEW")
    add_subdirectory(${DEPENDENCIES_DIR}/GLEW/build/cmake/)
    set(GLEW_INCLUDE_DIRS ${DEPENDENCIES_DIR}/GLEW/include)

    # Set GLEW_BUILD_STATIC option
    option(GLEW_BUILD_STATIC ON)

    # Useful in case the libraries and the #include <GL/glew.h> can't be found.
    find_path(GLEW_INCLUDE_DIR GL/glew.h)  
    find_library(GLEW_LIBRARY_RELEASE glew32)
    find_library(GLEW_LIBRARY_DEBUG glew32d)

    # Subdirectories
    log_message(BOOL_LOG_INFORMATION "Adding OpenGL")
    add_subdirectory(${DEPENDENCIES_DIR}/GLFW)

else()  # Vulkan?

endif()


if(${BOOL_CREATE_TESTS})
    log_message(BOOL_LOG_INFORMATION "Creating Tests                                    ")
    log_message(BOOL_LOG_INFORMATION " - Using the following Source Files:              ")
    iterate_files(${TST_FILES})

    ## Enable Testing of the Program
    enable_testing()
    
    ## Add Google-Test
    log_message(BOOL_LOG_INFORMATION "Adding GoogleTest")
    add_subdirectory(${DEPENDENCIES_DIR}/GoogleTest  EXCLUDE_FROM_ALL)
    
    ## Prevent overriding the parent project's compiler/linker settings on Windows
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    ## Add the Unit Tests - NOTE: they should start with tests_xxxx to work with
    ## Google Tests.
    #add_subdirectory(test)
    set(TEST_PROJECT_NAME "${STRING_PROJECT_NAME}-test")
    add_executable(${TEST_PROJECT_NAME} ${TST_FILES})
    ## Find the Header And Source files to test
    target_include_directories(${TEST_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/includes )
    target_include_directories(${TEST_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/src/ )
    target_include_directories(${TEST_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/test/ )

    target_link_libraries(${TEST_PROJECT_NAME} PUBLIC gtest gtest_main)
endif()


##=============================================================================
## SECTION: Create the Executable
##=============================================================================
## @Brief: This section will create the executable and link all the dependencies
if(${BOOL_CREATE_EXECUTABLE})
    log_message(BOOL_LOG_INFORMATION "Creating Executable                               ")
    log_message(BOOL_LOG_INFORMATION " - Using the following Source Files:              ")
    iterate_files(${SRC_FILES})

    # Add your main project executable
    add_executable(${STRING_PROJECT_NAME} ${SRC_FILES})

    # Link against libraries
    log_message(BOOL_LOG_INFORMATION "Linking Necessary Libraries")
    target_link_libraries(${STRING_PROJECT_NAME} PUBLIC glfw glew ${OPENGL_LIBRARIES})

    # Include directories
    log_message(BOOL_LOG_INFORMATION "Adding Include Directories")
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLFW/include)
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLEW/include)
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include)  # Add your own include directory if needed

    ## Allow for Release and Debug Versions
    if(BOOL_RELEASE_VERSION STREQUAL "Release")
        set_target_properties(${PROJECT_NAME} PROPERTIES RELEASE_POSTFIX "${CMAKE_RELEASE_POSTFIX}")
    else()
        set_target_properties(${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "${CMAKE_DEBUG_POSTFIX}")
    endif()

    ## Automatically add in threads should they be possible to be used on the 
    ## development environment
    find_package(Threads)
    if(Threads_FOUND)
        log_message(BOOL_LOG_INFORMATION " Threads Found: Enabling Them     ")
        target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
    else()
        log_message(BOOL_LOG_INFORMATION " Threads Found: Skip Enabling Them")
        target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
    endif()

endif()


##=============================================================================
## SECTION: Create the Library
##=============================================================================
## @Brief: This section will essentially be the same as the executable, but can
##         be changed to ensure the library is created suffiently for later use
if(${BOOL_CREATE_LIBRARY})
    log_message(BOOL_LOG_INFORMATION "Creating Library")
    log_message(BOOL_LOG_INFORMATION " - Using the following Source Files:              ")
    iterate_files(${SRC_FILES})

    # Add your main project executable
    add_library(${STRING_PROJECT_NAME}_lib ${SRC_FILES})

    # Link against libraries
    log_message(BOOL_LOG_INFORMATION "Linking Necessary Libraries")
    target_link_libraries(${STRING_PROJECT_NAME} PUBLIC glfw glew ${OPENGL_LIBRARIES})

    # Include directories
    log_message(BOOL_LOG_INFORMATION "Adding Include Directories")
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLFW/include)
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLEW/include)
    target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include)  # Add your own include directory if needed


    ## Automatically add in threads should they be possible to be used on the 
    ## development environment
    find_package(Threads)
    if(Threads_FOUND)
        log_message(BOOL_LOG_INFORMATION " Threads Found: Enabling Them     ")
        target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
    else()
        log_message(BOOL_LOG_INFORMATION " Threads Found: Skip Enabling Them")
        target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
    endif()
endif()


##=============================================================================
## SECTION: Create the Installer
##=============================================================================
## CPack Information if you want to create an installer
if(${BOOL_CREATE_INSTALLER})
    set(CPACK_PROJECT_NAME ${PROJECT_NAME})
    set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
    set(CPACK_VERBATIM_VARIABLES true)
    set(CPACK_PACKAGE_VERSION_MAJOR 0)
    set(CPACK_PACKAGE_VERSION_MINOR 1)
    set(CPACK_PACKAGE_VERSION_PATCH 0)
    #set(CPACK_PACKAGE_DESCRIPTION_SUMMARY )
    #set(CPACK_PACKAGE_DESCRIPTION_FILE )
    #set(CPACK_RESOURCE_FILE_WELCOME )
    set(CPACK_RESOURCE_FILE_LICENSE ../LICENSE)
    set(CPACK_RESOURCE_FILE_README ../README.md)
    include(CPack)
endif()




##==============================================================================
## SECTION: Code Profiler
##==============================================================================
## @Brief: This section of the code will profile the executable and help with
##         finding out where things have gone awry. Will use GPerf on linux 
##         environments and GPROF - which comes with GCC if available on Win32

if(${BOOL_CREATE_PERFORMANCE_PROFILE})
    # Only run this on linux, as google states it's only tested on Linux, otherwise use gprof
    if(NOT WIN32)
        # Use GPerf
        log_message(BOOL_LOG_INFORMATION "Code Profiling Library: GPerf                               ")
        log_message(BOOL_LOG_INFORMATION "  -- Linux Development Environment Found                    ")
    else()
        # Use gprof, llvm-profdata, or MSVC Performance Profiler
        
        if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
            log_message(BOOL_LOG_INFORMATION "Code Profiling Library: MSVC Performance Profiler       ")
            log_message(BOOL_LOG_INFORMATION "  -- Linux Development Environment NOT Found            ")
            set_target_properties(${BUILD_TARGET} PROPERTIES LINK_FLAGS "/PROFILE")
            
            ## This should enable you to use Visual Studio to check out the profiler, but you'll require VS
            ## and not VSCode
        elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
            log_message(BOOL_LOG_INFORMATION "Code Profiling Library: GPROF                           ")
            log_message(BOOL_LOG_INFORMATION "  -- Linux Development Environment NOT Found            ")

            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg")
            set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pg")
            set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -pg")

            ## PS: To find out what the profiled code is, use the following script
            ## gprof your_executable gmon.out > profile_output.txt
        else()
            ##CMAKE_CXX_COMPILER_ID STREQUAL "Clang"
            log_message(BOOL_LOG_INFORMATION "Code Profiling Library: llvm-profdata                   ")
            log_message(BOOL_LOG_INFORMATION "  -- Linux Development Environment NOT Found            ")

            ## PS: Should work!
            set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-instr-generate -fcoverage-mapping")

        endif()

        
        

    endif()
endif()




###############
################
# Everything below here was the master CMakeLists.txt and it works flawlessly


# Project Settings
#SET(STRING_PROJECT_NAME template_application_cxx)
#SET(CMAKE_VERBOSE_MAKEFILE OFF)

# Project Settings
#cmake_minimum_required(VERSION 3.17)
#project(${STRING_PROJECT_NAME} LANGUAGES CXX)

# Set the C++ standard
#set(CMAKE_CXX_STANDARD 20)
#set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(CMAKE_CXX_EXTENSIONS OFF)

# Variables
#set(DEPENDENCIES_DIR ${CMAKE_SOURCE_DIR}/dependencies)
#set(SRC_DIR ${CMAKE_SOURCE_DIR}/src)
#set(TST_DIR ${CMAKE_SOURCE_DIR}/test)

# Find and link OpenGL
#find_package(OpenGL REQUIRED)
#set(BUILD_SHARED_LIBS OFF)
#set(CMAKE_MODULE_PATH "")
#set(GLEW_ROOT /build/bin/)

# Add GLEW as a subproject
#add_subdirectory(${DEPENDENCIES_DIR}/GLEW/build/cmake/)
#set(GLEW_INCLUDE_DIRS ${DEPENDENCIES_DIR}/GLEW/include)

# Set GLEW_BUILD_STATIC option
#option(GLEW_BUILD_STATIC ON)

# Useful in case the libraries and the #include <GL/glew.h> can't be found.
#find_path(GLEW_INCLUDE_DIR GL/glew.h)  
#find_library(GLEW_LIBRARY_RELEASE glew32)
#find_library(GLEW_LIBRARY_DEBUG glew32d)

# Subdirectories
# add_subdirectory(${DEPENDENCIES_DIR}/GLAD)
#add_subdirectory(${DEPENDENCIES_DIR}/GLFW)

# Add your main project executable
#add_executable(${STRING_PROJECT_NAME} ${SRC_DIR}/main.cpp)

# Link against libraries
#target_link_libraries(${STRING_PROJECT_NAME} PUBLIC glfw glew ${OPENGL_LIBRARIES})

# Include directories
#target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLFW/include)
#target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${DEPENDENCIES_DIR}/GLEW/include)
#target_include_directories(${STRING_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include)  # Add your own include directory if needed


