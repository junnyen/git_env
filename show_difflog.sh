#!/bin/sh
diff1=$1
diff2=$2
git log --pretty=format:"%h - %s - %an" ${diff1}..${diff2}
