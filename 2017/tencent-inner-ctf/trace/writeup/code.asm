[INFO]004005e8                     lui r28, 0x2
[INFO]004005ec       addiu r28, r28, 0xffff8a38
[INFO]004005f0               addu r28, r28, r25
[INFO]004005f4       addiu $sp, $sp, 0xffffffe0
[INFO]004005f8               sw r28, [$sp+0x10]
[INFO]004005fc               sw $ra, [$sp+0x1c]
[INFO]00400600          lw r2, [r28+0xffff804c]
[INFO]00400604                beqz r2, 0x400618
[INFO]00400608                      move r1, r1
[INFO]00400618                     bal 0x400620
[INFO]0040061c                             nop
[INFO]00400620                    lui r28, 0x42
[INFO]00400624       addiu r28, r28, 0xffff9020
[INFO]00400628         lw r25, [r28+0xffff8024]
[INFO]0040062c            addiu r25, r25, 0x80c
[INFO]00400630                     bal 0x40080c
[INFO]00400634                             nop
[INFO]00400638               lw r28, [$sp+0x10]
[INFO]0040063c                     bal 0x400644
[INFO]00400640                             nop
[INFO]00400644                    lui r28, 0x42
[INFO]00400648       addiu r28, r28, 0xffff9020
[INFO]0040064c         lw r25, [r28+0xffff8024]
[INFO]00400650            addiu r25, r25, 0xe80
[INFO]00400654                     bal 0x400e80
[INFO]00400658                             nop
[INFO]0040065c               lw $ra, [$sp+0x1c]
[INFO]00400660                           jr $ra
[INFO]00400664             addiu $sp, $sp, 0x20
[INFO]00400710                     lui r4, 0x41
[INFO]00400714                     lui r2, 0x41
[INFO]00400718             addiu r4, r4, 0x1024
[INFO]0040071c             addiu r2, r2, 0x1024
[INFO]00400720                  subu r2, r2, r4
[INFO]00400724                  sra r2, r2, 0x2
[INFO]00400728                 srl r5, r2, 0x1f
[INFO]0040072c                  addu r5, r5, r2
[INFO]00400730                  sra r5, r5, 0x1
[INFO]00400734                beqz r5, 0x400754
[INFO]00400738                    lui r28, 0x42
[INFO]00400754                           jr $ra
[INFO]00400758                             nop
[INFO]0040080c                     lui r2, 0x41
[INFO]00400810              addiu r4, r2, 0xffc
[INFO]00400814                  lw r2, [r4+0x0]
[INFO]00400818                bnez r2, 0x400828
[INFO]0040081c                    lui r28, 0x42
[INFO]00400820                       j 0x400710
[INFO]00400824                             nop



null_func
[INFO]00400860       addiu $sp, $sp, 0xfffffff8
[INFO]00400864                sw $fp, [$sp+0x4]
[INFO]00400868                    move $fp, $sp
[INFO]0040086c                             nop
[INFO]00400870                    move $sp, $fp
[INFO]00400874                lw $fp, [$sp+0x4]
[INFO]00400878              addiu $sp, $sp, 0x8
[INFO]0040087c                           jr $ra
[INFO]00400880                             nop



strlen
[INFO]strlen       addiu $sp, $sp, 0xffffffd8
[INFO]00400888               sw $ra, [$sp+0x24]
[INFO]0040088c               sw $fp, [$sp+0x20]
[INFO]00400890                    move $fp, $sp
[INFO]00400894                sw r4, [$fp+0x28]
[INFO]00400898                     jal null_func
[INFO]0040089c                             nop
[INFO]004008a0                sw r0, [$fp+0x1c]
[INFO]004008a4                lw r2, [$fp+0x1c]
[INFO]004008a8                lw r3, [$fp+0x28]
[INFO]004008ac                  addu r2, r3, r2
[INFO]004008b0                  lb r2, [r2+0x0]
[INFO]004008b4                bnez r2, 0x4008c8
[INFO]004008b8                             nop

[INFO]004008bc                lw r2, [$fp+0x1c]
[INFO]004008c0                       b 0x4008dc
[INFO]004008c4                             nop

