--function Vendors_ItemCategories()
	--local item = ScriptManager.instance:getItem("Base.Money")
--if item then 
    --item:DoParam("DisplayCategory = Money")
--end
--end
function Vendors_RemoveServerItem(item, inventory)
	local container = inventory;
	container:DoRemoveItem(item);
	container:Remove(item);
end

function Vendors_AddItem(item, inventory)
	local magazine = nil;
	local maxAmmo = nil;
	local container = inventory;
	local addedItem = container:AddItem(item);
	maxAmmo = addedItem:getMaxAmmo();
	if maxAmmo > 0 and not addedItem:IsWeapon() then
		addedItem:setCurrentAmmoCount(maxAmmo);
	elseif addedItem:isCookable() and not string.find(addedItem:getType(), "Dead") then 
		addedItem:setCooked(true); 
	end
end

function Vendors_GetKeys()
	local playerObj = getSpecificPlayer(0)
	local car = playerObj:getNearVehicle();
	if car ~= nil then
		sendClientCommand(playerObj, "vehicle", "repair", {vehicle = car:getId()});
		Events.OnTick.Remove(Vendors_GetKeys);
	end
end

function Vendors.Commands.spawnVehicle(playerObj, args)
	local vehicle = Vendors.Vehicle:addVehicle(args["fullId"], playerObj, args["direction"]);
	if vehicle and args["withKey"] == true then
		playerObj:sendObjectChange("addItem", {item = vehicle:createVehicleKey()});
	end
	return vehicle;
end

Events.OnClientCommand.Add(function(moduleName, command, playerObj, args)
	if moduleName == "Vendors" and Vendors.Commands[command] then
		local vehicle = Vendors.Commands[command](playerObj, args);
	end
	return vehicle;
end);