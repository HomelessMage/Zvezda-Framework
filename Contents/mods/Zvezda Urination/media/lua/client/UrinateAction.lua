UrinateAction = ISBaseTimedAction:derive("UrinateAction")
function UrinateAction:isValid()
	print("VALIDATING THE PEE ACTION!")
	return true
end

function UrinateAction:update()	
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
	print("UPDATING THE PEE ACTION!")
end

function UrinateAction:start()
	self:setActionAnim("urinationUrinate")
	print("STARTED THE PEE ACTION!")
end

function UrinateAction:stop()
	ISBaseTimedAction.stop(self)
	UrinationWindow.updateWindow()
	UrinationFunctions.playerUrinating = false
	print("STOPPED THE PEE ACTION!")
end

function UrinateAction:perform()
	local specificPlayer = self.character
	local urinate = UrinationFunctions.FixUrinateValue(specificPlayer)
	--local accidentValue = UrinationFunctions.FixAccidentValue(specificPlayer) --EXPERIMENTAL
	local dItem = getPlayer():getWornItem("Underwear"); --unused

	if (self.peeSelf) then
		specificPlayer:getStats():setStress(specificPlayer:getStats():getStress() + 0.6) --If they have peed themselves, add stress and unhappyness
		specificPlayer:getBodyDamage():setUnhappynessLevel(specificPlayer:getBodyDamage():getUnhappynessLevel() + 50)
		UrinationFunctions.UrinateBottoms(specificPlayer)
		if SandboxVars.Urination.CreatePeePuddle == true then
			local urineItem = InventoryItemFactory.CreateItem("Urination.HumanUrine")
			specificPlayer:getCurrentSquare():AddWorldInventoryItem(urineItem, ZombRand(0.1, 0.5), ZombRand(0.1, 0.5), 0)
		end
		--accidentValue = accidentValue - 1
		specificPlayer:Say("I've urinated myself...")
		--print("ACCIDENT VALUE IS = ", accidentValue)
	end

	UrinationFunctions.RemoveUrinateStress(specificPlayer, urinate)

	if (self.useToilet) then
		getSoundManager():PlayWorldSound("D_Flush", specificPlayer:getCurrentSquare(), 0, 15 * SandboxVars.Urination.ToiletNoiseRadiusMultiplier, 0, false)
		addSound(specificPlayer, specificPlayer:getX(), specificPlayer:getY(), specificPlayer:getZ(), 15 * SandboxVars.Urination.ToiletNoiseRadiusMultiplier, 10) --play toilet noises if they've used a toilet
		self.toiletObject:setWaterAmount(self.toiletObject:getWaterAmount() - 10)
		--accidentValue = accidentValue + 1
		print("PEEING IN THE TOILET!")
		--print("ACCIDENT VALUE IS = ", accidentValue)
	else
		if (not self.peeSelf) then
			specificPlayer:getStats():setStress(specificPlayer:getStats():getStress() - 0.25)
			specificPlayer:getBodyDamage():setBoredomLevel(specificPlayer:getBodyDamage():getBoredomLevel() - 20)
			specificPlayer:setHaloNote("-20 Boredom, -25 Stress", 200)
			if SandboxVars.Urination.CreatePeePuddle == true then
				local urineItem = InventoryItemFactory.CreateItem("Urination.HumanUrine")
				specificPlayer:getCurrentSquare():AddWorldInventoryItem(urineItem, ZombRand(0.1, 0.5), ZombRand(0.1, 0.5), 0)
			end
			print("DID NOT PEE ON SELF OR IN TOILET!")
		end
		specificPlayer:getStats():setFatigue(specificPlayer:getStats():getFatigue() + 0.025) --add a small amount of fatigue if player did not use toilet
	end

	UrinationWindow.updateWindow()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
	UrinationFunctions.playerUrinating = false
	print("PERFORMING THE PEE ACTION!")
end

function UrinateAction:new(character, time, stopWalk, stopRun, peedSelf, useToilet, toiletObject)	
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.stopOnWalk = stopWalk
	o.stopOnRun = stopRun
	o.maxTime = time
	o.peeSelf = peedSelf
	o.useToilet = useToilet
	o.toiletObject = toiletObject
	print("URINATE HAS BEEN CALLED!")
	return o
end