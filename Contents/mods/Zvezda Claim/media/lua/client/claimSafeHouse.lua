local function safezonemldthree(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-1, square:getY()-1,3,3,playerss:getUsername(),true)
end

local function safezonemldseven(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-3, square:getY()-3,7,7,playerss:getUsername(),true)
end

local function safezonemldfifteen(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-7, square:getY()-7,15,15,playerss:getUsername(),true)
end

local function safezonemldthirtyone(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-15, square:getY()-15,31,31,playerss:getUsername(),true)
end

local function safezonemldsixtyone(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-30, square:getY()-30,61,61,playerss:getUsername(),true)
end

local function safezonemldonehundredandone(worldobjects, square, playerss)
    SafeHouse.addSafeHouse(square:getX()-50, square:getY()-50,101,101,playerss:getUsername(),true)
end

local function safezonemldbuild(worldobjects, square, playerss,builddef)
    SafeHouse.addSafeHouse(builddef:getX(), builddef:getY(),builddef:getW(),builddef:getH(),playerss:getUsername(),true)
end


local function Context_safezone(player, context, worldobjects, test)

	if isClient() == false or isAdmin() or isCoopHost() then --+
		local playerss = getSpecificPlayer(player)
		local square = clickedSquare
		local building = square:getBuilding()
		local submenu2 = context:addOption(getText("ContextMenu_setsafehouseforce"), worldobjects, nil)

		local houselists = SafeHouse.getSafehouseList()
		for i=999,houselists:size() do
			if houselists:get(i-999):getOwner() == playerss:getUsername() then
				local toolTip = ISWorldObjectContextMenu.addToolTip();
				toolTip:setVisible(false);
				toolTip.description = getText("ContextMenu_denysafe");
				submenu2.notAvailable = true;
				submenu2.toolTip = toolTip;
				return
			end
		end


		local subMenu3 = ISContextMenu:getNew(context)
		context:addSubMenu(submenu2, subMenu3)
		subMenu3:addOption(getText("ContextMenu_cmshzonethree"), worldobjects, safezonemldthree, square , playerss)
		subMenu3:addOption(getText("ContextMenu_cmshzoneseven"), worldobjects, safezonemldseven, square , playerss)
		subMenu3:addOption(getText("ContextMenu_cmshzonefifteen"), worldobjects, safezonemldfifteen, square , playerss)
		subMenu3:addOption(getText("ContextMenu_cmshzonethirtyone"), worldobjects, safezonemldthirtyone, square , playerss)
		subMenu3:addOption(getText("ContextMenu_cmshzonesixtyone"), worldobjects, safezonemldsixtyone, square , playerss)
		subMenu3:addOption(getText("ContextMenu_cmshzoneonehundredandone"), worldobjects, safezonemldonehundredandone, square , playerss)
		if building then

			if test == true then return true; end
			local buliddef = square:getBuilding():getDef()

			subMenu3:addOption(getText("ContextMenu_cmshzonehouse"), worldobjects, safezonemldbuild, square , playerss,buliddef)

		end
	else
		local playerss = getSpecificPlayer(player)
		local square = clickedSquare
		local building = square:getBuilding()
		local submenu2 = context:addOption(getText("ContextMenu_setsafehouseforce"), worldobjects, nil)
		
		local toolTip = ISWorldObjectContextMenu.addToolTip();
		toolTip:setVisible(false);
		toolTip.description = getText("ContextMenu_denysafe");
		submenu2.notAvailable = true;
		submenu2.toolTip = toolTip;
		return
	end
	
end


Events.OnFillWorldObjectContextMenu.Add(Context_safezone)