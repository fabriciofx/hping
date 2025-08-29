# Executable
bin_PROGRAMS = hping3

# Source files
hping3_SOURCES = adbuf.c antigetopt.c apd.c apdutils.c ars.c arsglue.c \
	binding.c cksum.c datafiller.c datahandler.c display_ipopt.c gethostname.c \
	getifname.c getlhs.c getusec.c hex.c hstring.c if_promisc.c interface.c \
	ip_opt_build.c libpcap_stuff.c listen.c logicmp.c main.c memlock.c \
	memlockall.c memstr.c memunlock.c memunlockall.c opensockraw.c \
	parseoptions.c random.c rapd.c relid.c resolve.c rtt.c sbignum-tables.c \
	sbignum.c scan.c script.c send.c sendhcmp.c sendicmp.c sendip_handler.c \
	sendip.c sendrawip.c sendtcp.c sendudp.c signal.c sockopt.c split.c \
	statistics.c strlcpy.c usage.c version.c waitpacket.c

# Flags
AM_CFLAGS = @PCAP_CFLAGS@ @TCL_CFLAGS@
hping3_LDADD = @PCAP_LIBS@ @TCL_LIBS@

# Regras automáticas de dependência
depend:
	@echo "Making dependences..."
	@$(CC) $(AM_CFLAGS) -MM $(hping3_SOURCES) > .depend || true

-include .depend

# Limpeza
clean-local:
	rm -rf hping3
