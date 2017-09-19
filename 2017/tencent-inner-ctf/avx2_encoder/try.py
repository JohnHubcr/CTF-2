#!/usr/bin/env python
# coding:utf-8

from claripy import *
from pwn import *


def psllq(src, imm):
    if imm > 63:
        return 0
    dst = src << imm
    return dst


def psrlq(src, imm):
    if imm > 63:
        return 0
    dst = src.LShR(imm)
    return dst


def vpaddq(SRC1, SRC2):
    dst = (SRC1.reversed[63:0] + SRC2.reversed[63:0]).reversed
    dst = Concat(dst, (SRC1.reversed[127:64] + SRC2.reversed[127:64]).reversed)
    dst = Concat(dst,
                 (SRC1.reversed[191:128] + SRC2.reversed[191:128]).reversed)
    dst = Concat(dst,
                 (SRC1.reversed[255:192] + SRC2.reversed[255:192]).reversed)
    return dst


def vpermq(SRC, imm):
    imm = BVV(imm, 8)
    dst = (SRC.reversed[255:0] >> (imm[1:0].args[0] * 64))[63:0].reversed
    dst = Concat(dst, (SRC.reversed[255:0] >>
                       (imm[3:2].args[0] * 64))[63:0].reversed)
    dst = Concat(dst, (SRC.reversed[255:0] >>
                       (imm[5:4].args[0] * 64))[63:0].reversed)
    dst = Concat(dst, (SRC.reversed[255:0] >>
                       (imm[7:6].args[0] * 64))[63:0].reversed)
    return dst


def vpor(SRC1, SRC2):
    dst = SRC1 | SRC2
    return dst


def vpshufhw(SRC1, imm):
    imm = BVV(imm, 8)
    dst = SRC1.reversed[63:0].reversed
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[1:0].args[0] * 16))[79:64].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[3:2].args[0] * 16))[79:64].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[5:4].args[0] * 16))[79:64].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[7:6].args[0] * 16))[79:64].reversed)
    dst = Concat(dst, SRC1.reversed[191:128].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[1:0].args[0] * 16))[207:192].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[3:2].args[0] * 16))[207:192].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[5:4].args[0] * 16))[207:192].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[7:6].args[0] * 16))[207:192].reversed)
    return dst


def vpshuflw(SRC1, imm):
    imm = BVV(imm, 8)
    dst = (SRC1.reversed >> (imm[1:0].args[0] * 16))[15:0].reversed
    dst = Concat(dst, (SRC1.reversed >> (imm[3:2].args[0] * 16))[15:0].reversed)
    dst = Concat(dst, (SRC1.reversed >> (imm[5:4].args[0] * 16))[15:0].reversed)
    dst = Concat(dst, (SRC1.reversed >> (imm[7:6].args[0] * 16))[15:0].reversed)
    dst = Concat(dst, SRC1.reversed[127:64].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[1:0].args[0] * 16))[143:128].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[3:2].args[0] * 16))[143:128].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[5:4].args[0] * 16))[143:128].reversed)
    dst = Concat(dst,
                 (SRC1.reversed >> (imm[7:6].args[0] * 16))[143:128].reversed)
    dst = Concat(dst, SRC1.reversed[255:192].reversed)
    return dst


def vpsllq(SRC, imm):
    dst = psllq(SRC.reversed[63:0], imm).reversed
    for i in xrange(64, 256, 64):
        dst = Concat(dst, psllq(SRC.reversed[i + 63:i], imm).reversed)
    return dst


def vpsrlq(SRC, imm):
    dst = psrlq(SRC.reversed[63:0], imm).reversed
    for i in xrange(64, 256, 64):
        dst = Concat(dst, psrlq(SRC.reversed[i + 63:i], imm).reversed)
    return dst


def vpsubq(src1, src2):
    dst = (src1.reversed[63:0] - src2.reversed[63:0]).reversed
    # for i in xrange(64, 256, 64):
    #     dst = Concat(dst, src1[i + 63:i] - src2[i + 63:i])
    dst = Concat(dst, (src1.reversed[127:64] - src2.reversed[127:64]).reversed)
    dst = Concat(dst,
                 (src1.reversed[191:128] - src2.reversed[191:128]).reversed)
    dst = Concat(dst,
                 (src1.reversed[255:192] - src2.reversed[255:192]).reversed)
    return dst