[INFO]004008c8                lw r2, [$fp+0x1c]
[INFO]004008cc                addiu r2, r2, 0x1
[INFO]004008d0                sw r2, [$fp+0x1c]
[INFO]004008d4                       b 0x4008a4
[INFO]004008d8                             nop

[INFO]004008dc                    move $sp, $fp
[INFO]004008e0               lw $ra, [$sp+0x24]
[INFO]004008e4               lw $fp, [$sp+0x20]
[INFO]004008e8             addiu $sp, $sp, 0x28
[INFO]004008ec                           jr $ra
[INFO]004008f0                             nop



strcpy
[INFO]004008f4       addiu $sp, $sp, 0xffffffd8
[INFO]004008f8               sw $ra, [$sp+0x24]
[INFO]004008fc               sw $fp, [$sp+0x20]
[INFO]00400900                    move $fp, $sp
[INFO]00400904                sw r4, [$fp+0x28]
[INFO]00400908                sw r5, [$fp+0x2c]
[INFO]0040090c                     jal null_func
[INFO]00400910                             nop
[INFO]00400914                sw r0, [$fp+0x1c]
[INFO]00400918                       b 0x40094c
[INFO]0040091c                             nop

[INFO]00400920                lw r2, [$fp+0x1c]
[INFO]00400924                lw r3, [$fp+0x28]
[INFO]00400928                  addu r2, r3, r2
[INFO]0040092c                lw r3, [$fp+0x1c]
[INFO]00400930                lw r4, [$fp+0x2c]
[INFO]00400934                  addu r3, r4, r3
[INFO]00400938                  lb r3, [r3+0x0]
[INFO]0040093c                  sb r3, [r2+0x0]
[INFO]00400940                lw r2, [$fp+0x1c]
[INFO]00400944                addiu r2, r2, 0x1
[INFO]00400948                sw r2, [$fp+0x1c]

[INFO]0040094c                lw r2, [$fp+0x1c]
[INFO]00400950                lw r3, [$fp+0x2c]
[INFO]00400954                  addu r2, r3, r2
[INFO]00400958                  lb r2, [r2+0x0]
[INFO]0040095c                bnez r2, 0x400920
[INFO]00400960                             nop

[INFO]00400964                lw r2, [$fp+0x1c]
[INFO]00400968                lw r3, [$fp+0x28]
[INFO]0040096c                  addu r2, r3, r2
[INFO]00400970                  sb r0, [r2+0x0]
[INFO]00400974                             nop
[INFO]00400978                    move $sp, $fp
[INFO]0040097c               lw $ra, [$sp+0x24]
[INFO]00400980               lw $fp, [$sp+0x20]
[INFO]00400984             addiu $sp, $sp, 0x28
[INFO]00400988                           jr $ra
[INFO]0040098c                             nop



qsort(buf, n)
    if (n < 2) {
        return;
    }
    x = buf[0];
    j = 1;
    for (i = 1; i < n; ++i) {
        if (buf[i] < x) {
            tmp = buf[i];
            buf[j] = buf[i];
            buf[i] = tmp;
            ++j;
        }
    }
    tmp = buf[j - 1];
    buf[j - 1] = buf[0];
    buf[0] = tmp;
    qsort(buf, j - 1);
    qsort(buf + j, n - j);

[INFO]00400990       addiu $sp, $sp, 0xffffffd0
[INFO]00400994               sw $ra, [$sp+0x2c]
[INFO]00400998               sw $fp, [$sp+0x28]
[INFO]0040099c                    move $fp, $sp
[INFO]004009a0                sw r4, [$fp+buf]
[INFO]004009a4                sw r5, [$fp+n]
[INFO]004009a8                     jal null_func
[INFO]004009ac                             nop
[INFO]004009b0                lw r2, [$fp+n]
[INFO]004009b4                 slti r2, r2, 0x2
[INFO]004009b8                bnez r2, out
[INFO]004009bc                             nop

[INFO]004009c0                lw r2, [$fp+buf]
[INFO]004009c4                 lbu r2, [r2+0x0]
[INFO]004009c8                sb r2, [$fp+x]    ; x = buf[0]
[INFO]004009cc                addiu r2, r0, 0x1
[INFO]004009d0                sw r2, [$fp+j]    ; j = 1
[INFO]004009d4                addiu r2, r0, 0x1
[INFO]004009d8                sw r2, [$fp+i]    ; i = 1
[INFO]004009dc                       b 0x400a64
[INFO]004009e0                             nop

