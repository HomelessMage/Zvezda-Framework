--***********************************************************
--**                    NECROPOLISRP.NET                   **
--**				  Author: github.com/buffyuwu		   **
--**                  Advanced context menu tools          **
--***********************************************************
require "ISUI/ISPanel"
NecropolisUtilities = {};

NecropolisUtilities.adminMenu = function(player, context, worldobjects, test, items)
	local square = nil;
	for i,v in ipairs(worldobjects) do
		square = v:getSquare();
		break;
	end

	local playerObj = getSpecificPlayer(player)
	local sq = getSpecificPlayer(player):getCurrentSquare()
	if getAccessLevel() ~= "" then --anything observer and up
		if sq and sq:getBuilding() then
			if test then return ISWorldObjectContextMenu.setTest() end
			context:addOption("[Get Building Key]", worldobjects, DebugContextMenu.OnGetBuildingKey, player)
		end
	end
	for _,obj in ipairs(worldobjects) do --filter for what we find when we right click
		local dx = obj:getSquare():getX() - playerObj:getSquare():getX()
		local dy = obj:getSquare():getY() - playerObj:getSquare():getY()
		local zGood = math.abs(obj:getSquare():getZ() - playerObj:getSquare():getZ()) < 2
		local dist = math.sqrt(dx*dx + dy*dy)
		if instanceof(obj, "IsoThumpable") and obj:isDoor() then
			if getAccessLevel() ~= "" then
				context:addOption(door:isLocked() and "[Door Unlock]" or "[Door Lock]", worldobjects, DebugContextMenu.OnDoorLock, door)
				context:addOption(string.format("[Set Door Key ID (%d)]", door:getKeyId()), worldobjects, DebugContextMenu.OnSetDoorKeyID, door)
			end
			if not zGood or dist > 2 then 
				return
			else
				context:addOption("Knock", worldobjects, NecropolisUtilities.knockdoor, player, door);
			end
			return
		elseif instanceof(obj, "IsoDoor") then
			if getAccessLevel() ~= "" then
				context:addOption(obj:isLocked() and "[Door Unlock]" or "[Door Lock]", worldobjects, DebugContextMenu.OnDoorLock, door)
				context:addOption(string.format("[Set Door Key ID (%d)]", obj:getKeyId()), worldobjects, DebugContextMenu.OnSetDoorKeyID, door)
			end
			if not zGood or dist > 2 then 
				return
			else
				context:addOption("Knock", worldobjects, NecropolisUtilities.knockdoor, player, door);
			end
			return
		elseif instanceof(obj, "IsoWindow") then
			if getAccessLevel() ~= "" then
				context:addOption(window:isLocked() and "[Window Unlock]" or "[Window Lock]", worldobjects, DebugContextMenu.OnWindowLock, window)
				context:addOption(window:isPermaLocked() and "[Window Perm Unlock]" or "[Window Perm Lock]", worldobjects, DebugContextMenu.OnWindowPermLock, window)
			end
			if not zGood or dist > 2 then 
				return
			else
				context:addOption("Knock", worldobjects, NecropolisUtilities.knockdoor, player, door);
			end
			return
		end
	end
end
-- i had to repeat the dx dy check above because with it in one place, 
-- it would allow users to knock from 500ft away because the location didnt update anywhere but in a filter within the for loop. i dont know why.



NecropolisUtilities.knockdoor = function(playerObj, worldobject, obj, door)
	local range = 10
	getPlayer():getSquare():playSound("Knocking")
	addSound(getPlayer(), getPlayer():getX(),getPlayer():getY(),getPlayer():getZ(), range, 1)
end



-- pulled from the default debug mode map teleporting
function ISWorldMap:onRightMouseUp(x, y)
	if self.symbolsUI:onRightMouseUpMap(x, y) then
		return true
	end
	if getAccessLevel() == "" then
		return false
	end
	local playerNum = 0
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end -- Debug in main menu
	local context = ISContextMenu.get(playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())

	local option = context:addOption("Show Cell Grid", self, function(self) self:setShowCellGrid(not self.showCellGrid) end)
	context:setOptionChecked(option, self.showCellGrid)

	option = context:addOption("Show Tile Grid", self, function(self) self:setShowTileGrid(not self.showTileGrid) end)
	context:setOptionChecked(option, self.showTileGrid)

	self.hideUnvisitedAreas = self.mapAPI:getBoolean("HideUnvisited")
	option = context:addOption("Hide Unvisited Areas", self, function(self) self:setHideUnvisitedAreas(not self.hideUnvisitedAreas) end)
	context:setOptionChecked(option, self.hideUnvisitedAreas)

	option = context:addOption("Isometric", self, function(self) self:setIsometric(not self.isometric) end)
	context:setOptionChecked(option, self.isometric)

	-- DEV: Apply the style again after reloading ISMapDefinitions.lua
	option = context:addOption("Reapply Style", self,
		function(self)
			MapUtils.initDefaultStyleV1(self)
			MapUtils.overlayPaper(self)
		end)

	local worldX = self.mapAPI:uiToWorldX(x, y)
	local worldY = self.mapAPI:uiToWorldY(x, y)
	if getWorld():getMetaGrid():isValidChunk(worldX / 10, worldY / 10) then
		option = context:addOption("Teleport Here", self, self.onTeleport, worldX, worldY)
	end

	return true
end

Events.OnFillWorldObjectContextMenu.Add(NecropolisUtilities.adminMenu);
