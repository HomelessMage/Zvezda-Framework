UrinationStatusMini = ISPanel:derive("UrinationStatusMini")
UrinationStatusMini.compassLines = {}

function UrinationStatusMini:initialise()
	ISPanel.initialise(self)
end

function UrinationStatusMini:new(x, y, width, height)
	local o = {}
	o = ISPanel:new(x, y, width, height)
	setmetatable(o, self)
	self.__index = self
	o.title = ""
	o.pin = false
	o.borderColor = {r=.82, g=.56, b=.29, a=1}
	o.moveWithMouse = true
	
	return o
end

function UrinationStatusMini.onRightMouseUp(x, y)
	UrinationWindow:setVisible(true)
	UrinationStatusMini:setVisible(false)
	UrinationWindow.updateWindow()
	
	UrinationStatusMini.tooltip:setVisible(false)
	UrinationStatusMini.tooltip:removeFromUIManager()
	UrinationStatusMini.tooltip.followMouse = false
end

function UrinationStatusMini:createChildren()
    ISPanel.createChildren(self)

    self.innerPanel = ISPanel:new(1, 98, 10, 96)
	self.innerPanel.backgroundColor = {r=1, g=1, b=0, a=.5}
	self.innerPanel.moveWithMouse = true
	self.innerPanel.onRightMouseUp = UrinationWindow.onRightMouseUp
	self:addChild(self.innerPanel)
	
	self.statusLabel = ISRichTextPanel:new(-17, 61, 0, 0)
	self.statusLabel:initialise()
	self.statusLabel:noBackground()
	self.statusLabel:instantiate()
	self.statusLabel.onRightMouseUp = UrinationWindow.onRightMouseUp
	self:addChild(self.statusLabel)
	
	self.customTooltip = ISToolTip:new()
	self.customTooltip:initialise()
	self.customTooltip.description = "error"
	
	self.tooltip = self.customTooltip
end

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function UrinationStatusMini:updateStatus()
	if not UrinationStatusMini:isVisible() then
		return
	end

	local specificPlayer = getSpecificPlayer(0)
	local urinate = specificPlayer:getModData()["Urinate"]
	if (type(urinate) ~= "number") then
		urinate = 0.0
	end
	
	local labelR = nil
	local labelG = nil
	local labelB = nil
	
	if (urinate < .2) then
		labelR = 0
		labelG = 1
		labelB = 0
	elseif (urinate >= .2 and urinate < .4) then
		labelR = 1
		labelG = 1
		labelB = 0
	elseif (urinate >= .4 and urinate < .6) then
		labelR = 1
		labelG = 0
		labelB = 0
	elseif (urinate >= .6) then
		labelR = 1
		labelG = 0
		labelB = 0
	end
	
	self.statusLabel:paginate()
	
	self.innerPanel.backgroundColor = {r=labelR, g=labelG, b=labelB, a=.5}
	
	local statusHeight = (urinate / 0.6) * 96
	self.innerPanel.height = statusHeight * -1
	
	local tooltipColor = " <RGB:" .. labelR .. "," .. labelG .. "," .. labelB .. "> "
	self.tooltip.description = getText("UI_optionscreen_binding_UrinationStatus") .. ": " .. tooltipColor .. "    " .. round(urinate * 100 * 1.66667, 1) .. "%"
end

function UrinationStatusMini:prerender()
	if UrinationStatusMini:isMouseOver() then
		self.tooltip:setVisible(true)
		self.tooltip:addToUIManager()
		self.tooltip.followMouse = true
	else
		self.tooltip:setVisible(false)
		self.tooltip:removeFromUIManager()
		self.tooltip.followMouse = false
    end
	
	if self.background then
		self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
		self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	end
	
	if (self.x < 110 and self.x > 80 and self.y < 450) then
		UrinationStatusMini:setX(110)
	end
	
	if (self.x <= 80 and self.y < 450) then
		UrinationStatusMini:setY(450)
	end
	
end

function UrinationStatusMini.updateWindow()
	UrinationStatusMini:updateStatus()
end

function UrinationStatusMiniWindow()
	local specificPlayer = getSpecificPlayer(0)
	local layout = specificPlayer:getModData()["DLayout"]
	local x = 5
	local y = 450
	local visible = false
	
	if (layout ~= nil and layout.DWindowMini ~= nil) then
		x = layout.DWindowMini.x
		y = layout.DWindowMini.y
		visible = layout.DWindowMini.visible
	end
	
	UrinationStatusMini = UrinationStatusMini:new(x, y, 12, 100)
	UrinationStatusMini:addToUIManager()
	UrinationStatusMini:setVisible(visible)
	UrinationStatusMini.pin = true
	UrinationStatusMini.resizable = false
end
Events.OnGameStart.Add(UrinationStatusMiniWindow)