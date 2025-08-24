#!/bin/bash
echo "Updating yt-dlp"
./yt-dlp_linux -U
echo "Enter YT link"
read ytlink

echo "Extract audio only? [y/N]"
read audioyn


case $audioyn in
    y | Y) ytid="-f bestaudio -x --audio-format mp3"; echo "Audio only" ;;
    N | n) echo "Full video"
        echo "1. Default settings 2. Custom vid stream ID [1/2]"
        read customid
        case $customid in
            1) echo "Using default settings" ;;
            2)
                ./yt-dlp_linux $ytlink -F
                echo "Choose format ID"
                read vidid
                ytid="-f $vidid";;
            *) echo "Unknown command, using default settings"
        esac
        ;;
    *) echo "Unknown command, using full video, default settings"
esac


echo "Path? (leave empty for default)"
read path
case $path in
    '') echo "Using default" ;;
    *) ytpath="-P $path"
esac


./yt-dlp_linux $ytlink $ytid $ytpath
