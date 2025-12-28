# convert-MTS-to-mp4
This script converts the MTS files in a directory to mp4 files and carries over the MTS exif data. This is somewhat specific to Sony MTS files, but should be easily convertible to others as necessary. Courtesy of Gemini AI with my direction.

The goal was to ensure that most, if not all, of the exif data that was contained in the MTS video files was included in the converted MP4 files. In particular I wanted the GPS information.

What is shown below is an example of the resulting exif data in a converted MP4 file:

```
ExifTool Version Number         : 12.40
File Name                       : Yellowstone Painters Pot - 1 (2020-10-28).mp4
Directory                       : .
File Size                       : 100 MiB
File Modification Date/Time     : 2025:12:27 15:09:46-08:00
File Access Date/Time           : 2025:12:27 15:10:30-08:00
File Inode Change Date/Time     : 2025:12:27 15:09:46-08:00
File Permissions                : -rw-rw-r--
File Type                       : MP4
File Type Extension             : mp4
MIME Type                       : video/mp4
Major Brand                     : MP4 Base Media v1 [IS0 14496-12:2003]
Minor Version                   : 0.2.0
Compatible Brands               : isom, iso2, avc1, mp41
Movie Header Version            : 0
Create Date                     : 2020:10:28 23:51:24
Modify Date                     : 2020:10:28 23:51:24
Time Scale                      : 1000
Duration                        : 0:01:28
Preferred Rate                  : 1
Preferred Volume                : 100.00%
Preview Time                    : 0 s
Preview Duration                : 0 s
Poster Time                     : 0 s
Selection Time                  : 0 s
Selection Duration              : 0 s
Current Time                    : 0 s
Next Track ID                   : 3
Track Header Version            : 0
Track Create Date               : 0000:00:00 00:00:00
Track Modify Date               : 0000:00:00 00:00:00
Track ID                        : 1
Track Duration                  : 0:01:28
Track Layer                     : 0
Track Volume                    : 0.00%
Image Width                     : 1920
Image Height                    : 1080
Graphics Mode                   : srcCopy
Op Color                        : 0 0 0
Compressor ID                   : avc1
Source Image Width              : 1920
Source Image Height             : 1080
X Resolution                    : 72
Y Resolution                    : 72
Bit Depth                       : 24
Pixel Aspect Ratio              : 1:1
Buffer Size                     : 500000
Max Bitrate                     : 9382704
Average Bitrate                 : 9382704
Video Frame Rate                : 59.94
Matrix Structure                : 1 0 0 0 1 0 0 0 1
Media Header Version            : 0
Media Create Date               : 0000:00:00 00:00:00
Media Modify Date               : 0000:00:00 00:00:00
Media Time Scale                : 48000
Media Duration                  : 0:01:28
Media Language Code             : und
Handler Description             : SoundHandler
Balance                         : 0
Audio Format                    : mp4a
Audio Channels                  : 2
Audio Bits Per Sample           : 16
Audio Sample Rate               : 48000
Handler Vendor ID               : Apple
Encoder                         : Lavf58.76.100
Handler Type                    : Metadata Tags
Artist                          : Robert Strom
Author                          : Robert Strom
GPS Coordinates                 : 44 deg 43' 41.93" N, 110 deg 42' 2.86" W
Make                            : Sony
Model                           : DSC-HX50V
XMP Toolkit                     : Image::ExifTool 12.40
Exposure Time                   : 1/52
F Number                        : 4.0
GPS Altitude Ref                : Above Sea Level
Shutter Speed Value             : 1/52
White Balance                   : Auto
Media Data Size                 : 104834264
Media Data Offset               : 123842
Aperture                        : 4.0
Image Size                      : 1920x1080
Megapixels                      : 2.1
Shutter Speed                   : 1/52
GPS Altitude                    : 2301.2 m Above Sea Level
Avg Bitrate                     : 9.57 Mbps
GPS Latitude                    : 44 deg 43' 41.93" N
GPS Longitude                   : 110 deg 42' 2.86" W
Rotation                        : 0
GPS Latitude Ref                : North
GPS Longitude Ref               : West
GPS Position                    : 44 deg 43' 41.93" N, 110 deg 42' 2.86" W
```

Sample output as the script is running:

```
+-(15:36:44)--> ./video-conversion-gpu.sh                                     --(Sat,Dec27)-+
Please enter the full path to the directory containing your MTS files:
/mnt/QNAP-1/My Documents/My Videos/Yellowstone Trip - 2020-10
==================================================
LINUX SONY AVCHD BATCH CONVERSION STARTED
Batch Start: 2025-12-27 15:36:57
==================================================
Processing: Sanctuary outside of Yellowstone - 1 (2020-10-24).MTS
File Start: 2025-12-27 15:36:57
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:37:43
Duration:   0m 46s
--------------------------------------------------
Processing: Sanctuary outside of Yellowstone - 2 (2020-10-24).MTS
File Start: 2025-12-27 15:37:43
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:38:23
Duration:   0m 40s
--------------------------------------------------
Processing: Sanctuary outside of Yellowstone - eagles (2020-10-24).MTS
File Start: 2025-12-27 15:38:23
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:38:41
Duration:   0m 18s
--------------------------------------------------
Processing: Sanctuary outside of Yellowstone - otters  (2020-10-24).MTS
File Start: 2025-12-27 15:38:41
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:39:02
Duration:   0m 21s
--------------------------------------------------
Processing: Sanctuary outside of Yellowstone - wolves (2020-10-24).MTS
File Start: 2025-12-27 15:39:02
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:39:55
Duration:   0m 53s
--------------------------------------------------
Processing: Yellowstone - Bacteria Mat - 1 (2020-10-25).MTS
File Start: 2025-12-27 15:39:55
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 15:41:10
Duration:   1m 15s
...
...
...
--------------------------------------------------
Processing: Yellowstone - walkway pano (2020-10-25).MTS
File Start: 2025-12-27 16:24:19
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 16:24:39
Duration:   0m 20s
--------------------------------------------------
Processing: Yellowstone - waterfall - 1 (2020-10-28).MTS
File Start: 2025-12-27 16:24:39
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 16:24:57
Duration:   0m 18s
--------------------------------------------------
Processing: Yellowstone - waterfall - 2 (2020-10-28).MTS
File Start: 2025-12-27 16:24:57
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 16:25:25
Duration:   0m 28s
--------------------------------------------------
Processing: Yellowstone - water flowing under ice (2020-10-25).MTS
File Start: 2025-12-27 16:25:25
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 16:25:55
Duration:   0m 29s
--------------------------------------------------
Processing: Yellowstone - water flowing under walkway (2020-10-27).MTS
File Start: 2025-12-27 16:25:55
Injecting Sony RTMD/Extended Attribute Metadata...
    1 image files updated
File End:   2025-12-27 16:26:24
Duration:   0m 29s
--------------------------------------------------
==================================================
Batch Finished: 2025-12-27 16:26:24
TOTAL TIME:     0h 49m 27s
==================================================

--------------------------------------------------
```

