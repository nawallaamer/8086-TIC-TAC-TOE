[ORG 0X0100]
jmp START
string: db "~TIC TAC TOE~"
string1: db "Press ENTER to Start"
string2: db "Press SPACEBAR to Play Again"
string3: db "Press ESC to Quit"
string4: db "Presented by: NAWALL AAMER"
string5: db "GAME IS OVER!!!"
str: db "~TIC TAC TOE~"
str1: db "Input Guidance."
str2: db "MATCH DRAW!!!"
array: db 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p'
msg1: db "PLAYER X WINS!"
msg2: db "PLAYER 0 WINS!"
vic: dw 0
rand: dw 0

a: dw 0
b: dw 0
c: dw 0
d: dw 0
e: dw 0
f: dw 0
g: dw 0
h: dw 0
i: dw 0
j: dw 0
k: dw 0
l: dw 0
m: dw 0
n: dw 0
o: dw 0
p: dw 0


CLRSCR:
push es
push ax
push cx
push di
mov ax,0xb800
mov es,ax
xor di,di
mov ax,0x0720
mov cx, 2000
cld
rep stosw
pop di
pop cx
pop ax
pop es
ret 

TITLE:
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,13
mov di, 384         ;in second line so 160+64
mov si, str
titll:
mov al, [si]
mov ah, 0x86        ;blinking orange foreground on black background 
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne titll
pop si
pop di
pop cx
pop es
pop ax
ret

SAMPLE:
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,15
mov di, 2560        ;below grid 1
mov si, str1
l1:
mov al, [si]
mov ah, 0x7          ;black background with white foreground 
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne l1
pop si
pop di
pop cx
pop es
pop ax
ret

MATCH_DRAW:
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,13
mov di, 2946       
mov si, str2
l7:
mov al, [si]
mov ah, 0x86        ;blinking orange foreground on black background 
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne l7
pop si
pop di
pop cx
pop es
pop ax
ret


GINPUT:
pusha
mov ax,0xb800
mov es,ax
mov di, 802       
mov bx,0  
l2:
mov al, [array+bx]
mov ah, 0x7
mov [es:di], ax
inc bx
add di,8
cmp bx,4
jne l2

mov di, 1122     
mov bx,4  
l3:
mov al, [array+bx]
mov ah, 0x7
mov [es:di], ax
inc bx
add di,8
cmp bx,8
jne l3
                                             
mov di, 1442                                 
mov bx,8
l4:
mov al, [array+bx]
mov ah, 0x7
mov [es:di], ax
inc bx
add di,8
cmp bx,12
jne l4

mov di, 1762      
mov bx,12  
l5:
mov al, [array+bx]
mov ah, 0x7
mov [es:di], ax
inc bx
add di,8
cmp bx,16
jne l5
popa
ret

GRID:
push di
push cx
push ax
mov ax,0xb800
mov es,ax
mov di, 960
mov cx, 990
mov ax, 0x012D         ;horizontal lines printed in blue colour with black background
call HORIZONTAL
mov di, 1280
mov cx, 1310
mov ax, 0x012D
call HORIZONTAL
mov di, 1600
mov cx, 1630
mov ax,0x012D
call HORIZONTAL
mov di, 646
mov cx, 2086
mov ax, 0x017C   ;vertical lines printed in blue colour with black background 
call VERTICAL
mov di, 654
mov cx, 2094
mov ax,0x017C
call VERTICAL
mov di, 662
mov cx, 2102
mov ax, 0x017C
call VERTICAL 
pop ax
pop cx
pop di
ret

GRID1:
push di 
push cx
push ax
mov ax,0xb800
mov es,ax
mov di, 1024
mov cx, 1054
mov ax, 0x012D
call HORIZONTAL
mov di, 1344
mov cx, 1374
mov ax, 0x012D
call HORIZONTAL
mov di, 1664
mov cx, 1694
mov ax,0x012D
call HORIZONTAL
mov di, 710
mov cx, 2150
mov ax, 0x017C
call VERTICAL
mov di, 718
mov cx, 2158
mov ax, 0x017C
call VERTICAL
mov di, 726
mov cx, 2166
mov ax, 0x017C
call VERTICAL
pop ax
pop cx
pop di
ret

