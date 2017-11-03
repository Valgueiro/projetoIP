CC := gcc -std=c99
RM := rm -f
MK := mkdir -p
CFLAGS := -Wall -Werror -Wconversion -Wextra
LDLIB := -lm

OUTPUTDIR := bin
LIBDIR := lib
CLIENTDIR := examples/simpleChatClient
SERVERDIR := examples/simpleChatServer

CLIENTNAME := client
SERVERNAME := server

EXT := c
INC := -I lib

CLIENTSOURCES := $(shell find $(CLIENTDIR) -type f -name *.$(EXT))
SERVERSOURCES := $(shell find $(SERVERDIR) -type f -name *.$(EXT))
LIBS := $(shell find $(LIBDIR) -type f -name *.$(EXT))

CLIENTOBJS := $(subst .$(EXT),.o,$(CLIENTSOURCES))
SERVEROBJS := $(subst .$(EXT),.o,$(SERVERSOURCES))
LIBOBJS := $(subst .$(EXT),.o,$(LIBS))

all: mkdirs buildServer buildClient clean

server: mkdirs buildServer clean runServer

client: mkdirs buildClient clean runClient

buildClient: $(LIBOBJS) $(CLIENTOBJS)
	@echo "\n  Linking $(CLIENTNAME)..."
	$(CC) -o $(OUTPUTDIR)/$(CLIENTNAME) $(LIBOBJS) $(CLIENTOBJS) $(LDLIB) $(CFLAGS)
	@echo "\n"

buildServer: $(LIBOBJS) $(SERVEROBJS)
	@echo "\n  Linking $(SERVERNAME)..."
	$(CC) -o $(OUTPUTDIR)/$(SERVERNAME) $(LIBOBJS) $(SERVEROBJS) $(LDLIB) $(CFLAGS)
	@echo "\n"

%.o : %.$(EXT)	
	$(CC) -c $< -o $@ $(INC) $(CFLAGS)

mkdirs:
	$(MK) $(OUTPUTDIR)

clean:
	@echo "  Cleaning..."
	$(RM) $(LIBOBJS) $(CLIENTOBJS) $(SERVEROBJS)

runClient:
	@echo "\n  Strating to run $(CLIENTNAME)...\n"; ./$(OUTPUTDIR)/$(CLIENTNAME)

runServer:
	@echo "\n  Strating to run $(SERVERNAME)...\n"; ./$(OUTPUTDIR)/$(SERVERNAME) 