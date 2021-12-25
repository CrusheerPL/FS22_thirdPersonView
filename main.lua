source(g_currentModDirectory.."thirdPersonView.lua")

local function playernew_inj(self, superFunc, isServer, isClient)
	f = superFunc(self, isServer, isClient)
	f.inputInformation.registrationList[InputAction.TOGGLE_3RD_PERSON_VIEW] = {callback=ThirdPersonView.toggleThirdPersonView, triggerUp=false, triggerDown=true, triggerAlways=false, activeType=Player.INPUT_ACTIVE_TYPE.STARTS_ENABLED, callbackState=nil, text=g_i18n:getText("input_TOGGLE_3RD_PERSON_VIEW"), textVisibility=true}
	return f
end

Player.new = Utils.overwrittenFunction(Player.new, playernew_inj)
Player.onLeaveVehicle = Utils.appendedFunction(Player.onLeaveVehicle, ThirdPersonView.onLeaveVehicle_inj)