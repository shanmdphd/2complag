all: run up

run:
	nmfe75 A4401.mod A4401.lst

up:
	git add . ; git commit -m "update: run"; git push
