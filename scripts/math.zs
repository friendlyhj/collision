#loader preinit
#norun
for a in 1 .. 10 {
    for b in 1 .. 10 {
        for m in 1 .. 10 {
            for n in 1 .. 10 {
                if (pow(a * b, m) + pow(a, n) + pow (b, n) == 100 * m + 11 * n) {
                    print("a = " ~ a);
                    print("b = " ~ b);
                    print("m = " ~ m);
                    print("n = " ~ n);
                    print("y = " ~ (100 * m + 11 * n));
                    print("--------------------");
                }
            }
        } 
    }
}