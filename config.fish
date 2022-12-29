starship init fish | source

set fish_greeting

# Envrionment variables
set -U fish_user_paths $PYENV_ROOT/bin
set -gx PYENV_ROOT $HOME/.pyenv
set -gx PIPX_DEFAULT_PYTHON $PYENV_ROOT/versions/3.10.5/bin/python
set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig /usr/share/pkgconfig $PKG_CONFIG_PATH
set -gx BAT_THEME "Nord"
set -gx PYTHON3_HOST_PROG "/usr/bin/python3"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx GIT_REPOS_DIR "$HOME/repos"
set -gx FISH_CONFIG "$GIT_REPOS_DIR/config-fish/config.fish"
set -gx NVIM_CONFIG "$GIT_REPOS_DIR/config-nvim"
set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"
set -gx LOCAL_BIN "$HOME/.local/bin"
set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar"
set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
set -gx _ZL_CD cd
set -gx PYTHONDONTWRITEBYTECODE 1
set -gx FZF_DEFAULT_OPTS "
  --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
  --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
"

# Secret Environment variables
source $HOME/.config/fish/env.fish

# Changes to PATH
set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH
set -gx PATH "/usr/local/go/bin" "$GOPATH/bin" "$GOROOT/bin" $PATH
set -gx PATH "$HOME/.pyenv/bin" $PATH
set -gx PATH "$HOME/.poetry/bin" $PATH
set -gx PATH "$HOME/.cargo/bin" $PATH
set -gx PATH "$HOME/.surrealdb" $PATH
set -gx PATH "$HOME/.local/share/flatpak/exports/bin" $PATH
set -gx PATH "$LOCAL_BIN" $PATH
set -gx PATH $PYENV_ROOT/bin $PATH
set -gx PATH "$HOME/.config/rofi/scripts" $PATH

# Aliases
if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end
alias gs "git status -s"
alias ra-update "curl -sL https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz \
  | gunzip -c - > $LOCAL_BIN/rust-analyzer \
  && chmod u+x $LOCAL_BIN/rust-analyzer \
  && rust-analyzer --version"
alias nr "nvim src/main.rs"
alias n "nvim ."
alias repo "git remote -v | awk 'NR==1 {print $2}' | cut -d ':' -f 2 | cut -d '.' -f 1"

. (pyenv init - | psub)
status --is-interactive; and pyenv virtualenv-init - | source
direnv hook fish | source
