#!/bin/sh

GIT="/usr/bin/env git"
CURRENT=`$GIT symbolic-ref --short -q HEAD`
PAGES="gh-pages"
HTML="_build/html"
FORMATS="slides"

make $FORMATS && \
    $GIT checkout $PAGES && \
    cp -r $HTML/* . && \
    find . -type f -exec sed -i 's/static/static/g' {} \; && \
    find . -type f -exec sed -i 's/source/source/g' {} \; && \
    find . -type f -exec sed -i 's/images/images/g' {} \; && \
    rm -rf static && mv static static && \
    rm -rf sources && mv sources sources && \
    rm -rf images && mv images images && \
    rm -rf _* && \
    $GIT add . --all && \
    $GIT commit -a -m "Update content for GH pages." && \
    $GIT push origin +$PAGES;

$GIT checkout $CURRENT
