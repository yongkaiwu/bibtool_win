# *** makefile ****************************************************************
#  
#  This file is part of BibTool.
#  It is distributed under the GNU General Public License.
#  See the file COPYING for details.
#  
#  (c) 1996-2020 Gerd Neugebauer
#  
#  Net: gene@gerd-neugebauer.de
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# *****************************************************************************

#  Look also in the file include/bibtool/config.h for additional
#  configuration parameters.
#  Read the file INSTALL for explanation.
# =============================================================================

#  This is the generic makefile for BibTool.
#  Especially it can be used on Unix systems and as a basis for
#  systems not directly mentioned in the distribution.

# =============================================================================
#  Configuration Section
# =============================================================================
# 
prefix	    = /usr/local
exec_prefix = ${prefix}
datadir     = ${datarootdir}
datarootdir = ${prefix}/share

# -------------------------------------------------------
#  Prefix to be prepended to all installation directories.
#  Thus it is possible to install in a different location
#  as the final location. This seems useful for building
#  RPMs on Linux.

INSTALLPREFIX =

# -------------------------------------------------------
#  Destination directory for make install
#  This is usually a directory where public executables
#  are installed.

BINDIR     = ${exec_prefix}/bin

# -------------------------------------------------------
#  Destination directory for make install.man
#  This is usually a directory where public man pages
#  are installed.
#  Additionally name the section of the man pages to use.
#  This should be 1 (user commands), l (local), or n (new)
# 
MANDIR     = ${datarootdir}/man
MANSECT    = 1

# -------------------------------------------------------
#  Destination directory for make install.lib
#  This is usually a directory where public shared files
#  are installed plus a final BibTool.
# 

LIBDIR     = ${exec_prefix}/lib/BibTool

#-------------------------------------------------------
# Destination directory for make install.include
# This is usually a directory where public include files
# are installed plus a final `bibtool'.
# Note: The include files may contain system specific
#	code and may not be shared amoung architectures.
#

INCLUDEDIR = ${prefix}/include/bibtool

# -------------------------------------------------------
#  Name the C compiler
# 

CC         = gcc

# -------------------------------------------------------
#  CFLAGS are the flags for the C compiler.
#  For debugging it should be -g. 
#  For final version you can try to activate 
#  the optimizer with -O or -O2 or whatever
#  BEWARE: Some C compiler produce erroneous code if the
# 	   optimizer is turned on.
# 

CFLAGS     = -g -O2
# CFLAGS = -O
#  GNU C
# CFLAGS = -g -Wall
# CFLAGS = -g -Wall -pedantic -Wpointer-arith -Wshadow -Wcast-align

##-------------------------------------------------------
## C_INCLUDE are the flags for the C compiler pointing it
## to the location of the header files. Usually this
## does not need any modifications.
##

C_INCLUDE     = -Iinclude

# -------------------------------------------------------
#  EXT is the optional extension of the final executable.
#  Various operating systems have their own ideas about
#  that.
# 

EXT        =

# -------------------------------------------------------
#  Extension of object files
# 

OBJ        = .o

# -------------------------------------------------------
#		  Name some programs
# 
# -------------------------------------------------------
#  MV is a command to move certain files maybe to other
#  directories or drives. Only plain files are moved.
#

MV		= mv

# -------------------------------------------------------
#  RM is a command to remove certain files. It should not
#  be confused when trying to remove non-existent files.
#  Only plain files are removed this way.
#

RM		= rm -rf

# -------------------------------------------------------
#  MAKEDEPEND is a program to find dependencies for
#  .c and .h files.
#  Not present on MS-DOS, Atari, Amiga, Next

MAKEDEPEND	= makedepend
# MAKEDPEND	= gcc -MM

# -------------------------------------------------------
#  INSTALL is a program to properly install some files.
#  Maybe cp should also do this job (on UNIX)

INSTALL		= /usr/bin/install -c

# -------------------------------------------------------
#  INSTALL_DATA is a command to install some data files.
# 

