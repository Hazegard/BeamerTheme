Folder structure:
- build/
- fonts/
- output/
- theme/
- img/
- main.tex
- part1/
    - build/
    - output/
    - img/
    - mypart1.tex


Run `make part1/mypart1.tex` to compile only your part

Run `make main.tex` to compile your main file and parts you included inside.

Use `ltx.sh` to create a new part `./ltx.sh new myPart`.

You can include subpart in your main file with `\input{part1/myfile.tex}`

Forked from: https://github.com/edasubert/beamerMaterialDesign



# Material Design theme
Material Design theme is a theme for Beamer inspired by Google's Material Design (https://material.io). It changes the layout, brings reasonable colors and provides necessary card environment. 

If you like the design of Google apps and are tired of the themes provided by Beamer, this might be just what you are looking for. 

For demonstration please see [output/example.pdf](output/example.pdf) which doubles as a quick manual. 

Easiest way to use the theme is to download the code and create your presentation by changing materialDesignExample.pdf. 

Feel free to submit any issues you find right here on github.

This theme is released under [MIT license](LICENSE). Feel free to modify or improve or whatever. 