SCREEN1:
                        ;print title 
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,13
mov di, 384         
mov si, string
loop1:
mov al, [si]
mov ah, 0x82         ;white background with green foreground but blinking
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop1

                  ;printing message 1 to start
mov cx,20
mov di, 1818       
mov si, string1
loop2:
mov al, [si]
mov ah, 0x6         ;black background with orange foreground
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop2

                 ;printing message2 to play again
mov cx,28
mov di, 1970       
mov si, string2
loop3:
mov al, [si]
mov ah, 0x6         ;black background with orange foreground
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop3

                     ;printing message3 to quit
mov cx,17
mov di, 2140      
mov si, string3
loop4:
mov al, [si]
mov ah, 0x6         ;black background with orange foreground
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop4

                   ;printing presented by message
mov cx,26
mov di, 3360        
mov si, string4
loop5:
mov al, [si]
mov ah, 0x7         ;white foreground with black background
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop5

pop si
pop di
pop cx
pop es
pop ax
ret

GAME_OVER:
push ax
push es
push cx
push di
push si
call CLRSCR
mov ax,0xb800
mov es,ax
mov cx,15
mov di, 1984
mov si, string5
loop6:
mov al, [si]
mov ah, 82h            ;black background with green foreground but blinking
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne loop6
pop si
pop di
pop cx
pop es
pop ax
ret   

OPTION:
mov ah,0
int 16h
cmp al,1Bh                 ;comparing ascii of esc
jne NEXT_CHAR
call GAME_OVER
jmp exit
NEXT_CHAR:
cmp al,0x0D                ;comparing ascii of enter
jne OPTION 
call CLRSCR
call TITLE
call GRID
call GRID1
call SAMPLE
call GINPUT
mov cx,0
cmp word[rand],0
je r
call INPUT2
jmp exit
r:
call INPUT
exit:
ret

HORIZONTAL:
mov [es:di], ax
add di, 2
cmp di,cx
jne HORIZONTAL
ret

VERTICAL:
mov [es:di],ax
add di, 160
cmp di,cx
jne VERTICAL
ret

GenRandNum:
push bp
mov bp,sp;
push cx
push ax
push dx;

MOV AH, 00h                      ; interrupts to get system time
INT 1AH                          ; CX:DX now hold number of clock ticks since midnight
mov ax, dx
xor dx, dx
mov cx, 2
div cx                           ; here dx contains the remainder of the division - from 0 to 9

mov word[rand],dx


pop cx;
pop ax;
pop dx;
pop bp;
ret

line1:
mov dx,0
mov dx,[a]
cmp dx,[b]
je checklineone1
jmp exit_line1
checklineone1:
mov dx,[b]
cmp dx,[c]
je checklineone2
jmp exit_line1
checklineone2:
mov dx,[c]
cmp dx,[d]
jne exit_line1
mov word[vic],1
cmp dx,1
jne x_player
call PLAYER0
jmp exit_line1
x_player:
call PLAYERX
exit_line1:
ret

line2:
mov dx,0
mov dx,[e]
cmp dx,[f]
je checklinetwo1
jmp exit_line2
checklinetwo1:
mov dx,[f]
cmp dx,[g]
je checklinetwo2
jmp exit_line2
checklinetwo2:
mov dx,[g]
cmp dx,[h]
jne exit_line2
mov word[vic],1
cmp dx,1
jne x_player1
call PLAYER0
jmp exit_line2
x_player1:
call PLAYERX
exit_line2:
ret

line3:
mov dx,0
mov dx,[i]
cmp dx,[j]
je checklinethree1
jmp exit_line3
checklinethree1:
mov dx,[j]
cmp dx,[k]
je checklinethree2
jmp exit_line3
checklinethree2:
mov dx,[k]
cmp dx,[l]
jne exit_line3
mov word[vic],1
cmp dx,1
jne x_player2
call PLAYER0
jmp exit_line3
x_player2:
call PLAYERX
exit_line3:
ret

