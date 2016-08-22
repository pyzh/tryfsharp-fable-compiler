@echo off
.paket\paket.bootstrapper.exe
if errorlevel 1 (
  exit /b %errorlevel%
)
if not exist paket.lock (
  .paket\paket.exe -v install
) else (
  .paket\paket.exe -v restore
)
if errorlevel 1 (
  exit /b %errorlevel%
)

if not exist fable-compiler\build\fable\bin\Fable.Client.Suave.exe (
  git clone -b cors https://github.com/tryfsharp/fable-compiler.git 
  cd fable-compiler
  call build.cmd FableSuaveRelease
  cd ..
)

packages\FAKE\tools\FAKE.exe %* --fsiargs build.fsx
