UrinationFunctions = {} -- holds most of the functions
UrinationFunctions.firstRunTimer = false --game runs 'EveryTenMinutes' on load, this is to skip the first one

UrinationFunctions.UrinationItemCheckRightClick = function(worldObjects, specificPlayer)
	if (specificPlayer ~= nil) then
		if (not specificPlayer:isDriving()) then
			ISTimedActionQueue.add(UrinateDropPantsAction:new(specificPlayer, 100, false, nil))
			UrinationWindow.updateWindow()
			UrinationStatusMini.updateWindow()
		end
	end
end

UrinationFunctions.UrinatedBottomsMood = function(specificPlayer)
	for i = 0, specificPlayer:getWornItems():size() - 1 do
		local item = specificPlayer:getWornItems():getItemByIndex(i)

		if (item:getModData()["DOriginalName"] ~= nil) then --if worn item is urinated
			specificPlayer:getStats():setStress(specificPlayer:getStats():getStress() + 0.07 * SandboxVars.Urination.UrinatedBottomsMultiplier) --If they are wearing wet bottoms, add stress and unhappyness
			specificPlayer:getBodyDamage():setUnhappynessLevel(specificPlayer:getBodyDamage():getUnhappynessLevel() + 5 * SandboxVars.Urination.UrinatedBottomsMultiplier) -- these are 10% of peeing self
			break
		end
	end
end

--actual urination process
UrinationFunctions.UrinateBottoms = function(specificPlayer)
	local clothing = nil
	local bodyLocations = {"Underwear", "Torso1Legs1", "Legs1", "Pants", "Skirt", "Dress", "BathRobe", "FullSuit", "FullSuitHead", "FullTop", "BodyCostume"}

	for i = 1, #bodyLocations do
		clothing = specificPlayer:getWornItem(bodyLocations[i]) --if player has clothing on one of the bodyLocations categories
		if (clothing ~= nil) then
			break
		end
	end

	if (clothing ~= nil and clothing:getModData()["DOriginalName"] == nil) then --If player urinates already urinated clothes, don't add clothing debuff twice
		local cleanName = nil
		
		if (string.find(clothing:getName(), "%(")) then
			local startIndex = string.find(clothing:getName(), "%(")
			cleanName = string.sub(clothing:getName(), 0, startIndex - 2)
		else
			cleanName = clothing:getName()
		end
		
		clothing:getModData()["DOriginalName"] = cleanName

		clothing:setName(cleanName .. getText("ContextMenu_Urinated"))
		clothing:setWetness(500)
		clothing:setDirtyness(100)
	end
end

--opening the urination menu
UrinationFunctions.UrinationKeyUp = function(keynum)
	local specificPlayer = getSpecificPlayer(0)
	
	if (specificPlayer ~= nil) then
		if keynum == getCore():getKey("UrinationStatus") and not UrinationWindow:getIsVisible() and not UrinationStatusMini:getIsVisible() then
			if (UrinationFunctions.lastShownMiniWindow) then
				UrinationStatusMini:setVisible(true)
				UrinationStatusMini.updateWindow()
			else
				UrinationWindow:setVisible(true)
				UrinationWindow.updateWindow()
			end
		elseif keynum == getCore():getKey("UrinationStatus") then
			if (UrinationWindow:getIsVisible()) then
				UrinationFunctions.lastShownMiniWindow = false
				UrinationWindow:setVisible(false)
			else
				UrinationFunctions.lastShownMiniWindow = true
				UrinationStatusMini:setVisible(false)
			end
		end
	end
end
Events.OnKeyPressed.Add(UrinationFunctions.UrinationKeyUp)

UrinationFunctions.FixUrinateValue = function(specificPlayer)
	local urinate = specificPlayer:getModData()["Urinate"]
	
	if (type(urinate) ~= "number") then
		urinate = 0.0 --by default, get mod data appears to return a string
	end

	return urinate
end

--EXPERIMENTAL
--UrinationFunctions.FixAccidentValue = function(specificPlayer)
--	local accidentValue = specificPlayer:getModData()["AccidentValue"]
--		
--	if (type(accidentValue) ~= "number") then
--		accidentValue = 0.0 --by default, get mod data appears to return a string
--	end

--	return accidentValue
--end

