bin_PROGRAMS = sampala

sampala_SOURCES = \
	sampala.vala \
	sampala-gauge.vala \
	sampala-app.vala

INCLUDES = \
	-include config.h \
	$(SAMPALA_CFLAGS) \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	-DPKGLIBDIR=\""$(pkglibdir)"\"

VALAFLAGS = \
	--vapidir=$(srcdir)/../vapi --pkg config \
	@SAMPALA_PACKAGES@

sampala_LDADD = \
	$(SAMPALA_LIBS)
