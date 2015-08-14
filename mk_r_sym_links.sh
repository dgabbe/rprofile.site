#!/bin/sh
#
# Set up your account to have .Renviron and Rprofile.site point to your local git repo.
# Assume script is run from git local working directory.
#

dir=`pwd`
rEnviron=$HOME/.Renviron
rProfileSite=$HOME/Rprofile.site

if [[ -L $rEnviron && -L $rProfileSite ]]
then
	printf "\n    Sym links found. No changes to make.\n\n"
	exit 0
fi

if [[ -f $rEnviron ]]
then
	mv $rEnviron $rEnviron.org
	printf "\n    Moved $rEnviron to $rEnviron.org\n"
fi
ln -s "$dir"/dot-Renviron  $rEnviron

if [[ -f $rProfileSite ]]
then
	mv $rProfileSite $rProfileSite.org
	printf "\n    Moved $rProfileSite to $rProfileSite.org\n"
fi
ln -s "$dir"/Rprofile.site  $rProfileSite

printf "\n    `ls -alF $rEnviron`\n"
printf "    `ls -alF $rProfileSite`\n"
printf "\n    Please exit R and RStudio without saving the workspace.\n"
printf "    Then restart both R and RStudio and check for proper startup.\n\n"
