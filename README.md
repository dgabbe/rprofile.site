# rprofile.site

### Purpose and Features

The purpose of this project is to customize your R environment for R scripts and
R GUIs (RStudio) independently of your .bash files while keeping the files under
source code control. You can easily maintain the same environment across
multiple computers. The user profile, `.Rprofile`, is left available to use in
your `$HOME` directory or your project's working directory.

Review and edit `Rprofile.site` to set R's options to your preferences.

#### [13-Oct-2016](https://github.com/dgabbe/rprofile.site/commit/fc9527e31c365bb7add527c1eb06b22d64977c55) Changes
* Added .First() to attach `devtools` package if installed and running interactively. 
* Attach `dgutil` package if installed.

#### [25-Oct-2016](https://github.com/dgabbe/rprofile.site/commit/c57cadcb14c5ec8eeecb0664fa2c304687860790) Changes
This release represents a refactoring of the code.  The use of `local()`, suggests that R's lexical scoping rules
are being twisted and bent.  The purpose is to prevent the `base` environment from being modified, but that's 
`.First`'s purpose.  All code moved into `.First`.

Session details now displayed using message() for better control.

The bash prompt code was moved to the [wdprompt](https://github.com/dgabbe/wdprompt/) package.  It's optional and really 
shouldn't be cluttering up an initialization file.  Started if it's installed.

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
23-Oct-2016 ~/Rprofile.site .First() starting...

    Option StringsAsFactors:   FALSE 
    Option download.file.method:   libcurl 
    Option repos:   https://cran.rstudio.com/ 
    Option defaultPackages: datasets, utils, grDevices, graphics, stats,
        methods

23-Oct-2016 ~/Rprofile.site .First() finished...
```

If you want to remove this setup:

```
cd ~
./rprofile.site/rm_r_sym_links.py
mv Rprofile.site.org Rprofile.site # only if you had one before 
```

### Use .First() or Packages to Customize

There are plenty of examples of `.Rprofile` or `Rprofile.site` that 
include functions or more generically, R objects.  At first, I thought this was 
a great idea, but I have found better ways.  Here are some points to keep in mind:

1. When `Rprofile.site` is executed, any objects are created 
in the `base` environment unless coded otherwise.
2. Storing the objects in `.GlobalEnv` (RStudio's Environment tab displays
`Global Environment`) avoids modifying `base`, but your changes are not
permanent.  Clearing the Global Environment will delete your objects. Some
examples work around this behavior by creating a hidden environment and then
adding their objects to it.  However, RStudio's *delete all saved objects*
(![broom](./broom.png)) default is to include hidden objects.
3. Don't assume your R session is initialized only
once.  R and RStudio have slightly different behaviors.  RStudio's 
*Session->Restart R* does not clear out the Global Environment, but does run the
R [initialization 
process](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html). 
The `devtools::` functions do as well.

The idiom `option("defaultPackages" =
c(getOption("defaultPackages"), "package1", "package2""))` ends up appending
your packages each time R initializaton runs.  Since R will only load a library
once, there is no change to your environment, but it's poor technique.

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

R's package facility provides a great solution. 
Writing a package will make you a better R programer, your code will have
fewer collisions with other R code, and RStudio's deployment features will manage
the packages needed.  

Remember, loading is different from attaching packages.  Once a
package is *installed*, `install.packages()`, its functions can be called with
`package::function()` syntax.  The `library` function will attach the package to
the current evironment and make it part of the namespaces that are searched.

### More on OS X Setup Details

Probably under the heading of TL;DC are the [notes](http://dgabbe.github.io/rprofile.site) I kept as I built out an R development environment on Yosemite, OS X 10.10.x and continuing on OS X 10.11, El Capitan.  They will be edited as soon as I straighten out some brew issues;
