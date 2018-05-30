RedsHouse1FScript:
	jp EnableAutoTextBoxDrawing

RedsHouse1FTextPointers:
	dw RedsHouse1FText1
	dw RedsHouse1FText2

RedsHouse1FText1: ; Mom
	TX_ASM
	ld a, [wd72e]
	bit 3, a
	jr nz, .heal ; if player has received a Pokémon from Oak, heal team
	ld a, [wPlayerGender]
	or a
	ld hl, MomWakeUpText1Boy
	jr z, .print
	ld hl, MomWakeUpText1Girl
.print
	call PrintText
	ld hl, MomWakeUpText2
	call PrintText
	jr .done
.heal
	call MomHealPokemon
.done
	jp TextScriptEnd

MomWakeUpText1Boy:
	TX_FAR _MomWakeUpText1Boy
	db "@"
MomWakeUpText1Girl:
	TX_FAR _MomWakeUpText1Girl
	db "@"
MomWakeUpText2:
	TX_FAR _MomWakeUpText2
	db "@"

MomHealPokemon:
	ld hl, MomHealText1
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, MomHealText2
	jp PrintText

MomHealText1:
	TX_FAR _MomHealText1
	db "@"
MomHealText2:
	TX_FAR _MomHealText2
	db "@"

RedsHouse1FText2: ; TV
	TX_ASM
	ld a, [wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	ld hl, TVWrongSideText
	jr nz, .print
	ld a, [wPlayerGender]
	or a
	ld hl, StandByMeText
	jr z, .print
	ld hl, WizardOfOzText
.print
	call PrintText
	jp TextScriptEnd

StandByMeText:
	TX_FAR _StandByMeText
	db "@"

WizardOfOzText:
	TX_FAR _WizardOfOzText
	db "@"

TVWrongSideText:
	TX_FAR _TVWrongSideText
	db "@"
