local function duplicateItem(item)
    local playerObj = getPlayer();
    local inventory = playerObj:getInventory();

    if instanceof(item, "InventoryItem") and item:getCategory() == "Container" then

        local itemInventory = item:getInventory();
        local items = itemInventory:getItems();

        local newBag = inventory:AddItem(item:getFullType());
        newBag:setName(item:getName());

        local newBagInventory = newBag:getInventory();

        for i=0, items:size()-1 do
            local _item = items:get(i);
            local itemType = _item:getFullType();
            newBagInventory:AddItem(itemType);
        end
    else

        local newItem = inventory:AddItem(item:getFullType());
        newItem:setName(item:getName());

    end
end

local function OnFillInventoryObjectContextMenu(player, context, items)
    if not (isDebugEnabled() or (isClient() and isAdmin())) then return true; end

    local text = "[DEBUG]"
    if isClient() and isAdmin() then
        text = "[ADMIN]"
    end

    local duplicateOption = context:addOption(text .. " Duplicate:")
    local subMenuDuplicate = ISContextMenu:getNew(context)
    context:addSubMenu(duplicateOption, subMenuDuplicate)

    for i, item in ipairs(items) do
        if type(item) == "table" then
            subMenuDuplicate:addOption(item.items[1]:getDisplayName(), item.items[1], duplicateItem);
        elseif instanceof(item, "InventoryItem") then
            subMenuDuplicate:addOption(item:getDisplayName(), item, duplicateItem);
        end
    end

end
Events.OnFillInventoryObjectContextMenu.Add(OnFillInventoryObjectContextMenu);
