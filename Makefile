.phony: build run stow unstow

LIST=code git i3 nvim redshift ssh system terminator tmux vim zsh

make_dirs:
	@mkdir -p ~/.config/
	@mkdir -p ~/.ssh/
	@mkdir -p ~/.config/Code/User/

rm_conflicts:
	@rm -rf ~/.profile
	@rm -rf ~/.zshrc

build:
	docker build  -t dotfiles .

run: build
	docker run -v $(shell pwd):/home/jan/.dotfiles:ro --rm -it dotfiles bash


stow: make_dirs rm_conflicts
	stow -v -t ~ $(LIST)

unstow: make_dirs
	stow -v -t ~ -D $(LIST)
