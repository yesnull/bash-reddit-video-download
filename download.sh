#!/bin/bash
while getopts l:o: flag
do
    case "${flag}" in
        l) LINK=${OPTARG};;
        o) OUTPUT_FILE=${OPTARG};;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument" >&2
            exit 1
            ;;
    esac
done

if [ -z "$LINK" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 -l <reddit video link> -o <mp4 output file>" >&2
    exit 1
fi

VIDEO_LINK=$(curl -s $LINK.json | jq -r '.[0].data.children[0].data.secure_media.reddit_video.dash_url')

ffmpeg -i $VIDEO_LINK -codec copy $OUTPUT_FILE;