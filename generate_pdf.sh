#!/bin/sh

for dir in */;
do 
    proper_dir=${dir%/}
    echo $PWD/$proper_dir
    shower pdf --cwd $PWD/$proper_dir
done