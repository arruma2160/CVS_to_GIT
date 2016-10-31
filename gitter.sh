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
#  [ *] Dependencies:
#       ----------------------------------------------
#  POSIX shell - bash 4.2
#  git cvsimport
#
#  [ *] Examples of use:
#       ----------------------------------------------
#  ./gitter.sh -h
#  ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo 
#  ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo -i A
##############################################################################################################


function help ()
{
    echo  -e "\033[1;32m"
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
    echo -e "\033[0m"
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
while getopts "s:d:i:h" opt; do
    case ${opt} in
       h)  help
           exit 0
           ;;
       s) SRC=${OPTARG}
           ;;
       d) DST=${OPTARG}
           ;;
       i) INITIAL=${OPTARG}
           ;;
   esac
done

# Verification of arguments
if [ ! "${SRC}" ] || [ ! "${DST}" ]; then
    echo -e "\n\033[1;31m[ !! *] ERROR: arguments not provided\033[0m"
    help
    exit 1
fi
if [ ! -d ${SRC} ] || [ ! -d ${DST} ]; then 
    echo -e "\033[1;31m[ !! *] Make sure both:"
    echo " - ${SRC}  and"
    echo -e " - ${DST}  exists\033[0m"
    exit 1
else
    echo "[ * ] Source directory: ${SRC}"
    echo "[ * ] Dest directory:   ${DST}"
fi

# Strip last '/' in case the arguments passed to the program have them 
if [ "${SRC: -1}" == "/" ]; then
    SRC=${SRC::-1}
fi
if [ "${DST: -1}" == "/" ]; then
    DST=${DST::-1}
fi

# 2. Go accross the CVS modules all / requested (initial letter) 
if [ ! "${INITIAL}" ]; then
    MODULES=$(ls -d ${SRC}/*)
else
    MODULES=$(ls -d ${SRC}/${INITIAL}*)
fi

while read -r name; do
    ## Git repo location
    NAME_CVS=$(echo ${name} | rev | cut -d/ -f1 | rev)   # CVS module name
    NAME_GIT=$(echo ${NAME_CVS} | tr " " "_" )           # Creation of git repo name - substitution of " " for "_"
    GIT_NEW_REPO="${DST}/${NAME_GIT}"                    # Path + name for git repo
    ## CVS -> GIT
    git cvsimport -C ${GIT_NEW_REPO} -v -d ${SRC} -o origin ${NAME_CVS}
done <<<  "$MODULES"

