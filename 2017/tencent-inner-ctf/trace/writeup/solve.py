#!/usr/bin/env python
# coding:utf-8

from ctf import *

data = list(string.lowercase + string.uppercase + string.digits + '{}_')
var = [[x] for x in xrange(26)]
data += var


def exchange(i, j):
    t = data[i]
    data[i] = data[j]
    data[j] = t


def simulate(base):
    i = base + 1
    j = base + 1
    while True:
        line = fp.readline()
        if line.startswith('[INFO]00400a60'):
            i += 1
        elif line.startswith('[INFO]00400a54'):
            exchange(i, j)
            j += 1
        elif line.startswith('[INFO]00400ab4'):
            exchange(base, j - 1)
        elif line.startswith('[INFO]00400ac8'):
            simulate(base)
        elif line.startswith('[INFO]00400aec'):
            simulate(j)
        elif line.startswith('[INFO]00400b10'):
            return


fp = open('trace.log')
simulate(0)
fp.close()


def simulate_equal():
    with open('trace.log') as fp:
        i = 0
        while True:
            line = fp.readline()
            if line.startswith('[INFO]00400d28'):
                i += 1
            elif line.startswith('[INFO]00400d1c'):
                eq[i] = False
            elif line.startswith('[INFO]00400d78'):
                return


n = len(data)
eq = [True] * (n - 1)
simulate_equal()

res = []
gp_list = []
gp = [data[0]]
for i in xrange(1, n):
    if eq[i - 1]:
        gp.append(data[i])
    else:
        gp_list.append(gp)
        gp = [data[i]]
gp_list.append(gp)

for gp in gp_list:
    for val in gp:
        if isinstance(val, str):
            break
    for x in gp:
        if not isinstance(x, str):
            x[0] = val

print ''.join([x[0] for x in var])
