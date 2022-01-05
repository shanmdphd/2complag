all: run up

run:
	nmfe75 A4403.mod A4403.lst

up:
	git add . ; git commit -m "update: run"; git push
