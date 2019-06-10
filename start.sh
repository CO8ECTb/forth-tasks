#!/bin/bash
echo "Cleaning object files" 
make clean
echo "Building ..."
make
cat stdlib.frt - | ./MyForthApp | sed 's/ *~*> *//g'
