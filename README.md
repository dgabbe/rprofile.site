# rprofile.site

### Purpose and Features

The purpose of this project is to customize your R environment for R scripts and
R GUIs (RStudio) independently of your .bash files while keeping the files under
source code control. You can easily maintain the same environment across
multiple computers. The user profile, `.Rprofile`, is left available to use in
your `$HOME` directory or your project's working directory.

Review and edit `Rprofile.site` to set R's options to your preferences.

#### [13-Oct-2016] New in https://github.com/dgabbe/rprofile.site/commit/fc9527e31c365bb7add527c1eb06b22d64977c55
* Added .First() to attach `devtools` package if running interactively and already installed. 
* Attach `dgutil` package if installed.

#### [17-Oct-2016] New in 
This release represents a refactoring of the code.  The use of `local()`, suggests that R's lexical scoping rules
are being twisted and bent.  The purpose is to prevent the `base` environment from being modified, but that's 
`.First`'s purpose.  All code moved into `.First`.

The bash prompt code is was moved to the [wdprompt](https://github.com/dgabbe/wdprompt/) package.  It's optional and really 
shouldn't be cluttering up an initialization file.  Rprofile.site does start it if it's installed.

### Installation

Follow these steps to install:
```
mkdir ~/rprofile.site
cd ~/rprofile.site
git init
git clone https://github.com/dgabbe/rprofile.site.git
./make_r_sym_links.py
```

If there is an existing `Rprofile.site`, it is renamed to `Rprofile.site.org`. Now edit `Rprofile.site` to make sure it has the options set to your preferences.  Startup R or RStudio to verify a message like the one below is displayed:
```
13-Oct-2016  Rprofile.site:  ~/Rprofile.site starting...

    Option StringsAsFactors:   FALSE 
    Option download.file.method:   libcurl 
    Option repos:   https://cran.rstudio.com/ 
    Option defaultPackages: datasets, utils, grDevices, graphics, stats,
        methods

 13-Oct-2016  Rprofile.site:  ~/Rprofile.site finished...
```

 If you want to remove this setup:

```
cd ~
./rprofile.site/rm_r_sym_links.py
mv Rprofile.site.org Rprofile.site # only if you had one before 
```

### Reasons Not to Add R Functions and Objects

There are plenty of examples of `.Rprofile` or `Rprofile.site` files that 
include functions or more generically, R objects.  At first, I thought this was 
a great idea, but problems with this approach have pointed the way to a better
implementation.

The first reason is that when `Rprofile.site` is processed, objects created are
stored in the `base` environment.  Good software hygiene practices dictate that
the core system remain unmodified.

The second reason is that if you store the objects in `.GlobalEnv` (RStudio's
Environment tab displays `Global Environment`) to avoid modifying `base`, your
changes are not permanent.  Clear the Global Environment, and your objects are
deleted as well.  Some examples work around this behavior by creating a hidden
environment and then adding their objects to it.  However, RStudio's *delete all
saved objects* (![broom](./broom.png)) default is to include hidden objects.  So
this seems like a step forward, but it's brittle because there is no easy way to
recover them.

Finally, the third reason is you can't assume your R session is initialized only
once.  R and RStudio have slightly different behaviors.  RStudio's
*Session->Restart R* does not clear out the Global Environment, but does run the
R [initialization
process](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html).  
The `devtools::` functions do as well.
`option("defaultPackages" = c(getOption("defaultPackages"), "package1",
"package2""))` ends up appending your packages each time R initializaton runs.

If you still want default packages loaded, try this:
```
.First <- function() {
  require("package1", quietly = TRUE)
  require("package2", quietly = TRUE)
}

```
If you use `library()`, instead of `require()`, any error will stop the initialization 
process.  It should take more than a missing package to bring the initialization
to a halt.

REVISE THIS PARAGRAPH:
R provides a great solution for all of the above with its package facility. 
Writing a package will make you a better R programer and make your code have
fewer collisions with other R code loaded.  Making function names available to
R, loading, is different from attaching them to current environment.  Once a
package is *installed*, `install.packages()`, its functions can be called with
`package::function()` syntax.  The `library` function will attach the package to
the current evironment and make it part of the namespaces that are searched.

### More on OS X Setup Details

Probably under the heading of TL;DC are the [notes](http://dgabbe.github.io/rprofile.site) I kept as I built out an R development environment on Yosemite, OS X 10.10.x and continuing on OS X 10.11, El Capitan.  They will be edited as soon as I straighten out some brew issues;
