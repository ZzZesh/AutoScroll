script_author("Zesh")
script_name("AutoScroll")
script_description('GhostHack')
script_version_number(0.1)
local autosc = require 'autosc'
local memory = require 'memory'
local cfg = autosc.load({set = {
AutoScroll = false,
CheckPt = false, 
function main()
while not isSampLoaded and not isSampfuncsLoaded do wait(0) end
while not isSampAvailable do wait(0) end
wait(9000)
autosc.save(cfg)
sampRegisterChatCommand("cfgg", SHOW_DLG)
			if cfg.set.AutoScroll and getAmmoInClip() < 5 then giveWeaponToChar(playerPed, 24, 0) end
			while cfg.set.CheckPt and getAmmoInClip() == 0 do wait(0) end
			wait(0)
				end
			end

function SHOW_DLG()
	lua_thread.create(showCur)
	return
end

function showCur()
	wait(0)
	if not dxutIsDialogExists(HND_DLG) then
		HND_DLG = dxutCreateDialog("{00FFFF} Autoscroll by Zesh")
		local X, Y = get_screen_centure(155, 165)
		dxutSetDialogPos(HND_DLG, X, Y, 310, 330)
		dxutAddCheckbox(HND_DLG, 1, "AutoScroll", 1, 80, 300, 20)
		dxutCheckboxSetChecked(HND_DLG, 1, cfg.set.AutoScroll)
		dxutAddCheckbox(HND_DLG, 2, "CheckPt", 2, 130, 300, 20)
		dxutCheckboxSetChecked(HND_DLG, 2, cfg.set.CheckPt)
		dxutAddButton(HND_DLG, 4, "Save", 4, 290, 300, 20)
		dxutAddButton(HND_DLG, 6, "Close W/O saving to file", 6, 270, 300, 20)
		sampToggleCursor(true)
	else
		dxutSetDialogVisible(HND_DLG, (not dxutIsDialogVisible(HND_DLG)))
	end
	while true do
		wait(0)
		local RES, DLG_EVENT, DLG_CONTROL = dxutPopEvent(HND_DLG)
		if DLG_CONTROL == 4 --[[ "Save" button]] then
			wait(0)
			autosc.save(cfg)
			dxutSetDialogVisible(HND_DLG, false)
			dxutDeleteDialog(HND_DLG)
			sampToggleCursor(false)
			break
		end
		if DLG_CONTROL == 1 --[[AutoScroll]] then
			cfg.set.AutoScroll = not cfg.set.AutoScroll
		end
		if DLG_CONTROL == 2 --[[CheckPt]] then
			cfg.set.CheckPt = not cfg.set.CheckPt
		end
		if DLG_CONTROL == 6 --[[Close W/O saving]] then
			wait(0)
			dxutSetDialogVisible(HND_DLG, false)
			sampToggleCursor(false)
			dxutDeleteDialog(HND_DLG)
			break
		end
	end
end


function getAmmoInClip()
  local struct = getCharPointer(playerPed)
  local prisv = struct + 0x0718
  local prisv = memory.getint8(prisv, false)
  local prisv = prisv * 0x1C
  local prisv2 = struct + 0x5A0
  local prisv2 = prisv2 + prisv
  local prisv2 = prisv2 + 0x8
  local ammo = memory.getint32(prisv2, false)
  return ammo
end
