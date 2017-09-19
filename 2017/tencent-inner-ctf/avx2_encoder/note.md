```bash

cat <<EOF | \
awk '{printf "%s = %s(%s, %s)\n", $2, $1, $3, $4}' | \
awk -F ',' '{printf "%s%s,%s\n", $1, $2, $4}' | \
sed -e 's/,\s\+\(.*\)h)$/, 0x\1)/'
    vpsubq  ymm0, ymm0, cs:ymmword_140002160
    vpshufhw ymm1, ymm0, 0D8h
    vpshufhw ymm0, cs:ymmword_140002160, 2Dh
    vpshuflw ymm5, ymm1, 0D2h
    vpshuflw ymm1, ymm0, 4Eh
    vpsrlq  ymm2, ymm1, 17h
    vpsllq  ymm0, ymm1, 29h
    vpsrlq  ymm3, ymm5, 39h
    vpermq  ymm1, ymm0, 39h
    vpsllq  ymm0, ymm5, 7
    vpxor   ymm4, ymm1, ymm2
    vpermq  ymm1, ymm0, 39h
    vpxor   ymm2, ymm1, ymm3
    vpsllq  ymm0, ymm4, 22h
    vpsrlq  ymm3, ymm4, 1Eh
    vpxor   ymm5, ymm2, ymm4
    vpermq  ymm1, ymm0, 39h
    vpxor   ymm2, ymm1, ymm3
    vpsllq  ymm0, ymm5, 4
    vpshufhw ymm3, ymm2, 0D2h
    vpermq  ymm1, ymm0, 39h
    vpsrlq  ymm2, ymm5, 3Ch
    vpxor   ymm2, ymm1, ymm2
    vpshuflw ymm4, ymm3, 0D8h
    vpshufhw ymm3, ymm2, 4Eh
    vpsrlq  ymm0, ymm4, 25h
    vpsllq  ymm2, ymm4, 1Bh
    vpermq  ymm1, ymm0, 93h
    vpshuflw ymm5, ymm3, 2Dh
    vpor    ymm4, ymm1, ymm2
    vpsrlq  ymm0, ymm5, 34h
    vpsllq  ymm3, ymm5, 0Ch
    vpermq  ymm1, ymm0, 93h
    vpor    ymm2, ymm1, ymm3
    vpaddq  ymm4, ymm2, ymm4
    vpsrlq  ymm0, ymm4, 28h
    vpsllq  ymm3, ymm4, 18h
    vpermq  ymm1, ymm0, 93h
    vpor    ymm2, ymm1, ymm3
    vpshufhw ymm3, ymm2, 0D2h
    vpshuflw ymm0, ymm3, 4Eh
EOF

```