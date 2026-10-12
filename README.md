# lawrence-berry.github.io

One-line bootstrap for my `setup-*` dotfiles. Served by GitHub Pages as
`https://lawrence-berry.github.io/setup`.

## Use it

```sh
(curl -fsSL https://lawrence-berry.github.io/setup || wget -qO- https://lawrence-berry.github.io/setup) | sh
```

(macOS has no `wget`; fresh Ubuntu may have no `curl` — the `||` covers both.)

It installs git if missing, clones or updates each repo into `~/Projects/util`,
then runs each one's `install.sh`. Safe to re-run.

## What it installs

| Repo | | Platform |
|---|---|---|
| [setup-mac](https://github.com/lawrence-berry/setup-mac) | Homebrew + the CLI toolchain | macOS |
| [setup-iterm](https://github.com/lawrence-berry/setup-iterm) | iTerm hotkey window, Karabiner, shell integration | macOS |
| [setup-shell](https://github.com/lawrence-berry/setup-shell) | shell aliases | all |
| [setup-git](https://github.com/lawrence-berry/setup-git) | git aliases + config | all |
| [setup-ssh](https://github.com/lawrence-berry/setup-ssh) | ssh config defaults | all |
| [setup-ruby](https://github.com/lawrence-berry/setup-ruby) | Ruby dotfiles | all |
| [setup-secrets](https://github.com/lawrence-berry/setup-secrets) | `~/.secrets` scaffold | all |

The macOS-only repos run first (so brew and the tools exist); Linux gets only
the cross-platform ones.