UrinationFunctions.ToiletUrinate = function(worldObjects, object, specificPlayer)
	if not object:getSquare() or not luautils.walkAdj(specificPlayer, object:getSquare()) then --if object on square is invalid, or player cannot walk adjacent to object
		return
	end

	ISTimedActionQueue.add(UrinateDropPantsAction:new(specificPlayer, 100, true, object))
	UrinationWindow.updateWindow()
	UrinationStatusMini.updateWindow()
end


UrinationFunctions.RightClick = function(player, context, worldObjects)
	local specificPlayer = getSpecificPlayer(player)
	local urinate = UrinationFunctions.FixUrinateValue(specificPlayer)
	
	if (urinate >= 0.2) then
		local firstObject -- Pick first object in worldObjects as reference one
		for _, o in ipairs(worldObjects) do
			if not firstObject then firstObject = o end
		end
		
		local square = firstObject:getSquare() -- the square this object is in is the clicked square
		local worldObjects = square:getObjects()
		local optionAdded = false
		local urinateOption = nil
		local toiletUrinateOption = nil
		
		for i = 0, worldObjects:size() - 1 do
			local object = worldObjects:get(i)
			
			if (object:getTextureName() and luautils.stringStarts(object:getTextureName(), "fixtures_bathroom_01") and object:hasWater() and object:getWaterAmount() >= 10.0 and object:getSquare():DistToProper(specificPlayer:getSquare()) < 1) then
				urinateOption = context:addOption(getText("ContextMenu_Urinate"), worldObjects, nil)
				local subMenu = ISContextMenu:getNew(context)
				context:addSubMenu(urinateOption, subMenu)
				toiletUrinateOption = subMenu:addOption("In Toilet", worldObjects, UrinationFunctions.ToiletUrinate, storeWater, specificPlayer)
				optionAdded = true
			end --don't exit loop if we find a toilet, sometimes multiple of the name are on the same tile
		end
		
		if not optionAdded then
			urinateOption = context:addOption(getText("ContextMenu_Urinate"), worldObjects, UrinationFunctions.UrinationItemCheckRightClick, specificPlayer)
			local tooltip = ISWorldObjectContextMenu.addToolTip()
			urinateOption.toolTip = tooltip
			
			local vehicle = specificPlayer:getVehicle()
			if vehicle and vehicle:isDriver(specificPlayer) then
				urinateOption.notAvailable = true
			end
		end
		
		if (urinateOption ~= nil and UrinationFunctions.playerUrinating) then
			urinateOption.notAvailable = true
			
			if (toiletUrinationOption ~= nil) then
				toiletUrinationOption.notAvailable = true
			end
		end
	end
end
Events.OnFillWorldObjectContextMenu.Add(UrinationFunctions.RightClick)

UrinationFunctions.WashUrinated = function(playerObj, square, urinatedItem, bleachItem, storeWater, hasUrinatedItemEquipped)
	if not square or not luautils.walkAdj(playerObj, square, true) then
		return
	end
	
	--BRUH HAS THE TAKE OFF CLOTHING CODE I KEPT NEEDING! I'm a moron lol, I'll remember this.
	if (hasUrinatedItemEquipped) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, urinatedItem, 50))
	end
	
	
	ISTimedActionQueue.add(WashUrinatedAction:new(playerObj, square, urinatedItem, bleachItem, storeWater))
end

UrinationFunctions.getMoveableDisplayName = function(obj)
	if not obj then return nil end
	if not obj:getSprite() then return nil end
	local props = obj:getSprite():getProperties()
	if props:Is("CustomName") then --This is copied from the vanilla 'Wash' context menu code
		local name = props:Val("CustomName")
		if props:Is("GroupName") then
			name = props:Val("GroupName") .. " " .. name
		end
		
		return Translator.getMoveableDisplayName(name)
	end
	return nil
end

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

