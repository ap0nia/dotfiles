ifeq ($(OS),Windows)
	OS_NAME = Windows
else
	OS_NAME = $(shell uname -s)

	ifeq ($(OS_NAME),Darwin)
		OS_NAME = MacOS
	else 
		ifeq ($(OS_NAME),Linux)
			OS_NAME = Linux
		else
			OS_NAME = Cygwin
		endif
	endif
endif

.PHONY: install
install:
	@stow --target=$$HOME --stow $(OS_NAME)/

refresh:
	@stow --target=$$HOME --restow $(OS_NAME)/

clean:
	@stow --target=$$HOME --delete $(OS_NAME)/
