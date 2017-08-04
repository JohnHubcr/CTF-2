#!/usr/bin/env python
# coding:utf-8

import pwnlib
from pwn import log, ordlist

from .cyendec import cyencoder, cydecoder

__all__ = ['cyremote']


class cyremote(pwnlib.tubes.remote.remote):

    def __init__(self, host, port, block_end_with_line=True, *args, **kwargs):
        super(cyremote, self).__init__(host, port, *args, **kwargs)
        self._enc = cyencoder()
        self._dec = cydecoder()
        self._block_end = []
        self._block_end_with_line = block_end_with_line

    def add_block_end(self, data):
        self._block_end.append(data)

    def send(self, data):
        while self.can_recv_raw(0.01):
            raw = self.recv_raw(40960)
            self.buffer.add(raw)

        data = [i if isinstance(i, int) else ord(i) for i in data]
        data = self._enc.plist(data)
        super(cyremote, self).send(data)

        while self.can_recv_raw(0.01):
            raw = self.recv_raw(40960)
            self.buffer.add(raw)

    def recv_raw(self, numb=None, *a, **kw):
        res = u''
        s = u''
        raw = super(cyremote, self).recv_raw(numb)
        if raw is None:
            return raw
        for c in raw:
            t = self._dec.u9(c)
            if t is not None:
                s += unichr(t)
            # handle block end with user specific string
            if self._block_end and s.endswith(self._block_end[0]):
                self._block_end = self._block_end[1:]
                self._dec.final()
                res += s
                s = u''
            # handle block end with newline
            if self._block_end_with_line and s.endswith(self.newline):
                self._dec.final()
                res += s
                s = u''
        self._dec.final()
        return res + s

    def sendline(self, line=''):
        if isinstance(line, str) or isinstance(line, unicode):
            super(cyremote, self).sendline(line)
            return
        self.send(line + list(self.newline))


if __name__ == '__main__':
    from pwn import *
    context.log_level = 'debug'
    io = cyremote('45.79.101.169', 12312)
    # io = cyremote('45.79.101.169', 12312, block_end_with_line=False) # default True
    # io.add_block_end('block end')
    data = [
        229, 187, 190, 228, 185, 135, 228, 185, 154, 228, 185, 154, 227, 132,
        150, 32, 229, 177, 177, 227, 132, 150, 229, 176, 186, 228, 185, 154,
        225, 151, 170, 33, 0, 0, 0x20, 0x25, 0x64, 0x20, 0x25, 0x64, 0x20, 0x25,
        0x64, 0x0a
    ]
    data += [0] * (213 - len(data))

    for i in data:
        io.sendline(str(i))
        print io.recv()

    io.interactive()
