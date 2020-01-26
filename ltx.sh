#! /bin/bash

current_dir=$(pwd)
build="build"
output="output"
img="img"
command=$1
latexmkrc="\$ENV{TEXINPUTS} = '.:..//:';"
default_tex="\documentclass[12pt]{article}
\newcommand{\rootdir}{..}
\input{header}
\input{metadatas}
\begin{document}
Test123456789
\end{document}"

gitignore="# Ignore everything in this directory
*
# Except this file
!.gitignore"

if [[ "$command" == "new" ]]
then
    echo $1
    echo $2
    # exit
    dir_name=$2
    mkdir -p "$current_dir/$dir_name"
    mkdir -p "$current_dir/$dir_name/$build"
    echo "$gitignore" > "$current_dir/$dir_name/$build/.gitignore"
    mkdir -p "$current_dir/$dir_name/$output"
    echo "$gitignore" > "$current_dir/$dir_name/$output/.gitignore"
    mkdir -p "$current_dir/$dir_name/$img"
    touch "$current_dir/$dir_name/$img/.gitignore"
    echo "$default_tex" > "$current_dir/$dir_name/$dir_name.tex"
    echo "$latexmkrc" > "$current_dir/$dir_name/.latexmkrc"
    cd "$dir_name" && pipenv run latexmk -g -xelatex -shell-escape -output-directory="$build/" "$dir_name.tex"
    mv "$current_dir/$dir_name/$build/$dir_name.pdf" "$current_dir/$dir_name/$output/$dir_name.pdf"
    rm "$current_dir/$dir_name/$dir_name.pdf"
    ln -s "$current_dir/$dir_name/$output/$dir_name.pdf" "$current_dir/$dir_name/$dir_name.pdf"
fi
