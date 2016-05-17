# rprofile.site
## Purpose and Installation

The purpose of this project is to customize your R environment for R scripts and R GUIs (RStudio) independently of your .bash files while keeping the files under source code control. You can easily maintain the same environment across multiple computers. The user profile, `.Rprofile`, is left available to use in your `$HOME` directory or your project's working directory. 

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
13-May-2016  Rprofile.site:  ~/Rprofile.site starting...

    Option StringsAsFactors:   FALSE 
    Option download.file.method:   libcurl 
    Option repos:   https://cran.rstudio.com/ 
    Option defaultPackages: datasets, utils, grDevices, graphics, stats,
                            methods

 13-May-2016  Rprofile.site:  ~/Rprofile.site finished...
```

 If you want to remove this setup:

```
cd ~
./rprofile.site/rm_r_sym_links.py
mv Rprofile.site.org Rprofile.site # only if you had one before 
```

## Reasons Not to Add R Functions and Objects

There are plenty of examples of `.Rprofile` or `Rprofile.site` files that include functions or more generically, R objects.  At first, I thought this was a great idea, but my experiences have shown me there are problems with this approach and pointed the way to a better implementation.

The first reason is that when `Rprofile.site` is processed, objects created are stored in the `base` environment.  Good software hygiene practices dictate that the core system remain unmodified.

The second reason is that if you store the objects in `.GlobalEnv` (RStudio's Environment tab displays `Global Environment`) to avoid modifying `base`, your changes are not permanent.  Clear the Global Environment, and your objects are trashed as well.  Some examples work around this behavior by creating a hidden environment and then adding their objects to it.  However, RStudio's *delete all saved objects* (broom.png) default is to include hidden objects.  So this seems like a step forward, but it's brittle because there is no easy way to recover them.

Finally, the third reason is you can't assume your R session is initialized only once.  R and RStudio have slightly different behaviors.  RStudio's Session->Restart R does not clear out the Global Environment, but does run the R initialization process as documented in https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html.  The result is that taskCallBacks can be duplicated.  And `option("defaultPackages" = c(getOption("defaultPackages"), "package1", "package2""))` ends up appending your packages each time R initializaton runs.

R provides a great solution for all of the above with its package facility.  Writing a package will make you a better R programer and make your code have fewer collisions with other R code loaded.  Making function names available to R, loading, is different from attaching them to current environment.  Once a package is _installed_, its functions can be called with `package::function()`.  The `library` function will attach the package to the current evironment and make it part of the namespaces that are searched.

## More on OS X Setup Details

Probably under the heading of TL;DC are the [notes](http://dgabbe.github.io/rprofile.site) I kept as I built out an R development environment on Yosemite, OS X 10.10.x and continuing on OS X 10.11, El Capitan.  They will be edited as soon as I straighten out some brew issues;
