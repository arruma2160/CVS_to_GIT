#! /bin/bash

###############################################################################################################
#  [ *] Script bash to convert CVS repository modules: 
#       ----------------------------------------------
#  into Git repositories keeping the history of the 
#  repository.
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
    echo  " Usage: ./gitter.sh -s <CVS_repo_sr> -d <GIT_repo_dest> [-h|-i <init_mod>"
    echo  " "
    echo  " -s <CVS_repo_src>:   location of the CVS repository with all CVS modules of that repo"
    echo  " -d <GIT_repo_dest>:  location of the destination GIT repository, place where you want the new GIT repo."
    echo  " -h:                  displays help."
    echo  " -i <init_mod>:       initial of the module names to be converted."
    echo  " [ *] Examples of use:"
    echo  " ./gitter.sh -h"
    echo  " ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo "
    echo  " ./gitter.sh -s ~/CVS_repo -d ~/GIT_repo -i A"
    echo
}


