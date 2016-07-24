#! /bin/bash

clone_dot_repo() {
 [ -d $HOME/dot ] && rm -rf $HOME/dot
 git clone https://github.com/grafoo/dot $HOME/dot
}

setup_dot_dirs() {
 declare -ra _dot_dirs=( \
  "config" \
 )

 local _dot_dir
 for _dot_dir in ${_dot_dirs[@]}
 do
  [ -d "$HOME/.${_dot_dir}" ] && rm -rf "$HOME/.${_dot_dir}"
  mkdir "$HOME/.${_dot_dir}"
 done
}

setup_dot_files() {
 declare -ra dot_files=( \
  "asoundrc" \
  "bash_profile" \
  "bashrc" \
  "config/user-dirs.conf" \
  "emacs" \
  "gitconfig" \
  "jackdrc" \
  "profile" \
  "psqlrc" \
  "tmux.conf" \
  "vimrc" \
  "xinitrc" \
 )

 local _dot_file
 for _dot_file in ${dot_files[@]}
 do
  [ -f "$HOME/.${_dot_file}" ] && rm -rf "$HOME/.${_dot_file}"
  ln -s "$HOME/dot/${_dot_file}" "$HOME/.${_dot_file}"
 done
}

# install packages
sudo xbps-install -Su
sudo xbps-install -S xorg-minimal xfce4 vim git dejavu-fonts-ttf setxkbmap xf86-video-intel

# setup dot files
clone_dot_repo && setup_dot_dirs && setup_dot_files
sudo ln -s /etc/sv/dbus /var/service/
sudo xbps-install -S chromium
#sudo xbps-install -S xf86-input-synaptics #mabye not needed
sudo xbps-install -S xinput
sudo xbps-install -S xrdb
sudo xbps-install -S rfkill
