
# Things I'd like to add

- allow for the renaming of the computer (by default it's "ubuntu"...)

  `snap install yq` + `yq ...` to edit the cloud.cfg

- Enhance the `vim` addons installation process. The `/usr/share/vim/addons`
  folder is the correct destination, but we also need some files to make it
  all work with the vim manager (see `vim-addons` and `vim-addon-manager`).
  More or less, we install extensions and then let each user decide whether
  to enable them in their account with `vim-addons install <name>`.
  See the `vim-scripts` package as an example of how to handle such.



