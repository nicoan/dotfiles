#!/bin/bash
# Run config if npm is present
if [[ ! `command -v npm` ]]; then
    # Create dir if not exists
    mkdir -p $HOME/.npm-packages

    # Set the global dir in npm
    npm config set prefix "${HOME}/.npm-packages"

    NPM_PACKAGES="${HOME}/.npm-packages"

    export PATH="$NPM_PACKAGES/bin:$PATH"

    # Unset manpath so we can inherit from /etc/manpath via the `manpath` command
    unset MANPATH # delete if you already modified MANPATH elsewhere in your config
    export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
fi

