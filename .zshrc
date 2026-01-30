export PYTHONPATH="/path/to/directory/with/modules"
export PYTHONPATH="/opt/homebrew/lib/python3.11/site-packages"
export PATH=$PATH:/usr/local/bin/
export TESSDATA_PREFIX=/opt/homebrew/share/tessdata
export PATH="$PATH:/Users/athos/Library/CloudStorage/GoogleDrive-athos@kompru.com/My Drive/06 Code/Github_old/flutter/bin"
export ANDROID_SDK_ROOT=/Users/athos/Library/Android/sdk
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/20.0.2
export PATH=$JAVA_HOME/bin:$PATH

# Keystore configuration (secrets removed - add to ~/.zshrc.local)
# export KEYSTORE_PATH="/path/to/keystore.jks"
# export KEYSTORE_PASSWORD="your-password"
# export KEY_ALIAS="your-alias"
# export KEY_PASSWORD="your-password"

export PATH="/usr/local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# API Keys (secrets removed - add to ~/.zshrc.local)
# export XAI_API_KEY="your-key-here"
# export OPENAI_API_KEY="your-key-here"

# Claude Code: Enable MCP tool search for on-demand loading (10-15% token savings)
# Defers MCP tool definitions when they exceed 5% of context window
export ENABLE_TOOL_SEARCH=auto:5

# Claude Code: Extended thinking budget aliases (5-10% savings on simple tasks)
# Thinking tokens are billed as expensive output tokens
alias claude-quick='MAX_THINKING_TOKENS=5000 claude'  # Simple tasks: reads, tests, grep
alias claude-deep='MAX_THINKING_TOKENS=50000 claude'  # Complex: architecture, multi-file refactors
# Default 'claude' uses 31,999 thinking tokens (normal implementation work)

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Load local secrets (not tracked in git)
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
