ThirdPersonView = {}
local ThirdPersonView_mt = Class(ThirdPersonView)

function ThirdPersonView.new()
	local self = setmetatable({}, ThirdPersonView_mt)

	self.viewState = false -- is player 3rd person view enabled?
	ConstructionScreen.onClose = Utils.appendedFunction(ConstructionScreen.onClose, ThirdPersonView.restoreView)
    Player.onEnter = Utils.appendedFunction(Player.onEnter, ThirdPersonView.restoreView)
    Player.debugDraw = Utils.appendedFunction(Player.debugDraw, ThirdPersonView.debug)
	Player.getPositionData = Utils.overwrittenFunction(Player.getPositionData, ThirdPersonView.getPositionData)

	return self
end

-- TODO:
-- - przywrócić ustawienia kamery po wyjściu z garderoby i menu budowy
-- - przywrócić rotację postaci po wyjściu z garderoby
function ThirdPersonView:restoreView()
	if g_currentMission.tpv.viewState then for i=1, 2 do g_currentMission.player:consoleCommandThirdPersonView() end end
end

function ThirdPersonView:toggleThirdPersonView()
	local rot = (g_currentMission.player.rotY + 2 * math.pi) % (2 * math.pi) + math.pi
	if g_currentMission.tpv.viewState then
		rot = (g_currentMission.player.graphicsRotY + math.rad(360)) % math.rad(360) + math.pi
	end
	g_currentMission.player:consoleCommandThirdPersonView()
	g_currentMission.player.rotY = rot
	if not g_currentMission.tpv.viewState then -- 1p to 3p
		g_currentMission.player.model:setSkeletonRotation(rot)
	end
	g_currentMission.tpv.viewState = not g_currentMission.tpv.viewState
end

function ThirdPersonView:getPositionData(superFunc)
    local posX, posY, posZ = getTranslation(g_currentMission.player.rootNode)
    if g_currentMission.player.isClient and g_currentMission.player.isControlled and g_currentMission.player.isEntered then
		if g_currentMission.tpv.viewState then
			return posX, posY, posZ, g_currentMission.player.rotY - math.pi
		else
			return posX, posY, posZ, g_currentMission.player.rotY
		end
    else
        return posX, posY, posZ, g_currentMission.player.graphicsRotY + math.pi
    end
end

function ThirdPersonView:debug()
	if g_currentMission.player.baseInformation.isInDebug then
		setTextColor(1, 0, 0, 1)
		local line = 0.58
		
		renderText(0.05, line, 0.02, "[FS22_thirdPersonView]")
		line = line - 0.02
		
		-- 1p/3p camera Y rotation
		renderText(0.05, line, 0.02, string.format("playerCam rotY(%.3f rad / %.3f deg)", g_currentMission.player.rotY, math.deg(g_currentMission.player.rotY)))
		line = line - 0.02
		
		-- player Y rotation
		renderText(0.05, line, 0.02, string.format("graphicsRotY(%.3f rad / %.3f deg)", g_currentMission.player.graphicsRotY, math.deg(g_currentMission.player.graphicsRotY)))
		line = line - 0.02
		
		-- 3p camera pivot rotation
		local rx, ry, rz = getWorldRotation(g_currentMission.player.thirdPersonLookatNode)
		renderText(0.05, line, 0.02, string.format("thirdPersonLookatNode rotX(%.3f rad / %.3f deg) | rotY(%.3f rad / %.3f deg) | rotZ(%.3f rad / %.3f deg)", rx, math.deg(rx), ry, math.deg(ry), rz, math.deg(rz)))
	end
end

