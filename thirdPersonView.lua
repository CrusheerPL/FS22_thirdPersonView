ThirdPersonView = {}
local ThirdPersonView_mt = Class(ThirdPersonView)

function ThirdPersonView.new()
	local self = Object.new(ThirdPersonView_mt)

	self.viewState = false -- is player 3rd person view enabled?

	return self
end

function ThirdPersonView:onEnterVehicle()
	if self.viewState then g_currentMission.player:consoleCommandThirdPersonView() end
end

function ThirdPersonView:onLeaveVehicle_inj()
	if self.viewState then g_currentMission.player:consoleCommandThirdPersonView() end
end

function ThirdPersonView:toggleThirdPersonView()
	g_currentMission.player:consoleCommandThirdPersonView()
	self.viewState = not self.viewState
end