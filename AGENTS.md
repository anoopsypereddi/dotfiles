# Project agent memory

This file is the project's committed home for project-intrinsic agent knowledge: build, test, release, architecture, and sharp-edge notes that should travel with the code.

- Add durable project-specific notes here as they are discovered through real work.

## Structure & install

- Dotfiles are managed by a plain `Makefile` (no dotfile manager). `make all` symlinks each config into `$HOME`. Per-tool targets: `tmux`, `zsh`, `git`, `claude`.
- Symlinking goes through the `link` make-define (and the bespoke `tmux` target), which **backs up a real (non-symlink) file to `<dest>.bak`** before force-linking. The `tmux` target additionally reloads a running tmux server.
- Source files live under per-tool dirs (`zsh/`, `git/`, `tmux/`, `.claude/`); targets: `zsh/.zshrc`→`~/.zshrc`, `zsh/starship.toml`→`~/.config/starship.toml`, `git/.gitconfig`→`~/.gitconfig`, `git/.gitignore_global`→`~/.gitignore_global`.
- **Secrets/local overrides are untracked, never committed.** `.zshrc` sources `~/.zshrc.local` then `~/.secrets` if present. The repo `.gitignore` blocks `.env*`, `.secrets`, `*.local`, SSH private keys, `*.pem`, history files.
- **Git identity is intentionally NOT in the committed `git/.gitconfig`** (repo is shared/forkable). Identity comes from per-directory `includeIf "gitdir:~/work/"`/`~/personal/` blocks → `~/.gitconfig-work`/`~/.gitconfig-personal`.
- `.claude/settings.local.json` is machine-local by Claude Code convention; it is gitignored and NOT managed by the Makefile.
