#!/usr/bin/env python
# encoding: utf-8

def p54(c):
    assert(0 <= c < 1<<54)
    r = []
    r += p27(c>>27)
    r += p27(c & 0x7ffffff)
    return r

def p36(c):
    assert(0 <= c < 1<<36)
    r = []
    r.append((c >> 18) & 0x1ff)
    r.append(c >> 27)
    r.append((c >> 9) & 0x1ff)
    r.append(c & 0x1ff)
    return r

def p27(c):
    assert(0 <= c < 1<<27)
    r = []
    r.append((c >> 9) & 0x1ff)
    r.append(c >> 18)
    r.append(c & 0x1ff)
    return r

def p18(c):
    assert(0 <= c < 1<<18)
    r = []
    r.append(c & 0x1ff)
    r.append(c >> 9)
    return r

def u27(b):
    if len(b) < 3:
        return None
    r = b[1] << 18 | b[0] << 9 | b[2]
    return r

def u18(b):
    if len(b) < 2:
        return None
    r = b[1] << 9 | b[0]
    return r

class cyencoder(object):
    def __init__(self):
        self.bit_buf = 0
        self.bit_num = 0

    def pstr(self, s):
        r = ''
        for c in s:
            r += self.p9(ord(c))
        r += self.final()
        return r

    def plist(self, s):
        r = ''
        for c in s:
            r += self.p9(c)
        r += self.final()
        return r

    def p9(self, c):
        assert(0 <= c < 1<<9)
        left_bits = self.bit_num+1
        self.bit_buf |= c >> left_bits
        self.bit_num += 9
        r = chr(self.bit_buf)
        if self.bit_num >= 16:
            left_bits -= 8
            r += chr((c >> left_bits) & 0xff)
        self.bit_buf = (c << (8-left_bits)) & 0xff
        self.bit_num = left_bits
        return r

    def p1(self, b):
        self.bit_buf |= b >> self.bit_num
        self.bit_num += 1
        if self.bit_num >= 8:
            r = chr(self.bit_buf)
            self.bit_buf = 0
            self.bit_num = 0
            return r
        else:
            return ''

    def final(self):
        r = chr(self.bit_buf)
        self.bit_buf = 0
        self.bit_num = 0
        return r

class cydecoder(object):
    def __init__(self):
        self.bytes = []
        self.bit_buf = 0
        self.bit_num = 0

    def ustr(self, s):
        r = u''
        for c in s:
            t = self.u9(c)
            if t is not None:
                r += unichr(t)
        return r

    def ulist(self, s):
        r = []
        for c in s:
            t = self.u9(c)
            if t is not None:
                r.append(t)
        return r

    def u9(self, c):
        c = ord(c)
        assert(0 <= c < 0x100)
        left_bits = self.bit_num-1
        if left_bits >= 0:
            self.bit_buf |= c >> left_bits
        else:
            self.bit_buf |= c << -left_bits
        self.bit_num += 8
        if self.bit_num >= 9:
            r = self.bit_buf
            self.bit_buf = (c << (9-left_bits)) & 0x1ff
            self.bit_num = left_bits
            return r
        else:
            return None

    def final(self):
        self.bytes = []
        self.bit_buf = 0
        self.bit_num = 0