INSTALL_DATA	= ${INSTALL} -m 644

# -------------------------------------------------------
#  INSTALL_DIR is a command to create a directory if not
#  already existent. If your install does not support the 
#  -d option you can try to use mkdir instead.

INSTALL_DIR	= ./mkdirchain

# -------------------------------------------------------
# The ranlib program or : for nothing.
#
RANLIB		= ranlib

# -------------------------------------------------------
# The ar program invocation to add files to the archive.
#
AR		= ar r

# -------------------------------------------------------
# PERL is the complete path to an existing perl executable.
# Perl 4.* and Perl 5.* are both ok.
#
PERL		= @PERL@

# -------------------------------------------------------
#  LINT is a program to check the C source for problems.
#  

LINT		= lint

# -------------------------------------------------------
#  CXREF is a C cross reference program.
#  

CXREF		= cxref

# -------------------------------------------------------
#  Defines to support (non-ANSI) C compilers.
#  For Solaris 2 you may have to define HAVE_STRING_H
#  For some versions of Cygwin you may have to define
#  STD_HEADERS.
#  For ANSI C compilers they should be empty.
#  Mostly needed for the GNU regex library.
#  Include
#  -DHAVE_STRING_H	if your C compiler has string.h
# 			(e.g. on Solaris 2)
# 			Maybe you have to enlarge the
# 			include search path.
#  -DREGEX_MALLOC	if you have NO alloca() library
# 			function
#  -DHAVE_ALLOCA_H	if you need alloca.h for alloca()
#  -DSTDC_HEADERS       if gcc reports conflicting types
#                       for malloc (on Linux?)
# 

NON_ANSI_DEFS = -DHAVE_CONFIG_H

# -------------------------------------------------------
#  GNU Regular Expression Library support.
#  First of all the (sub)directory containing the 
#  necessary files (excluding trailing slash).
# 
#  This directory is contained in the BibTool distribution.
#  I have tried newer versions of this library without
#  positive results. (Try it if you don't believe me:-)
# 
REGEX_DIR  = regex-0.12
# 

REGEX_DEF  = -DREGEX -I$(REGEX_DIR) -I..

REGEX      = regex$(OBJ)

# -------------------------------------------------------
#  Kpathsea Library support.
#  This library provides means to specify a search path 
#  with recursive search in subdirectories.
#  The library is NOT contained in the BibTool distribution.
#  This routines are expected to work with Kpathsea-2.6 or
#  above.
# 
#  See the file INSTALL for details.
# 
#  Kpathsea is not known to work yet on anything else but
#  Unix platforms.
#  This item is purely experimental.
#  Maybe you are better off not trying it!
# 
#  The value of KPATHSEA_DIR is the directory containing
#  the distribution of kpathsea. I.e. the directory
#  containing the subdirectory kpathsea.
#  The value of KPATHSEA is the name of the kpathsea library.
#  if kpathsea should not be used then it has to be empty.
#  The value of KPATHSEA_DEF are the additional flags for the
#  C compiler. It should arrange things that the macro
#  KPATHSEA is defined and the directory beneath kpathsea
#  is in the include search path.

KPATHSEA_DIR    = 
KPATHSEA        = 
KPATHSEA_STATIC = 
KPATHSEA_DEF    = 

# -------------------------------------------------------
#  Default search paths
#  The values are NULL or a string containing a colon
#  separated list of directories.
#  DON'T FORGET THE CURRENT DIRECTORY!
# 
#  The character ENV_SEP separates the directories in
#  environment search paths.
# 

BIBINPUTS_DEFAULT = NULL
BIBTOOL_DEFAULT   = \".:$(LIBDIR)\"
ENV_SEP           = \":\"

# -------------------------------------------------------
#  Declare the file naming conventions.
#  FILE_TYPES contains optionally a macro definition
#  determining the file naming conventions.
#  -DMS-DOS denotes MSDOG-like file names. (Also for Atari)
#  -DAMIGA denotes the Amiga file names.
#  The default (empty) are UN*X-like file names.
# 
#  DIR_SEP is the directory-file separator.

