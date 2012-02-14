BUNDLE = drmr.lv2
INSTALL_DIR = /usr/local/lib/lv2
CC=gcc

$(BUNDLE): manifest.ttl drmr.ttl drmr.so drmr_ui.so
	rm -rf $(BUNDLE)
	mkdir $(BUNDLE)
	cp manifest.ttl drmr.ttl drmr.so drmr_ui.so $(BUNDLE)

drmr.so: drmr.c drmr_hydrogen.c
	$(CC) -shared -fPIC -DPIC drmr.c drmr_hydrogen.c `pkg-config --cflags --libs lv2-plugin sndfile samplerate` -lexpat -lm -o drmr.so

drmr_ui.so: drmr_ui.c drmr_hydrogen.c
	$(CC) -shared -fPIC -DPIC drmr_ui.c drmr_hydrogen.c `pkg-config --cflags --libs lv2-plugin gtk+-2.0 sndfile samplerate` -lexpat -lm -o drmr_ui.so

install: $(BUNDLE)
	mkdir -p $(INSTALL_DIR)
	rm -rf $(INSTALL_DIR)/$(BUNDLE)
	cp -R $(BUNDLE) $(INSTALL_DIR)

clean:
	rm -rf $(BUNDLE) drmr.so drmr_ui.so