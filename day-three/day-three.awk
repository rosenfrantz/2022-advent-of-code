#! /usr/bin/awk -f
# run with ./day-three.awk alpha.txt rucksacks
# alpha.txt contains letters a-z followed by A-Z each on a new line. Line number corresponds to priority value. 


## Setting up priority value array
FILENAME == "alpha.txt" { l=1; while (l<=NR) { # NR==FR mess means this is only run on first file given in command line. 
    priority[$0]=l #assign a new value to priority array where key is the letter, value is line number which also corresponds to priority value
    l++ } } # increment l 


## Item priority 

FILENAME == "rucksacks" {{ first_compartment="["substr($0,1,length/2)"]" # assign first compartment via substring starting at first element, ending at the halfway point. #assigned with the [ ] around it so that it works as input for match
second_compartment=substr($0,length/2 + 1); # assign second compartment substring starting at halfway point +1, ending at end of string
match_index=match(second_compartment,first_compartment); # identify which item in second compartment matches first, return index of that item
match_value=substr(second_compartment, match_index, 1); # store actual value of the item
sum+=priority[match_value]} #access the priority value of that item, add to overall sum of item priorities
 }



## Badge priority
FILENAME == "rucksack-groups" { # note: this file is created by first running creating-groups.awk with rucksacks as input
   split($1, first_elf, "")
   second_elf=$2
   third_elf=$3

   i=1; matches =""; while (i<=length(first_elf)) {
    if (match(second_elf,first_elf[i])) # compares the second string against each letter of the first string, 
        matches=matches first_elf[i];    # if the letter exists in both, adds it to list of matches. 
    i++
   } 

   split(matches, matches_array, "") # transforms list of matches into an array (later see if can figure to save into array directly)
   
   i=1; triple_match=""; while (i<=length(matches)) { # check each item being carried by both first and second elf in group against third elf
    if (match(third_elf,matches_array[i])) # if item that is matched in first two elves' rucksacks also exists in third
         triple_match= matches_array[i] # set it as match; (in theory there should only ever be one match -- at most, that match may occur more than once in any of the rucksacks)
    i++
    }
    badge_sum+=priority[triple_match]
} 

END { print "item sum: " sum "\n" "badge sum: " badge_sum }