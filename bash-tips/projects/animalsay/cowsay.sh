#!/bin/bash

set -exv

# 1. use `read` command to take 2 inputs: $animal and $text
# then call validate_text and validate_animal
# then call render_cowsay


# 2. validate text
validate_text() {
## validate text, must be < 500 chars

}

# 3. validate animal
validate_animal(){
## must be a valid animal under drawings/

}

# render complete cowsay, inputs: text, animal
render_cowsay() {
    render_thought_bubble $text
    render_animal $animal
}


# 4. render thought bubble function, input: text
render_thought_bubble() {
    ## split the input text into lines with max length = 50

    ## resize thought bubble accordingly

}


# 5. render animal, input: animal
render_animal() {
    ## find path to the animal's drawing

}


