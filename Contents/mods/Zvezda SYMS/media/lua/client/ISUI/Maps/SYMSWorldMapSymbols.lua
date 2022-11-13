require('ISUI/Maps/ISWorldMapSymbols')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_HANDWRITTEN = getTextManager():getFontHeight(UIFont.Handwritten)
local SYMBOL_TEXTURE_HGT = 20

local function round(number, decimalPlaces)
    local multiplier = 10 ^ (decimalPlaces or 0)
    return math.floor(number * multiplier + 0.5) / multiplier
end

local function generateId(data) 
    local id = ""
    if data.symbolID ~= nil then id = id .. data.symbolID end
    if data.textTranslated ~= nil then id = id .. data.textTranslated end
    if data.textUntranslated ~= nil then id = id .. data.textUntranslated end
    if data.worldX ~= nil then id = id .. data.worldX end
    if data.worldY ~= nil then id = id .. data.worldY end

    return id
end                             
-----

ISWorldMapSymbolTool_SYMSCopyMarkings = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_SYMSCopyMarkings")

function ISWorldMapSymbolTool_SYMSCopyMarkings:new(symbolsUI)
    local o = ISWorldMapSymbolTool.new(self, symbolsUI)
    return o
end

function ISWorldMapSymbolTool_SYMSCopyMarkings:activate()
    local allSymbols = {}
    local hasMark = false                     

    for i = 1, self.symbolsAPI:getSymbolCount() do
        hasMark = true              
        local symbol = self.symbolsAPI:getSymbolByIndex(i - 1)

        local textUntranslated, textTranslated, symbolID, symbolScale
        local isText = symbol:isText()
        if isText then
            textTranslated = symbol:getTranslatedText()
            textUntranslated = symbol:getUntranslatedText()
            symbolScale = symbol:getDisplayHeight() / (self.mapAPI:getWorldScale() * FONT_HGT_HANDWRITTEN)
        elseif symbol:isTexture() then
            symbolID = symbol:getSymbolID()
            symbolScale = symbol:getDisplayHeight() / (self.mapAPI:getWorldScale() * SYMBOL_TEXTURE_HGT)
        end

        local data = {
            isText = isText,
            worldX = symbol:getWorldX(),
            worldY = symbol:getWorldY(),
            r = symbol:getRed(),
            g = symbol:getGreen(),
            b = symbol:getBlue(),
            a = symbol:getAlpha(),
            textTranslated = textTranslated,
            textUntranslated = textUntranslated,
            symbolID = symbolID,
            scale = symbolScale
        }
        allSymbols[generateId(data)] = data
    end

    if hasMark then
        self.modal = ISTextBox:new(0, 0, 280, 150, getText("IGUI_SYMS_Name"), "",
                self, self.onCopy, self.symbolsUI.character:getPlayerNum(), allSymbols)
        self.modal:setValidateFunction(self, self.validateName)
        self.modal:setValidateTooltipText(getText("Tooltip_SYMS_ValidateName"))
        self.modal:initialise()
        self.modal:addToUIManager()
    end
end

function ISWorldMapSymbolTool_SYMSCopyMarkings:deactivate()
    if self.modal then
        self.modal.no:forceClick()
        self.modal = nil
    end
end

function ISWorldMapSymbolTool_SYMSCopyMarkings:validateName(text)
    return text ~= ""
end

function ISWorldMapSymbolTool_SYMSCopyMarkings:onCopy(button, allSymbols)
    self.modal = nil
    self.symbolsUI:setCurrentTool(nil)

    if button.internal ~= "OK" then return end

    local item = InventoryItemFactory.CreateItem("SYMS.SYMSPaper")
    item:setName(button.parent.entry:getText())
    item:setCustomName(true)
    item:getModData().symbols = allSymbols
    self.symbolsUI.character:getInventory():AddItem(item)

    local paper = self.symbolsUI.character:getInventory():getFirstTypeRecurse("Base.SheetPaper2")
    paper:getContainer():Remove(paper)

    -- Check if character has any paper left
    self.symbolsUI:checkInventorySYMS()

    self.symbolsUI.character:playSound("MapAddNote")
end

-----

ISWorldMapSymbolTool_SYMSPasteMarkings = ISWorldMapSymbolTool:derive("ISWorldMapSymbolTool_SYMSPasteMarkings")

function ISWorldMapSymbolTool_SYMSPasteMarkings:new(symbolsUI)
    local o = ISWorldMapSymbolTool.new(self, symbolsUI)
    return o
end

function ISWorldMapSymbolTool_SYMSPasteMarkings:activate()
    self.modal = SYMSComboModal:new(0, 0, 280, 150, getText("IGUI_SYMS_Name"),
            self, self.onPaste, self.symbolsUI.character:getPlayerNum())
    self.modal:initialise()
    self.modal:addToUIManager()
end

function ISWorldMapSymbolTool_SYMSPasteMarkings:deactivate()
    if self.modal then
        self.modal.no:forceClick()
        self.modal = nil
    end
end

