WorldMapSymbolTool_FreeHandEraser = ISWorldMapSymbolTool:derive("WorldMapSymbolTool_FreeHandEraser")

function WorldMapSymbolTool_FreeHandEraser:activate()
end

function WorldMapSymbolTool_FreeHandEraser:deactivate()
end

function WorldMapSymbolTool_FreeHandEraser:onMouseDown(x, y)
	if self.rightDown then
		return false;
	end

	self.mouseHeld = true;
	return true;
end

function WorldMapSymbolTool_FreeHandEraser:onMouseUp(x, y)
	self.mouseHeld = false;
	return false
end

function WorldMapSymbolTool_FreeHandEraser:onMouseMove(dx, dy)
	if self.mouseHeld then
		self:removeAnnotation()
		for i=1,3 do
			self.symbolsUI:checkAnnotationForMoveMouse();
			self:removeAnnotation()
		end
	end
	return false
end

function WorldMapSymbolTool_FreeHandEraser:onRightMouseDown(x, y)
	self.rightDown = true;
	return true;
end

function WorldMapSymbolTool_FreeHandEraser:onRightMouseUp(x, y)
	self.rightDown = false;
	return true;
end

function WorldMapSymbolTool_FreeHandEraser:render()
	self.symbolsUI:checkAnnotationForRemoveMouse()
	self.symbolsUI:checkAnnotationForRemoveJoypad()
end

function WorldMapSymbolTool_FreeHandEraser:onJoypadDownInMap(button, joypadData)
	if button == Joypad.AButton then
		self:removeAnnotation()
	end
end

function WorldMapSymbolTool_FreeHandEraser:getJoypadAButtonText()
	if self.symbolsUI.mouseOverNote or self.symbolsUI.mouseOverSymbol then
		return getText("IGUI_Map_RemoveElement")
	end
	return nil
end

function WorldMapSymbolTool_FreeHandEraser:removeAnnotation()
	if self.symbolsUI.mouseOverNote then
		self.symbolsAPI:removeSymbolByIndex(self.symbolsUI.mouseOverNote)
		self.symbolsUI.mouseOverNote = nil
		if self.symbolsUI.character then
			self.symbolsUI.character:playSoundLocal("MapRemoveMarking")
		end
		return true
	end
	if self.symbolsUI.mouseOverSymbol then
		self.symbolsAPI:removeSymbolByIndex(self.symbolsUI.mouseOverSymbol)
		self.symbolsUI.mouseOverSymbol = nil
		return true
	end
	return false
end

function WorldMapSymbolTool_FreeHandEraser:new(symbolsUI)
	local o = ISWorldMapSymbolTool.new(self, symbolsUI)
	return o
end