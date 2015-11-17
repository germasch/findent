findent: indents/beautifies/converts Fortran sources

 - findent supports Fortran-2008
 - findent can convert from fixed form to free form
 - binaries for Unix and Windows (findent and findent.exe respectively)
 - wrapper for processing one or more files in one call available
      for Unix and Windows (wfindent and wfindent.bat respectively)
 - (g)vim users: findent can act as a plug-in to format your
      edit file with the '=' command
 - gui frontent available in a separate package: jfindent

Linux users: the tar ball contains a static linked executable, 
             probably you can use that:
             
             download findent-x.y.tgz
	     $ tar xf findent-x.y.tgz
	     $ cd findent-x.y
	     $ cd bin
	     $ install findent wfindent $HOME/bin
	 or: $ sudo install findent wfindent /usr/local/bin

	     If the pre compiled version does not work,
	     ( try: $ ./findent -h )
	     use the recipe under Unix-Linux users.

Unix-Linux users: 
    prerequisites: flex, bison, gnumake, g++
    make findent and wfindent:    
             download findent-x.y.tgz
             $ tar xf findent-x.y.z.tgz
             $ cd findent-x.y
	     $ ./configure --prefix=<Your installation directory, default /usr/local>
	     $ make clean
             $ make
	     $ make install

    if necessary, remake the Windows executable (requires package mingw32):
	     $ ./configure --with-windows
             $ make clean
	     $ make

	findent.exe is available in src/
	wfindent.bat is available in scripts/


Windows users: download findent-x.y.zip
               $ unzip findent-x.y.zip
               $ copy findent.exe C:\WINDOWS
	       $ copy wfindent.bat C:\WINDOWS
	       $ copy findent.jar C:\WINDOWS


All systems:

Usage:    $ findent -h
Examples: $ findent < in.f90 > out.f90
          $ findent -i4 -Rr < in.f > out.f90
          $ wfindent -i4 -Rr *.f

(g)vim users:
   Install findent, and add the following to your .vimrc:

      augroup fortfiletype
	autocmd!
	autocmd Filetype fortran :execute ":setl sw=3"
	autocmd Filetype fortran :execute ":setl equalprg=findent\\ -Ia\\ -i3"
	autocmd Filetype fortran :execute ":setl expandtab"
      augroup END

   Read
     :help =
   in vim or gvim.


# $Id: README.1st 120 2015-08-24 14:27:19Z willem_vermin $
