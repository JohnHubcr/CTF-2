#!/usr/bin/env python
# encoding: utf-8

from .cyendec import cyencoder, cydecoder
from socket import *
import random

class cyio(object):
    def __init__(self, r, OOB_OBFUSCATE = False):
        self.OOB_OBFUSCATE = OOB_OBFUSCATE
        self.oob_count = 0
        self.r = r
        self.enc = cyencoder()
        self.dec = cydecoder()

    def recv(self, l, final=True):
        s = u''
        while len(s) < l:
            c = self.r.recv(1)
            t = self.dec.u9(c)
            if t is not None:
                s += unichr(t)
        if final:
            self.dec.final()
        return s

    def recvuntil(self, until, final=True):
        s = u''
        while True:
            c = self.r.recv(1)
            t = self.dec.u9(c)
            if t is not None:
                s += unichr(t)
                if s.endswith(until):
                    break
        if final:
            self.dec.final()
        return s

    def send(self, s):
        if isinstance(s, basestring):
            s = self.enc.pstr(s)
        elif isinstance(s, list):
            s = self.enc.plist(s)
        if self.OOB_OBFUSCATE and self.oob_count <= 3:
            d = chr(random.randint(0, 255))
            if random.randint(0, 100) < 70:
                self.oob_count += 1
                self.r.sock.send(s+d, MSG_OOB)
            else:
                self.r.send(s)
        else:
            self.r.send(s)

    def sendline(self, s):
        if isinstance(s, basestring):
            s = self.enc.pstr(s+'\n')
        elif isinstance(s, list):
            s = self.enc.plist(s+[0x0a])
        self.r.send(s)

    def interactive(self):
        return self.r.interactive()

    def close(self):
        return self.r.close()
