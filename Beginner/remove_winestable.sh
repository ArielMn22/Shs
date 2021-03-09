#!/bin/bash

# Ainda estou trabalhando neste aqui

apt-get remove winehq-stable -y

add-apt-repository https://dl.winehq.org/wine-builds/ubuntu/ --remove

apt-get update

apt-get autoremove
