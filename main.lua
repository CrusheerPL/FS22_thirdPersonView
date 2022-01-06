source(g_currentModDirectory.."thirdPersonView.lua")
local tpv

function init()
    FSBaseMission.delete = Utils.appendedFunction(FSBaseMission.delete, unload)
    Mission00.load = Utils.prependedFunction(Mission00.load, mload)
	Player.new = Utils.overwrittenFunction(Player.new, playernew_inj)
end

-- nie wiem co daja te dwie funkcje ale niech beda
function mload(mission)
	tpv = ThirdPersonView:new()
	mission.tpv = tpv
	addModEventListener(tpv)
end

function unload()
	removeModEventListener(tpv)
	tpv:delete()
	tpv = nil
end

function playernew_inj(self, superFunc, isServer, isClient)
	f = superFunc(self, isServer, isClient)
	f.inputInformation.registrationList[InputAction.TOGGLE_3RD_PERSON_VIEW] = {callback=ThirdPersonView.toggleThirdPersonView, triggerUp=false, triggerDown=true, triggerAlways=false, activeType=Player.INPUT_ACTIVE_TYPE.STARTS_ENABLED, callbackState=nil, text=g_i18n:getText("input_TOGGLE_3RD_PERSON_VIEW"), textVisibility=true}
	return f
end

init()