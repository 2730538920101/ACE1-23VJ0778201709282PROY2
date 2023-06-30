all: pro2.asm
	dosbox -c 'ml vacas\pro2\pro2.asm' -c 'pro2.exe'

debug: pro2.asm
	dosbox -c 'ml vacas\pro2\pro2.asm' -c 'debug pro2.exe'