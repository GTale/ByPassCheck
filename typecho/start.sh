#!/usr/bin/env bash
clear
wget -o typecho.tar.gz https://github.com/typecho/typecho/releases/download/v1.1-17.10.30-release/1.1.17.10.30.-release.tar.gz
mkdir typecho && tar -xvf typecho.tar.gz -C typecho && cd typecho
