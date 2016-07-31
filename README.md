# neighborsOfPattern

Generate the Neighborhood of a String
Generate the d-neighborhood neighbors(pattern, d), i.e. the set of all k-mers whose Hamming distance from the given k-mer does not exceed d. The main reccursive function called neighbors is an R implementation of the pseudocode provided by P.Pevzner and P.E.C Compeau in Coursera.org, course "Finding Hidden Messages in DNA (Bioinformatics I)"

ATTENTION: The input must be a character sequence of the form "ATCGGCA", of variable length, without spaces containing only one or more of the following letters: "A", "C", "G" and/or "T"
