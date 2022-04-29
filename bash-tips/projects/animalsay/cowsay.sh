#!/bin/bash

# set -ex


# 2. validate text
validate_text() {
    ## validate text, must be < 500 chars
}


# 3. validate animal
validate_animal() {
    ## must be a valid animal under drawings/
}


# render complete cowsay, inputs: text, animal
render_cowsay() {
    words=$2
    render_thought_bubble ${words[@]}
    render_animal $1
}


# 4. render thought bubble function, input: text
render_thought_bubble() {

}


# 5. render animal, input: animal
render_animal() {
    ## find path to the animal's drawing

    ## display its content

}

# 1. use `read` command to take 2 inputs: $animal and $text

# then call validate_text and validate_animal
validate_text $words

validate_animal $animal

# finally, call render_cowsay
render_cowsay $animal ${words[@]}

