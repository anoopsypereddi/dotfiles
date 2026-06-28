DOTFILES := $(shell pwd)

.PHONY: all tmux claude zsh git

all: tmux claude zsh git

# link,src,dest: back up a real (non-symlink) dest, then force-link src -> dest.
define link
	@if [ -e "$(2)" ] && [ ! -L "$(2)" ]; then \
		mv "$(2)" "$(2).bak"; \
		echo "backed up existing $(2) -> $(2).bak"; \
	fi
	@ln -sf "$(1)" "$(2)"
	@echo "linked $(2) -> $(1)"
endef

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

zsh:
	$(call link,$(DOTFILES)/zsh/.zshrc,$(HOME)/.zshrc)
	@mkdir -p $(HOME)/.config
	$(call link,$(DOTFILES)/zsh/starship.toml,$(HOME)/.config/starship.toml)

git:
	$(call link,$(DOTFILES)/git/.gitconfig,$(HOME)/.gitconfig)
	$(call link,$(DOTFILES)/git/.gitignore_global,$(HOME)/.gitignore_global)

claude: $(HOME)/.claude/CLAUDE.md

$(HOME)/.claude/CLAUDE.md: | $(HOME)/.claude
	ln -sf $(DOTFILES)/.claude/CLAUDE.md $@

$(HOME)/.claude:
	mkdir -p $@
