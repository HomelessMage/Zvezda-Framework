---@diagnostic disable: undefined-global, lowercase-global, deprecated
--***********************************************************
--**                  NECROPOLISRP.NET                     **
--**			  File Author: github.com/buffyuwu	       **
--**                    Admin Logs                         **
--***********************************************************
--
--This logs common admin actions in the admins.txt located in your server's ./Logs directory
--Things logged from this code are marked with [Buffy Logs] in the .txt file to differentiate the additional entries from the basegame logging.

--admin panel
local adminPanelCreate = ISAdminPanelUI.create
function ISAdminPanelUI:create()
    adminPanelCreate(self)
    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." opened the admin panel"})
end

--what they click in the admin panel
local adminPanelButton = ISAdminPanelUI.onOptionMouseDown
function ISAdminPanelUI:onOptionMouseDown(button, x, y)
    adminPanelButton(self, button, x, y)
    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." clicked "..tostring(button.internal).." in the admin panel"})
end

--item list viewer specifics
local itemListViewer = ISItemsListViewer.initialise
function ISItemsListViewer:initialise()
    itemListViewer(self)
    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." opened the item list viewer"}) --log this button press potentially twice because its important.
end

local itemListViewerAdd = ISItemsListTable.onOptionMouseDown
function ISItemsListTable:onOptionMouseDown(button, x, y)
    itemListViewerAdd(self, button, x, y)
    local item = button.parent.datas.items[button.parent.datas.selected].item
    if button.internal == "ADDITEM1" then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." spawned 1 "..item:getFullName()})
    elseif button.internal == "ADDITEM2" then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." spawned 2 "..item:getFullName()})
    elseif button.internal == "ADDITEM5" then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." spawned 5 "..item:getFullName()})
    elseif button.internal == "ADDITEM" then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." spawned a lot of "..item:getFullName()}) --they hit the 'multiple' button, god help you
    end
end

--admin powers ui
local adminPowers = ISAdminPowerUI.onClick
function ISAdminPowerUI:onClick(button)
    --first collect our current values
    local invisible = getPlayer():isInvisible()
    local godMode = getPlayer():isGodMod()
    local ghostMode = getPlayer():isGhostMode()
    local noclip = getPlayer():isNoClip()
    local timedActionInstantCheat = getPlayer():isTimedActionInstantCheat()
    local unlimitedCarry = getPlayer():isUnlimitedCarry()
    local unlimitedEndurance = getPlayer():isUnlimitedEndurance()
    local canSeeAll = getPlayer():isCanSeeAll()
    local networkTeleport = getPlayer():isNetworkTeleportEnabled()
    local hearAll = getPlayer():isCanHearAll()
    local zombiesDontAttack = getPlayer():isZombiesDontAttack()
    local ShowMPInfos = getPlayer():isShowMPInfos()
    local fastMove = ISFastTeleportMove.cheat
    local buildCheat = ISBuildMenu.cheat
    local farmCheat = ISFarmingMenu.cheat
    local healthCheat = ISHealthPanel.cheat
    local mechanicCheat = ISVehicleMechanics.cheat
    local moveableCheat = ISMoveableDefinitions.cheat

    adminPowers(self, button) --run the function
    if not button.internal == "SAVE" then return end

    --now lets see what changed
    if getPlayer():isInvisible() == true and not invisible then --is this different from the previous value? log it.
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on invisibility"})
    end
    if getPlayer():isInvisible() == false and invisible then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off invisibility"})

    end
    if getPlayer():isGodMod() == true and not godMode then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on godmode"})
    end
    if getPlayer():isGodMod() == false and godMode then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off godmode"})

    end
    if getPlayer():isGhostMode() == true and not ghostMode then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on ghost mode"})
    end
    if getPlayer():isGhostMode() == false and ghostMode then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off ghost mode"})

    end
    if getPlayer():isNoClip() == true and not noclip then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on noclip"})
    end
    if getPlayer():isNoClip() == false and noclip then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off noclip"})
    end
    if getPlayer():isTimedActionInstantCheat() == true and not timedActionInstantCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on timed action instant"})
    end
    if getPlayer():isTimedActionInstantCheat() == false and timedActionInstantCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off timed action instant"})

    end
    if getPlayer():isUnlimitedCarry() == true and not unlimitedCarry then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on unlimited carry"})
    end
    if getPlayer():isUnlimitedCarry() == false and unlimitedCarry then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off unlimited carry"})

    end
    if getPlayer():isUnlimitedEndurance() == true and not unlimitedEndurance then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on unlimited endurance"})
    end
    if getPlayer():isUnlimitedEndurance() == false and unlimitedEndurance then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off unlimited endurance"})

    end
    if getPlayer():isCanSeeAll() == true and not canSeeAll then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on ESP"})
    end
    if getPlayer():isCanSeeAll() == false and canSeeAll then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off ESP"})

    end
    if getPlayer():isNetworkTeleportEnabled() == true and not networkTeleport then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on network teleporting"})
    end
    if getPlayer():isNetworkTeleportEnabled() == false and networkTeleport then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off network teleporting"})

    end
    if getPlayer():isCanHearAll() == true and not hearAll then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on hearing everyone's voice chat"})
    end
    if getPlayer():isCanHearAll() == false and hearAll then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off hearing everyone's voice chat"})

    end
    if getPlayer():isZombiesDontAttack() == true and not zombiesDontAttack then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on zombiesDontAttack"})
    end
    if getPlayer():isZombiesDontAttack() == false and zombiesDontAttack then 
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off zombiesDontAttack"})

    end
    if getPlayer():isShowMPInfos() == true and not ShowMPInfos then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on showing MP info"})
    end
    if getPlayer():isShowMPInfos() == false and ShowMPInfos then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off showing MP info"})

    end
    if ISFastTeleportMove.cheat == true and not fastMove then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on LUDICROUS SPEED!! "})
    end
    if ISFastTeleportMove.cheat == false and fastMove then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off LUDICROUS SPEED!! and crashed into a wall"})

    end
    if ISBuildMenu.cheat == true and not buildCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on building cheats"})
    end
    if ISBuildMenu.cheat == false and buildCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off building cheats"})

    end
    if ISFarmingMenu.cheat == true and not farmCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on farming cheats"})
    end
    if ISFarmingMenu.cheat == false and farmCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off farming cheats"})

    end
    if ISHealthPanel.cheat == true and not healthCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on health panel cheats"})
    end
    if ISHealthPanel.cheat == false and healthCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off health panel cheats"})

    end
    if ISVehicleMechanics.cheat == true and not mechanicCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on mechanic cheats"})
    end
    if ISVehicleMechanics.cheat == false and mechanicCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off mechanic cheats"})

    end
    if ISMoveableDefinitions.cheat == true and not moveableCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled on moveable cheats"})
    end
    if ISMoveableDefinitions.cheat == false and moveableCheat then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." toggled off moveable cheats"})
    end
