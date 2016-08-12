#!/usr/bin/env bash
set -e

cd server
stack install --local-bin-path ../out
cd ..

cd out
./server
