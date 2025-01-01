# .dotfiles
This project setups all my system configurations with a single command. Works by creating symlinks in `~/.config`. 

## Dependencies
Run the following command to install dependencies (from the project root directory):

<details><summary>Arch</summary>

    ```
    sudo pacman -S - < dependencies.txt
    ```
</details>

<details><summary>Ubuntu</summary>

    ```
    sudo apt install $(cat dependencies.txt)
    ```

</details>

## Usage
Use the `dot` script to install, uninstall or reload configurations.
```
$ ./dot
Usage: ./dot {install|uninstall|reload}
```