function ISWorldMapSymbolTool_SYMSPasteMarkings:onPaste(button, item)
    self.modal = nil
    self.symbolsUI:setCurrentTool(nil)

    if button.internal ~= "OK" then return end

    local curretSymbols = {}
    local added = false

    for i = 1, self.symbolsAPI:getSymbolCount() do
        local symbol = self.symbolsAPI:getSymbolByIndex(i - 1)

        local textUntranslated, textTranslated, symbolID
        local isText = symbol:isText()
        if isText then
            textTranslated = symbol:getTranslatedText()
            textUntranslated = symbol:getUntranslatedText()
        elseif symbol:isTexture() then
            symbolID = symbol:getSymbolID()
        end

        local data = {
            isText = isText,
            worldX = symbol:getWorldX(),
            worldY = symbol:getWorldY(),
            r = symbol:getRed(),
            g = symbol:getGreen(),
            b = symbol:getBlue(),
            a = symbol:getAlpha(),
            textTranslated = textTranslated,
            textUntranslated = textUntranslated,
            symbolID = symbolID
        }
        curretSymbols[generateId(data)] = data
    end                        
    local allSymbols = item:getModData().symbols
    local added = false
    for k, symbol in pairs(allSymbols) do
        local newSymbol

        if not curretSymbols[k] then 
            if symbol.isText then
                if symbol.textUntranslated then
                    newSymbol = self.symbolsAPI:addUntranslatedText(symbol.textUntranslated, UIFont.Handwritten, symbol.worldX, symbol.worldY)
                else
                    newSymbol = self.symbolsAPI:addTranslatedText(symbol.textTranslated, UIFont.Handwritten, symbol.worldX, symbol.worldY)
                end
                newSymbol:setAnchor(0.0, 0.0)
            else
                newSymbol = self.symbolsAPI:addTexture(symbol.symbolID, symbol.worldX, symbol.worldY)
                newSymbol:setAnchor(0.5, 0.5)
            end

            local r, g, b = self:getAvailableColor(symbol.r, symbol.g, symbol.b)
            newSymbol:setRGBA(r, g, b, symbol.a)
            newSymbol:setScale(symbol.scale)
            added = true
        end    
    end
    if added then
        self.symbolsUI.character:playSound("MapAddNote")
    end
end

function ISWorldMapSymbolTool_SYMSPasteMarkings:getAvailableColor(r, g, b)
    local inventory = self.symbolsUI.character:getInventory()

    local rR, rG, rB = round(r, 1), round(g, 1), round(b, 1)
    if rR == 0 and rG == 0 and rB == 0 then
        if not inventory:containsTypeRecurse("Base.Pen") then
            return self:getReplacementColor(inventory)
        end
    elseif rR == 0.2 and rG == 0.2 and rB == 0.2 then
        if not inventory:containsTypeRecurse("Base.Pencil") then
            return self:getReplacementColor(inventory)
        end
    elseif rR == 1 and rG == 0 and rB == 0 then
        if not inventory:containsTypeRecurse("Base.RedPen") then
            return self:getReplacementColor(inventory)
        end
    elseif rR == 0 and rG == 0 and rB == 1 then
        if not inventory:containsTypeRecurse("Base.BluePen") then
            return self:getReplacementColor(inventory)
        end
    end
    return r, g, b
end

function ISWorldMapSymbolTool_SYMSPasteMarkings:getReplacementColor(inventory)
    if inventory:containsTypeRecurse("Base.Pen") then
        return 0, 0, 0
    elseif inventory:containsTypeRecurse("Base.Pencil") then
        return 0.2, 0.2, 0.2
    elseif inventory:containsTypeRecurse("Base.RedPen") then
        return 1, 0, 0
    elseif inventory:containsTypeRecurse("Base.BluePen") then
        return 0, 0, 1
    end
    return 0, 0, 0
end

-----

local originalCreateChildren = ISWorldMapSymbols.createChildren
function ISWorldMapSymbols:createChildren()
    originalCreateChildren(self)

    local btnWid = self.width - 20 * 2
    local btnHgt = FONT_HGT_SMALL + 2 * 2

    local y = self.removeBtn:getBottom() + 20
    self.symsCopyBtn = ISButton:new(20, y, btnWid, btnHgt, getText("IGUI_SYMS_CopyElements"), self, ISWorldMapSymbols.onButtonSYMS)
    self.symsCopyBtn.internal = "SYMS_COPY"
    self.symsCopyBtn:initialise()
    self.symsCopyBtn:instantiate()
    self.symsCopyBtn.borderColor.a = 0.0
    self:addChild(self.symsCopyBtn)

    y = self.symsCopyBtn:getBottom() + 20
    self.symsPasteBtn = ISButton:new(20, y, btnWid, btnHgt, getText("IGUI_SYMS_TransferElements"), self, ISWorldMapSymbols.onButtonSYMS)
    self.symsPasteBtn.internal = "SYMS_PASTE"
    self.symsPasteBtn:initialise()
    self.symsPasteBtn:instantiate()
    self.symsPasteBtn.borderColor.a = 0.0
    self:addChild(self.symsPasteBtn)

    self:setHeight(self.symsPasteBtn:getBottom() + 20)

    self:insertNewLineOfButtons(self.symsCopyBtn)
    self:insertNewLineOfButtons(self.symsPasteBtn)

    self:checkInventorySYMS()
