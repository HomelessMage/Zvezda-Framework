require "ISUI/Maps/ISWorldMapSymbols"
require "DrawOnMap/WorldMapSymbolTool_SplineTool"

ISWorldMapSymbols.initTools_prepatch_drawonmap = ISWorldMapSymbols.initTools;

ISWorldMapSymbols.initTools = function(self)
	self:initTools_prepatch_drawonmap();
	self.tools.SplineTool = WorldMapSymbolTool_SplineTool:new(self);
	self.tools.FreeHandEraseTool = WorldMapSymbolTool_FreeHandEraser:new(self);
end


ISWorldMapSymbols.onButtonClick_prepatch_drawonmap = ISWorldMapSymbols.onButtonClick;

ISWorldMapSymbols.onButtonClick = function(self, button)
	local originalTool = self.currentTool;

	self:onButtonClick_prepatch_drawonmap(button);
	
	 -- Allow symbol selection with the free hand tool selected
	if button.symbol and originalTool == self.tools.SplineTool then
		local symbol = self.selectedSymbol;
		self:setCurrentTool(self.tools.SplineTool);
		self.selectedSymbol = symbol;
	end

	if button.internal == "FREE_HAND" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.SplineTool)
	end

	if button.internal == "FREE_HAND_ERASE" then
		self.selectedSymbol = nil
		self:toggleTool(self.tools.FreeHandEraseTool)
	end

	if button.internal == "FREE_HAND_SIZE" then
		self.tools.SplineTool:resetScale();
		self.freeHandSizeBtn.title = "Line Size: " .. self.tools.SplineTool.scale
	end

	if button.internal == "FREE_HAND_SIZE_DOWN" then
		self.tools.SplineTool:scaleDown();
		self.freeHandSizeBtn.title = "Line Size: " .. self.tools.SplineTool.scale
	end

	if button.internal == "FREE_HAND_SIZE_UP" then
		self.tools.SplineTool:scaleUp();
		self.freeHandSizeBtn.title = "Line Size: " .. self.tools.SplineTool.scale
	end

	if button.internal == "LINE_SPACING" then
		self.tools.SplineTool:resetFill();
		self:updateFillText();
	end

	if button.internal == "LINE_SPACING_DOWN" then
		self.tools.SplineTool:fillDown();
		self:updateFillText();
	end

	if button.internal == "LINE_SPACING_UP" then
		self.tools.SplineTool:fillUp();
		self:updateFillText();
	end
end

function ISWorldMapSymbols:updateFillText()
	local fill = self.tools.SplineTool.fill;
	if fill > 0.01 then
		self.lineSpacingBtn.title = "Line Fill: " .. fill
	else
		self.lineSpacingBtn.title = "Line Fill: Off"
	end
end

ISWorldMapSymbols.createChildren_prepatch_drawonmap = ISWorldMapSymbols.createChildren;

ISWorldMapSymbols.createChildren = function(self)
	self:createChildren_prepatch_drawonmap();
	--self:createDrawOnMapChildren(); -- F*&@ it, we'll do it live. Too many other mods are messing this way up.
end

