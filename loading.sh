#!/usr/bin/env bash

# Set the animation frames
frames=("|" "/" "-" "\\")

# Set the number of times to loop
count=10

# Loop through the animation frames
for ((i=0; i<count; i++)); do
    # Print the current frame
    printf "\r%s" "${frames[i % ${#frames[@]}]}"
    # Sleep for a short period of time
    sleep 0.1
done

# Print a newline after the animation is complete
printf "\n"
