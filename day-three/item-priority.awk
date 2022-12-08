#! /usr/bin/awk -f
# run with ./item-priority.awk alpha.txt rucksacks
# alpha.txt contains letters a-z followed by A-Z each on a new line. Line number corresponds to priority value. 
NR==FNR{ l=1; while (l<=NR) { # NR==FR mess means this is only run on first file given in command line. 
    priority[$0]=l #assign a new value to priority array where key is the letter, value is line number which also corresponds to priority value
    l++ # increment l 
}; next }  # move on to next file given via command line

{ first="["substr($0,1,length/2)"]" # assign first compartment via substring starting at first element, ending at the halfway point. #assigned with the [ ] around it so that it works as input for match
second=substr($0,length/2 + 1); # assign second compartment substring starting at halfway point +1, ending at end of string
match_index=match(second,first); # identify which item in second compartment matches first, return index of that item
match_value=substr(second, match_index, 1); # store actual value of the item
sum+=priority[match_value] }  #access the priority value of that item, add to overall sum of item priorities

END { print sum }
