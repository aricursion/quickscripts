#!/bin/bash

if ! [ -x "$(command -v zathura)" ]; then
    echo "Please download zathura and try again";
    echo "https://pwmt.org/projects/zathura/";
    exit
fi

if [ -x "$(command -v nvim)" ]; then
    EDITOR=nvim;
elif [ -x "$(command -v vim)" ]; then
    EDITOR=vim;
elif [ -x "$(command -v nano)" ]; then
    EDITOR=nano;
elif [ -x "$(command -v emacs)" ]; then
    EDITOR=emacs;
else
    echo "Editor not found";
    exit;
fi

# for now assume zathura

pdf_count=`ls *.pdf 2>/dev/null | wc -l`

if [ $pdf_count -gt 1 ]; then 
    echo "Too many pdfs can't pick one";
    exit;
elif [ $pdf_count == 0 ]; then
    echo "No pdf found, attempting to open tex file anyway";
else
    zathura *.pdf &
fi

tex_count=`ls *.tex 2>/dev/null | wc -l`

if [ $tex_count -gt 1 ]; then
    echo "Too many tex files can't pick one";
    exit;
elif [ $tex_count == 0 ]; then
    echo "No tex file found";
    exit
else
    $EDITOR *.tex;
fi