end

--hate to override a whole function, but here we are
function ISWhitelistModifyRow:onOptionMouseDown(button, x, y)
    if button.internal == "CLOSE" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
    if button.internal == "UPDATE" then
        sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] "..tostring(getOnlineUsername()).." made changes to the database"})
        local where = {}
        local query = {}
        for _,v in ipairs(self.buttonDatas) do
            local previousData = string.trim(self.data[v.columnName]);
            if v.type == "INTEGER" or v.type == "TEXT" then
                local data = string.trim(v:getText());
                if v.columnName == "accesslevel" then
                    if data == "admin" and getAccessLevel() ~= "admin" then
                        local modal = ISModalDialog:new(self.x + (self.width/2),self.y + (self.height/2), 250, 150, getText("IGUI_DbViewer_CantSetAdmin"), false, nil, nil, nil);
                        modal:initialise()
                        modal:addToUIManager()
                        return;
                    end
                end
                if self.data[v.columnName] and previousData ~= data then
                    table.insert(query, v.columnName)
                    table.insert(query, data)
                    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] ".."OLD value for "..v.columnName.." = "..previousData.." NEW value = "..data})
                elseif previousData ~= "" then
                    table.insert(where, v.columnName)
                    table.insert(where, previousData)
                    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] ".."OLD value for "..v.columnName.." = "..previousData.." NEW value = "..data})
                end
            elseif v.type == "BOOLEAN" then
                local value = "false";
                if v.selected == 1 then
                    value = "true";
                end
                if not previousData or previousData ~= value then
                    table.insert(query, v.columnName)
                    table.insert(query, value)
                    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] ".."OLD value for "..v.columnName.." = "..previousData.." NEW value = "..value})
                else
                    table.insert(where, v.columnName)
                    table.insert(where, previousData)
                    sendClientCommand(getPlayer(), 'ISLogSystem', 'writeLog', {loggerName = "admin", logText = "[Buffy Logs] ".."OLD value for "..v.columnName.." = "..previousData.." NEW value = "..value})
                end
            end
        end
        local params = {}
        local queryStr = "UPDATE " .. self.tableName .. " SET "
        for i=1,#query,2 do
            queryStr = queryStr .. query[i] .. " = ?"
            table.insert(params, query[i+1])
            if i < #query - 1 then
                queryStr = queryStr .. ","
            end
        end
        local whereStr = " WHERE "
        for i=1,#where,2 do
            whereStr = whereStr .. where[i] .. " = ?"
            table.insert(params, where[i+1])
            if i < #where - 1 then
                whereStr = whereStr .. " AND "
            end
        end
        queryStr = queryStr .. whereStr;
        executeQuery(queryStr, params);
        self.view:clear();
        getTableResult(self.tableName, self.entriesPerPages);
        self:setVisible(false);
        self:removeFromUIManager();
    end
end
