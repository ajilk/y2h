# Utility functions helpful for debugging 

# Prints $1 in red 
debug() { printf "%b" "\e[1;31m$1\e[0m"; }