## Gentoo WSL

### Creating the WSL distribution

1. [Download a stage archive](https://www.gentoo.org/downloads).
2. Import a new WSL distribution.

The format for importing WSL distributions is:

```sh
wsl --import <distribution name> <distribution location> <tar location>
```

An example of the command to execute from Cygwin.

```sh
wsl --import Gentoo $(cygpath -m /cygdrive/c/WSL/Gentoo) $(cygpath -m /cygdrive/c/Users/Name/Downloads/gentoo.tar.xz)
```

### Setting up the distribution

> [!IMPORTANT]
> Ensure that you are logged in as the _root_ user for the following steps.

1. Enter the distribution. WSL logs you in as the root user for all distributions by default.

```sh
wsl -d Gentoo
```

2. Set a password for the root user.

```sh
passwd
```

3. Update the package manager.

```sh
emerge --sync
```

4. Install sudo.

> [!NOTE]
> This is required in order to perform actions with root permissions as a non-root user.

```sh
emerge --ask app-admin/sudo
```

5. Add a new user.

```sh
useradd -m -G wheel <username>`
```

6. Set a password for the new user

```sh
passwd <username>
```

7. Ensure the new user has access to root permissions after providing a valid password to `sudo`.

8. Open the `sudoers` file.

```sh
visudo
```

9. Edit the `sudoers` file and ensure the following line is present.

> [!NOTE]
> It is assumed the the new user is part of the wheel group.
> If they are not, either added the new user to the wheel group, or adjust the `sudoers` file accordingly.

```sh
%wheel ALL=(ALL) ALL
```

10. Edit locales to generate.

```sh
nano /etc/locale.gen
```

11. Generate locales.

```sh
locale-gen
```

12. Set locale.

```sh
eselect locale set <number>
```

13. Configure WSL default user login.

> [!TIP]
> In order to follow best practices, we will login as a non-root user.
> More information about WSL configuration can be found [here](https://learn.microsoft.com/en-us/windows/wsl/wsl-config).

Edit the `/etc/wsl.conf` and ensure the following lines are present.

```
[user]
default = <name of new user>
```

14. Reboot WSL from Windows shell.

```sh
wsl --shutdown
```

> [!CAUTION]
> Gentoo may override the existing `PATH` variable that is initialized by WSL.
> Fix this by editing `/etc/profile.env` and appending `:${PATH}` to the end of all `PATH` declarations.

### Setting up the distribution

> [!IMPORTANT]
> Log in as a _non-root_ user for the following steps.

1. Install a better shell.

```sh
emerge --ask app-shells/zsh
```

2. Change the default shell.

```sh
chsh -s $(which zsh)
```

3. Install relevant manual requirements.

4. Setup WSL and npiperelay.

> [!IMPORTANT]
> Some integrations make assumptions about the environment.
> For example, the ssh-agent relay assumes that the `~/.ssh` directory exists.

### Troubleshooting

#### Masked package by keyword

> [Answer](https://www.reddit.com/r/Gentoo/comments/t64ge4/how_to_unmask_this_package/)

Example error.

```sh
!!! All ebuilds that could satisfy "libpulse" have been masked.
!!! One of the following masked packages is required to complete your request:
- media-libs/libpulse-15.99.1::gentoo (masked by: ~amd64 keyword)

For more information, see the MASKED PACKAGES section in the emerge
man page or refer to the Gentoo Handbook.
```

Example solution. `/etc/portage/package.accept_keywords/zellij`

```
app-misc/zellij ~amd64
```

#### Adding an overlay

[Ebuild repositories](https://wiki.gentoo.org/wiki/Ebuild_repository) are places where you can install packages from.

The [eselect repository tool](https://wiki.gentoo.org/wiki/Eselect/Repository) helps manage them.

#### Masked by missing keyword

Example error.

```sh

```

Add the following to `/etc/portage/package.accept_keywords`.

```
app-text/sioyek **
```

#### Updating config

Run `etc-update` and then it does something...

#### Discord WSL pipe

[Official guide at andweed/presence.vim](https://github.com/andweeb/presence.nvim/wiki/Rich-Presence-in-WSL)

Make sure to setup the `discord` group and execute the relay script as root.

```sh
sudo groupadd discord
sudo usermod -a -G discord <username>
sudo ~/.config/wsl/discord-relay
```
