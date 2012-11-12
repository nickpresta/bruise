#!/usr/bin/env bash

BREWROOT=$HOME/.pythonbrew/venvs

if [ ! -e $HOME/.pythonbrew/etc/bashrc ]; then
    echo "You need pythonbrew to use bruise [easy_install pythonbrew]."
fi

function bruisemake() {
    REPONAME=`basename "$PWD"`
    BRANCHNAME=`git rev-parse --abbrev-ref HEAD`
    envsuper="$REPONAME_$BRANCHNAME"
    pythonbrew venv create $envsuper
    pythonbrew venv use $envsuper
    if [ -f requirements.txt ]; then
        pip install -r requirements.txt
    fi
}

function bruise() {
    GITDIR=`git rev-parse --git-dir`
    if [ ! -d "$GITDIR" ]; then
        return
    fi

    REPONAME=`basename "$PWD"`
    BRANCHNAME=`git rev-parse --abbrev-ref HEAD`
    envbase=$REPONAME
    envsuper="$REPONAME_$BRANCHNAME"
    MYENV=""
    MYPYTHON=""

    pythons=`ls $BREWROOT`
    for p in $pythons; do
        envs=`ls $BREWROOT/$p`
        for e in $envs; do
            if [ -d $BREWROOT/$p/$envsuper ]; then
                MYENV=$envsuper
            elif [ -d $BREWROOT/$p/$envbase ]; then
                MYENV=$envbase
            fi
        done

        if [ ! -z "$MYENV" ]; then
            python=`echo $p | cut -d "-" -f 2-2`
            MYPYTHON=$python
        fi

    done

    if [ ! -z "$1" ]; then
        MYPYTHON=$python
    fi

    if [ ! -z "$MYENV" ]; then
        pythonbrew switch $MYPYTHON
        pythonbrew venv use $MYENV
        return
    else
        echo "No pythonbrew found. Type bruisemake to make one."
    fi

}

cd() {
    builtin cd $@
    GITDIR=`git rev-parse --git-dir`
    if [ -d "$GITDIR` ]; then
        bruise
    fi
}
