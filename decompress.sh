#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [city]"
    exit 1
fi

city="$1"
directory="./data/simulation/populations/$city"

if [ ! -d "$directory" ]; then
    echo "$directory not found, trying $city..."
    directory="./$city"
    if [ ! -d "$directory" ]; then
        echo "Directory '$directory' not found."
        exit 1
    fi
fi

for f in "$directory"/*.tar.gz; do
    tar -xzf "$f" -C "$directory"
done
