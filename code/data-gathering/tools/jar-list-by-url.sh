#!/bin/sh
curl -s --retry 10 $1 | jar t
