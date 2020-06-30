# How to use this script:
# 1: Place cachematrix.R in the work dir
# 2: In the R console, type the following cmds in sequence:
# 2.1:  source("cachematrix.R")
# 2.2:  set.seed(10); x <- matrix(rnorm(36, 10, 1), 6)
# 2.3:  y <- makeCacheMatrix(x)
# 2.4:  cacheSolve(y)
# 2.5:  cacheSolve(y)
# When the first time you call cacheSolve(y), it will calculate the inverse
# When the second time call cacheSolve(y), it will display the same inverse-
#     -results with a text message "getting cached data from previous run".
# When change the set.seed() and rerun 2.2 to 2.4 cmds, it will re-calculate-
#     -the inverse without message "getting cached data from previous run".

makeCacheMatrix <- function(x = matrix()){
    s <- NULL
    set <- function(y){
        x <<- y
        s <<- NULL
    }
    get <- function(){x}
    setsolve <- function(solve){s <<- solve}
    getsolve <- function(){s}
    list(set = set,
         get = get,
         setsolve = setsolve,
         getsolve = getsolve)
}

cacheSolve <- function(x, ...){
    s <- x$getsolve()
    if(!is.null(s)){
        message("getting cached data from previous run")
        return(s)
    }
    data <- x$get()
    s <- solve(data, ...)
    x$setsolve(s)
    s
}
