#!/bin/bash

# --- CONFIGURATION ---
# Use the GPU option if at all possible. Using the GPU performs the video conversion many times faster than using the CPU

# Should try using this on the GMKtec Mini PC N150 - it has an Intel GPU. Probably not very powerful, but work a try

ENCODER_TYPE="nvidia"    # Options: "nvidia", "intel", or "cpu" (AMD uses different VAAPI syntax in Linux)
AUTHOR_NAME="Robert Strom"
CAMERA_MAKE="Sony"       # Hard-coded to prevent "264" codec ID error
DATE_FORMAT="%Y-%m-%d %H:%M:%S"

# 1. Prompt for Source Directory
echo "Please enter the full path to the directory containing your MTS files:"
read -r SOURCE_DIR

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Directory not found."
    exit 1
fi

DEST_DIR="$SOURCE_DIR/MP4_Converted"
LOG_FILE="$SOURCE_DIR/ConversionLog.txt"

# Define Encoder Settings
# Note: Linux FFmpeg usually uses h264_vaapi for Intel/AMD or h264_nvenc for Nvidia
case $ENCODER_TYPE in
    "nvidia")
        V_CODEC="h264_nvenc"
        Q_PARAM=("-rc" "constqp" "-qp" "19")
        ;;
    "intel")
        V_CODEC="h264_qsv"
        Q_PARAM=("-global_quality" "20")
        ;;
    *)
        V_CODEC="libx264"
        Q_PARAM=("-crf" "18" "-preset" "slow")
        ;;
esac

mkdir -p "$DEST_DIR"

GLOBAL_START_TIME=$(date +"$DATE_FORMAT")
GLOBAL_START_SECONDS=$(date +%s)

echo "=================================================="
echo "LINUX SONY AVCHD BATCH CONVERSION STARTED"
echo "Batch Start: $GLOBAL_START_TIME"
echo "=================================================="
echo "Conversion Log - Started: $GLOBAL_START_TIME" > "$LOG_FILE"
echo "==================================================" >> "$LOG_FILE"

# Loop through MTS files (case-insensitive)
shopt -s nullglob nocaseglob
for FILE in "$SOURCE_DIR"/*.MTS; do
    BASENAME=$(basename "$FILE" .MTS)
    OUTPUT_FILE="$DEST_DIR/$BASENAME.mp4"

    FILE_START_TIME=$(date +"$DATE_FORMAT")
    FILE_START_SECONDS=$(date +%s)

    echo -e "\e[36mProcessing: $(basename "$FILE")\e[0m"
    echo "File Start: $FILE_START_TIME"
    echo "[$FILE_START_TIME] Starting: $(basename "$FILE")" >> "$LOG_FILE"

    # 1. High Quality Conversion
    ffmpeg -hwaccel auto -i "$FILE" -c:v $V_CODEC "${Q_PARAM[@]}" -c:a aac -b:a 192k -movflags +faststart "$OUTPUT_FILE" -hide_banner -loglevel error

    if [ $? -eq 0 ]; then
        echo -e "\e[32mInjecting Sony RTMD/Extended Attribute Metadata...\e[0m"

        # 2. Metadata Mapping
        # Linux paths are case-sensitive; -ee3 and RequestAll=3 are preserved for Sony data
        exiftool -tagsFromFile "$FILE" -ee3 -api QuickTimeUTC -api RequestAll=3 -n -m -P \
            "-QuickTime:CreateDate<DateTimeOriginal" \
            "-QuickTime:ModifyDate<DateTimeOriginal" \
            "-Keys:Author=$AUTHOR_NAME" "-Keys:Artist=$AUTHOR_NAME" \
            "-Keys:Make=$CAMERA_MAKE" "-UserData:Make=$CAMERA_MAKE" \
            "-Keys:Model<Model" \
            "-Keys:GPSCoordinates<GPSPosition" \
            "-Keys:GPSCoordinates<Composite:GPSPosition" \
            "-GPSLatitude<GPSLatitude" "-GPSLatitudeRef<GPSLatitudeRef" \
            "-GPSLongitude<GPSLongitude" "-GPSLongitudeRef<GPSLongitudeRef" \
            "-GPSAltitude<GPSAltitude" "-GPSAltitudeRef<GPSAltitudeRef" \
            "-XMP:FNumber<FNumber" "-XMP:ExposureTime<ExposureTime" \
            "-XMP:ShutterSpeedValue<ShutterSpeed" "-XMP:WhiteBalance<WhiteBalance" \
            -overwrite_original "$OUTPUT_FILE"

        FILE_END_TIME=$(date +"$DATE_FORMAT")
        FILE_END_SECONDS=$(date +%s)
        ELAPSED_SECONDS=$((FILE_END_SECONDS - FILE_START_SECONDS))
        DURATION_MIN=$((ELAPSED_SECONDS / 60))
        DURATION_SEC=$((ELAPSED_SECONDS % 60))

        echo "File End:   $FILE_END_TIME"
        echo -e "\e[32mDuration:   ${DURATION_MIN}m ${DURATION_SEC}s\e[0m"
        echo "[$FILE_END_TIME] Completed: $(basename "$FILE") (${DURATION_MIN}m ${DURATION_SEC}s)" >> "$LOG_FILE"
    else
        echo -e "\e[31mError converting $FILE\e[0m"
    fi
    echo "--------------------------------------------------"
done

GLOBAL_END_TIME=$(date +"$DATE_FORMAT")
GLOBAL_END_SECONDS=$(date +%s)
TOTAL_ELAPSED=$((GLOBAL_END_SECONDS - GLOBAL_START_SECONDS))

T_HOUR=$((TOTAL_ELAPSED / 3600))
T_MIN=$(( (TOTAL_ELAPSED % 3600) / 60 ))
T_SEC=$((TOTAL_ELAPSED % 60))

echo "=================================================="
echo "Batch Finished: $GLOBAL_END_TIME"
echo -e "\e[33mTOTAL TIME:     ${T_HOUR}h ${T_MIN}m ${T_SEC}s\e[0m"
echo "=================================================="
echo "Batch Finished: $GLOBAL_END_TIME" >> "$LOG_FILE"
echo "Total Elapsed:  ${T_HOUR}h ${T_MIN}m ${T_SEC}s" >> "$LOG_FILE"
