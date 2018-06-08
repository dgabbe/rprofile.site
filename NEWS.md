---
title: Release Notes
---

#### [7-Jun-2018](https://github.com/dgabbe/rprofile.site/tree/2018-06-07) Changes
* Removed `desc` to packages added for interactive sessions because `usethis` layers on top of it.
* Added `header.html` and `docs/` directory so proper previews for LinkedIn media articles are generated. A GitHub repo landing page
offers no hooks to change the open graph meta tags.
* Switched to new Python installer scripts.
* Added `RSTUDIO_PANDOC=/usr/local/bin/pandoc:/Applications/RStudio.app/Contents/MacOS/pandoc` to `.Renviron` 
to pandoc erroring out creating an HTML preview for Readme.md files with badges.


#### [4-Feb-2018](https://github.com/dgabbe/rprofile.site/tree/2018-02-04) Changes
* Added `desc` to packages added for interactive sessions
* `usethis` loaded after `devtools`

#### [27-Jan-2018](https://github.com/dgabbe/rprofile.site/tree/2018-01-27) Changes
* Added `usethis` to packages added for interactive sessions
* Moved `devtools` and `dgutils` under interactive sessions

#### [18-Aug-2017](https://github.com/dgabbe/rprofile.site/tree/2017-08-18) Changes
* Added Shiny options to speed development:
    + `shiny.launch.browser = TRUE`
    + `shiny.autoreload = TRUE`
    + `shiny.autoreload.interval = 2000 # in milliseconds`

#### [15-Aug-2017](https://github.com/dgabbe/rprofile.site/tree/2017-08-15) Changes
* Packages attached w/`require` now generate no message if the package is not installed
to make R initialization as quiet as possible for non-critical pieces. 
* Added a section on fixing errors after an R minor release upgrade.  Yes, 
monkeys do fall out of trees.

#### [10-Jan-2017](https://github.com/dgabbe/rprofile.site/tree/2017-01-10) Changes
* `.py` files renamed to `.command` so scripts can be doubled clicked or run from the command line.

#### [7-Nov-2016](https://github.com/dgabbe/rprofile.site/tree/2016-11-07) Changes
* `init_wd()` now no longer required before `start_wd()`.

#### [25-Oct-2016](https://github.com/dgabbe/rprofile.site/tree/2016-10-25) Changes
* This release represents a refactoring of the code.  The use of `local()`,
suggests that R's lexical scoping rules are being twisted and bent.  The purpose
is to prevent the `base` environment from being modified, but that's `.First`'s
purpose.  All code moved into `.First`.
* Session details now displayed using message() for better control.
* The bash prompt code was moved to the
[wdprompt](https://github.com/dgabbe/wdprompt/) package.  It's optional and
really shouldn't be cluttering up an initialization file.  Started if it's
installed.

#### [13-Oct-2016](https://github.com/dgabbe/rprofile.site/tree/2016-10-13) Changes
* Added .First() to attach `devtools` package if installed and running interactively.
* Attach `devtools` package if installed and interactive.
* Attach `dgutils` package if installed.
