#! /usr/bin/env python
#
# Undo rconfig setup. If there are any .org files, you must manually rename.
# Assume script is run from git local working directory.
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
	if os.path.islink(f["home"]):
		os.remove(f["home"])
		print"\n    ", f["home"], "removed."
		changesMade = True

for f in config_files:
  org_f = f["home"] + ".org"
  if os.path.isfile(org_f)
    os.rename(org_f, f["home"])
    print "\n    Moved ", org_f, " to ", f["home"]
    changesMade = True

if changesMade:
	print "\n    Please exit R and RStudio without saving the workspace."
	print "    Then restart both R and RStudio for removal to take effect.\n\n"
else:
	print ""







