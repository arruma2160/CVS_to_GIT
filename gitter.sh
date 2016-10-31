#! /bin/bash

###############################################################################################################
#  [ *] Script bash to convert CVS repository modules into Git repositories 
#       keeping the history of the repository in them. It needs at least two arguments to be passed:
#           - source argument pointing to the CVS repository containing all modules,
#           - dest argument pointing to the place where to put the new git repository.
#       This program will create inside the dest folder a new folder "<name>.git" containing the repo
#       converted from CVS. The name of this folder will be the same than the CVS module name plus ".git" 
#       appended.
#
#  [ *] Usage: 
#       ----------------------------------------------
#  ./gitter.sh -s <CVS_repo_src> -d <GIT_repo_dest> [ -h|-i <init_mod> ] 
#  
#  [ *] Arguments:
#  -s <CVS_repo_src>:   location of the CVS repository with all CVS modules of that repo
#  -d <GIT_repo_dest>:  location of the destination GIT repository, place where you want the new GIT repo.
#  -h:                  displays help.
#  -i <init_mod>:       initial of the module names to be converted
#
#  [ *] Examples of use:
#       ----------------------------------------------
#  ./gitter.sh -h
#  ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo 
#  ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo -i A
##############################################################################################################


function help ()
{
    echo 
    echo  " [ *] Usage: ./gitter.sh -s <CVS_repo_sr> -d <GIT_repo_dest> [-h|-i <init_mod>]"
    echo  " "
    echo  " -s <CVS_repo_src>:   location of the CVS repository with all CVS modules of that repo"
    echo  " -d <GIT_repo_dest>:  location of the destination GIT repository, place where you want the new GIT repo."
    echo  " -h:                  displays help."
    echo  " -i <init_mod>:       initial of the module names to be converted."
    echo  
    echo  " [ *] Examples of use:"
    echo  " ./gitter.sh -h"
    echo  " ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo "
    echo  " ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo -i A"
    echo
}


## MAIN ##

# 1. Getting arguments passed from the command line

# Argument number checks
NUMARGS=$#
if [ ${NUMARGS} -eq 0 ]; then
    help
    exit 1
fi

# Option arguments parsing
while getopts ":s:d:ih" opt; do
    case ${opt} in
       h)  help
           exit 0
           ;;
       s) SRC=${OPTARG}
           ;;
       d) DST=${OPTARG}
           ;;
       i) INT=${OPTARG}
           ;;
   esac
done

# Verification of arguments
if [ ! "${SRC}" ] || [ ! "${DST}" ]; then
    echo "[ !! *] ERROR: arguments not provided"
    help
    exit 1
fi
if [ ! -d ${SRC} ] || [ ! -d ${DST} ]; then 
    echo "[ !! *] Make sure both:"
    echo " - ${SRC}  and"
    echo " - ${DST}  exists"
    exit 1
else
    echo "[ * ] Source directory: ${SRC}"
    echo "[ * ] Dest directory:   ${SRC}"
fi