FILE_TYPES    = 
DIR_SEP       = /

# =============================================================================
#  End of Configuration Section
# =============================================================================

MAKEFILE      = makefile

SHELL	      = /bin/sh

RSC_DEF	      = -DRSC_BIBINPUTS_DEFAULT=$(BIBINPUTS_DEFAULT)	\
		-DRSC_BIBTOOL_DEFAULT=$(BIBTOOL_DEFAULT)	\
		-DENV_SEP=$(ENV_SEP)

DONT_LINK     = -c
LINK_TO       = -o
STANDALONE    = -DSTANDALONE

C_FLAGS	      = $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) $(C_INCLUDE) $(FILE_TYPES)
LD_FLAGS      = $(LDFLAGS)

CFILES	      = main.c				\
		$(CLIBFILES)
CLIBFILES     = check.c				\
		crossref.c			\
		database.c			\
		entry.c				\
		error.c				\
		expand.c			\
		init.c				\
		io.c				\
		key.c				\
		macros.c			\
		names.c				\
		parse.c				\
		print.c				\
		pxfile.c			\
		record.c			\
		rewrite.c			\
		rsc.c				\
		s_parse.c			\
		symbols.c			\
		stack.c				\
		sbuffer.c			\
		tex_aux.c			\
		tex_read.c			\
		type.c				\
		version.c			\
		wordlist.c

HPATH	      = include${DIR_SEP}bibtool${DIR_SEP}
HFILES	      = config.h			\
		${HPATH}check.h			\
		${HPATH}crossref.h		\
		${HPATH}database.h		\
		${HPATH}bibtool.h		\
		${HPATH}config.h		\
		${HPATH}entry.h			\
		${HPATH}error.h			\
		${HPATH}expand.h		\
		${HPATH}general.h		\
		${HPATH}init.h			\
		${HPATH}io.h			\
		${HPATH}key.h			\
		${HPATH}keynode.h		\
		${HPATH}macros.h		\
		${HPATH}names.h			\
		${HPATH}parse.h			\
		${HPATH}print.h			\
		${HPATH}pxfile.h		\
		${HPATH}regex.h			\
		${HPATH}record.h		\
		${HPATH}resource.h		\
		${HPATH}rewrite.h		\
		${HPATH}rsc.h			\
		${HPATH}s_parse.h		\
		${HPATH}sbuffer.h		\
		${HPATH}stack.h			\
		${HPATH}symbols.h		\
		${HPATH}tex_aux.h		\
		${HPATH}tex_read.h		\
		${HPATH}type.h			\
		${HPATH}version.h		\
		${HPATH}wordlist.h

OFILES	      = main$(OBJ)			\
		$(OLIBFILES)
OLIBFILES     = check$(OBJ)			\
		crossref$(OBJ)			\
		database$(OBJ)			\
		entry$(OBJ)			\
		error$(OBJ)			\
		expand$(OBJ)			\
		init$(OBJ)			\
		io$(OBJ)			\
		key$(OBJ)			\
		macros$(OBJ)			\
		names$(OBJ)			\
		parse$(OBJ)			\
		print$(OBJ)			\
		pxfile$(OBJ)			\
		record$(OBJ)			\
		rewrite$(OBJ)			\
		rsc$(OBJ)			\
		s_parse$(OBJ)			\
		symbols$(OBJ)			\
		stack$(OBJ)			\
		sbuffer$(OBJ)			\
		tex_aux$(OBJ)			\
		tex_read$(OBJ)			\
		type$(OBJ)			\
		version$(OBJ)			\
		wordlist$(OBJ)

