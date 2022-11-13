local tires
local tireNames = {
    "TireFrontLeft", 
    "TireFrontRight",
    "TireRearLeft",
    "TireRearRight",
}

local OnGameStart = function()

    

end

local onTick = function(tick)

	local playerObj = getPlayer(); if not playerObj then return end
	local vehicle = playerObj:getVehicle()
	if not vehicle then return end

    local spikeStrip = GetSpikeStripInSquare(playerObj)

    if spikeStrip then
        PunctureTires(playerObj, vehicle)
    end
end

function PunctureTires(playerObj, vehicle)

    tires = {}

    for i = 1,4,1 do 
        tires[i] = vehicle:getPartById(tireNames[i])
    end

    if not(tires[1] and tires[4]) then return end

    for _,tire in ipairs(tires) do

        if tire then

            local wheelIndex = tire:getWheelIndex()

            if isClient() then
                sendClientCommand(playerObj, 'vehicle', 'fixPart', { vehicle = vehicle:getId(), part = tire:getId(), condition = tire:getCondition() - 75, haveBeenRepaired = 0 })  
                sendClientCommand(playerObj, "vehicle", "setTirePressure", { vehicle = vehicle, part = tire:getId(), psi = 0 })
            else
                tire:setCondition(tire:getCondition() - 75)
                tire:setContainerContentAmount(0)

                vehicle:setTireInflation(wheelIndex, tire:getContainerContentAmount() / tire:getContainerCapacity())
                vehicle:transmitPartModData(tire)
                vehicle:updatePartStats()
            end
        end

        BravensUtils.TryPlaySoundClip(vehicle, "TiresPop")
    end
end

function GetSpikeStripInSquare(playerObj)

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

        local objs = sq:getWorldObjects();

        if objs then

            for i = 0, objs:size() - 1 do

                local item = objs:get(i):getItem()
        
                if item:getFullType() == "Braven.SpikeStrip" then
                    return item
                end
            end
        end
    end
end

Events.OnGameStart.Add(OnGameStart);
Events.OnTick.Add(onTick)