[INFO]004009e4                lw r2, [$fp+i]
[INFO]004009e8                lw r3, [$fp+buf]
[INFO]004009ec                  addu r2, r3, r2
[INFO]004009f0                  lb r2, [r2+0x0]
[INFO]004009f4                lb r3, [$fp+x]
[INFO]004009f8                   slt r2, r2, r3
[INFO]004009fc                beqz r2, 0x400a58 ; branch if buf[i] >= x
[INFO]00400a00                             nop

[INFO]00400a04                lw r2, [$fp+j]
[INFO]00400a08                lw r3, [$fp+buf]
[INFO]00400a0c                  addu r2, r3, r2
[INFO]00400a10                 lbu r2, [r2+0x0]
[INFO]00400a14                sb r2, [$fp+tmp] ; tmp = buf[j]
[INFO]00400a18                lw r2, [$fp+j]
[INFO]00400a1c                lw r3, [$fp+buf]
[INFO]00400a20                  addu r2, r3, r2
[INFO]00400a24                lw r3, [$fp+i]
[INFO]00400a28                lw r4, [$fp+buf]
[INFO]00400a2c                  addu r3, r4, r3
[INFO]00400a30                  lb r3, [r3+0x0]
[INFO]00400a34                  sb r3, [r2+0x0] ; buf[j] = buf[i]
[INFO]00400a38                lw r2, [$fp+i]
[INFO]00400a3c                lw r3, [$fp+buf]
[INFO]00400a40                  addu r2, r3, r2
[INFO]00400a44               lbu r3, [$fp+tmp]
[INFO]00400a48                  sb r3, [r2+0x0] ; buf[i] = tmp
[INFO]00400a4c                lw r2, [$fp+j]
[INFO]00400a50                addiu r2, r2, 0x1
[INFO]00400a54                sw r2, [$fp+j]    ; j = j + 1

[INFO]00400a58                lw r2, [$fp+i]
[INFO]00400a5c                addiu r2, r2, 0x1
[INFO]00400a60                sw r2, [$fp+i]    ; i = i + 1

[INFO]00400a64                lw r3, [$fp+i]
[INFO]00400a68                lw r2, [$fp+n]
[INFO]00400a6c                   slt r2, r3, r2
[INFO]00400a70                bnez r2, 0x4009e4 ; branch loop if i < n
[INFO]00400a74                             nop

[INFO]00400a78                lw r2, [$fp+j]
[INFO]00400a7c         addiu r2, r2, 0xffffffff
[INFO]00400a80                lw r3, [$fp+buf]
[INFO]00400a84                  addu r2, r3, r2
[INFO]00400a88                 lbu r2, [r2+0x0]
[INFO]00400a8c                sb r2, [$fp+tmp]  ; tmp = buf[j - 1]
[INFO]00400a90                lw r2, [$fp+j]
[INFO]00400a94         addiu r2, r2, 0xffffffff
[INFO]00400a98                lw r3, [$fp+buf]
[INFO]00400a9c                  addu r2, r3, r2
[INFO]00400aa0                lw r3, [$fp+buf]
[INFO]00400aa4                  lb r3, [r3+0x0]
[INFO]00400aa8                  sb r3, [r2+0x0] ; buf[j - 1] = buf[0]
[INFO]00400aac                lw r2, [$fp+buf]
[INFO]00400ab0               lbu r3, [$fp+tmp]
[INFO]00400ab4                  sb r3, [r2+0x0] ; buf[0] = tmp
[INFO]00400ab8                lw r2, [$fp+j]
[INFO]00400abc         addiu r2, r2, 0xffffffff
[INFO]00400ac0                      move r5, r2
[INFO]00400ac4                lw r4, [$fp+buf]
[INFO]00400ac8                     jal qsort    ; call qsort(buf, j - 1)
[INFO]00400acc                             nop
[INFO]00400ad0                lw r2, [$fp+j]
[INFO]00400ad4                lw r3, [$fp+buf]
[INFO]00400ad8                  addu r4, r3, r2
[INFO]00400adc                lw r3, [$fp+n]
[INFO]00400ae0                lw r2, [$fp+j]
[INFO]00400ae4                  subu r2, r3, r2
[INFO]00400ae8                      move r5, r2
[INFO]00400aec                     jal qsort    ; call qsort(buf + j, n - j)
[INFO]00400af0                             nop
[INFO]00400af4                       b 0x400b00
[INFO]00400af8                             nop

