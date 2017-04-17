# CVS to GIT 

# Description<br />
Script bash to convert CVS repository modules into Git repositories <br />
keeping the history of the repository in them. It needs at least two arguments to be passed:<br />
    - source argument pointing to the CVS repository containing all modules,<br />
    - dest argument pointing to the place where to put the new git repository.<br />
This program will create inside the dest folder a new folder "<name>.git" containing the repo<br />
converted from CVS. The name of this folder will be the same than the CVS module name plus ".git" <br />
appended.<br />

# Usage: <br />
./gitter.sh -s <CVS_repo_src> -d <GIT_repo_dest> [ -h|-i <init_mod> ] <br />

Arguments:<br />
-s <CVS_repo_src>:   location of the CVS repository with all CVS modules of that repo<br />
-d <GIT_repo_dest>:  location of the destination GIT repository, place where you want the new GIT repo.<br />
-h:                  displays help.<br />
-i <init_mod>:       initial of the module names to be converted<br />

# Dependencies:<br />
POSIX shell - bash 4.2<br />
git cvsimport<br />

# Examples of use:<br />
./gitter.sh -h<br />
./gitter.sh -s ~/CVS_repo -d ~/GIT_repo<br />
./gitter.sh -s ~/CVS_repo -d ~/GIT_repo -i A<br />

