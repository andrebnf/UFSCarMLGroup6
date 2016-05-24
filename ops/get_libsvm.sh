#!/bin/bash

cd ./algs/svm/;

wget -O ./_tmp.zip http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+zip;

unzip -q ./_tmp.zip;

rm ./_tmp.zip;

mv ./libsvm* ./libsvm;

cd libsvm;

matlab -nodesktop -nosplash -nojvm < ../../../ops/compilesvm.m;
