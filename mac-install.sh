#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update

# Installation definitions
brew_install()
{
  echo "\nInstalling $1..."

  if brew list $1 &>/dev/null; then 
    echo "${1} already installled 😎";
  else
    brew install $1 
  fi
}

brew_cask_install()
{
  echo "\nInstalling $1..."

  if brew info $1 | grep "/usr/local/Caskroom/${1}" &>/dev/null; then 
    echo "${1} already installled 🎯";
  else 
    brew install cask $1 
  fi
}

install_iterm()
{
  brew_cask_install "iterm2"
}

install_cowsay_and_fortune()
{
  brew_install "cowsay"
  brew_install "fortune"
  fortune | cowsay
}

install_bash()
{
  brew_install "bash"
  
  if cat /etc/shells | grep "/usr/local/bin/bash" &>/dev/null; then
   echo "/usr/local/bin/bash already added to shells 🎱"
  else
   echo /usr/local/bin/bash | sudo tee -a /etc/shells
  fi

  chsh -s /usr/local/bin/bash
}

install_git_and_vcprompt()
{
  brew_install "git"
  brew_install "vcprompt"
  git --version | cowsay
}

install_bash_profile()
{
  if [ -d "~/Code" ]; then
   echo "directory Code already exists, proceeding..."
  else
   mkdir ~/Code
  fi

  wget https://raw.githubusercontent.com/vladislavs-poznaks/dotfiles/master/.bash_profile -P ~/
}

install_vim_profile()
{
  if [ -d "~/.vim" ]; then
    echo "directory .vim already exists, proceeding..."
  else
    mkdir ~/.vim
  fi

  wget https://raw.githubusercontent.com/vladislavs-poznaks/vim-atom-dark/master/colors/atom-dark-256.vim -P ~/ 
}

install_docker_and_docker_compose()
{
  brew_cask_install "docker" 
  brew_cask_install "docker-compose"
  { docker --version && print "\n" && docker-compose --version; } | cowsay
}

install_iterm

install_cowsay_and_fortune

install_bash

install_git_and_vcprompt

install_bash_profile

install_vim_profile

brew_cask_install "phpstorm"

brew_cask_install "webtorrent"

brew_cask_install "spotify"

brew_cask_install "google-chrome" && open -a "Google Chrome" --args --make-default-browser

echo "Installation complete 💪"
