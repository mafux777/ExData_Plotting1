## Brief comments for this assignment

As always, I have focussed on creating code that has very little superfluous elements. In other words,
I try to get away with the minimum number of code lines, but not at the expense of code readability.

I think I have matched the four plots perfectly, perhaps with the exception that in one of the sub-plots
of plot4 I did not get rid of the box in the legend.

I was somewhat sloppy in reading all columns in as character to avoid having to deal with the warning message
about the question mark. Most of the plots perform a graceful auto-cast into as.numeric(), except the histogram.

So things I left to improve:
- Box in legend
- Dealing with the question marks (converting into proper NAs, perhaps with gsub())

