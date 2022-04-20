The following tips are extracted from various sources, including:
- [Complete Bash Shell Scripting](https://www.udemy.com/course/complete-bash-shell-scripting-b/)
- [Flow Control - Part 1](https://linuxcommand.org/lc3_wss0080.php)
# Basic commands
## Redirection operators
- `>`: write content to file
- `>>`: append content to file

Examples:
```
$ echo "Hello" > test.txt
$ echo "World" >> test.txt
```

- `0`: input
- `1`: output
- `2`: error

Examples:
These are equivalent commands to redirect output and error logs to `log.txt`.
```
$ ls some_file.txt 1>log.txt 2>log.txt
$ ls some_file.txt 1>log.txt 2>&1
$ ls some_file.txt &>log.txt
```

## Read a file
### By opening the file
Use text editors such as `vi`, `vim`, `nano`...

Example:
```
$ vi some_file.txt
```

### Without opening the file
- `cat`: print file content to console
- `cat -n`: to see line number
- `less`: preview file content. Hit `Enter` to scroll down, `q` to quit the preview state
- `head -10`: print the first 10 lines
- `tail -10`: print the last 10 lines

Examples:
```
$ cat -n some_file.txt
$ head -10 some_file.txt
```

### With content manipulation
Use `awk`, `sed`. For examples, to print line 5-10 of `some_file.txt`:
```
$ awk 'NR>=5 && NR<=10 {print}' some_file.txt
$ sed -n '5,10p' some_file.txt
```

## Common commands
### grep
`grep` is used to search for a substring or a pattern.

The following command will print out all lines in `file1.txt` and `file2.txt` that has `a Keyword` substring:

```
$ grep "a Keyword" file1.txt file2.txt
```

Basic grep options
- `-i`: case insensitive
- `-w`: match the whole word
- `-v`: display lines _without_ the substring
- `-o`: only display matched substring, not the whole line
- `-c`: display number of matched lines
- `-r`: search in subdirectories
- `-l`: display file names only
- `-e`: multiple substrings
- `-E`: used for patterns

The following command prints out `Hello` lines from `file.txt`:
```
$ grep -E "^Hello$" file.txt
```

### cut
Like the name suggests, `cut` gives you a substring of each line in a file.

This command displays the second, third, forth, and tenth characters, if any, of every line in `some_file.txt`:
```
$ cut -c 2-4,10 some_file.txt
```

Basic cut options
- `-d`: specify the delimeter
- `-f`: get the fields separated by the default (or specified via `-d`) delimiter

### awk
`awk` is used to process text files which are organized by columns/fields. `awk` is less verbose than `cut` in most cases because we can specify additional actions to manipulate output with `awk`.

Some options:
- `-F`: specify the delimeter
- `-v var=value`: declare a variable
- `NR`: line number variable

### tr
`tr` is the abbreviation for "translate". `tr` is useful for replacing or deleting characters from the input.

```
$ tr 'a' 'b' <some_file.txt
$ tr [:upper:] [:lower:] <some_file.txt
$ tr 'a' '' <some_file.txt
```

### tee
`tee` is used to both display an output and store the output into a file. Its common usage is log creation.

```
$ ls | tee out.txt
```

- `-a`: append output to file instead of overwriting

## String manipulation commands
### Length
```
$ x="Hello"
$ echo "${#x}"
5
```

### Concat
```
$ newString=${string1}${string2}
```

### Replace
```
$ someString="one fish"
$ echo "${someString/one/two}"
two fish
```

### Slice

```
$ someString="one fish"
$ echo "${someString:2:4}"
e fi
```

## Path commands
In many cases, you need to manipulate paths to get to a destination script. The following commands are useful for such cases.
### realpath
`realpath` takes a partial path of a file, and returns its absolute path.
```
$ realpath README.md
/home/chauvu/bash-tips/REAME.md
```

### basename
`basename` takes a path to a file and returns only the file name.

```
$ basename /home/chauvu/bash-tips/REAME.md
README.md
```
If an extension is provided, `basename` strips the extension from the file name.

```
$ basename /home/chauvu/bash-tips/REAME.md .md
README
```

### dirname
Returns the directory of a file or directory.
```
$ dirname /home/chauvu/bash-tips/REAME.md
/home/chauvu/bash-tips
```



# Bash Shell
## File format
- File extension: `.sh`
- First line is almost always `#!/bin/bash`, which means that the script will be executed by the Bash shell. Run `cat /etc/shells` to see the full list of supported shells on your system.
- Remember to set execution permission for the script via `chmod u+x some_script.sh`, otherwise you'd get permissions denied error when running the script

## Variables

### User-defined variables
Users are responsible for creating and managing these variables. Their names should be `[a-zA-Z0-9_]`
```
#!/bin/bash

a="Hello"
echo "$a, World!"
```
Gotchas:
- DO NOT add any space before or after the `=` sign.
- if value contains space(s), quotes are required. Otherwise, quotes are optional.
- we can store output of a command to a variable: `currentDate=$(date)`

### Environment variables
Variables of this type are capitalized: `USER`, `HOME`,...

Tips: use default values whenever possible to avoid bugs associated with undefined variable.

```
FOO="${BAR:-someDefaultValue}"  # If variable BAR not set or null, use "someDefaultValue"
```

## Flow control
### if, elif, else
```
if commands; then
    commands
[elif commands; then
    commands...]
[else
    commands]
fi
```

Example:
```
if [ -f .bash_profile ]; then
    echo "You have a .bash_profile. Things are fine."
else
    echo "Yikes! You have no .bash_profile!"
fi
```

### Case
Very useful to extract arguments from command line.
[Example](https://github.com/ggreer/the_silver_searcher/blob/a61f1780b64266587e7bc30f0f5f71c6cca97c0f/sanitize.sh#L134-L156):
```
case opt in
    -h|--help)
        usage
        exit 0
        ;;
    *)
        echo "Unknown option: '$opt'"
        usage
        exit 1
        ;;
esac
```

### For
```
for i in word1 word2 word3; do
    echo "$i"
done
```

## Data structures
### Array
```
myEmptyArray=()
myArray=( 1 ab 2.3 )

echo "${myArray[@]}"      # display all elements
echo "${myArray[2]}"      # display the third element
echo "${myArray[-1]}"     # display the last element
echo "${myArray[*]:1:3}"  # display the first and second elements
```

To iterate through all elements of an array using a for loop:

```
for elt in ${myArray[@]}
do
  echo $elt
done
```

### Associative array
Associative arrays are similar to hashmaps, dictionaries... in other languages.

```
myDict=([dog]=4 [bird]=2)

echo "${myDict[dog]}"  # display value of key "dog"
echo "${!myDict[@]}"   # display all keys
```

## Functions
[Example](https://github.com/ggreer/the_silver_searcher/blob/a61f1780b64266587e7bc30f0f5f71c6cca97c0f/sanitize.sh):

```
AVAILABLE_SANITIZERS=(
    address
    thread
    undefined
    valgrind
)

# function definition
valid_sanitizer() {
    for san in "${AVAILABLE_SANITIZERS[@]}"; do
        if [[ "$1" == "$san" ]]; then
            return 0
        fi
    done
    return 1
}

# call the function, $opt is a variable
if valid_sanitizer "$opt"; then
    run_sanitizers+=("$opt")
else
    echo "Invalid Sanitizer: '$opt'"
    usage
    exit 1
fi

```

Tips:
- use `local`, e.g. `local x=6` to define local variable within a function and avoid poluting your script's namespace
- if a function returns something, use special var `$?` to get the returned value.


# Debugging
Common error types:
- Syntax errors
- Runtime errors

Syntax errors stop script execution.
Runtime errors don't stop script execution

If a script has a syntax error, Bash will execute it line by line until hitting the line with the syntax error.

Each command return an exit status (sometimes called exit code, return code,...) which is stored in the special variable `$?`.
- `0`: success
- non-zero exit codes 1-255: failure.
  - 127: command not found
  - 1: command failed during execution
  - 2: incorrect command usage

So, how to debug a bash script? The `set` command comes in handy.

## set

### set -n to identify syntax errors
To check a script for syntax errors without executing it, have `set -n` at the beginning of the script.

```
$ cat some_script.sh

#!/bin/bash

set -n

a=$(date
```
When we call the script, it will fail immediately with the syntax error.

### set -v to display commands
Having `set -x` at the beginning of a script allows all commands to be displayed in the output stream.

For example, if `some_script.sh` has a simple `pwd` command to display the current directory, its output would look like this:
```
$ ./some_script.sh
pwd
/home/chauvu/bash-tips
```

Or you can provide the `-v` option via CLI without having to insert this command into the script:
```
$ bash -v some_script.sh
```

### set -e to exit script on failure
Having `set -e` at the beginning of a script stops the script from executing subsequent lines once an error is encountered.

