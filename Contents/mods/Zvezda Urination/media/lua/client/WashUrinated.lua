WashUrinatedAction = ISBaseTimedAction:derive("WashUrinatedAction")
function WashUrinatedAction:isValid()
	return true
end

function WashUrinatedAction:update()
end

function WashUrinatedAction:start()
	self:setActionAnim("Loot")
	self:setAnimVariable("LootPosition", "")
	self:setOverrideHandModels(nil, nil)
	self.sound = self.character:playSound("WashYourself")
	self.character:reportEvent("EventWashClothing")
end

function WashUrinatedAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function WashUrinatedAction:stop()
	self:stopSound()
    ISBaseTimedAction.stop(self)
end

function WashUrinatedAction:perform()
	self:stopSound()

	if (self.urinatedItem:getModData()["DOriginalName"] ~= nil) then
		local coveredParts = BloodClothingType.getCoveredParts(self.urinatedItem:getBloodClothingType())
		if coveredParts then
			for j = 0, coveredParts:size() - 1 do
				self.urinatedItem:setBlood(coveredParts:get(j), 0)
				self.urinatedItem:setDirt(coveredParts:get(j), 0)
			end
		end
		
		self.urinatedItem:setName(self.urinatedItem:getModData()["DOriginalName"])
		self.urinatedItem:getModData()["DOriginalName"] = nil
		
		self.urinatedItem:setWetness(100)
		self.urinatedItem:setDirtyness(0)
		self.urinatedItem:setRunSpeedModifier(self.urinatedItem:getRunSpeedModifier() + 0.2)
		
		if(self.bleachItem == 'Bleach') then --Testing bleach is item
			self.bleachItem:setThirstChange(self.bleachItem:getThirstChange() + 0.3)
			if self.bleachItem:getThirstChange() > - 0.3 then
				self.bleachItem:Use()
			end
			print("Had bleach, got rid of stuff")
		end
	end

	self.character:resetModelNextFrame()
	triggerEvent("OnClothingUpdated", self.character)

	ISTakeWaterAction.SendTakeWaterCommand(self.character, self.storeWater, 15)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function WashUrinatedAction:new(playerObj, square, urinatedItem, bleachItem, storeWater)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = playerObj
	o.square = square
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = 400
	o.urinatedItem = urinatedItem
	o.bleachItem = bleachItem
	o.storeWater = storeWater
	return o
end 