DOTFILES := $(shell pwd)

.PHONY: all tmux claude

all: tmux claude

tmux: $(HOME)/.tmux.conf

claude: $(HOME)/.claude/CLAUDE.md $(HOME)/.claude/settings.local.json

$(HOME)/.tmux.conf:
	ln -sf $(DOTFILES)/tmux/.tmux.conf $@

$(HOME)/.claude/CLAUDE.md: | $(HOME)/.claude
	ln -sf $(DOTFILES)/.claude/CLAUDE.md $@

$(HOME)/.claude/settings.local.json: | $(HOME)/.claude
	ln -sf $(DOTFILES)/.claude/settings.local.json $@

$(HOME)/.claude:
	mkdir -p $@
