#! /usr/bin/awk -f
# run with ./day-four.awk assignments
BEGIN { FS = "[-\,]" }

## Part One: Fully Contain
# An elf's entire assignment fully contains another elf's when: whichever assignment that has the smallest (or equivalent) lower bound, also has an upper bound that is equal to or greater than the other asignment's upper bound.  

{if ($1 < $3 && $2 >= $4) 
    {
        contain_count+= 1
        }
else 
   {if ($3 < $1 && $4 >= $2)  # this statement needed to capture instances where $3=$1 and $4>$2, otherwise just "else" w/o additional conditional would work
        {
            contain_count+= 1}
    else # where $1=$3
        { if ($1==$3)
        { contain_count +=1}  
        }
         # if endpoints match, only option is for one to fully contain other
    }
}




## Part Two: Any Overlap 
# In order for an assignment pair to not overlap at all whichever elf has the smallest lower bound must have an upper bound that is also smaller than the other elf's lower bound

{if ($1 < $3 && $2 < $3) { # if the first elf's assignment lower bound is smaller than the second elf's lower bound, AND the first elf's upper bound is also smaller than the second elf's lower bound then there is no overlap
            }   # so do nothing
    else {if ( $3 < $1 && $4 < $1) { # OTOH, if the second elf's assignment lower bound is smaller than the first elf's lower bound, AND the second elf's upper bound is smaller than the first elf's lower bound, there is also no overlap 
                } #also do nothing
    else {overlap_count+=1 # otherwise there is some amount of overlap, so add to count
    }
  } }

END { print "# of assignments pairs where one assignment completely contains the other: "  contain_count  "\n" "# of assignment pairs with any amount of overlap: "  overlap_count } 