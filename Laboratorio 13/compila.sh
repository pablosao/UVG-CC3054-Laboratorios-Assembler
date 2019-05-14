#!/bin/bash

echo "$(sudo gcc -c phys_to_virt.c)"

echo "$(sudo as -o lab13.o lab13.s gpio0_2.s -g)"

echo "$(sudo gcc -o lab13 lab13.o phys_to_virt.o)"

