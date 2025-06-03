function bitcount(n){
    var count = 0;
    while (n > 0) {
        count += n & 1;
        n = n div 2;
    }
    return count;

}