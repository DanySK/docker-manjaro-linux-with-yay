# Manjaro Linux docker with yay installed

Running yay as root is forbidden,
so this docker has a second user called `builduser` that can run `yay`.
If you are developing a docker based on this image, you can add commands like:

```dockerfile
RUN sudo -u builduser yay -Syu --noconfirm
```

Just prefix `sudo -u builduser` to any `yay` invocation,
and you should be good to go.
