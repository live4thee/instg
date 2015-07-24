# user needs to configure the following variables
# -------------------------------------------------------------------
BIN_FILE = foo.tar.gz
UNZIPPER = tar -C / -zxf
TARGET = install-script.bin
# -------------------------------------------------------------------

TEMPLATE = installer.sh.in
nr_script = $(shell wc -l $(TEMPLATE) | cut -d' ' -f1)
md5sum = $(shell md5sum $(BIN_FILE) | cut -d' ' -f1)

.PHONY: all clean

all: $(TARGET)

$(TARGET):
	@sed "s,@nrline@,$(nr_script),g" $(TEMPLATE) | \
		sed "s,@unzipper@,$(UNZIPPER),g" | \
		sed "s,@md5sum@,$(md5sum),g" | \
		cat - $(BIN_FILE) > $(TARGET) \
		&& { echo "Generated $(TARGET)"; chmod 0755 $(TARGET); } || $(RM) $(TARGET)

clean:
	$(RM) $(TARGET)
