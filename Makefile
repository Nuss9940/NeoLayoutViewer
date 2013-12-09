#
# Makefile
#

# Tray icon flag. Possible values:
# none, tray (for gnome 2.x) , indicator (for gnome 3.x)
ICON = indicator

# Build type. Possible values:
# debug, release
BUILDTYPE = release

BINNAME = neo_layout_viewer
BINDIR = bin

# Path prefix for 'make install'
PREFIX = /usr/local
APPNAME = NeoLayoutViewer

#########################################################

EXEC_PREFIX = $(PREFIX)
DATADIR = $(PREFIX)/share

VALAC = valac --thread --Xcc="-lm" --Xcc="-DXK_TECHNICAL" --Xcc="-DXK_PUBLISHING" --Xcc="-DXK_APL" -D $(ICON) 
VAPIDIR = --vapidir=vapi/ 

# Source files 
SRC = src/main.vala src/unique.vala src/neo-window.vala src/key-overlay.vala src/config-manager.vala src/keybinding-manager.vala csrc/keysend.c csrc/checkModifier.c

# Asset files
ASSET_FILES=$(wildcard assets/**/*.png)

#test for valac version, workaround for Arch Linux bug
ifeq ($(wildcard /usr/include/gee-0.8),)
	GEEVERSION=1.0
else
	GEEVERSION=0.8
endif

# packges 
PKGS = --pkg x11 --pkg keysym --pkg gtk+-3.0 --pkg gee-$(GEEVERSION) --pkg gdk-x11-3.0 --pkg posix  --pkg unique-3.0 

# Add some args if tray icon is demanded.
ifeq ($(ICON),tray)
SRC += src/tray.vala
endif
ifeq ($(ICON),indicator)
SRC += src/indicator.vala
PKGS += --pkg appindicator3-0.1
endif
 
# compiler options for a debug build
VALAC_DEBUG_OPTS = -g --save-temps
#VALAC_DEBUG_OPTS =  -g 
# compiler options for a debug build
VALAC_RELEASE_OPTS = -X -O2 --disable-assert 

 
# the 'all' target build a debug build
all: $(BINDIR) info bulid_$(BUILDTYPE)

# the 'release' target builds a release build
# you might want disable asserts also
release: $(BINDIR) clean bulid_release

info:
	@echo ""
	@echo "Buildtype: $(BUILDTYPE)"
	@echo "Trayicon: $(ICON)"
	@echo ""
	@echo "Notes:"
	@echo "Edit the variable ICON in the head of Makefile"
	@echo "if you want enable a tray icon."
	@echo ""
	@echo "Edit the variabe BUILDTYPE in the head of Makefile"
	@echo "to switch build type to 'release'."
	@echo ""
	@echo ""

$(BINDIR):
	@mkdir -p $(BINDIR)
	@ln -s ../assets bin/assets

bulid_debug:
#	@echo $(VALAC) $(VAPIDIR) $(VALAC_DEBUG_OPTS) $(SRC) -o $(BINDIR)/$(BINNAME) $(PKGS) $(CC_INCLUDES)
	$(VALAC) $(VAPIDIR) $(VALAC_DEBUG_OPTS) $(SRC) -o $(BINDIR)/$(BINNAME) $(PKGS) $(CC_INCLUDES)

bulid_release:
	$(VALAC) $(VAPIDIR) $(VALAC_RELEASE_OPTS) $(SRC) -o $(BINDIR)/$(BINNAME) $(PKGS) $(CC_INCLUDES)

install: all
	install -d $(EXEC_PREFIX)/bin
	install -D -m 0755 $(BINDIR)/$(BINNAME) $(EXEC_PREFIX)/bin
	$(foreach ASSET_FILE,$(ASSET_FILES), install -D -m 0644 $(ASSET_FILE) $(DATADIR)/$(APPNAME)/$(ASSET_FILE) ; )

uninstall:
	@rm -v $(EXEC_PREFIX)/bin/$(BINNAME)
	@rm -v -r $(DATADIR)/$(APPNAME)

# clean all build files
clean:
	@rm -v -fr *~ *.c src/*.c src/*~ 

