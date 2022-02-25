# dotzsh
My zsh configuration.

## Installation
1. Clone the repo
    ```
    git clone git://github.com/isaacault/dotzsh.git ~/.zsh
    ```

2. Add the symlinks
    ```
    ln -s ~/.vim/zshrc ~/.zshrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    ln -s ~/.vim/ideavimrc ~/.ideavimrc
    ```

3. Install plugins
    ```
    cd ~/.zsh
    git submodule update --init --recursive
    ```
