#! /usr/bin/env python
#
# Set up your account to have .Renviron and Rprofile.site point to your local git repo.
# Assume script is run from git local working directory.
#

import sys
import os

home = os.environ["HOME"]
dir = os.path.dirname(os.path.abspath(sys.argv[0])) # Very simple, may need to revisit
rEnviron = os.path.join(home, ".Renviron")
rProfileSite = os.path.join(home, "Rprofile.site")

if os.path.islink(rEnviron) and os.path.islink(rProfileSite): 
	print "\n    Sym links found. No changes to make.\n\n"
	sys.exit()
	
if os.path.isfile(rEnviron):
 	os.rename(rEnviron, rEnviron.org)
 	print "\n    Moved ", rEnviron, " to ", rEnviron, ".org\n"
os.symlink(os.path.join(dir, "dot-Renviron"), rEnviron)
 
if os.path.isfile(rProfileSite):
 	os.rename(rProfileSite, rProfileSite.org)
 	print "\n    Moved ", rProfileSite, " to ", rProfileSite, ".org\n"
os.symlink(os.path.join(dir, "Rprofile.site"), rProfileSite)

print "\n    ", rEnviron, " -> ", os.path.realpath(rEnviron), "\n"
print "\n    ", rProfileSite, " -> ", os.path.realpath(rProfileSite), "\n"
print "\n    Please exit R and RStudio without saving the workspace.\n"
print "    Then restart both R and RStudio and check for proper startup.\n\n"







