SYMSComboModal = ISPanelJoypad:derive("SYMSComboModal")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function SYMSComboModal:new(x, y, width, height, text, target, onclick, player, param1, param2, param3, param4)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    local playerObj = player and getSpecificPlayer(player) or nil
    if y == 0 then
        if playerObj and playerObj:getJoypadBind() ~= -1 then
            o.y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
        else
            o.y = o:getMouseY() - (height / 2)
        end
        o:setY(o.y)
    end
    if x == 0 then
        if playerObj and playerObj:getJoypadBind() ~= -1 then
            o.x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
        else
            o.x = o:getMouseX() - (width / 2)
        end
        o:setX(o.x)
    end
    o.name = nil
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.5 }
    o.borderColor = { r = 0.4, g = 0.4, b = 0.4, a = 1 }
    o.width = width
    local txtWidth = getTextManager():MeasureStringX(UIFont.Small, text) + 10
    if width < txtWidth then
        o.width = txtWidth
    end
    o.height = height
    o.anchorLeft = true
    o.anchorRight = true
    o.anchorTop = true
    o.anchorBottom = true
    o.text = text
    o.target = target
    o.onclick = onclick
    o.player = player
    o.param1 = param1
    o.param2 = param2
    o.param3 = param3
    o.param4 = param4
    o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png")
    return o;
end

function SYMSComboModal:initialise()
    ISPanelJoypad.initialise(self)

    local fontHgt = FONT_HGT_SMALL
    local buttonWid1 = getTextManager():MeasureStringX(UIFont.Small, "Ok") + 12
    local buttonWid2 = getTextManager():MeasureStringX(UIFont.Small, "Cancel") + 12
    local buttonWid = math.max(math.max(buttonWid1, buttonWid2), 100)
    local buttonHgt = math.max(fontHgt + 6, 25)
    local padBottom = 10

    self.yes = ISButton:new((self:getWidth() / 2) - 5 - buttonWid, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, getText("UI_Ok"), self, SYMSComboModal.onClick)
    self.yes.internal = "OK"
    self.yes:initialise()
    self.yes:instantiate()
    self.yes.borderColor = { r = 1, g = 1, b = 1, a = 0.1 }
    self:addChild(self.yes)

    self.no = ISButton:new((self:getWidth() / 2) + 5, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, getText("UI_Cancel"), self, SYMSComboModal.onClick)
    self.no.internal = "CANCEL"
    self.no:initialise()
    self.no:instantiate()
    self.no.borderColor = { r = 1, g = 1, b = 1, a = 0.1 }
    self:addChild(self.no)

    local height = 2 + FONT_HGT_SMALL + 2
    self.comboBox = ISComboBox:new(self:getWidth() / 2 - ((self:getWidth() - 40) / 2), (self:getHeight() - height) / 2, self:getWidth() - 40, height, self, self.onSelected)
    self.comboBox.noSelectionText = getText("IGUI_SYMS_SelectMarkings")
    self:addChild(self.comboBox)

    self:insertNewLineOfButtons(self.comboBox)

    local items = getSpecificPlayer(self.player):getInventory():getAllTypeRecurse("SYMS.SYMSPaper")
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        self.comboBox:addOptionWithData(item:getDisplayName(), item)
    end
    self.comboBox.selected = 0
end

function SYMSComboModal:destroy()
    self:setVisible(false)
    self:removeFromUIManager()
end

function SYMSComboModal:onClick(button)
    if self.player and JoypadState.players[self.player + 1] then
        setJoypadFocus(self.player, nil)
    elseif self.joyfocus and self.joyfocus.focus == self then
        self.joyfocus.focus = nil
    end
    if self.onclick ~= nil then
        local item
        if self.comboBox.selected > 0 then
            item = self.comboBox.options[self.comboBox.selected].data
        end
        self.onclick(self.target, button, item)
    end
    self:destroy()
end

function SYMSComboModal:titleBarHeight()
    return 16
end

function SYMSComboModal:prerender()
    self.backgroundColor.a = 0.8

    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);

    local th = self:titleBarHeight()
    self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);

    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    --local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
    --self:drawTextCentre(self.text, self:getWidth() / 2, self.comboBox:getY() - 8 - fontHgt, 1, 1, 1, 1, UIFont.Small)

    self:updateButtons()
end

function SYMSComboModal:updateButtons()
    self.yes:setEnable(true)
    self.yes.tooltip = nil
    if self.comboBox.selected == 0 then
        self.yes:setEnable(false)
        self.yes.tooltip = getText("IGUI_TextBox_CantBeEmpty")
    end
end

function SYMSComboModal:render()

end

function SYMSComboModal:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function SYMSComboModal:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function SYMSComboModal:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function SYMSComboModal:onMouseUp(x, y)
    if not self:getIsVisible() then
        return ;
    end
    self.moving = false
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x, y)
    end
    ISMouseDrag.dragView = nil
end

function SYMSComboModal:onMouseUpOutside(x, y)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function SYMSComboModal:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.yes)
    self:setISButtonForB(self.no)
    self.joypadButtons = {}
end

function SYMSComboModal:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        if not self.yes:isEnabled() then
            return
        end
        self.yes.player = self.player
        self.yes.onclick(self.yes.target, self.yes)
        if joypadData.focus == self then
            if self.player and JoypadState.players[self.player + 1] then
                setJoypadFocus(self.player, nil)
            else
                joypadData.focus = nil
            end
        end
        self:destroy()
    end
    if button == Joypad.BButton then
        self.no.player = self.player
        self.no.onclick(self.no.target, self.no)
        if joypadData.focus == self then
            if self.player and JoypadState.players[self.player + 1] then
                setJoypadFocus(self.player, nil)
            else
                joypadData.focus = nil
            end
        end
        self:destroy()
    end
end

function SYMSComboModal:close()
    ISPanelJoypad.close(self)
    if JoypadState.players[self.player + 1] then
        setJoypadFocus(self.player, nil)
    end
end

