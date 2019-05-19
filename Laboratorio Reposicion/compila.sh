#!/bin/bash

echo "$(sudo gcc -c phys_to_virt.c)"

echo "$(sudo as -o labRep.o labRep.s gpio0_2.s -g)"

echo "$(sudo gcc -o labRep labRep.o phys_to_virt.o)"