UrinationFunctions.WashRightClick = function(player, context, worldObjects)
	if (context == nil) then
		return
	end
	
	local hasUrinatedItem = false
	local hasUrinatedItemEquipped = false
	local urinatedItem = nil
	local bleachItem = nil
	local specificPlayer = getSpecificPlayer(player)
	
	for i = 0, specificPlayer:getInventory():getItems():size() - 1 do
		local item = specificPlayer:getInventory():getItems():get(i)

		local validItems = 
		{
			['Bleach'] = true,
		    ['Soap2'] = true,
		}
		
		if validItems[item:getType()] then
			bleachItem = item
		end

		--if (item:getType() == "Bleach") then
		--	bleachItem = item
		--end
		
		if (item:getModData()["DOriginalName"] ~= nil) then
			hasUrinatedItem = true --if player has urinated clothing item in inventory
			if (item:isEquipped()) then
				hasUrinatedItemEquipped = true --if player has urinated clothing item equipped
			end
			urinatedItem = item
		end
	end
	
	if (hasUrinatedItem) then
		local storeWater = nil
		local firstObject = nil
		for _, o in ipairs(worldObjects) do
			if not firstObject then firstObject = o end
		end
		
		local square = firstObject:getSquare() -- the square this object is in is the clicked square
		local worldObjects = square:getObjects()
		for i = 0, worldObjects:size() - 1 do
			local object = worldObjects:get(i)
			if (object:getTextureName() and object:hasWater()) then --similar to the way vanilla shows the 'Wash' menu, should show up anywhere that does
				storeWater = object
			end
		end

		if storeWater == nil then
			return
		end
		
		if storeWater:getSquare():DistToProper(specificPlayer:getSquare()) > 10 then
			return
		end

		local washOption = context:addOptionOnTop(getText("ContextMenu_UrinateSterilize"), nil, nil)
		local subMenu = ISContextMenu:getNew(context)
		context:addSubMenu(washOption, subMenu)
		local option = subMenu:addOption(urinatedItem:getName(), specificPlayer, UrinationFunctions.WashUrinated, square, urinatedItem, bleachItem, storeWater, hasUrinatedItemEquipped)
		
		local source = UrinationFunctions.getMoveableDisplayName(storeWater)
		if source == nil and instanceof(storeWater, "IsoWorldInventoryObject") and storeWater:getItem() then
			source = storeWater:getItem():getDisplayName()
		elseif source == nil then
			source = getText("ContextMenu_NaturalWaterSource")
		end
		
		local waterRemaining = storeWater:getWaterAmount()
		
		if (waterRemaining < 15) then
			option.notAvailable = true --show option but red/disabled if there is not enough water
		end
		
		if (bleachItem == nil) then --or bleachItem:getThirstChange() >= -0.3
			option.notAvailable = true
		end
		
		local bleachText = "0"
		
		--if (bleachItem ~= nil) then
			--if(bleachItem == 'Bleach') then --Testing bleach is item
				--bleachText = tostring(math.min(round(bleachItem:getThirstChange(), 2) * -1, 0.3))
				--print("Whoa you used bleach what a freaking loser lol")
			--end
		--end
		
		local tooltip = ISWorldObjectContextMenu.addToolTip()
		tooltip.description = getText("ContextMenu_WaterSource") .. ": " .. source
		tooltip.description = tooltip.description .. " <LINE> Water: " .. tostring(math.min(waterRemaining, 15)) .. " / " .. tostring(15)
		--tooltip.description = tooltip.description .. " <LINE> Bleach: " .. bleachText .. " / 0.3"
		tooltip.description = tooltip.description .. " <LINE> Dirty: " .. math.ceil(urinatedItem:getDirtyness()) .. " / 100"
		option.toolTip = tooltip
	end
end
Events.OnFillWorldObjectContextMenu.Add(UrinationFunctions.WashRightClick)

UrinationFunctions.PeePuddleCheck = function(playerNum)
	local specificPlayer = getSpecificPlayer(playerNum)
	if specificPlayer == nil then
		return
	end
	
	local peeCount = 1
	local lastPeeSquare = nil
	
	for x = -2, 2 do
		for y = -2, 2 do
			local sq = getCell():getGridSquare(specificPlayer:getX() + x, specificPlayer:getY() + y, specificPlayer:getZ()) --loop through from -2 to +2
			
			if sq then
				for i = 0, sq:getObjects():size() - 1 do --loop through each tile's objects
					local object = sq:getObjects():get(i)
					
					if (object ~= nil and object:getObjectName() == "WorldInventoryItem" and object:getItem():getType() == "HumanUrine") then
						peeCount = peeCount + 1
						lastPeeSquare = sq
					end
				end
			end
		end
	end

	if (peeCount > 0) then
		specificPlayer:getBodyDamage():setUnhappynessLevel(specificPlayer:getBodyDamage():getUnhappynessLevel() + (0.5 * peeCount))
	end
end

