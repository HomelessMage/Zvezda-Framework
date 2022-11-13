--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISBetterTilesPlace = ISBuildingObject:derive("ISBetterTilesPlace")


function ISBetterTilesPlace:create(x, y, z, north, sprite)
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISTimedActionQueue.clear(self.character)
	-- ISTimedActionQueue.add(ISWalkToTimedAction:new(self.character, square))

	
	
end

-- function ISBetterTilesPlace:isValid(square)
-- 	return square:TreatAsSolidFloor()
-- end

function ISBetterTilesPlace:render(x, y, z, square)
	-- if not ISBetterTilesPlace.floorSprite then
	-- 	-- ISBetterTilesPlace.floorSprite = IsoSprite.new()
	-- 	-- ISBetterTilesPlace.floorSprite:LoadFramesNoDirPageSimple(catballstile)
	-- end
	local r,g,b,a = 0.0,1.0,0.0,0.8
	-- if not self:isValid(square) then
	-- 	r = 1.0
	-- 	g = 0.0
	-- end
	ISBetterTilesPlace.floorSprite:RenderGhostTileColor(x, y, z, r, g, b, a)
	-- print(square,"sasd")
	if self.mouseDown then
		local objectss = square:getObjects()
		-- print(objectss)
		if objectss:size()==0 then
			local Spiobj=ISMoveableSpriteProps.new(IsoObject.new(square, BetterTilePickertiles):getSprite())
			-- ISMoveableSpriteProps:placeMoveable(self.character, square, BetterTilePickertiles)
			local itemz = self.character:getInventory():AddItem("Money")

			ISMoveableSpriteProps:placeMoveableInternalfix(square, itemz, BetterTilePickertiles)

		end

		for i=0, objectss:size() - 1 do
			if objectss:get(i):getSprite() == nil then

				-- print("tileloos")
				-- local Spiobj=ISMoveableSpriteProps.new(IsoObject.new(square, BetterTilePickertiles):getSprite())
				-- -- ISMoveableSpriteProps:placeMoveable(self.character, square, BetterTilePickertiles)
				-- local itemz = self.character:getInventory():AddItem("Money")

				-- ISMoveableSpriteProps:placeMoveableInternalfix(square, itemz, BetterTilePickertiles)

				break
			end
			local objectname = objectss:get(i):getSprite():getName()
			if objectname==BetterTilePickertiles then
				break
			elseif i==objectss:size() - 1 then
				-- local objectz = IsoObject.new(square, BetterTilePickertiles,"",false)

				-- -- local objectzy = IsoObject.new(square, BetterTilePickertiles,"Stove",true)
                -- -- square:AddTileObject(objectz)
				-- -- print(objectzy:getObjectName())
				-- square:AddTileObject(objectz)

				-- debugScenarios.Trailer3Scenario_Building.addItem(square:getX(),square:getY(),square:getZ(), BetterTilePickertiles)
				-- local thump = IsoThumpable.new(getCell(), square, BetterTilePickertiles, nil, false, nil)
				-- square:AddSpecialObject(thump)
				-- thump:transmitCompleteItemToServer()

				

				local Spiobj=ISMoveableSpriteProps.new(IsoObject.new(square, BetterTilePickertiles):getSprite())
				-- ISMoveableSpriteProps:placeMoveable(self.character, square, BetterTilePickertiles)
				local itemz = self.character:getInventory():AddItem("Money")

				ISMoveableSpriteProps:placeMoveableInternalfix(square, itemz, BetterTilePickertiles)


				-- ISTimedActionQueue.add(ISMoveablesAction:new(self.character, square, Spiobj,"place", BetterTilePickertiles, self ));

			end

		end


		
		
	end
end

-- function ISBetterTilesPlace:onMouseUp(x, y)
-- 	self.mouseDown = false
-- 	print("onMouseUp")



-- end

-- function ISBetterTilesPlace:onMouseDown(x, y)
-- 	self.mouseDown = true
-- 	print("onMouseDown")
-- end

local function TilesPickerOnMouseDown()
	ISBetterTilesPlace.mouseDown=true
	-- print("TilesPickerOnMouseDown")
	-- Your code here
end
local function TilesPickerOnMouseUp()
	ISBetterTilesPlace.mouseDown=false
	-- print("TilesPickerOnMouseUp")
	
	-- Your code here
end
Events.OnMouseDown.Add(TilesPickerOnMouseDown)
Events.OnMouseUp.Add(TilesPickerOnMouseUp)




function ISBetterTilesPlace:new(sprite, northSprite, character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o:setSprite(sprite)
	o:setNorthSprite(northSprite)
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
	return o
end

