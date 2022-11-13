local isdeletemodez = false


local BTPgetgetMouseCoords = function()
	local x = getMouseXScaled();
	local y = getMouseYScaled();
	local z = getPlayer():getZ();
	local wx, wy = ISCoordConversion.ToWorld(x, y, z);
	wx = math.floor(wx);
	wy = math.floor(wy);
	return x, y, z, wx, wy
end



local BTPgetSqObjs = function()
	local mx, my, wz, wx, wy = BTPgetgetMouseCoords()
	--[[
	local mx = getMouseXScaled();
	local my = getMouseYScaled();
	local wz = getPlayer():getZ();
	local wx, wy = ISCoordConversion.ToWorld(mx, my, wz);
	wx = math.floor(wx);
	wy = math.floor(wy);
	--]]
	local cell = getWorld():getCell();
	local sq = cell:getGridSquare(wx, wy, wz);
	if sq == nil then return false; end
	local sqObjs = sq:getObjects();
	local sqSize = sqObjs:size();
	local tbl = {}
	for i = sqSize-1, 0, -1 do -- enumerate square objects and pack them into a table
		local obj = sqObjs:get(i);
		table.insert(tbl, obj)
	end
	return sq, sqObjs, tbl, cell
end

local BTPgetSqObjs = function(_keyPressed)


if isdeletemodez == true and _keyPressed == 45 then
    local sq, sqObjs, objTbl, cell = BTPgetSqObjs()
    
    if not sq then return end
    
    local z = getPlayer():getZ()
    
    for i = 1, #objTbl do
        local obj = objTbl[i]
        local sprite = obj:getSprite() 
        if sprite and sprite:getProperties():Is(IsoFlagType.solidfloor) ~= true then 
            local stairObjects = buildUtil.getStairObjects(obj)
            
            if #stairObjects > 0 then
                for i=1,#stairObjects do
                    if isClient() then
                        sledgeDestroy(stairObjects[i])
                    else
                        stairObjects[i]:getSquare():RemoveTileObject(stairObjects[i])
                    end
                end
            else
                if isClient() then
                    sledgeDestroy(obj)
                else
                    sq:RemoveTileObject(obj);
                    sq:getSpecialObjects():remove(obj);
                    sq:getObjects():remove(obj);
                end
            end
            
        end
    end
end

end
Events.OnKeyKeepPressed.Add(BTPgetSqObjs);



local BTPhighlightSquare = function()
	if isdeletemodez == true  then 
		local mx = getMouseXScaled();
		local my = getMouseYScaled();
		local player = getPlayer();
		local wz = player:getZ();
		local wx, wy = ISCoordConversion.ToWorld(mx, my, wz);
		wx = math.floor(wx);
		wy = math.floor(wy);
		local cell = getWorld():getCell();
		local sq = cell:getGridSquare(wx, wy, wz);
		if sq ~= nil then
			local sqObjs = sq:getObjects();
			local sqSize = sqObjs:size();
			for i = sqSize - 1, 0, -1 do
				local obj = sqObjs:get(i)
				obj:setHighlighted(true)
			end
		end
	end
end

Events.OnMouseMove.Add(BTPhighlightSquare);




------------------------
local flyspeed=0.2----飞行速度
local isonflymode=false--开始游戏默认关闭


local function isonflymodez(worldObjects,player)
    isonflymode=not isonflymode
    getPlayer():setGodMod(isonflymode)
        
    
end
local function isdeletemode(worldObjects,player)
    isdeletemodez=not isdeletemodez
end

local function BTPinit(worldObjects,player)
	local ui = ISTilesPickerDebugUI:new(0, 0, getPlayer(player))
	ui:initialise();
	ui:addToUIManager();


end

local function Getbuildtools(worldObjects,player)
    getPlayer():getInventory():AddItem("_BuildTools")

end