ISWorldMapSymbols.createDrawOnMapChildren = function(self)
	local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

	local btnWid = self.width - 20 * 2
	local btnHgt = FONT_HGT_SMALL + 2 * 2

	local findHighestIndex = function(luaTable)
		local highest = 0;
		for i,v in pairs(luaTable) do
			if i > highest then
				highest = i;
			end
		end
		return highest;
	end

	local index = findHighestIndex(self.children);
	local y = self.children[index]:getBottom() + 10

	self.splineBtn = ISButton:new(20, y, btnWid, btnHgt, "Free Hand", self, ISWorldMapSymbols.onButtonClick)
	self.splineBtn.internal = "FREE_HAND"
	self.splineBtn:initialise()
	self.splineBtn:instantiate()
	self.splineBtn.borderColor.a = 0.0
	self:addChild(self.splineBtn)

	y = self.splineBtn:getBottom() + 10

	self.freeHandEraseBtn = ISButton:new(20, y, btnWid, btnHgt, "Free Hand Erase", self, ISWorldMapSymbols.onButtonClick)
	self.freeHandEraseBtn.internal = "FREE_HAND_ERASE"
	self.freeHandEraseBtn:initialise()
	self.freeHandEraseBtn:instantiate()
	self.freeHandEraseBtn.borderColor.a = 0.0
	self:addChild(self.freeHandEraseBtn)

	y = self.freeHandEraseBtn:getBottom() + 10

	local sizeControlButtonW = (btnWid - 10) / 4

	self.freeHandSizeBtn = ISButton:new(25 + sizeControlButtonW, y, sizeControlButtonW * 2, btnHgt, "Line Size: 3", self, ISWorldMapSymbols.onButtonClick)
	self.freeHandSizeBtn.internal = "FREE_HAND_SIZE"
	self.freeHandSizeBtn:initialise()
	self.freeHandSizeBtn:instantiate()
	self.freeHandSizeBtn.borderColor.a = 0.0
	self:addChild(self.freeHandSizeBtn)

	self.sizeDownBtn = ISButton:new(20, y, sizeControlButtonW, btnHgt, "-", self, ISWorldMapSymbols.onButtonClick)
	self.sizeDownBtn.internal = "FREE_HAND_SIZE_DOWN"
	self.sizeDownBtn:initialise()
	self.sizeDownBtn:instantiate()
	self.sizeDownBtn.borderColor.a = 0.0
	self:addChild(self.sizeDownBtn)

	self.sizeUpBtn = ISButton:new(30 + sizeControlButtonW * 3, y, sizeControlButtonW, btnHgt, "+", self, ISWorldMapSymbols.onButtonClick)
	self.sizeUpBtn.internal = "FREE_HAND_SIZE_UP"
	self.sizeUpBtn:initialise()
	self.sizeUpBtn:instantiate()
	self.sizeUpBtn.borderColor.a = 0.0
	self:addChild(self.sizeUpBtn)

	y = self.freeHandSizeBtn:getBottom() + 10

	self.lineSpacingBtn = ISButton:new(25 + sizeControlButtonW, y, sizeControlButtonW * 2, btnHgt, "Line Fill: 1", self, ISWorldMapSymbols.onButtonClick)
	self.lineSpacingBtn.internal = "LINE_SPACING"
	self.lineSpacingBtn:initialise()
	self.lineSpacingBtn:instantiate()
	self.lineSpacingBtn.borderColor.a = 0.0
	self:addChild(self.lineSpacingBtn)

	self.lineSpacingDownBtn = ISButton:new(20, y, sizeControlButtonW, btnHgt, "-", self, ISWorldMapSymbols.onButtonClick)
	self.lineSpacingDownBtn.internal = "LINE_SPACING_DOWN"
	self.lineSpacingDownBtn:initialise()
	self.lineSpacingDownBtn:instantiate()
	self.lineSpacingDownBtn.borderColor.a = 0.0
	self:addChild(self.lineSpacingDownBtn)

	self.lineSpacingUpBtn = ISButton:new(30 + sizeControlButtonW * 3, y, sizeControlButtonW, btnHgt, "+", self, ISWorldMapSymbols.onButtonClick)
	self.lineSpacingUpBtn.internal = "LINE_SPACING_UP"
	self.lineSpacingUpBtn:initialise()
	self.lineSpacingUpBtn:instantiate()
	self.lineSpacingUpBtn.borderColor.a = 0.0
	self:addChild(self.lineSpacingUpBtn)

	self:insertNewLineOfButtons(self.splineBtn)
	self:insertNewLineOfButtons(self.freeHandEraseBtn)
	self:insertNewLineOfButtons(self.sizeDownBtn, self.freeHandSizeBtn, self.sizeUpBtn)
	self:insertNewLineOfButtons(self.lineSpacingDownBtn, self.lineSpacingBtn, self.lineSpacingUpBtn)

	self:setHeight(self.lineSpacingBtn:getBottom() + 20)
end

ISWorldMapSymbols.checkInventory_prepatch_drawonmap = ISWorldMapSymbols.checkInventory;

ISWorldMapSymbols.checkInventory = function(self)
	self:checkInventory_prepatch_drawonmap();

	if self.splineBtn then -- We have to check because this function runs once before the buttons are created
	
		self.splineBtn.enable = self.addNoteBtn.enable;
		self.splineBtn.tooltip = self.addNoteBtn.tooltip;

		self.freeHandEraseBtn.enable = self.removeBtn.enable;
		self.freeHandEraseBtn.tooltip = self.removeBtn.tooltip;

		if self.currentTool == self.tools.SplineTool and not self.splineBtn.enable then
			self:setCurrentTool(nil)
		end
		if self.currentTool == self.tools.FreeHandEraseTool and not self.freeHandEraseBtn.enable then
			self:setCurrentTool(nil)
		end
	end
end

ISWorldMapSymbols.prerender_prepatch_drawonmap = ISWorldMapSymbols.prerender;

ISWorldMapSymbols.prerender = function(self)
	self:prerender_prepatch_drawonmap();

	if not self.splineBtn then -- I don't want to check this every frame, but for compatibility's sake other mods have tied my hands here
		self:createDrawOnMapChildren()
		self:checkInventory();
	end

	self.splineBtn.borderColor.a = (self.currentTool == self.tools.SplineTool) and 1 or 0
	self.freeHandEraseBtn.borderColor.a = (self.currentTool == self.tools.FreeHandEraseTool) and 1 or 0
end
