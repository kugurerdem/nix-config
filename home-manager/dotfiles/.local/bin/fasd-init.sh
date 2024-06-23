#/usr/bin/env bash

# Check if fasd is installed
if ! command -v $command_name &> /dev/null
then
    echo "$command_name could not be found"
    exit 1
fi

# Some initialization code
eval "$(fasd --init auto)"

# Cache the initialization
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
