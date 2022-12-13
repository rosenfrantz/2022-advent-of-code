#! /usr/bin/awk -f
# run with ./creating_groups.awk rucksacks
BEGIN { FS= "\n"; RS="\n\n" } #only setting FS didn't work (perhaps since setting it to RS default, so overrode RS default to something else, now behaves as expected)
{ 
    fn=1; while (fn<=NF) {
    if (fn % 3 == 0)
        groupings = groupings $(fn-2) " " $(fn-1) " " $fn "\n"  # sets line to this multiple of 3, plus the two fields that occur before that. new line at beginning rather than end bc easier to have extra line at start in main file when processing prine. 
    fn++
    } } 

    END { print groupings > "rucksack-groups"}