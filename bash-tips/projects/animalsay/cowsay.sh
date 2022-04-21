#!/bin/bash

# set -ex

MAX_LENGTH=50

die() {
    echo $1
    exit 1
}

# 2. validate text
validate_text() {
    ## validate text, must be < 500 chars
    # if [ ${#$1} -gt 500 ]; then
    #     return 1
    # else
    #     return 0
    # fi
    return 0
}

# 3. validate animal
validate_animal() {
    ## must be a valid animal under drawings/
    ## let's check if the expected file exists under drawings
    ls drawings/${animal}.txt
    return $?
}

# render complete cowsay, inputs: text, animal
render_cowsay() {
    words=$2
    render_thought_bubble ${words[@]}
    render_animal $1
}

display_line() {
    line="| "
    words=$1
    start=$2
    end=$(($3+1))
    for word in "${words[*]:start:end}"; do
        line="$line $word"
    done
    numSpaces=$(($MAX_LENGTH-${#line}-1))
    for i in $(seq 1 $numSpaces); do
        line="$line "
    done
    line="$line |"
    echo "$line"
}


# 4. render thought bubble function, input: text
render_thought_bubble() {
    echo $(for i in $(seq 1 $MAX_LENGTH); do printf "-"; done)
    newline=true
    ## split the input text into lines with max length = 50
    ## resize thought bubble accordingly
    words=$1
    count=0
    start=0
    end=0
    for i in "${!words[@]}"; do
        word=${words[i]}
        if [ $((count+${#word})) -gt $MAX_LENGTH ]; then
            display_line ${words[@]} $start $end
            start=$end
            end=$(($start+${#word}))
            count=${#word}
        else
            ((end=end+1))
        fi
    done
    # display last line
    display_line $words $start $end
    echo $(for i in $(seq 1 $MAX_LENGTH); do printf "-"; done)
}


# 5. render animal, input: animal
render_animal() {
    ## find path to the animal's drawing
    animalFilePath="drawings/$1.txt"
    cat $animalFilePath
}

# 1. use `read` command to take 2 inputs: $animal and $text
read -p "Choose an animal: " animal
read -p "Enter its thought: " -a words
# then call validate_text and validate_animal
validate_text $words
if [ $? -ne 0 ]; then
    die "Error: You're thinking too much!"
fi

validate_animal $animal
if [ $? -ne 0 ]; then
    die "Error: Animal ${animal} not found"
fi

# then call render_cowsay
render_cowsay $animal ${words[@]}
