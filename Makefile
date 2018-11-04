all:

# Clean any existing and matching dotfiles, then use GNU stow to symlink all the repo files...
fresh_dotfiles: delete_existing unstow stow

delete_existing:
	@./rm_existing_dotfiles.sh

unstow:
	@./unstow_dotfiles.sh

stow:
	@./stow_dotfiles.sh