out
[INFO]00400afc                             nop
[INFO]00400b00                    move $sp, $fp
[INFO]00400b04               lw $ra, [$sp+0x2c]
[INFO]00400b08               lw $fp, [$sp+0x28]
[INFO]00400b0c             addiu $sp, $sp, 0x30
[INFO]00400b10                           jr $ra
[INFO]00400b14                             nop



callback
[INFO]00400b18       addiu $sp, $sp, 0xfffffec0
[INFO]00400b1c              sw $ra, [$sp+0x13c]
[INFO]00400b20              sw $fp, [$sp+0x138]
[INFO]00400b24                    move $fp, $sp
[INFO]00400b28                    lui r28, 0x42
[INFO]00400b2c       addiu r28, r28, 0xffff9020
[INFO]00400b30               sw r28, [$sp+buf_0x419020] ; +buf_0x419020 = 0x419020
[INFO]00400b34          lw r2, [r28+0xffff8058] ; r2 = *(int*)0x411078
[INFO]00400b38                  lw r2, [r2+0x0]
[INFO]00400b3c               sw r2, [$fp+0x134] ; +0x134 = *(char *)r2
[INFO]00400b40                     lui r2, 0x41
[INFO]00400b44               lw r2, [r2+0x1010] ; r2 = flag
[INFO]00400b48                      move r4, r2
[INFO]00400b4c                     jal strlen   ; call strlen(flag)
[INFO]00400b50                             nop
[INFO]00400b54               lw r28, [$fp+buf_0x419020]
[INFO]00400b58                sw r2, [$fp+x] ; +x = flag
[INFO]00400b5c                sw r0, [$fp+i]    ; i = 0
[INFO]00400b60                       b 0x400b9c
[INFO]00400b64                             nop

[INFO]00400b68                lw r2, [$fp+i]
[INFO]00400b6c                andi r2, r2, 0xff
[INFO]00400b70               addiu r2, r2, 0x61
[INFO]00400b74                andi r2, r2, 0xff
[INFO]00400b78                 sll r3, r2, 0x18
[INFO]00400b7c                 sra r3, r3, 0x18
[INFO]00400b80                lw r2, [$fp+i]
[INFO]00400b84             addiu r4, $fp, 0x138
[INFO]00400b88                  addu r2, r4, r2
[INFO]00400b8c           sb r3, [r2+data] ; data[i] = i + 'A'
[INFO]00400b90                lw r2, [$fp+i]
[INFO]00400b94                addiu r2, r2, 0x1
[INFO]00400b98                sw r2, [$fp+i]    ; i = i + 1

[INFO]00400b9c                lw r2, [$fp+i]
[INFO]00400ba0                slti r2, r2, 0x1a
[INFO]00400ba4                bnez r2, 0x400b68 ; branch if i < 0x1a
[INFO]00400ba8                             nop

[INFO]00400bac                sw r0, [$fp+j]
[INFO]00400bb0                       b 0x400bf0
[INFO]00400bb4                             nop  ; j = 0

[INFO]00400bb8                lw r2, [$fp+j]
[INFO]00400bbc               addiu r2, r2, 0x1a
[INFO]00400bc0                lw r3, [$fp+j]
[INFO]00400bc4                andi r3, r3, 0xff
[INFO]00400bc8               addiu r3, r3, 0x41
[INFO]00400bcc                andi r3, r3, 0xff
[INFO]00400bd0                 sll r3, r3, 0x18
[INFO]00400bd4                 sra r3, r3, 0x18
[INFO]00400bd8             addiu r4, $fp, 0x138
[INFO]00400bdc                  addu r2, r4, r2
[INFO]00400be0           sb r3, [r2+data] ; data[j + 0x1a] = j + 'a'
[INFO]00400be4                lw r2, [$fp+j]
[INFO]00400be8                addiu r2, r2, 0x1
[INFO]00400bec                sw r2, [$fp+j]    ; j = j + 1

