#! /usr/bin/env python
#
# Set up your account to have .Renviron and Rprofile.site point to your local git repo.
# Assume script is run from git local working directory.
#
# Assume if a link is found, the environment is already setup, but not 
# necessarily by this repo.
#

import sys
import os

home = os.environ["HOME"]
dir = os.path.dirname(os.path.abspath(sys.argv[0])) # Very simple, may need to revisit

# build a list of all the config files and their corresponding repo names
config_files = (
	{"home": os.path.join(home, ".Renviron"), "repo": "dot-Renviron"},
	{"home": os.path.join(home, "Rprofile.site"), "repo": "Rprofile.site"},
	)
	
changesMade = False

for f in config_files:
	if os.path.isfile(f["home"]) and not os.path.islink(f["home"]):
		os.rename(f["home"], f["home"] + ".org")
		print "\n    Moved ", f["home"], " to ", f["home"], ".org"

	if os.path.islink(f["home"]):
		print"\n    ", f["home"], " is a sym link. No changes to make."
	else:
		os.symlink(os.path.join(dir, f["repo"]), f["home"])
		changesMade = True
		print "\n    ", f["home"], " -> ", os.path.realpath(f["repo"])
		
if changesMade:
	print "\n    Please exit R and RStudio without saving the workspace."
	print "    Then restart both R and RStudio and check for proper startup.\n\n"
else:
	print ""
