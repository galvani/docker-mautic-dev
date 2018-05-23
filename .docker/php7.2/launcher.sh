#!/bin/bash

echo Launchin Postfix
postfix start

echo Launching $1 $2
$1 $2
exit 1