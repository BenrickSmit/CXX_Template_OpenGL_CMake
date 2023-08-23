#!/bin/bash

##-------------------------------------------------------------------------------------------------
## HEADER INFORMATION
##-------------------------------------------------------------------------------------------------
## This program is used to run all tests, run the application, and then run the profiler

##-------------------------------------------------------------------------------------------------
## SECTION: Base Variable Declarations
##-------------------------------------------------------------------------------------------------
GREEN=`tput setaf 10`
RED=`tput setaf 1`
BLUE=`tput setaf 33`
YELLOW=`tput setaf 11`
NC=`tput sgr0`

##-------------------------------------------------------------------------------------------------
## SECTION: Function Declarations
##-------------------------------------------------------------------------------------------------
print_color(){
	if [ "$2" == "RED" ]; then
		printf "${RED}${1}${NC}\n"
	elif [ "$2" == "YELLOW" ]; then
		printf "${YELLOW}${1}${NC}\n"
	elif [ "$2" == "BLUE" ]; then
		printf "${BLUE}${1}${NC}\n"
	elif [ "$2" == "GREEN" ]; then
		printf "${GREEN}${1}${NC}\n"
	else
		printf "$1\n"
	fi
	#print_color "Saluton!" "BLUE"
}


##-------------------------------------------------------------------------------------------------
## SECTION: PROGRAM LOGIC
##-------------------------------------------------------------------------------------------------
print_color "------------------------------------------------------------------------------" "BLUE" 
print_color "RUN TESTS" "BLUE"
print_color "------------------------------------------------------------------------------" "BLUE" 
print_color " " ""
./run_tests.sh

print_color "------------------------------------------------------------------------------" "BLUE" 
print_color "RUN APPLICATION" "BLUE"
print_color "------------------------------------------------------------------------------" "BLUE" 
print_color " " ""
./run_application.sh

print_color "------------------------------------------------------------------------------" "BLUE" 
print_color "RUN PROFILING" "BLUE"
print_color "------------------------------------------------------------------------------" "BLUE" 
print_color " " ""
./run_profile.sh

print_color "------------------------------------------------------------------------------" "BLUE" 
print_color "CREATE DOCUMENTATION" "BLUE"
print_color "------------------------------------------------------------------------------" "BLUE" 
print_color " " ""
./init_documentation.sh