ThirdPersonView = {}
local ThirdPersonView_mt = Class(ThirdPersonView)

function ThirdPersonView.new()
	local self = setmetatable({}, ThirdPersonView_mt)

	self.viewState = false -- is player 3rd person view enabled?
    Player.onEnter = Utils.appendedFunction(Player.onEnter, ThirdPersonView.restoreView)
	ConstructionScreen.onClose = Utils.appendedFunction(ConstructionScreen.onClose, ThirdPersonView.restoreView)

	return self
end

function ThirdPersonView:restoreView()
	if g_currentMission.tpv.viewState then for i=1, 2 do g_currentMission.player:consoleCommandThirdPersonView() end end
end

function ThirdPersonView:toggleThirdPersonView()
	g_currentMission.player:consoleCommandThirdPersonView()
	g_currentMission.tpv.viewState = not g_currentMission.tpv.viewState
end