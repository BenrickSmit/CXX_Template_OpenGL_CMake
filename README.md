# GeneralCXXTemplate
A basic C++ Project template file structure created to help me with sideprojects. It allows the easy creation of libraries, profiling information, tests, and more.

# Description
This is a general C++ template project structure. It comes with automated
documentation, automated testing (using gtest), automated profiling (using google automated profiling tools) and CMake
to help with the execution. A copy of the executable will be present in the <code>bin/</code> folder.

NOTE: To change any information about the application, use the .env file. The application will then propagate these changes throughout the application as necessary.

<code>generate.sh</code> is used to run all of the application frameworks such as profiling, tess, etc
<code>generate_build_info</code> is used to create the build_info directory later used by CMake and Docker. 
PS: If any documents are missing, try torun generate_build_info.sh first, and this should clear up most of the issues, probably.

<code>docker-run.sh</code> is the file to run the image using only the Dockerfile(_CXX)
<code>docker-compose_run.sh</code> is the file used to run the image using docker-compose.yml - this is the preferred way.

<code>init_documentation.sh</code> is used to create the documentation automatically
<code>run_all.sh</code> is used to run all tests and program execution, as well as to create the necessary documentation and profile information
<code>run_application.sh</code> is used to run only the application
<code>run_tests.sh</code> is used to run only the tests
<code>run_profile.sh</code> is used to run only the profiler

<code>build_info</code> contains the build_name, build_version, and build_cxx_standard text files.
<code>build_name</code> contains the project name. 
<code>build_version</code> contains the project version number. 
<code>build_cxx_standard</code> contains the CXX standard used, it's default is 11

Find the project [here](https://github.com/BenrickSmit/GeneralCXXTemplate), if you did not find this project on my github.

# Requirements
This will be the requirements for the application to successfully run, here, however, it only requires Docker to be installed, for now.

# Features
This states the current features provided by the program

# Future Changes
This gives information on the future changes that are likely to be implemented.

# How to Run
This gives information on how to normally run the CXX program

# How to Run Unit Tests
This gives information on how to normally run the CXX program's tests

# Key Dependencies
This gives information on the dependencies required by the CXX program

# How to contribute
This states how others can contribute to the project, and what styles to use

# License
This project is under the following [licence](LICENSE).

