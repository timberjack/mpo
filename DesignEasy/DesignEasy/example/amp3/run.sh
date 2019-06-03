#!/bin/bash
pkill DesignEasy
bash ./clear.sh
./DesignEasy 2 > log 2>&1 &
