ShowDebug: .byte 0

.macro StoreState() {

	pha // A
	txa
	pha // X
	tya
	pha // Y

}


.macro RestoreA() {

	asl TED.INTERRUPT_FLAGS
	pla // Y
	rti
}

.macro RestoreState() {
	
	asl TED.INTERRUPT_FLAGS

	pla // Y
	tay
	pla // X
	tax
	pla // A

	rti
}

.macro SetDebugBorder(value) {

	lda ShowDebug
	beq Finish

	lda #value
	sta TED.BORDER_COLOR

	Finish:
}