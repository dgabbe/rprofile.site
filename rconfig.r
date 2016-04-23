# rconfig.r is the file that does the bulk of the work for customizating your R
# session.  The reason for a more complex setup is to:
#   a) All for the global environment to be cleared, but still retain the
#      customizations.  I prefer this over hidden environments.
#   b) R session initialized happens during other commands.  This file should
#      only be executed once because some commands append or create new
#      instances, when you only expect one.
# This is similar to the issues around the bash rc files.
#

my_options <- list(
  list("tab.width", 2),
  list("digits", 4),
  list("papersize", "letter"),
  list("stringsAsFactors", FALSE),
  list("defaultPackages", c(getOption("defaultPackages"),
                            "ggplot2",
                            "RColorBrewer",
                            "reshape2",
                            "scales"
                            )
  )
)

#
# General options
#
options(
  tab.width = 2,
  digits = 4,
  papersize = "letter",
  stringsAsFactors = FALSE, # Correct for now, wonder if/when it will bite me.
  defaultPackages = c(
    getOption("defaultPackages"),
    "ggplot2",
    "RColorBrewer",
    "reshape2",
    "scales"
  )
)
#
# RStudio operates a worldwide distribution system so selecting them is a
# reasonable default.  Also specify https connection.
#
local({
  r <- getOption("repos");
  r["CRAN"] <- "https://cran.rstudio.com/"
  options(repos=r)
})
#
# Warning: a hack - waiting for R 3.2.2 to be released to see how the defaults are set.
#
# For the paranoid.  R and RStudio can have different settings for CRAN https connections.  Set to https if unset.
# Reference: https://support.rstudio.com/hc/en-us/articles/206827897-Secure-Package-Downloads-for-R
#
local({
  if ( is.null(getOption("download.file.method"))) {
    os_type <- .Platform$OS.type
    if (os_type == "unix") { options(download.file.method = "libcurl")
    } else { options(download.file.method = "wininet") }
  }
})

#' Emulate bash command line prompt behavior in R console.  RStudio does display
#' the current working directory in the Console window title bar, but it is not
#' where I reflexively look.
#'
#' References:
#'    \url{http://stackoverflow.com/questions/4222476/r-display-a-time-clock-in-the-r-command-line}
#'    \url{http://stackoverflow.com/questions/25136059/how-to-show-working-directory-in-r-prompt}
#
#' Not ideal defining in base, will work on improved solution later
#'
working_dir_prompt <- function(...) {
  # There are no arguments because the callback task manager doesn't allow for
  # optional function arguments. Since you need to add a callback if you want to
  # change the behavior, it's no different than changing the variables below.
  #
  # Set the prompt to display the current working directory according to personal preferences.
  fullPath <- TRUE
  promptLen <- c(15)

  curDir <- getwd()
  if (fullPath) {
    # Mirror the behavior by my bash prompt.
    options(prompt = paste(curDir, ">\n"))
  } else {
    if (nchar(curDir) <= promptLen) {
      options(prompt = paste(curDir,"> "))
    } else {
      options(prompt = paste("...", substring(curDir, nchar(curDir) - 15), "> "))
    }
  }
  TRUE
}

#
# The code for the task callback is a copy of the function.  The global
# environment can be cleared and the prompt behavior continues to work.
#
# If you don't like how this work, it can be removed by:
#   1. getTaskCallbackNames()
#   2. Get the Task ID number that matches "working_dir_prompt"
#   3. removeTaskCallback([id])
#   4. options(prompt=paste("your string here"))
#
sink("/dev/null") # suppress output
  addTaskCallback(working_dir_prompt, data=NULL, name="working_dir_prompt")
sink()

# My fingers are used to typing bash commands so create some equivalents
cd <- setwd
pwd <- getwd
env <- utils::sessionInfo # I always forget sessionInfo

#' Title
#'
#' Not ideal defining in base, will work on improved solution later
#'
#' @param text
#'
#' @return
#' @export
#'
#' @examples
note <- function (text = "Previous command worked"){
  timestamp(prefix = "<<<<< Notes to myself >>>>>\n",
            stamp=paste(format(Sys.time(), "%d-%b-%Y (%a) %R @"), getwd(), "\n", text, sep=" "),
            suffix = "\n<<<<< Notes to myself >>>>>\n",
            quiet = TRUE)
}

if (interactive()) {
  cat("    Option StringsAsFactors set to", getOption("stringsAsFactors"), "\n")
  cat("    Option download.file.method set to", getOption("download.file.method"), "\n")
  cat(strwrap(toString(getOption("defaultPackages")), width=80,
                    initial="    Default Packages: ",
                    prefix="",
                    indent=0, exdent=nchar("    Default Packages: ")),
      sep="\n"
  )
  cat("\n", format(Sys.Date(), format = "%d-%b-%Y"),
    " Rprofile.site: ", Sys.getenv("R_PROFILE"), "loaded...\n\n"
  )
  working_dir_prompt() # Force a top level task to invoke callback
}

