# zsh
Needs to configure the `ZDOTDIR` previously. Run the following commands:
```sh
echo "ZDOTDIR=~/.dotfiles/config/zsh/" >> ~/.zshenv

```
The configuration depends on a couple of plugins:
```sh
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-history-substring-search
 git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```
