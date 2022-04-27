#!/bin/sh
#first, we need to be sure that all subtitle tags understandable by ffmpeg
rename -v "s|[[].*mp4|mp4|g" *.mp4
rename -v "s| |\.|g" *.mp4
rename -v "s|da\.srt|dan\.srt|g" *.srt
rename -v "s|no\.srt|nor\.srt|g" *.srt
rename -v "s|sv\.srt|swe\.srt|g" *.srt
rename -v "s|nl\.srt|dut\.srt|g" *.srt
rename -v "s|el\.srt|ell\.srt|g" *.srt
rename -v "s|en\.srt|eng\.srt|g" *.srt
rename -v "s|fr\.srt|fre\.srt|g" *.srt
rename -v "s|it\.srt|ita\.srt|g" *.srt
rename -v "s|de\.srt|ger\.srt|g" *.srt
#it checks mp4 files and corresponding subtitles and automatically merge them
for FNM in *.mp4
  do    CNT=0
        MAPNR=1
        META=""
        LANG=""
        HAR=""
        echo "ffmpeg -i $FNM \\"
        for FNS in ${FNM%.mp4}.*.srt
          do    LANG+="-i $FNS \\"$'\n'
                TMP=${FNS%*.srt}
                META+="-metadata:s:s:$((CNT++)) language=${TMP##*.} "
                HAR+="-map $((MAPNR++)) "
done
        echo "${LANG}-map 0:v -map 0:a $HAR \\"
        echo "-c:v copy -c:a copy -c:s mov_text \\"
        echo "$META \\"
        echo "2_$FNM ; rm $FNM ; mv 2_$FNM $FNM"
done > post.sh
chmod 755 post.sh
#output is post.sh
./post.sh
exit 0
