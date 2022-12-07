# Part One:
# set record delimiter as blank line; for each record, while f is less than number of fields, add the value at that field index to the sum, then increment counter. 
# after processing each record, print sum | sort numerically high-low | return only first value
awk 'BEGIN { RS = "\n\n" } { 
    f=1; sum=0;
    while ( f<= NF )  {
            sum += $f
            f ++ 
            } print sum } ' elf-calories | sort -n -r | head -n 1

# Part Two:
#same as above but return first three values, then add those values, at end returning final answer.

awk 'BEGIN { RS = "\n\n" } { 
    f=1; sum=0;
    while ( f<= NF )  {
            sum += $f
            f ++ 
            } print sum } ' elf-calories | sort -n -r | head -n 3 | awk '{ megasum += $0 } END { print megasum }'