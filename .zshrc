# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions sudo zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

plugins=(zsh-autosuggestions sudo zsh-syntax-highlighting)



# on startup

eval $(thefuck --alias)
colorscript -r

# Terminal Shortcuts

alias srz="source ~/.zshrc"

alias s="cmatrix -s"

alias l="tree -L 2"

function ct {
	clear
  colorscript -r
	cd
}

function c { 
  clear
  colorscript -r
}

function li () {
	ls -lah --group-directories-first $1
}

# Git Schortcuts

alias gs="git status"

alias ga="git add ."

alias gp="git push"

alias gcm="git checkout master"

alias config="/usr/bin/git --git-dir=/home/jirayu/Projects/Private/dotfiles --work-tree=/home/jirayu"

function gc () {
    git commit -m $1
}

function gb () {
    git checkout -b $1
}

function gcb () {
    git checkout $1
}

function gmb () {
    git merge $1
}

function gmb () {
    git branch -d $1
}

# Directory Shortcuts

alias KSBG="cd ~/Nextcloud/Bildung/KSBG"

alias TechLab="cd ~/Nextcloud/TechLab"

alias Layout="cd ~/Nextcloud/Layouts"

alias Nextcloud="cd ~/Nextcloud"

# Latex

function Theoryen {
  mkdir fig
  mkdir pdf
  cp ~/Nextcloud/Layouts/Theory_Notebook_English/letterfonts.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_English/macros.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_English/preamble.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_English/Theory.tex .
  mv Theory.tex main.tex
}

function Theoryde {
  mkdir fig
  mkdir pdf
  cp ~/Nextcloud/Layouts/Theory_Notebook_German/letterfonts.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_German/macros.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_German/preamble.tex .
  cp ~/Nextcloud/Layouts/Theory_Notebook_German/Theory.tex .
  mv Theory.tex main.tex
}

alias Facharbeit="cp ~/Nextcloud/Layouts/Facharbeit/Facharbeit.tex ."

alias Layout="cp ~/Nextcloud/Layouts/Layout/layout.tex ."

function graph () {
  cp ~/Nextcloud/Layouts/Graph/template.py fig/$1.py
  echo "plt.savefig($1.pdf)" >> fig/$1.py
  nvim fig/$1.py --wait
  rm fig/$1.py
}

function importpdf () {

  # Define a function to sanitize filenames
  sanitize_filename() {
    echo $1 | tr -c '[:alnum:]' '_'
  }

  # Rename Word documents, PowerPoint presentations, and PDF files
  for file in *.docx *.pptx *.pdf; do
    if [[ -e $file ]]; then
      new_name=$(sanitize_filename $file)
        mv "$file" "$new_name"
    fi
  done

  # Convert Word documents and PowerPoint presentations to PDF
  for file in *.docx *.pptx; do
    if [[ -e $file ]]; then
      pdf_name="${file%.*}.pdf"
      pandoc "$file" -o "$pdf_name"
    fi
  done

  # Move PDF files to the specified folder
  for pdf_file in *.pdf; do
    if [[ -e $pdf_file ]]; then
      mv "$pdf_file" pdf/
    fi
  done

  # Import PDF files into LaTeX file (assuming LaTeX file is named main.tex)

  for pdf_file in "$pdf_folder"/*.pdf; do
    if [[ -e $pdf_file ]]; then
      # Check if the PDF file is already imported in the LaTeX file
      grep -q "$(basename "$pdf_file")" main.tex
      if [ $? -ne 0 ]; then
        # If not imported, add the import statement to LaTeX file
        echo "\\includepdf[pages=-]{$pdf_file}" >> main.tex
      fi
    fi
  done

}

function importimg {
  for image_file in *.png *.jpg; do
    if [[ -e $image_file ]]; then
      # Check if the image file is already imported in the LaTeX file
      grep -q "$(basename "$image_file")" main.tex
      if [ $? -ne 0 ]; then
        # If not imported, add the import statement to LaTeX file
        echo "\\includegraphics[width=\\textwidth]{$(sanitize_filename "$image_file")}" >> main.tex
      fi
    fi
  done
}

# Zathura

function z () {
  zathura $1 &>/dev/null &
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