DOCFILES      = doc$(DIR_SEP)bibtool.1		\
		doc$(DIR_SEP)bibtool.tex	\
		doc$(DIR_SEP)bibtool.bib	\
		doc$(DIR_SEP)bibtool.ist	\
		doc$(DIR_SEP)bibtool-doc.sty	\
		doc$(DIR_SEP)ref_card.tex	\
		doc$(DIR_SEP)Makefile		\
		doc$(DIR_SEP)config.tex		\
		doc$(DIR_SEP)c_main.tex		\
		doc$(DIR_SEP)c_lib.tex		\
		doc$(DIR_SEP)c.tex		\
		doc$(DIR_SEP)c_get.pl		\
		doc$(DIR_SEP)make_version.pl

LIBFILES      = lib$(DIR_SEP)biblatex.rsc	\
		lib$(DIR_SEP)braces.rsc		\
		lib$(DIR_SEP)check_y.rsc	\
		lib$(DIR_SEP)default.rsc	\
		lib$(DIR_SEP)field.rsc		\
		lib$(DIR_SEP)improve.rsc	\
		lib$(DIR_SEP)iso2tex.rsc	\
		lib$(DIR_SEP)keep_bibtex.rsc	\
		lib$(DIR_SEP)keep_biblatex.rsc	\
		lib$(DIR_SEP)month.rsc		\
		lib$(DIR_SEP)opt.rsc		\
		lib$(DIR_SEP)sort_fld.rsc	\
		lib$(DIR_SEP)tex_def.rsc

PROGFILES     = Perl$(DIR_SEP)bibtool.pl	\
		Tcl$(DIR_SEP)bibtool.tcl
ETCFILES      = README.md			\
		install.tex			\
		COPYING				\
		Changes.tex			\
		makefile.unx			\
		makefile.dos			\
		makefile.ata			\
		makefile.ami			\
		ToDo				\
		THANKS				\
		pxfile.man			\
		sbuffer.man			\
		$(MSDOS_targets)		\
		$(PROGFILES)

DISTFILES     = $(ETCFILES)			\
		$(CFILES)			\
		$(HFILES)			\
		$(LIBFILES)			\
		$(DOCFILES)			\
		$(REGEX_DIR)
# -----------------------------------------------------------------------------
#  The main target
# -----------------------------------------------------------------------------

default all: bibtool$(EXT)

bibtool$(EXT): $(OFILES) $(REGEX) $(KPATHSEA_STATIC)
	$(CC) $(LD_FLAGS) $(C_FLAGS) $(LINK_TO) $@ $(OFILES) $(REGEX) $(KPATHSEA) $(KPATHSEA_STATIC)

tex_read$(EXT): tex_read.c
	$(CC) $(LD_FLAGS) $(C_FLAGS) $(STANDALONE) tex_read.c $(LINK_TO) tex_read$(EXT)

tex_aux$(OBJ): tex_aux.c
	$(CC) $(C_FLAGS) $(REGEX_DEF) $(DONT_LINK) tex_aux.c -o tex_aux$(OBJ)

main$(OBJ): main.c
	$(CC) $(C_FLAGS) $(REGEX_DEF) $(KPATHSEA_DEF) $(DONT_LINK) main.c

init$(OBJ): init.c
	$(CC) $(C_FLAGS) $(KPATHSEA_DEF) $(DONT_LINK) init.c

parse$(OBJ): parse.c
	$(CC) $(C_FLAGS) $(KPATHSEA_DEF) $(DONT_LINK) parse.c -o parse$(OBJ)

rewrite$(OBJ): rewrite.c
	$(CC) $(C_FLAGS) $(REGEX_DEF) $(DONT_LINK) rewrite.c -o rewrite$(OBJ)

rsc$(OBJ): rsc.c
	$(CC) $(C_FLAGS) $(RSC_DEF) $(DONT_LINK) rsc.c -o rsc$(OBJ)

.c$(OBJ):
	$(CC) $(C_FLAGS) $(DONT_LINK) -c $< -o $@

# __________________________________________________________________
#  Include the makefile into the dependencies to force updates
#  when the makefile is modified.

