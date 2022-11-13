UrinationWindow = ISCollapsableWindow:derive("UrinationWindow")
UrinationWindow.compassLines = {}

function UrinationWindow:initialise()
	ISCollapsableWindow.initialise(self)
end

function UrinationWindow:new(x, y, width, height)
	local o = {}
	o = ISCollapsableWindow:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.title = ""
	o.pin = false
	o:noBackground()
	o.urinatePic = getTexture("D_urinatePic.png")
	return o
end

function UrinationWindow:saveWindow()
	local specificPlayer = getSpecificPlayer(0)
	local DLayout = {}
	DLayout.DWindow = {}
	DLayout.DWindow.x = UrinationWindow:getX()
	DLayout.DWindow.y = UrinationWindow:getY()
	DLayout.DWindow.visible = UrinationWindow:getIsVisible()

	DLayout.DWindowMini = {}
	DLayout.DWindowMini.x = UrinationStatusMini:getX()
	DLayout.DWindowMini.y = UrinationStatusMini:getY()
	DLayout.DWindowMini.visible = UrinationStatusMini:getIsVisible()

	specificPlayer:getModData()["DLayout"] = DLayout
end

function UrinationWindow.onRightMouseUp(x, y)
	UrinationWindow:setVisible(false)
	UrinationStatusMini:setVisible(true)
	UrinationStatusMini.updateWindow()
end

function UrinationWindow:createChildren()
	ISCollapsableWindow.createChildren(self)
	self.HomeWindow = ISRichTextPanel:new(0, 16, 210, 250)
	self.HomeWindow:initialise()
	self.HomeWindow.autosetheight = false
	self.HomeWindow:ignoreHeightChange()
	self.HomeWindow.onRightMouseUp = UrinationWindow.onRightMouseUp
	self:addChild(self.HomeWindow)
	
	local urinateImage = getTexture("media/textures/D_urinatePic0.png")

	self.urinatePicture = ISImage:new(40, 60, 100, 25, urinateImage)
	self.urinatePicture:initialise()
	self.urinatePicture.onRightMouseUp = UrinationWindow.onRightMouseUp
	self:addChild(self.urinatePicture)
	
	self.statusLabel = ISRichTextPanel:new(0, 15, 210, 1)
	self.statusLabel:initialise()
	self.statusLabel:instantiate()
	self.statusLabel.onRightMouseUp = UrinationWindow.onRightMouseUp
	self:addChild(self.statusLabel)
end

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function UrinationWindow:updateStatus()
	if not UrinationWindow:isVisible() then
	return end

	local specificPlayer = getSpecificPlayer(0)
	local urinate = specificPlayer:getModData()["Urinate"]
	if (type(urinate) ~= "number") then
		urinate = 0.0
	end
	
	local UrinationStatusTextSize = "<SIZE:medium>"

	if (getCore():getScreenWidth() > 1920) then
		UrinationStatusTextSize = "<SIZE:small>"
	end
	
	local UrinationStatusText = getText("UI_optionscreen_binding_UrinationStatus") .. ": "
	local labelR, labelG, labelB = 0
	
	if (urinate < .2) then
		self.urinatePicture.texture = getTexture("media/textures/D_urinatePic0.png")
		labelR = 0
		labelG = 1
		labelB = 0
	elseif (urinate >= .2 and urinate < .4) then
		self.urinatePicture.texture = getTexture("media/textures/D_urinatePic33.png")
		labelR = 1
		labelG = 1
		labelB = 0
	elseif (urinate >= .4 and urinate < .6) then
		self.urinatePicture.texture = getTexture("media/textures/D_urinatePic66.png")
		labelR = 1
		labelG = 0
		labelB = 0
	elseif (urinate >= .6) then
		self.urinatePicture.texture = getTexture("media/textures/D_urinatePic99.png")
		labelR = 1
		labelG = 0
		labelB = 0
	end
	
	local colorString = "<RGB:" .. labelR .. "," .. labelG .. "," .. labelB .. ">"
	
	if (SandboxVars.Urination.ShowNumericStatus == true) then
		self.statusLabel.text = colorString .. "<CENTRE>" .. UrinationStatusTextSize .. UrinationStatusText .. round(urinate * 100 * 1.66667, 1) .. "%"
		self.statusLabel:paginate()
	elseif (self.statusLabel ~= nil) then
		self.statusLabel = nil
	end
	
	self.HomeWindow:paginate()
end

function UrinationWindow.updateWindow()
	UrinationWindow:updateStatus()
	UrinationWindow:saveWindow()
end

function UrinationMainWindow()
	local specificPlayer = getSpecificPlayer(0)
	local layout = specificPlayer:getModData()["DLayout"]
	local x = 5
	local y = 500
	local visible = false
	
	if (layout ~= nil and layout.DWindow ~= nil) then
		x = layout.DWindow.x
		y = layout.DWindow.y
		visible = layout.DWindow.visible
	end
	
	UrinationWindow = UrinationWindow:new(x, y, 210, 220)
	UrinationWindow:addToUIManager()
	UrinationWindow:setVisible(visible)
	UrinationWindow.pin = true
	UrinationWindow.resizable = false
end
Events.OnGameStart.Add(UrinationMainWindow)