line4:
mov dx,0
mov dx,[m]
cmp dx,[n]
je checklinefour1
jmp exit_line4
checklinefour1:
mov dx,[n]
cmp dx,[o]
je checklinefour2
jmp exit_line4
checklinefour2:
mov dx,[o]
cmp dx,[p]
jne exit_line4
mov word[vic],1
cmp dx,1
jne x_player3
call PLAYER0
jmp exit_line4
x_player3:
call PLAYERX
exit_line4:
ret

line5:
mov dx,0
mov dx,[a]
cmp dx,[e]
je checklinefive1
jmp exit_line5
checklinefive1:
mov dx,[e]
cmp dx,[i]
je checklinefive2
jmp exit_line5
checklinefive2:
mov dx,[i]
cmp dx,[m]
jne exit_line5
mov word[vic],1
cmp dx,1
jne x_player4
call PLAYER0
jmp exit_line5
x_player4:
call PLAYERX
exit_line5:
ret

line6:
mov dx,0
mov dx,[b]
cmp dx,[f]
je checklinesix1
jmp exit_line6
checklinesix1:
mov dx,[f]
cmp dx,[j]
je checklinesix2
jmp exit_line6
checklinesix2:
mov dx,[j]
cmp dx,[n]
jne exit_line6
mov word[vic],1
cmp dx,1
jne x_player5
call PLAYER0
jmp exit_line6
x_player5:
call PLAYERX
exit_line6:
ret

line7:
mov dx,0
mov dx,[c]
cmp dx,[g]
je checklineseven1
jmp exit_line7
checklineseven1:
mov dx,[g]
cmp dx,[k]
je checklineseven2
jmp exit_line7
checklineseven2:
mov dx,[k]
cmp dx,[o]
jne exit_line7
mov word[vic],1
cmp dx,1
jne x_player6
call PLAYER0
jmp exit_line7
x_player6:
call PLAYERX
exit_line7:
ret

line8:
mov dx,0
mov dx,[d]
cmp dx,[h]
je checklineeight1
jmp exit_line8
checklineeight1:
mov dx,[h]
cmp dx,[l]
je checklineeight2
jmp exit_line8
checklineeight2:
mov dx,[l]
cmp dx,[p]
jne exit_line8
mov word[vic],1
cmp dx,1
jne x_player7
call PLAYER0
jmp exit_line8
x_player7:
call PLAYERX
exit_line8:
ret

line9:
mov dx,0
mov dx,[a]
cmp dx,[f]
je checklinenine1
jmp exit_line9
checklinenine1:
mov dx,[f]
cmp dx,[k]
je checklinenine2
jmp exit_line9
checklinenine2:
mov dx,[k]
cmp dx,[p]
jne exit_line9
mov word[vic],1
cmp dx,1
jne x_player8
call PLAYER0
jmp exit_line9
x_player8:
call PLAYERX
exit_line9:
ret

line10:
mov dx,0
mov dx,[d]
cmp dx,[g]
je checklineten1
jmp exit_line10
checklineten1:
mov dx,[g]
cmp dx,[j]
je checklineten2
jmp exit_line10
checklineten2:
mov dx,[j]
cmp dx,[m]
jne exit_line10
mov word[vic],1
cmp dx,1
jne x_player9
call PLAYER0
jmp exit_line10
x_player9:
call PLAYERX
exit_line10:
ret

PLAYERX:                  ;player x wins message print krwanai k liye
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,14
mov di, 2944
mov si, msg1
lo:
mov al, [si]
mov ah, 0x86             ;black background with white foreground 
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne lo
pop si
pop di
pop cx
pop es
pop ax
ret

PLAYER0:                ; PLAYER 0 WINS PRINT KRWANAI K LIYE
push ax
push es
push cx
push di
push si
mov ax, 0xb800
mov es,ax
mov cx,14
mov di, 2944
mov si, msg2
lo1:
mov al, [si]
mov ah, 0x86             ;black background with white foreground 
mov [es:di], ax
dec cx
inc si
add di,2
cmp cx,0
jne lo1
pop si
pop di
pop cx
pop es
pop ax
ret

INPUT:                   ;input for the main game grid 
inc cx
cmp cx,17
je exit1
xor bx,bx

IN:
mov ah,0 
int 16h

