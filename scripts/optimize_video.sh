#!/bin/bash

# Video optimization script for mobile playback
# Requires ffmpeg to be installed

VIDEO_INPUT="assets/videos/Premium_dermatology_tech_202509031733.mp4"
VIDEO_OUTPUT="assets/videos/Premium_dermatology_tech_optimized.mp4"

echo "Optimizing video for mobile playback..."

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install it first:"
    echo "Ubuntu/Debian: sudo apt install ffmpeg"
    echo "macOS: brew install ffmpeg"
    echo "Windows: Download from https://ffmpeg.org/download.html"
    exit 1
fi

# Check if input file exists
if [ ! -f "$VIDEO_INPUT" ]; then
    echo "Error: Input video file not found: $VIDEO_INPUT"
    exit 1
fi

# Create backup of original
cp "$VIDEO_INPUT" "${VIDEO_INPUT}.backup"

# Optimize video for mobile playback
ffmpeg -i "$VIDEO_INPUT" \
    -c:v libx264 \
    -preset medium \
    -crf 28 \
    -maxrate 2M \
    -bufsize 4M \
    -c:a aac \
    -b:a 128k \
    -movflags +faststart \
    -vf "scale=1280:720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2" \
    -y \
    "$VIDEO_OUTPUT"

if [ $? -eq 0 ]; then
    echo "Video optimization completed successfully!"
    echo "Original size: $(du -h "$VIDEO_INPUT" | cut -f1)"
    echo "Optimized size: $(du -h "$VIDEO_OUTPUT" | cut -f1)"
    echo ""
    echo "To use the optimized video, update your code to use:"
    echo "'assets/videos/Premium_dermatology_tech_optimized.mp4'"
else
    echo "Error: Video optimization failed"
    exit 1
fi
