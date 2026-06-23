DOTFILES := $(shell pwd)

.PHONY: all tmux claude

all: tmux claude

# Link the tmux config and reload it into any running server.
# Always runs (no file target), force-links, and backs up a real file if present.
tmux:
	@if [ -e "$(HOME)/.tmux.conf" ] && [ ! -L "$(HOME)/.tmux.conf" ]; then \
		mv "$(HOME)/.tmux.conf" "$(HOME)/.tmux.conf.bak"; \
		echo "backed up existing ~/.tmux.conf -> ~/.tmux.conf.bak"; \
	fi
	ln -sf $(DOTFILES)/tmux/.tmux.conf $(HOME)/.tmux.conf
	@echo "linked ~/.tmux.conf -> $(DOTFILES)/tmux/.tmux.conf"
	@if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then \
		tmux source-file "$(HOME)/.tmux.conf" && echo "reloaded config into running tmux server"; \
	fi

claude: $(HOME)/.claude/CLAUDE.md $(HOME)/.claude/settings.local.json

$(HOME)/.claude/CLAUDE.md: | $(HOME)/.claude
	ln -sf $(DOTFILES)/.claude/CLAUDE.md $@

$(HOME)/.claude/settings.local.json: | $(HOME)/.claude
	ln -sf $(DOTFILES)/.claude/settings.local.json $@

$(HOME)/.claude:
	mkdir -p $@
