

local equiped -- define equiped for later assignment
local wrapsList = {}

local function ManageWraps(character, inventoryItem)
	local player = getPlayer()
	local inv = player:getInventory()
	local wrapList = inv:FindAll("Base.FistWraps")
	
	if wrapList:size() then
		if player.isEquipped(wrapList:get(i)) then
		local wrapExists = wrapsList[player.Name]
			if not wrapExists then 
				wrapsList[player.Name] = AddItem("Base.FistWraps")
				wrapExists = wrapsList[player.Name]
			end
			player:setWornItem(wrapExists:getBodyLocation(), wrapExists)
		end
	end
end

--Events.OnEquipPrimary.Add(function() ManageWraps() end)