$(OFILES): $(MAKEFILE)

# __________________________________________________________________
#  Targets from the GNU Regular Expression Library.

regex$(OBJ): $(REGEX_DIR)$(DIR_SEP)regex.c $(MAKEFILE)
	$(CC) $(C_FLAGS) -I$(REGEX_DIR) -I.. $(NON_ANSI_DEFS) $(REGEX_DIR)$(DIR_SEP)regex.c $(DONT_LINK) -o $@


bibtcl:
	cd BibTcl && $(MAKE) $(MFLAGS)

# -----------------------------------------------------------------------------
#  General development targets
# -----------------------------------------------------------------------------

CLEAN_TARGETS	= *$(OBJ) xref *.bak core #* *~ 

clean mostlyclean:
	-cd doc && $(MAKE) $(MFLAGS) clean
	-cd test && $(MAKE) $(MFLAGS) clean
	-cd BibTcl && $(MAKE) $(MFLAGS) clean
	-$(RM) $(CLEAN_TARGETS)

veryclean distclean realclean extraclean: clean
	-cd doc && $(MAKE) $(MFLAGS) distclean
	-cd test && $(MAKE) $(MFLAGS) distclean
	-$(RM) bibtool config.cache config.status config.log makefile

doc: d-o-c
d-o-c:
	cd doc; $(MAKE) $(MFLAGS) DIR_SEP=$(DIR_SEP)

info:

test check: Test
	@echo
Test:
	(cd test; $(MAKE))

libbibtool.a: $(OLIBFILES)
	$(AR) $@ $(OLIBFILES) regex.o
	$(RANLIB) $@

depend:
	-$(MAKEDEPEND) -fmakefile -DMAKEDEPEND -Iinclude $(CFILES)

install: install.bin install.lib

install.bin install-exec: bibtool$(EXT)
	-$(INSTALL_DIR) $(INSTALLPREFIX)$(BINDIR)
	$(INSTALL) bibtool$(EXT) $(INSTALLPREFIX)$(BINDIR)

INSTALL_LIB_FILES = lib$(DIR_SEP)*.*

install.lib install-data: 
	-$(INSTALL_DIR) $(INSTALLPREFIX)$(LIBDIR)
	for lib in $(INSTALL_LIB_FILES); do	\
	  $(INSTALL_DATA) $$lib $(INSTALLPREFIX)$(LIBDIR);	\
	done

INSTALL_INCLUDE_FILES = $(HFILES)

install.include install-include: 
	-$(INSTALL_DIR) $(INSTALLPREFIX)$(INCLUDEDIR)
	for inc in $(INSTALL_INCLUDE_FILES); do	\
	  $(INSTALL_DATA) $$inc $(INSTALLPREFIX)$(INCLUDEDIR);	\
	done

install.man install-man: 
	-$(INSTALL_DIR) $(INSTALLPREFIX)$(MANDIR)$(DIR_SEP)man$(MANSECT)
	$(INSTALL) doc$(DIR_SEP)bibtool.1 \
		$(INSTALLPREFIX)$(MANDIR)$(DIR_SEP)man$(MANSECT)$(DIR_SEP)bibtool.$(MANSECT)

uninstall: uninstall.bin uninstall.lib

uninstall.bin uninstall-exec:
	-$(RM) $(INSTALLPREFIX)$(BINDIR)$(DIR_SEP)bibtool$(EXT)

uninstall.lib uninstall-data:
	-$(RM) $(INSTALLPREFIX)$(LIBDIR)

uninstall.include uninstall-include:
	-$(RM) $(INSTALLPREFIX)$(INCLUDEDIR)

uninstall.man uninstall-man:
	-$(RM) $(INSTALLPREFIX)$(MANDIR)$(DIR_SEP)man$(MANSECT)$(DIR_SEP)bibtool.$(MANSECT)

status:
	@echo $(LIBDIR)

# =============================================================================
# DO NOT DELETE THIS LINE -- make depend depends on it.