local function flymoderightclickground(player, context, worldObjects)
    
	if isClient() and getPlayer():getAccessLevel()=="Admin" then


        local submenu = context:addOption(getText("IGUI_Tilespicker"), worldObjects, nil)

        local subMenu1 = ISContextMenu:getNew(context)
        context:addSubMenu(submenu, subMenu1)

        if not isonflymode then
            subMenu1:addOption(getText("IGUI_flymodeon"), worldObjects,isonflymodez,player)
            -- getPlayer():setGodMod(true)
            
        else
            subMenu1:addOption(getText("IGUI_flymodeonoff"), worldObjects,isonflymodez,player)
        end

        if not isdeletemodez then
            subMenu1:addOption(getText("IGUI_DeleteModeon"), worldObjects,isdeletemode,player)
            -- getPlayer():setGodMod(true)
            
        else
            subMenu1:addOption(getText("IGUI_DeleteModeoff"), worldObjects,isdeletemode,player)
        end

        subMenu1:addOption(getText("IGUI_TilespickerUI"), worldObjects,BTPinit,player)
        subMenu1:addOption(getText("IGUI_Getbuildtools"), worldObjects,Getbuildtools,player)
		
	elseif not isClient() then
        local submenu = context:addOption(getText("IGUI_Tilespicker"), worldObjects, nil)

        local subMenu1 = ISContextMenu:getNew(context)
        context:addSubMenu(submenu, subMenu1)

        if not isonflymode then
            subMenu1:addOption(getText("IGUI_flymodeon"), worldObjects,isonflymodez,player)
            -- getPlayer():setGodMod(true)
            
        else
            subMenu1:addOption(getText("IGUI_flymodeonoff"), worldObjects,isonflymodez,player)
        end

        if not isdeletemodez then
            subMenu1:addOption(getText("IGUI_DeleteModeon"), worldObjects,isdeletemode,player)
            -- getPlayer():setGodMod(true)
            
        else
            subMenu1:addOption(getText("IGUI_DeleteModeoff"), worldObjects,isdeletemode,player)
        end

        subMenu1:addOption(getText("IGUI_TilespickerUI"), worldObjects,BTPinit,player)
        subMenu1:addOption(getText("IGUI_Getbuildtools"), worldObjects,Getbuildtools,player)
		
	end
		
	
end
Events.OnFillWorldObjectContextMenu.Add(flymoderightclickground)




local playerpos=nil




local function connectsq(player)

    




    player:setX(playerpos[1])
    player:setY(playerpos[2])
    player:setZ(math.floor(playerpos[3]))
    -- print("p")-- makes sure the player doesn't fall
    -- player:setbFalling(false)
    -- player:setFallTime(0)
    -- player:setLastFallSpeed(0)
    local wz = math.floor(playerpos[3])
    local wx,wy = math.floor(playerpos[1]), math.floor(playerpos[2])
    local cell = getWorld():getCell()
    

    -- print(getPlayer():getCurrentSquare())

    -- local sq = player:getCurrentSquare()
    -- if sq==nil then
    --     sq = IsoGridSquare.new(cell, nil, wx , wy , playerpos[3])
    --     cell:ConnectNewSquare(sq, true)
        
    -- end
    
    if wz > 0 then


        for i=-2,2 do
            for k=-2,2 do
                for l=0 ,wz do
                    local sq = cell:getGridSquare(wx+i,wy+k,l);
                    if sq==nil then
                        sq = IsoGridSquare.new(cell, nil, wx +i, wy +k, l)
                        cell:ConnectNewSquare(sq, false)
                        
                    end


                end


                

                




            
            end
        
        end



    end



end






local function playerfly()

    -- if not isonflymode then return end
    if not isonflymode then
        playerpos=nil
        return
    end


    local player=getPlayer()
    if player==nil then
        playerpos=nil

        return
    end

    if playerpos==nil then
        playerpos={player:getX(),player:getY(),player:getZ()}
        
    end






    -- local playerpos={player:getX(),player:getY(),player:getZ()}

    


    if isKeyDown(Keyboard.KEY_W) then


        playerpos[3]=playerpos[3]+0.1

    end
        

    if isKeyDown(Keyboard.KEY_S) then
        playerpos[3]=playerpos[3]-0.1
        
    end

    if isKeyDown(Keyboard.KEY_LEFT) then
        playerpos[1]=playerpos[1]-flyspeed
    end

       
    if isKeyDown(Keyboard.KEY_RIGHT) then
        playerpos[1]=playerpos[1]+flyspeed

    end

    if isKeyDown(Keyboard.KEY_UP) then
        playerpos[2]=playerpos[2]-flyspeed

    end

    if isKeyDown(Keyboard.KEY_DOWN) then
        playerpos[2]=playerpos[2]+flyspeed

        
        
    end



    -- playerpos[3]=math.floor(playerpos[3])
    if playerpos[3]<0 then 
        playerpos[3]=0
    end
    -- print(playerpos[3])



    connectsq(player)
        
        




        








    -- isKeyDown(Keyboard.KEY_S)
    -- isKeyDown(Keyboard.KEY_W)
    -- isKeyDown(Keyboard.KEY_LEFT)
    -- isKeyDown(Keyboard.KEY_W)
    -- isKeyDown(Keyboard.KEY_RIGHT) 





end





Events.OnTick.Add(playerfly)