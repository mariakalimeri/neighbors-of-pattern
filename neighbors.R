neighbors <- function(pattern, d){
    library("seqinr")
    
    # INPUT format: 'Pattern' must contain only "A", "C", "G" and/or "T" 
    # concatenated in a single character (of variable length) without spaces
    # Examples are: "ATTGACAAT", "AAT", "CCAGTCATTATCGCC"
    
    if (!is.character(pattern) | length(grep(" ", pattern))!=0){
        return("Error: Pattern must be a character of the form 'ACGGTGTA' without spaces")                
    }
    uniqueCharsInPattern <- unique(s2c(pattern))
    alphabet <- c("A", "C", "G", "T")    
    if (sum(uniqueCharsInPattern %in% alphabet)!=length(uniqueCharsInPattern)){
        return("Error: Pattern must of the form 'ACGGTGTA' without spaces, containing only one or more of the following letters: 'A', 'C', 'G' and/or 'T'")                        
    }
    patternLength <- nchar(pattern)
    
    # ----------- Generating the Neighborhood of a String ----------------------
    # Generate the d-neighborhood neighbors(pattern, d), 
    # i.e. the set of all k-mers whose Hamming distance from pattern does not 
    # exceed d. 
    # ---> The following reccursive function is an R implementation of the 
    # pseudocode provided by P.Pevzner and P.E.C Compeau in Coursera.org
    if (d == 0){
        return(pattern)
    } 
    if (patternLength == 1){
        return(c("A", "C", "G", "T"))
    } 
    neighborhood <- NULL
    suffixNeighbors <- neighbors(suffix(pattern), d)
    for (i in 1:length(suffixNeighbors)){
	if (hammingDistance(suffix(pattern), suffixNeighbors[i]) < d){
            for (j in 1:length(alphabet)){
                neighborhood <- c(neighborhood, paste(alphabet[j], suffixNeighbors[i], sep=""))
            }
        } else {
            neighborhood <- c(neighborhood, paste(firstSymbol(pattern), suffixNeighbors[i], sep=""))
        }
    }
    return(neighborhood)   
}

# Auxiliary functions

# Get the first symbol of the k-mer "pattern".
firstSymbol <- function(string){
    return(substr(string, start=1, stop=1))                
}

# Get the (k-1) -mer that is obtained after we remove the first symbol of the k-mer pattern
suffix <- function(string){
    stringLength <- nchar(string)
    return(substr(string, start=2, stop=stringLength))        
}

# Find the hamming distance between two strings
# Definition: The number of mismatches between strings str1 and str2 is called 
# the Hamming distance between these strings
hammingDistance <- function(str1, str2){
    if (nchar(str1)!=nchar(str2)){
        print("The two strings must have the same length")
        return(NULL)
    } else {
        hamDist <- 0
        for (i in 1:nchar(str1)){
            if (substr(str1, start=i, stop=i)!=substr(str2, start=i, stop=i)){
                hamDist <- hamDist+1
            }
        }
    }
    return(hamDist)
}

