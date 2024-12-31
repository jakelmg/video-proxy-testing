@echo off
REM H264 to Prores Transcode Script
REM Usage: transcode prores.bat input.mp4/mov

if "%~1"=="" (
    echo Please provide an input file.
    echo Usage: transcode prores.bat input.mp4/mov
    exit /b 1
)

set INPUT=%~1
REM Extract the file name without extension
for %%F in ("%INPUT%") do set FILENAME=%%~nF
REM Append "-PRORES" to the file name and use .mp4 as the extension
set OUTPUT=%FILENAME%-PRORES.mov

echo Transcoding %INPUT% to %OUTPUT% using NVENC...
ffmpeg -hwaccel cuda -c:v h264_cuvid -i "%INPUT%" -c:v prores -profile:v 1 -threads 16 "%OUTPUT%"

if %ERRORLEVEL% NEQ 0 (
    echo Transcoding failed.
    exit /b %ERRORLEVEL%
)

echo Transcoding completed successfully.
exit /b 0