def vpxor(SRC1, SRC2):
    dst = SRC1 ^ SRC2
    return dst


# y = [BVS('y{}'.format(i), 256) for i in xrange(8)]

ymmword_140002160 = BVV(
    0x728f3ea4ce0845084b84e090296479e035cd89115d65e795fd40351f322f4fd8,
    256).reversed
x = BVS('input', 256)

ymm0 = x
ymm0 = vpsubq(ymm0, ymmword_140002160)
ymm1 = vpshufhw(ymm0, 0x0D8)
ymm0 = vpshufhw(ymmword_140002160, 0x2D)
ymm5 = vpshuflw(ymm1, 0x0D2)
ymm1 = vpshuflw(ymm0, 0x4E)
ymm2 = vpsrlq(ymm1, 0x17)
ymm0 = vpsllq(ymm1, 0x29)
ymm3 = vpsrlq(ymm5, 0x39)
ymm1 = vpermq(ymm0, 0x39)
ymm0 = vpsllq(ymm5, 7)
ymm4 = vpxor(ymm1, ymm2)
ymm1 = vpermq(ymm0, 0x39)
ymm2 = vpxor(ymm1, ymm3)
ymm0 = vpsllq(ymm4, 0x22)
ymm3 = vpsrlq(ymm4, 0x1E)
ymm5 = vpxor(ymm2, ymm4)
ymm1 = vpermq(ymm0, 0x39)
ymm2 = vpxor(ymm1, ymm3)
ymm0 = vpsllq(ymm5, 4)
ymm3 = vpshufhw(ymm2, 0x0D2)
ymm1 = vpermq(ymm0, 0x39)
ymm2 = vpsrlq(ymm5, 0x3C)
ymm2 = vpxor(ymm1, ymm2)
ymm4 = vpshuflw(ymm3, 0x0D8)
ymm3 = vpshufhw(ymm2, 0x4E)
ymm0 = vpsrlq(ymm4, 0x25)
ymm2 = vpsllq(ymm4, 0x1B)
ymm1 = vpermq(ymm0, 0x93)
ymm5 = vpshuflw(ymm3, 0x2D)
ymm4 = vpor(ymm1, ymm2)
ymm0 = vpsrlq(ymm5, 0x34)
ymm3 = vpsllq(ymm5, 0x0C)
ymm1 = vpermq(ymm0, 0x93)
ymm2 = vpor(ymm1, ymm3)
ymm4 = vpaddq(ymm2, ymm4)

ymm0 = vpsrlq(ymm4, 0x28)
ymm3 = vpsllq(ymm4, 0x18)
ymm1 = vpermq(ymm0, 0x93)
ymm2 = vpor(ymm1, ymm3)
ymm3 = vpshufhw(ymm2, 0x0D2)
ymm0 = vpshuflw(ymm3, 0x4E)

s = Solver()
s.add(ymm0.reversed ==
      0x92f5f9ce15de97eeb5109e3b20191bc0bc24c2308a5223d3c7479a3790d58eed)
print pack(s.eval(x, 1)[0], 'all', endianness='big')

# s = Solver()
# x = BVS('x', 256)
# ymm4 = x
# ymm0 = vpsrlq(ymm4, 0x28)
# ymm3 = vpsllq(ymm4, 0x18)
# ymm1 = vpermq(ymm0, 0x93)
# ymm2 = vpor(ymm1, ymm3)
# s.add(
#     ymm2 ==
#     25149796534093303161257786921815552954012177353325830356573640690115194385810L
# )
# s.eval(x, 2)

# s = Solver()
# x = BVS('x', 256)
# ymm2 = x
# ymm3 = vpshufhw(ymm2, 0x0D2)
# ymm0 = vpshuflw(ymm3, 0x4E)
# s.add(ymm0.reversed ==
#       0x92f5f9ce15de97eeb5109e3b20191bc0bc24c2308a5223d3c7479a3790d58eed)
# s.eval(x, 2)
