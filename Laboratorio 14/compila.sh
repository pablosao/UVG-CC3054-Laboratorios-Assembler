#!/bin/bash

echo "$(sudo gcc -c phys_to_virt.c)"

echo "$(sudo as -o lab14.o lab14.s gpio0_2.s -g)"

echo "$(sudo gcc -o lab14 lab14.o phys_to_virt.o)"