[INFO]00400bf0                lw r2, [$fp+j]
[INFO]00400bf4                slti r2, r2, 0x1a
[INFO]00400bf8                bnez r2, 0x400bb8 ; branch if j < 0x1a
[INFO]00400bfc                             nop

[INFO]00400c00                sw r0, [$fp+k]
[INFO]00400c04                       b 0x400c44
[INFO]00400c08                             nop

[INFO]00400c0c                lw r2, [$fp+k]
[INFO]00400c10               addiu r2, r2, 0x34
[INFO]00400c14                lw r3, [$fp+k]
[INFO]00400c18                andi r3, r3, 0xff
[INFO]00400c1c               addiu r3, r3, 0x30
[INFO]00400c20                andi r3, r3, 0xff
[INFO]00400c24                 sll r3, r3, 0x18
[INFO]00400c28                 sra r3, r3, 0x18
[INFO]00400c2c             addiu r4, $fp, 0x138
[INFO]00400c30                  addu r2, r4, r2
[INFO]00400c34           sb r3, [r2+data] ; data[k + 0xa] = k + '0'
[INFO]00400c38                lw r2, [$fp+k]
[INFO]00400c3c                addiu r2, r2, 0x1
[INFO]00400c40                sw r2, [$fp+k]    ; k = k + 1

[INFO]00400c44                lw r2, [$fp+k]
[INFO]00400c48                 slti r2, r2, 0xa
[INFO]00400c4c                bnez r2, 0x400c0c ; branch if k < 0xa
[INFO]00400c50                             nop

[INFO]00400c54               addiu r2, r0, 0x7b
[INFO]00400c58                sb r2, [$fp+0x72] ; data[62] = '{'
[INFO]00400c5c               addiu r2, r0, 0x7d
[INFO]00400c60                sb r2, [$fp+0x73] ; data[63] = '}'
[INFO]00400c64               addiu r2, r0, 0x5f
[INFO]00400c68                sb r2, [$fp+0x74] ; data[64] = '_'
[INFO]00400c6c                     lui r2, 0x41
[INFO]00400c70               lw r3, [r2+0x1010]
[INFO]00400c74              addiu r2, $fp, 0x34
[INFO]00400c78               addiu r2, r2, 0x41
[INFO]00400c7c                      move r5, r3
[INFO]00400c80                      move r4, r2
[INFO]00400c84                     jal strcpy   ; call strcpy(data + 65, flag)
[INFO]00400c88                             nop
[INFO]00400c8c               lw r28, [$fp+buf_0x419020]
[INFO]00400c90              addiu r2, $fp, 0x34
[INFO]00400c94                      move r4, r2
[INFO]00400c98                     jal strlen   ; call strlen(data) -> data_len
[INFO]00400c9c                             nop
[INFO]00400ca0               lw r28, [$fp+buf_0x419020]
[INFO]00400ca4                      move r3, r2
[INFO]00400ca8              addiu r2, $fp, 0x34
[INFO]00400cac                      move r5, r3
[INFO]00400cb0                      move r4, r2
[INFO]00400cb4                     jal qsort    ; qsort(data, data_len)
[INFO]00400cb8                             nop
[INFO]00400cbc               lw r28, [$fp+buf_0x419020]
[INFO]00400cc0              addiu r2, $fp, 0x34
[INFO]00400cc4                      move r4, r2
[INFO]00400cc8                     jal strlen   ; call strlen(data) -> data_len
[INFO]00400ccc                             nop
[INFO]00400cd0               lw r28, [$fp+buf_0x419020]
[INFO]00400cd4                sw r2, [$fp+x]    ; x = data_len
[INFO]00400cd8                sw r0, [$fp+cnt]  ; cnt = 0
[INFO]00400cdc                sw r0, [$fp+ii]   ; ii = 0
[INFO]00400ce0                       b 0x400d2c
[INFO]00400ce4                             nop

