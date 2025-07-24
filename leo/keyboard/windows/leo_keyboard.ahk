; CAPS LOCK BEHAVIOUR

; Disable CapsLock toggle state
SetCapsLockState("AlwaysOff")

; Map CapsLock to Ctrl when held, Esc when pressed alone
*CapsLock::
{
    Send("{LCtrl down}")
    KeyWait("CapsLock")  ; Wait for CapsLock release
    Send("{LCtrl up}")
    if (A_PriorKey == "CapsLock")  ; No other key was pressed
        Send("{Esc}")
}


; SPECIAL CHARACTERS

LCtrl & z::Send("ß")
LCtrl & s::Send("ş")
LCtrl & g::Send("ğ")  
LCtrl & c::Send("ç")
LCtrl & y::Send("ı")

; ALTERNATIVE BRACKETS

LCtrl & j::Send("(")
LCtrl & k::Send("[")
LCtrl & l::Send("{{}")

LCtrl & u::Send(")")
LCtrl & i::Send("]")
LCtrl & o::Send("{}}")