UrinationFunctions.CalculateUrinateValue = function(specificPlayer)
	local urinateIncrease = .0055556 * SandboxVars.Urination.UrinateIncreaseMultiplier -- * 6 * 24 = roughly ~0.4 per day, so 1 pee needed per day
	local drinksDrankMoodle = specificPlayer:getMoodles():getMoodleLevel(MoodleType.FoodEaten)
	local thirstyMoodle = specificPlayer:getMoodles():getMoodleLevel(MoodleType.Thirst)
	
	if (drinksDrankMoodle > 0) then
		urinateIncrease = urinateIncrease * drinksDrankMoodle -- up to *4
	end
	
	if (thirstyMoodle > 0) then
		if (thirstyMoodle == 2) then
			urinateIncrease = urinateIncrease * 0.75
		elseif (thirstyMoodle == 3) then
			urinateIncrease = urinateIncrease * 0.50
		elseif (thirstyMoodle == 4) then
			urinateIncrease = urinateIncrease * 0.25 -- as low as 1/4th
		end
	end

	return tonumber(urinateIncrease)
end

UrinationFunctions.OopsPee = function(specificPlayer, urinate)
	if SandboxVars.Urination.CanPeeSelf == true then
		local panic = specificPlayer:getMoodles():getMoodleLevel(MoodleType.Panic)
		--local drunk = specificPlayer:getMoodles():getMoodleLevel(MoodleType.Drunk)
		local luckyModifier = 0
		local bladderModifier = 0

		if specificPlayer:HasTrait("Lucky") then
			luckyModifier = 1
		elseif specificPlayer:HasTrait("Unlucky") then
			luckyModifier = -1
		end


		local peeChance = ZombRand((19 + luckyModifier + bladderModifier) - (panic * 2) - (urinate * 10)) --The highest chance is ZombRand(3), 25%. The lowest is ZombRand(15), 6.7% chance

		if (panic > 0 and urinate >= 0.48 and peeChance == 0) then --if they are panic'd and above 80% (or 70% if sick) urination level and they are below 95%/85%
			ISTimedActionQueue.add(UrinateAction:new(specificPlayer, 0, false, false, true, false, nil))
		elseif (peeChance == 0) then --if 95%/85% or higher, add chance
			ISTimedActionQueue.add(UrinateAction:new(specificPlayer, 0, false, false, true, false, nil))
		end
	end
end

UrinationFunctions.AddStress = function(specificPlayer)
	local urinate = UrinationFunctions.FixUrinateValue(specificPlayer)
	urinate = urinate + UrinationFunctions.CalculateUrinateValue(specificPlayer)
	
	if (urinate >= 0.4) then --Only effect the player's stress if their urinate is 66% or higher
		if (not UrinationFunctions.playerUrinating) then
			UrinationFunctions.OopsPee(specificPlayer, urinate)
		end
		
		if urinate > 0.6 then
			urinate = 0.6 --cap at .6
		end
		specificPlayer:getStats():setStress(urinate)
	end
	
	specificPlayer:getModData()["Urinate"] = tonumber(urinate)
end

UrinationFunctions.UrinationTimer = function()
	local specificPlayer = getSpecificPlayer(0)
	if specificPlayer == nil then return end
	
	if UrinationFunctions.firstRunTimer then
		UrinationFunctions.AddStress(specificPlayer)
		UrinationFunctions.UrinatedBottomsMood(specificPlayer)
	else

		UrinationFunctions.firstRunTimer = true
	end
	
	UrinationWindow.updateWindow()
	UrinationStatusMini.updateWindow()
end
Events.EveryTenMinutes.Add(UrinationFunctions.UrinationTimer)

UrinationFunctions.RemoveUrinateStress = function(specificPlayer, urinate)
	specificPlayer:getStats():setStress(urinate - 100) --get negative value
	if specificPlayer:getStats():getStress() < 0 then
		specificPlayer:getStats():setStress(0) --When player urinates, remove the stress that was added from urinate value
	end
	
	specificPlayer:getModData()["Urinate"] = 0.0
	UrinationWindow.updateWindow()
	UrinationStatusMini.updateWindow()
end

--Menu keybind code
--We need to use the global keyBinding table, this stores all our binding values
local index = nil -- index will be the position we want to insert into the table
for i, b in ipairs(keyBinding) do
	--we need to find the index of the item we want to insert after
	if b.value == "Zoom out" then
		index = i
		break
	end
end

if index then --use index from above
	table.insert(keyBinding, index+1, {value = "UrinationStatus", key = 52})

	local oldCreate = MainOptions.create

	function MainOptions:create()
		oldCreate(self)
	end
end