end

local originalPrerender = ISWorldMapSymbols.prerender
function ISWorldMapSymbols:prerender()
    originalPrerender(self)

    -- Compatibility with ExtraMapSymbolsUI
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=2701170568
    if ExtraMapSymbolsUI and ExtraMapSymbolsUI.CONST then
        local const = ExtraMapSymbolsUI.CONST
        local x = self.removeBtn:getX()
        local y = self.removeBtn:getBottom() + const.Pad

        self.symsCopyBtn:setX(x)
        self.symsCopyBtn:setY(y)
        self.symsCopyBtn:setWidth(self:getWidth() - const.ToolX * 2)
        y = self.symsCopyBtn:getBottom() + const.Pad

        self.symsPasteBtn:setX(x)
        self.symsPasteBtn:setY(y)
        self.symsPasteBtn:setWidth(self:getWidth() - const.ToolX * 2)
        y = self.symsPasteBtn:getBottom() + const.Pad * 3
        if self.scaleSlider then
            y = self.scaleSlider and self.scaleSlider:getBottom() + const.Pad * 3 or y + 44 + FONT_HGT_SMALL
        end
        self:setHeight(y)
    end

    if self:canWrite() ~= self.wasCanWrite2
            or self:canCopyMarkingsSYMS() ~= self.wasCanCopyMarkings
            or self.symbolsAPI:getSymbolCount() ~= self.prevSymbolCount then
        self.wasCanWrite2 = self:canWrite()
        self.wasCanCopyMarkings = self:canCopyMarkingsSYMS()
        self.prevSymbolCount = self.symbolsAPI:getSymbolCount()
        self:checkInventorySYMS()
    end

    self.symsCopyBtn.borderColor.a = (self.currentTool == self.tools.SYMSCopyMarkings) and 1 or 0
    self.symsPasteBtn.borderColor.a = (self.currentTool == self.tools.SYMSPasteMarkings) and 1 or 0
end

local originalInitTools = ISWorldMapSymbols.initTools
function ISWorldMapSymbols:initTools()
    originalInitTools(self)

    self.tools.SYMSCopyMarkings = ISWorldMapSymbolTool_SYMSCopyMarkings:new(self)
    self.tools.SYMSPasteMarkings = ISWorldMapSymbolTool_SYMSPasteMarkings:new(self)
end

function ISWorldMapSymbols:checkInventorySYMS()
    if not self.character then
        self.symsCopyBtn.enable = false
        self.symsPasteBtn.enable = false
        return
    end

    local canWrite = self:canWrite()
    local canCopyMarkings = self:canCopyMarkingsSYMS()
    self.symsCopyBtn.enable = (canWrite and canCopyMarkings) and self.symbolsAPI:getSymbolCount() > 0
    self.symsPasteBtn.enable = canWrite

    if canWrite and canCopyMarkings then
        self.symsCopyBtn.tooltip = nil
        if self.symbolsAPI:getSymbolCount() == 0 then
            self.symsCopyBtn.tooltip = getText("Tooltip_SYMS_NothingToCopy")
        end
    else
        self.symsCopyBtn.tooltip = ""
        if not canWrite then
            self.symsCopyBtn.tooltip = getText("Tooltip_Map_CantWrite")
        end
        if not canCopyMarkings then
            if not canWrite then
                self.symsCopyBtn.tooltip = self.symsCopyBtn.tooltip .. " <LINE> "
            end
            self.symsCopyBtn.tooltip = self.symsCopyBtn.tooltip .. getText("Tooltip_SYMS_CantCopyMarkings")
        end
    end

    if canWrite then
        self.symsPasteBtn.tooltip = nil
    else
        self.symsPasteBtn.tooltip = getText("Tooltip_Map_CantWrite")
    end

    if self.currentTool == self.tools.SYMSCopyMarkings and not (canWrite and canCopyMarkings) then
        self:setCurrentTool(nil)
    end
    if self.currentTool == self.tools.SYMSPasteMarkings and not canWrite then
        self:setCurrentTool(nil)
    end
end

function ISWorldMapSymbols:canCopyMarkingsSYMS()
    if not self.character then return false end
    if self.character:getInventory():containsTypeRecurse("Base.SheetPaper2") then
        return true
    end
    return false
end

function ISWorldMapSymbols:onButtonSYMS(button)
    if button.internal == "SYMS_COPY" then
        self.selectedSymbol = nil
        self:toggleTool(self.tools.SYMSCopyMarkings)
    elseif button.internal == "SYMS_PASTE" then
        self.selectedSymbol = nil
        self:toggleTool(self.tools.SYMSPasteMarkings)
    end
end