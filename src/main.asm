INCLUDE "gbhw.inc"
; rst vectors
SECTION "rst00",ROM0[0]
    ret

SECTION "rst08",ROM0[8]
    ret

SECTION "rst10",ROM0[$10]
    ret

SECTION "rst18",ROM0[$18]
    ret

SECTION "rst20",ROM0[$20]
    ret

SECTION "rst30",ROM0[$30]
    ret

SECTION "rst38",ROM0[$38]
    ret

SECTION "vblank",ROM0[$40]
    jp VBlank
SECTION "lcdc",ROM0[$48]
    reti
SECTION "timer",ROM0[$50]
    reti
SECTION "serial",ROM0[$58]
    reti
SECTION "joypad",ROM0[$60]
    reti

SECTION "bank0",ROM0[$61]

SECTION "romheader",ROM0[$100]
    nop
    jp Start

Section "start",ROM0[$150]

Start:
	di
	call DisableLCD
	ld hl,$8000
	ld bc,$01A0
	ld a,$00
	call FillMem
	ld hl,$9800
	ld bc,$0233
	call FillMem
	ld a,[wScratch1]
	ld [rLCDC],a
	ei
.loop
    halt
    jr .loop

VBlank:
    reti

DisableLCD:
	ld a,[rLCDC]
	rlca
	ret nc
.loop	ld a,[rLY]
	cp 145
	jr nz,.loop
	ld a,[rLCDC]
	ld [wScratch1],a
	res 7,a
	ld [rLCDC],a
	ret

FillMem:
	inc b
	inc c
	jr .skip
.loop	ld [hl],a
	inc hl
.skip	dec c
	jr nz,.loop
	dec b
	jr nz,.loop
	ret
