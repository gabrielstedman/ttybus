CFLAGS		+= -Wall
LDFLAGS		+= -lm
CC		?= gcc
BINARIES	 = tty_bus tty_fake tty_plug tty_attach dpipe
PREFIX		?= /usr/local

all: configure.h $(BINARIES) 

install: all
	echo Installing binaries in  $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(BINARIES) $(DESTDIR)$(PREFIX)/bin

configure.h: configure.h.in
	cat configure.h.in | sed -e "s/___SVNVERSION___/`git describe --abbrev=6 --tags`/g" > configure.h

tty_bus: tty_bus.o
	$(CC) -o tty_bus tty_bus.o $(LDFLAGS)

tty_bus.o: tty_bus.c
	$(CC) -c tty_bus.c $(CFLAGS)

tty_plug: tty_plug.o
	$(CC) -o tty_plug tty_plug.o $(LDFLAGS)

tty_plug.o: tty_plug.c
	$(CC) -c tty_plug.c $(CFLAGS)

tty_fake: tty_fake.o
	$(CC) -o tty_fake tty_fake.o $(LDFLAGS)

tty_fake.o: tty_fake.c
	$(CC) -c tty_fake.c $(CFLAGS)

tty_attach: tty_attach.o
	$(CC) -o tty_attach tty_attach.o $(LDFLAGS)

tty_attach.o: tty_attach.c
	$(CC) -c tty_attach.c $(CFLAGS)

dpipe: dpipe.o
	$(CC) -o dpipe dpipe.o $(LDFLAGS)

dpipe.o: dpipe.c
	$(CC) -c dpipe.c $(CFLAGS)

clean:
	rm -f *.o $(BINARIES) 

distclean: clean
	rm -f configure.h

