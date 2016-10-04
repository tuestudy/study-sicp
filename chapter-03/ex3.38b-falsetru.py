from threading import Thread
from time import sleep
from itertools import permutations

balance = 100

def switch():
    sleep(0)    # XXX

def Peter():
    global balance
    switch()
    val = balance   # access
    switch()
    val += 10       # compute
    switch()
    balance = val   # set

def Paul():
    global balance
    switch()
    val = balance   # access
    switch()
    val -= 20       # compute
    switch()
    balance = val   # set

def Mary():
    global balance
    switch()
    val = balance   # access
    switch()
    val /= 2        # compute
    switch()
    balance = val   # set

def simulate():
    global balance
    for order in permutations((Peter, Paul, Mary)):
        balance = 100
        threads = [Thread(target=who) for who in order]
        for thread in threads:
            thread.start()
        for thread in threads:
            thread.join()
        yield balance

results = {b for i in range(1000) for b in simulate()}
print sorted(results)
