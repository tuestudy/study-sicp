import math, time

def pytha(low, high):
    ret = []
    for i in xrange(low, high+1):
        for j in xrange(i, high+1):
            for k in xrange(j, high+1):
                if (k**2 == i**2 + j**2):
                    ret.append(map(int, [i, j, k]))
    return ret

def pytha2(low, high):
    ret = []
    for i in xrange(low, high+1):
        hsq = high**2
        for j in xrange(i, high+1):
            ksq = i**2 + j**2
            if (hsq>=ksq):
                k = math.sqrt(ksq)
                if k == math.floor(k):
                    ret.append(map(int, [i, j, k]))
    return ret

_st = time.time()
ret1 = pytha(1,500)
print 'Ex4.35: %5.3fs' % (time.time() - _st)

_st = time.time()
ret2 = pytha2(1,500)
print 'Ex4.37 - Ben\'s code: %5.3fs' % (time.time() - _st)
assert(ret1 == ret2)
