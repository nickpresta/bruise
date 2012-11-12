**What?**
Autobruise is a sourceable shell script that lets you automatically configure pythonbrew and load a virtualenv for your tree. To install, simply _source /path/to/your/bruise.sh_ in your .bashrc (or flavour).

**How?**

Autobruise overrides the shell's *cd* command.  When you change into a directory, if a *.git* directory is found, it calls pythonbrew, attempting to load a virtualenv named either the same thing as repository_branchname or the repository directory_.

**Why?**

Ultimately, I just wanted the ability to cd into a directory, and activate my environment. No thinking required.
