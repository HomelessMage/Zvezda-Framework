UrinateDropPantsAction = ISBaseTimedAction:derive("UrinateDropPantsAction")
function UrinateDropPantsAction:isValid()
	return true
end

function UrinateDropPantsAction:update()
	if (self.useToilet) then
		local props = self.toiletObject:getProperties()

		if (props:Val("Facing") == "N") then
			self.character:setDir(IsoDirections.N)
		elseif (props:Val("Facing") == "E") then
			self.character:setDir(IsoDirections.E)
		elseif (props:Val("Facing") == "S") then
			self.character:setDir(IsoDirections.S)
		elseif (props:Val("Facing") == "W") then
			self.character:setDir(IsoDirections.W)
		end
	end
end

function UrinateDropPantsAction:start()
	self:setActionAnim("urinationUrinate")
	UrinationFunctions.playerUrinating = true
end

function UrinateDropPantsAction:stop()
	ISBaseTimedAction.stop(self)
	UrinationWindow.updateWindow()
	UrinationFunctions.playerUrinating = false
end

function UrinateDropPantsAction:perform()
	local specificPlayer = self.character

	getSoundManager():PlayWorldSound("PutItemInBag", specificPlayer:getCurrentSquare(), 0, 2, 0, true)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
	
	ISTimedActionQueue.add(UrinateAction:new(specificPlayer, 400 * SandboxVars.Urination.UrinateTimeMultiplier, true, true, false, self.useToilet, self.toiletObject))
end

function UrinateDropPantsAction:new(character, time, useToilet, toiletObject)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = time
	o.useToilet = useToilet
	o.toiletObject = toiletObject
	return o
end