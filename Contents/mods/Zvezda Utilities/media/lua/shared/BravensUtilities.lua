--***********************************************************
--**                       BitBraven                       **
--***********************************************************

BravensUtils = {}

BravensUtils.TryPlaySoundClip = function(obj, soundName)

	if obj:getEmitter():isPlaying(soundName) then return end
    obj:getEmitter():playSoundImpl(soundName, IsoObject.new())

end

BravensUtils.TryStopSoundClip = function(obj, soundName)

	if not obj:getEmitter():isPlaying(soundName) then return end
	obj:getEmitter():stopSoundByName(soundName)
end

-- Drain the player's stamina for whatever reason
BravensUtils.TirePlayer = function(playerObj, amount)

	local stats = playerObj:getStats()
	if not stats then return end

	if stats:getEndurance() < 0.21 then return end --We don't want to *kill* someone out of exhaustion do we?
	stats:setEndurance(stats:getEndurance() - (amount / (playerObj:getPerkLevel(Perks.Fitness) / 2)))
end

-- Credits for this function: Konijima
BravensUtils.DelayFunction = function(func, delay)

    delay = delay or 1;
    local ticks = 0;
    local canceled = false;

    local function onTick()

        if not canceled and ticks < delay then
            ticks = ticks + 1;
            return;
        end

        Events.OnTick.Remove(onTick);
        if not canceled then func(); end
    end

    Events.OnTick.Add(onTick);
    return function()
        canceled = true;
    end
end

-- Make 10 attempts to find the vehicle that's nearest to the player and shares the target name. else, return nill.
BravensUtils.GetNearbyVehicle = function(playerObj, vehicleName)

    local vehicle

    for i = 1,10,1 do

        if not vehicle then

            local tempVehicle = playerObj:getUseableVehicle()

            if not tempVehicle then
                tempVehicle = playerObj:getNearVehicle()
            end

            if not tempVehicle then

                local px = playerObj:getX()
                local py = playerObj:getY()
                local pz = playerObj:getZ()

                local sqs = {}
                sqs[1] = getCell():getGridSquare(px, py, pz)

                local dir = playerObj:getDir()
                if (dir == IsoDirections.N) then        sqs[2] = getCell():getGridSquare(px-1, py-1, pz); sqs[3] = getCell():getGridSquare(px, py-1, pz);   sqs[4] = getCell():getGridSquare(px+1, py-1, pz);
                elseif (dir == IsoDirections.NE) then   sqs[2] = getCell():getGridSquare(px, py-1, pz);   sqs[3] = getCell():getGridSquare(px+1, py-1, pz); sqs[4] = getCell():getGridSquare(px+1, py, pz);
                elseif (dir == IsoDirections.E) then    sqs[2] = getCell():getGridSquare(px+1, py-1, pz); sqs[3] = getCell():getGridSquare(px+1, py, pz);   sqs[4] = getCell():getGridSquare(px+1, py+1, pz);
                elseif (dir == IsoDirections.SE) then   sqs[2] = getCell():getGridSquare(px+1, py, pz);   sqs[3] = getCell():getGridSquare(px+1, py+1, pz); sqs[4] = getCell():getGridSquare(px, py+1, pz);
                elseif (dir == IsoDirections.S) then    sqs[2] = getCell():getGridSquare(px+1, py+1, pz); sqs[3] = getCell():getGridSquare(px, py+1, pz);   sqs[4] = getCell():getGridSquare(px-1, py+1, pz);
                elseif (dir == IsoDirections.SW) then   sqs[2] = getCell():getGridSquare(px, py+1, pz);   sqs[3] = getCell():getGridSquare(px-1, py+1, pz); sqs[4] = getCell():getGridSquare(px-1, py, pz);
                elseif (dir == IsoDirections.W) then    sqs[2] = getCell():getGridSquare(px-1, py+1, pz); sqs[3] = getCell():getGridSquare(px-1, py, pz);   sqs[4] = getCell():getGridSquare(px-1, py-1, pz);
                elseif (dir == IsoDirections.NW) then   sqs[2] = getCell():getGridSquare(px-1, py, pz);   sqs[3] = getCell():getGridSquare(px-1, py-1, pz); sqs[4] = getCell():getGridSquare(px, py-1, pz);
                end

                for _,sq in ipairs(sqs) do
                    local vehicle2 = sq:getVehicleContainer()
                    if vehicle2 then
                        tempVehicle = vehicle2
                        break
                    end
                end
            end

            if (tempVehicle and tempVehicle:getScriptName() == vehicleName) then
                vehicle = tempVehicle
            end
        end
    end

    return vehicle
end

BravensUtils.isNumber = function(i)

    if tonumber(i) ~= nil then
        return true
    end

    return false
end