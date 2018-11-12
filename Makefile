GIT   := $(shell command -v git 2> /dev/null)
EMACS := $(shell command -v emacs 2> /dev/null)
CHROME := $(shell command -v google-chrome 2> /dev/null)
SPACEMACS := $(wildcard ~/.emacs.d/spacemacs.mk)
GUAKE   := $(shell command -v guake 2> /dev/null)

all:
	@echo " "
	@echo "No recipe in 'all' just yet!"
	@echo "TODO : install applications, setup dotfiles, run configurations...."

clean: unstow
	sudo apt-get remove -y google-chrome-stable emacs26
	rm -rf ~/.emacs.d

# Clean any existing and matching dotfiles, then use GNU stow to symlink all the repo files...
fresh_install: delete_existing unstow stow

restow: unstow stow

delete_existing:
	sudo chmod +x ~/.dotfiles/rm_existing_dotfiles.sh
	~/.dotfiles/rm_existing_dotfiles.sh

unstow: clone_dotfiles
	sudo chmod +x ~/.dotfiles/unstow_dotfiles.sh
	~/.dotfiles/unstow_dotfiles.sh

stow: clone_dotfiles
	sudo chmod +x ~/.dotfiles/stow_dotfiles.sh
	~/.dotfiles/stow_dotfiles.sh

clone_dotfiles:
ifndef GIT
	@git clone https://github.com/yottahawk/dotfiles.git ~/.dotfiles
else
	@echo "Git is already installed"
endif

# https://www.techinfected.net/2018/04/how-to-install-google-chrome-ubuntu-linux-mint-ppa.html
chrome:
ifndef CHROME
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt-get update
	sudo apt-get install google-chrome-stable
else
	@echo "Chrome is already installed"
endif

emacs:
ifndef EMACS
	sudo add-apt-repository -y ppa:kelleyk/emacs
	sudo apt-get update -y
	sudo apt-get install -y emacs26
else
	@echo "Emacs is already installed"
endif

spacemacs: emacs
ifndef SPACEMACS
	@echo "Installing spacemacs"
	rm -rf ~/.emacs.d
	git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	cd ~/.emacs.d && \
	git checkout -t origin/develop
else
	@echo "Spacemacs is already cloned"
endif

# https://askubuntu.com/questions/1077061/how-do-i-install-nvidia-and-cuda-drivers-into-ubuntu
nvidia:
	@echo -n "Are you sure you want to install nvidia drivers? " && read ans && [ $$ans == y ]
	sudo rm /etc/apt/sources.list.d/cuda*
	sudo apt remove nvidia-cuda-toolkit
	sudo apt remove nvidia-*
	sudo apt update
	sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
	sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
	sudo apt update
	sudo apt install nvidia-driver-410

guake:
ifndef GUAKE
	sudo apt-get install -y guake
else
	@echo "Guake is already installed"
endif
