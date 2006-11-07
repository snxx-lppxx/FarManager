@echo off

rem set misc far compilation options
set FAR_MSVCRT=
set USE_WFUNC=/D "USE_WFUNC" /D "USE_WFUNC_ALW" /D "USE_WFUNC_IN"
set FARTRY=/GX-
set CFG_0=Release

rem call a user defined batch file for custom setting
rem you can set there all the paths for VC and etc.
if exist custom.vc.release.bat call custom.vc.release.bat

rem generate/update lng files and lang.hpp
tools\lng.generator.exe -nc -i lang.ini farlang.templ

rem rebuild dependencies
tools\gawk -f .\scripts\mkdep.awk -v out=Release.vc mkdep.list.txt > far.release.dep

nmake /f "FAR.mak" CFG="far - Win32 %CFG_0%" | tools\tee !Error.vc.%CFG_0%
