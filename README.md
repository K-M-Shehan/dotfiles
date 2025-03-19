# My dotfiles

>This directory contains the dotfiles for my system.

## Requirements

Make sure you have the following installed on your system.

### Git
```bash
sudo apt install git
```

### Stow
```bash
sudo apt install stow
```

## Installation
Make sure that you are in the $HOME directory when you do this.

```bash
git clone https://github.com/K-M-Shehan/dotfiles.git
cd dotfiles
```

Then we will use GNU stow to create symlinks.

```bash
stow .
```