[INFO]00400ce8                lw r2, [$fp+ii]
[INFO]00400cec             addiu r3, $fp, 0x138
[INFO]00400cf0                  addu r2, r3, r2
[INFO]00400cf4           lb r3, [r2+data]
[INFO]00400cf8                lw r2, [$fp+ii]
[INFO]00400cfc                addiu r2, r2, 0x1
[INFO]00400d00             addiu r4, $fp, 0x138
[INFO]00400d04                  addu r2, r4, r2
[INFO]00400d08           lb r2, [r2+data]
[INFO]00400d0c             beq r3, r2, 0x400d20 ; branch if data[i] == data[i + 1]
[INFO]00400d10                             nop

[INFO]00400d14                lw r2, [$fp+cnt]
[INFO]00400d18                addiu r2, r2, 0x1
[INFO]00400d1c                sw r2, [$fp+cnt]  ; cnt = cnt + 1

[INFO]00400d20                lw r2, [$fp+ii]
[INFO]00400d24                addiu r2, r2, 0x1
[INFO]00400d28                sw r2, [$fp+ii]   ; ii = ii + 1

[INFO]00400d2c                lw r2, [$fp+x]
[INFO]00400d30         addiu r3, r2, 0xffffffff
[INFO]00400d34                lw r2, [$fp+ii]
[INFO]00400d38                   slt r2, r2, r3
[INFO]00400d3c                bnez r2, 0x400ce8 ; branch if ii < data_len - 1
[INFO]00400d40                             nop

[INFO]00400d44                lw r3, [$fp+cnt]
[INFO]00400d48               addiu r2, r0, 0x40
[INFO]00400d4c             beq r3, r2, 0x400d68 ; branch if cnt == 0x40
[INFO]00400d50                             nop

[INFO]00400d68              addiu r2, $fp, 0x34
[INFO]00400d6c                      move r4, r2
[INFO]00400d70          lw r2, [r28+0xffff8050]
[INFO]00400d74                     move r25, r2
[INFO]00400d78                         jalr r25
[INFO]00400d7c                             nop



_start
[INFO]00400dd0                     lui r28, 0x2
[INFO]00400dd4       addiu r28, r28, 0xffff8250
[INFO]00400dd8               addu r28, r28, r25
[INFO]00400ddc       addiu $sp, $sp, 0xffffffc8
[INFO]00400de0         lw r25, [r28+0xffff8028]
[INFO]00400de4               sw r28, [$sp+0x10]
[INFO]00400de8               sw r21, [$sp+0x30]
[INFO]00400dec                     move r21, r6
[INFO]00400df0               sw r20, [$sp+0x2c]
[INFO]00400df4                     move r20, r5
[INFO]00400df8               sw r19, [$sp+0x28]
[INFO]00400dfc                     move r19, r4
[INFO]00400e00               sw r18, [$sp+0x24]
[INFO]00400e04               sw r16, [$sp+0x1c]
[INFO]00400e08               sw $ra, [$sp+0x34]
[INFO]00400e0c                     bal 0x4005e8
[INFO]00400e10               sw r17, [$sp+0x20]
[INFO]00400e14               lw r28, [$sp+0x10]
[INFO]00400e18         lw r16, [r28+0xffff802c]
[INFO]00400e1c         lw r18, [r28+0xffff802c]
[INFO]00400e20               subu r18, r18, r16
[INFO]00400e24                sra r18, r18, 0x2
[INFO]00400e28               beqz r18, 0x400e50
[INFO]00400e2c                     move r17, r0
[INFO]00400e50               lw $ra, [$sp+0x34]
[INFO]00400e54               lw r21, [$sp+0x30]
[INFO]00400e58               lw r20, [$sp+0x2c]
[INFO]00400e5c               lw r19, [$sp+0x28]
[INFO]00400e60               lw r18, [$sp+0x24]
[INFO]00400e64               lw r17, [$sp+0x20]
[INFO]00400e68               lw r16, [$sp+0x1c]
[INFO]00400e6c                           jr $ra
[INFO]00400e70             addiu $sp, $sp, 0x38
[INFO]00400e80                     lui r3, 0x41
[INFO]00400e84         addiu r2, r0, 0xffffffff
[INFO]00400e88               lw r25, [r3+0xfec]
[INFO]00400e8c            beq r25, r2, 0x400ecc
[INFO]00400e90                             nop
[INFO]00400ecc                           jr $ra
[INFO]00400ed0                             nop
[INFO]callback from library, target address: 0x400b18
