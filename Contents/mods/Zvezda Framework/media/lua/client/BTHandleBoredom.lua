function BTUnhappinessHelper(bodyDamage, instance)
	-- If the player has less then 5 boredom, and they are not too unhappy already, lower unhappiness through work. This is only called while they are doing something to lower boredom.
	if bodyDamage:getBoredomLevel() < 5.0 and bodyDamage:getUnhappynessLevel() < 25.0 then
		bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - ((ZomboidGlobals.UnhappinessIncrease / 2.0) * instance:getMultiplier()));
	end
end

-- What follows is originally from Konijima's Community API, but edited to be used to help with finding nearby players.
-- This is not my original work! All credit for the original code belongs to the Community API team and contributors.
-- Link to the original code on the Community API Github:
-- https://github.com/Konijima/PZ-Community-API/blob/master/Contents/mods/CommunityAPI/media/lua/shared/CommunityAPI/IsoUtils.lua

--- Safely get the square of an IsoObject recursively
---@param object IsoObject|IsoGridSquare
---@return IsoGridSquare
function RecursiveGetSquare(object)
    if instanceof(object, "IsoGridSquare") then
        return object
    end

    if not instanceof(object, "IsoObject") then
        return nil
    end

    local square
    if instanceof(object, "IsoGameCharacter") and object:getVehicle() then
        square = object:getVehicle()
    end

    if not instanceof(square, "IsoGridSquare") then
        square = square:getSquare()
    end

    return square
end

---@param center IsoObject|IsoGridSquare
---@param range number tiles to scan from center, not including center. ex: range of 1 = 3x3
---@return table<IsoGridSquare>
function GetIsoRange(center, range)
    center = RecursiveGetSquare(center)
    if not center then
        return {}
    end

    --true center
    local centerX, centerY = center:getX(), center:getY()
    --add center to squares at the start
    local squares = {center}

    --no point in running everything below, return squares
    if range < 1 then return squares end

    --create a ring of IsoGridSquare around center, i=1 skips center
    for i=1, range do

        --currentX and currentY have to pushed off center for the logic below to kick in
        local currentX, currentY = centerX-i, centerY+i
        -- ring refers to the path going around center, -1 to skip center
        local expectedRingLength = (8*i)-1

        for _=0, expectedRingLength do
            --if on top-row and not at the upper-right
            if (currentY == centerY+i) and (currentX < centerX+i) then
                --move-right
                currentX = currentX+1
            --if on right-column and not the bottom-right
            elseif (currentX == centerX+i) and (currentY > centerY-i) then
                --move down
                currentY = currentY-1
            --if on bottom-row and not on far-left
            elseif (currentY == centerY-i) and (currentX > centerX-i) then
                --move left
                currentX = currentX-1
            --if on left-column and not on top-left
            elseif (currentX == centerX-i) and (currentY < centerY+i) then
                --move up
                currentY = currentY+1
            end

            ---@type IsoGridSquare square
            local square = getCell():getOrCreateGridSquare(currentX, currentY, 0)
            table.insert(squares, square)
        end
    end
    return squares
end

--- Get all humanoid in range from a center point
---@param center IsoObject|IsoGridSquare the center point
---@param range number tiles to scan from center, not including center. ex: range of 1 = 3x3
---@return int
function GetNumIsoPlayersInRange(center, range)
    center = RecursiveGetSquare(center)
    if not center then
        return {}
    end

    local squaresInRange = GetIsoRange(center, range)
    local playersFound = 0

    for sq=1, #squaresInRange do

        ---@type IsoGridSquare
        local square = squaresInRange[sq]
        local squareContents = square:getLuaMovingObjectList()

        for i=1, #squareContents do
            ---@type IsoMovingObject|IsoGameCharacter foundObject
            local foundObj = squareContents[i]

            if instanceof(foundObj, "IsoPlayer") then
                playersFound = playersFound + 1
            end
        end
    end

    return playersFound
end

-- End the modified code!

function BTHandleBoredom(player)
	if not player:isAsleep() then
		local bodyDamage = player:getBodyDamage();
		local instance = GameTime:getInstance();
		local javaBoredomAmount = ZomboidGlobals.BoredomDecrease * 0.1; -- This value is the value that Boredom is constantly decreased by when you are not in a map-designated room or in a vehicle. Var is used to counter this for times when the player is in a player built room.
		if player:getCurrentSquare() ~= nil and player:getCurrentSquare():isInARoom() ~= nil then
			-- Is the player currently doing an action that is not reading (that is already handled by the main code)?
			if player:hasTimedActions() and not player:isReading() then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * 0.1 * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
			
			-- Account for the already existing methods of losing boredom that are in the Java code here, other survivors around you, and if the player is calling out or talking. If either are true, reduce unhappiness!
			if player:IsSpeaking() and not player.callOut then
				BTUnhappinessHelper(bodyDamage, instance);
			end
			
			-- Because vanilla has this check mainly as a placeholder for when NPCs exist, where it does try to calculate this variable it always resets it to 0. This will probably never be run in the Java until the base game changes.
			if player:getNumSurvivorsInVicinity() > 0 then
				BTUnhappinessHelper(bodyDamage, instance);
			end
			
			-- Since the above is the case, its probably best to just handle players separately. If players get a slight bonus eventually (when NPCs exist) for both, that's kinda neat I guess! It's also a good bit better to not be running the check for players nearby unless it's actually needed.
			if GetNumIsoPlayersInRange(player:getCurrentSquare(), 4) > 1 then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * 0.1 * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
		-- Check for if the player is in a vehicle and actually driving, as that reduces boredom. Add the unhappiness check here, too.
		elseif player:getVehicle() ~= nil then
			local speed = player:getVehicle():getCurrentSpeedKmHour();
			if Math.abs(speed) > 0.1 then
				BTUnhappinessHelper(bodyDamage, instance);
			end
					
			-- Adding a reduction to boredom as long as you are doing a 'timed action' within a room. Why would someone grow bored if they are actively doing something? Especially when everything is crucial for survival.
			if player:hasTimedActions() and not player:isReading() then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * 0.1 * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
					
			-- Account for the already existing methods of losing boredom that are in the Java code here, other survivors around you, and if the player is calling out or talking. If either are true, reduce unhappiness!
			if player:IsSpeaking() and not player.callOut then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
				
			-- Because vanilla has this check mainly as a placeholder for when NPCs exist, where it does try to calculate this variable it always resets it to 0. This will probably never be run in the Java until the base game changes.
			if player:getNumSurvivorsInVicinity() > 0 then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * 0.1 * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
					
			-- Since the above is the case, its probably best to just handle players separately. If players get a slight bonus eventually (when NPCs exist) for both, that's kinda neat I guess! It's also a good bit better to not be running the check for players nearby unless it's actually needed.
			if GetNumIsoPlayersInRange(player:getVehicle():getSquare(), 4) > 1 then
				bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - (ZomboidGlobals.BoredomDecrease * 0.1 * instance:getMultiplier()));
				BTUnhappinessHelper(bodyDamage, instance);
			end
		else
			-- Player is not in a car, or in a room, so they are actively losing boredom. Run the unhappiness check here too!
			BTUnhappinessHelper(bodyDamage, instance);
		end
	end
end

Events.OnPlayerUpdate.Add(BTHandleBoredom);