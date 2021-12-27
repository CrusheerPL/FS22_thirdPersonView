ThirdPersonView = {}
local ThirdPersonView_mt = Class(ThirdPersonView)

function ThirdPersonView.new()
	local self = {}
	setmetatable({}, ThirdPersonView_mt)

	self.viewState = false -- is player 3rd person view enabled?
    Player.onLeaveVehicle = Utils.appendedFunction(Player.onLeaveVehicle, ThirdPersonView.restoreView)
    Player.onEnter = Utils.appendedFunction(Player.onEnter, ThirdPersonView.restoreView)

	return self
end

function ThirdPersonView:restoreView()
	if self.viewState then for i=1, 2 do g_currentMission.player:consoleCommandThirdPersonView() end end
end

function ThirdPersonView:toggleThirdPersonView()
	g_currentMission.player:consoleCommandThirdPersonView()
	self.viewState = not self.viewState
end