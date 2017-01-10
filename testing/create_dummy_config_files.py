#! /usr/bin/env python
#
# Create dummy files for testing install
# Run after rm_r_sym_links.command
#

import os

home = os.environ["HOME"]
# dir = os.path.dirname(os.path.abspath(sys.argv[0])) # Very simple, may need to revisit

# build a list of all the config files and their corresponding repo names
config_files = (
	{"home": os.path.join(home, ".Renviron"), "repo": "dot-Renviron"},
	{"home": os.path.join(home, "Rprofile.site"), "repo": "Rprofile.site"},
	{"home": os.path.join(home, ".Renviron.org")},
	{"home": os.path.join(home, "Rprofile.site.org")}
	)

for f in config_files:
	open(f["home"], 'a').close()