cmp al,0x61             ;ascii of a
jne nextchar1 
cmp bx, [a]
jne IN
mov ah,0x7
mov al,0x58             ;ascii of X to print
mov di,866
mov [es:di], ax
add word[a],2
call line1
call line5
call line9
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar1:
cmp al,0x62             ;ascii of b
jne nextchar2
cmp bx,[b]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 874
mov [es:di],ax
add word[b],2
call line1
call line6
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar2:
cmp al, 0x63            ;ascii of c
jne nextchar3
cmp bx,[c]
jne IN
mov ah,0x7
mov al,0x58
mov di, 882
mov [es:di],ax
add word[c],2
call line1
call line7
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar3:
cmp al, 0x64            ;ascii of d
jne nextchar4
cmp bx, [d]
jne IN
mov ah,0x7
mov al, 0x58 
mov di, 890
mov [es:di],ax
add word[d],2
call line1
call line10
call line8
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar4:
cmp al, 0x65            ;ascii of e
jne nextchar5
cmp bx, [e]
jne IN
mov ah,0x7
mov al,0x58
mov di, 1186
mov [es:di],ax
add word[e],2
call line2
call line5
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar5:
cmp al, 0x66            ;ascii of f
jne nextchar6
cmp bx, [f]
jne IN
mov ah,0x7
mov al,0x58
mov di,1194
mov [es:di],ax
add word[f],2
call line2
call line9
call line6
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar6:
cmp al, 0x67            ;ascii of g
jne nextchar7
cmp bx, [g]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 1202
mov [es:di],ax
add word[g],2
call line2
call line10
call line7
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar7:
cmp al, 0x68            ;ascii of h
jne nextchar8
cmp bx, [h] 
jne IN
mov ah,0x7
mov al,0x58
mov di, 1210
mov [es:di],ax
add word[h],2
call line2
call line8
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar8:
cmp al, 0x69            ;ascii of i
jne nextchar9
cmp bx, [i]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 1506
mov [es:di],ax
add word[i],2
call line3
call line5
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar9:
cmp al, 0x6A            ;ascii of j
jne nextchar10
cmp bx, [j]
jne IN
mov ah,0x7
mov al,0x58
mov di,1514
mov [es:di],ax
add word[j],2
call line3
call line10
call line6
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar10:
cmp al, 0x6B
jne nextchar11
cmp bx, [k]
jne IN
mov ah,0x7
mov al,0x58
mov di,1522
mov [es:di],ax
add word[k],2
call line3
call line7
call line9
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar11:
cmp al,0x6C
jne nextchar12
cmp bx, [l]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 1530
mov [es:di],ax
add word[l],2
call line3
call line8
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar12:
cmp al, 0x6D
jne nextchar13
cmp bx, [m]
jne IN
mov ah,0x7
mov al, 0x58 
mov di, 1826
mov [es:di],ax
add word[m],2
call line10
call line4
call line5
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar13:
cmp al, 0x6E
jne nextchar14
cmp bx,[n]
jne IN
mov ah,0x7
mov al,0x58
mov di, 1834
mov [es:di],ax
add word[n],2
call line4
call line6
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar14:
cmp al, 0x6F
jne nextchar15
cmp bx, [o]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 1842
mov [es:di],ax
add word[o],2
call line4
call line7
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

nextchar15:
cmp al, 70h
jne IN
cmp bx, [p]
jne IN
mov ah,0x7
mov al, 0x58
mov di, 1850
mov [es:di],ax
add word[p],2
call line4
call line8
call line9
cmp word[vic],1
je exit_ret
call INPUT2
jmp exit_ret

exit1:
call MATCH_DRAW
exit_ret:
ret

INPUT2:
inc cx
cmp cx,17
je exit2
xor bx,bx

IN1:
mov ah,0 
int 16h

