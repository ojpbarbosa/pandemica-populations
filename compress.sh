#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [city]"
    exit 1
fi

city="$1"
baseDir="./data/simulation/populations"
directory="$baseDir/$city"

if [ ! -d "$directory" ]; then
    echo "$directory not found, trying current directory..."
    baseDir="."
    directory="$baseDir/$city"
    if [ ! -d "$directory" ]; then
        echo "$directory not found."
        exit 1
    fi
fi

index=0
count=0
files=()

pushd "$directory" > /dev/null

for f in fragment-*.json; do
    count=$((count + 1))
    files+=("$f")

    if [ $count -eq 4 ]; then
        popd > /dev/null
        tar -czf "$baseDir/$city/fragment-$index.tar.gz" -C "$directory" "${files[@]}"
        pushd "$directory" > /dev/null
        files=()
        count=0
        index=$((index + 1))
    fi
done

if [ $count -gt 0 ]; then
    popd > /dev/null
    tar -czf "$baseDir/$city/fragment-$index.tar.gz" -C "$directory" "${files[@]}"
    pushd "$directory" > /dev/null
fi

popd > /dev/null
