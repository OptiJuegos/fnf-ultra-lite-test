@echo off

:: CD Route
cd /d "%CD%"

:: Set Input Directory and Output Directory
set "input_dir=assets\songs"
set "output_dir=assets\songs2"

:: Set Bitrate
set "audio_bitrate=16.00k"

:: Set Preset & codec
set "codec=libmp3lame"
set "preset=slow"

:: Recursively compress audio files in the input directory
for /r "%input_dir%" %%F in (*.mp3) do (
    set "input_file=%%F"
    set "relative_path=%%~pnxF"
    setlocal enabledelayedexpansion
    set "output_file=!output_dir!!relative_path!"
    set "output_file=!output_file:.mp3=.mp3!"
    mkdir "!output_file!\..\ >nul 2>&1"
    "ffmpeg.exe" -i "!input_file!" -preset %preset% -c:a %codec% -b:a %audio_bitrate% "!output_file!"
    move /y "!output_file!" "!input_file!" >nul
    endlocal
)

echo Done!
pause