cmp al,0x61                 ;ascii of a
jne next_char1 
cmp bx, [a]
jne IN1
mov ah,0x7
mov al,0x30                 ;ascii of 0 to print
mov di,866
mov [es:di], ax
inc word[a]
call line1
call line5
call line9
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char1:
cmp al,0x62                 ;ascii of b
jne next_char2
cmp bx, [b]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 874
mov [es:di],ax
inc word[b]
call line1
call line6
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char2:
cmp al, 0x63                ;ascii of c
jne next_char3
cmp bx, [c]
jne IN1
mov ah,0x7
mov al,0x30
mov di, 882
mov [es:di],ax
inc word[c]
call line1
call line7
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char3:
cmp al, 0x64                ;ascii of d
jne next_char4
cmp bx, [d]
jne IN1
mov ah,0x7
mov al, 0x30 
mov di, 890
mov [es:di],ax
inc word[d]
call line1
call line10
call line8
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char4:
cmp al, 0x65                ;ascii of e
jne next_char5
cmp bx, [e]
jne IN1
mov ah,0x7
mov al,0x30
mov di, 1186
mov [es:di],ax
inc word[e]
call line2
call line5
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char5:
cmp al, 0x66                ;ascii of f
jne next_char6
cmp bx, [f]
jne IN1
mov ah,0x7
mov al,0x30
mov di,1194
mov [es:di],ax
inc word[f]
call line2
call line9
call line6
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char6:
cmp al, 0x67    ;ascii of g
jne next_char7
cmp bx, [g]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 1202
mov [es:di],ax
inc word[g]
call line2
call line10
call line7
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char7:
cmp al, 0x68    ;ascii of h
jne next_char8
cmp bx, [h]
jne IN1
mov ah,0x7
mov al,0x30
mov di, 1210
mov [es:di],ax
inc word[h]
call line2
call line8
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char8:
cmp al, 0x69    ;ascii of i
jne next_char9
cmp bx, [i]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 1506
mov [es:di],ax
inc word[i]
call line3
call line5
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char9:
cmp al, 0x6A    ;ascii of j
jne next_char10
cmp bx, [j]
jne IN1
mov ah,0x7
mov al,0x30
mov di,1514
mov [es:di],ax
inc word[j]
call line3
call line10
call line6
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char10:
cmp al, 0x6B
jne next_char11
cmp bx, [k]
jne IN1
mov ah,0x7
mov al,0x30
mov di,1522
mov [es:di],ax
inc word[k]
call line3
call line7
call line9
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char11:
cmp al,0x6C
jne next_char12
cmp bx, [l]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 1530
mov [es:di],ax
inc word[l]
call line3
call line8
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char12:
cmp al, 0x6D
jne next_char13
cmp bx, [m]
jne IN1
mov ah,0x7
mov al, 0x30 
mov di, 1826
mov [es:di],ax
inc word[m]
call line10
call line4
call line5
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char13:
cmp al, 0x6E
jne next_char14
cmp bx, [n]
jne IN1
mov ah,0x7
mov al,0x30
mov di, 1834
mov [es:di],ax
inc word[n]
call line4
call line6
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

next_char14:
cmp al, 0x6F
jne next_char15
cmp bx, [o]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 1842
mov [es:di],ax
inc word[o]
call line4
call line7
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1
 
next_char15:
cmp al, 70h
jne IN1
cmp bx, [p]
jne IN1
mov ah,0x7
mov al, 0x30
mov di, 1850
mov [es:di],ax
inc word[p]
call line4
call line8
call line9
cmp word[vic],1
je exit_ret1
call INPUT
jmp exit_ret1

exit2:
call MATCH_DRAW
exit_ret1:
ret

CLEAN:
mov ax,0 
mov bx,0
mov cx,0 
mov dx,0 
mov si,0
mov di,0
mov word[vic],0
mov word[rand],0
mov word[a],0 
mov word[b],0
mov word[c],0
mov word[d],0
mov word[e],0
mov word[f],0
mov word[g],0
mov word[h],0
mov word[i],0
mov word[j],0
mov word[k],0
mov word[l],0
mov word[m],0
mov word[n],0
mov word[o],0
mov word[p],0
ret 

START:
call CLEAN
call CLRSCR
call TITLE
call SCREEN1
call GenRandNum
call OPTION

s:
mov ah,0 
int 16h
cmp al,20h
je START
cmp al,1bh
je start_exit
jmp s

start_exit:
call GAME_OVER
mov ax,0x4c00
int 21h