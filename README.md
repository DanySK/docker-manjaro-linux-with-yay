# Manjaro Linux docker with `yay`

Running yay as root is forbidden,
so this docker has a second user called `builduser` that can run `yay`,
and shadowed the actual `yay` command.

Namely, now, `yay-pure` is an actual call to yay,
while the command `yay` actually calls `sudo -u builduser yay-pure`.

Moreover, for those using this image as a base for other images,
I provide a builtin, Docker-friendly command `yay-install`,
which translates to `sudo -u builduser yay-pure --noconfirm --needed -Syu "@"`,
and cleans packages once finished.
The idea here is to simplify extension;
in fact, a derived image may simply have a docker file such as:

```dockerfile
RUN yay-install intellij-idea-community-edition
```

And live happily.

For those who need yay as-is,
just prefix `sudo -u builduser` to any `yay-pure` invocation.
If the alias does not suit you, just

```dockerfile
RUN mv /usr/bin/yay-pure /usr/bin/yay
RUN rm /usr/bin/yay-install
```
