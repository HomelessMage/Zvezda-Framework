function ISMoveableSpriteProps:getObjectHealth()
    local matHealth = ISMoveableDefinitions:getInstance().getHealthDefinition( self.material ) or 1.0;
    return 10000
end

function ISMoveableSpriteProps:placeMoveableInternalfix( _square, _item, _spriteName )
    local obj;
    local north         = self.facing and (self.facing=="N" or self.facing=="S");
    --local hasTileFloor  = _square and _square:getFloor();
    local insertIndex   = _square:getObjects() and _square:getObjects():size();
    local removeList    = {}; -- table used to remove objects after place (due to insertIndex)

    local selfisotype = getSprite(_spriteName):getProperties():Val("IsoType")

    if self.type=="WallOverlay" then
        local wall = self:getWallForFacing( _square, self.facing );
        if wall then
            wall:AttachExistingAnim(getSprite(_spriteName), 0, 0, false, 0, false, 0)
            --[[
            local overlay = getSprite(self.spriteName):newInstance();
            local sprList = wall:getChildSprites() or ArrayList.new();
            sprList:add( overlay );
            wall:setChildSprites( sprList );
            --]]
            if isClient() then wall:transmitUpdatedSpriteToServer() end
        end
    elseif self.type=="FloorTile" then
        local spr = getSprite( _spriteName ); --item:getWorldSprite() );
        local floor = _square:getFloor();
        if floor and spr then
            floor:setSprite(spr);
            if isClient() then floor:transmitUpdatedSpriteToServer(); end
        end
    elseif self.type=="Window" then
        obj = IsoWindow.new( getCell(), _square, getSprite( _spriteName ), north );
        obj:setIsLocked(false)

        local wallFrame = self:getWallForFacing( _square, north and "S" or "E", "WindowFrame" );
        local objects = _square:getObjects();
        for i=0, objects:size()-1 do
            local object 		= objects:get(i);
            local sprite 		= object:getSprite();

            if sprite and sprite:getName() then
                if instanceof(object, "IsoWindow") then
                    if ((not north) and sprite:getName() == "walls_special_01_8") or (north and sprite:getName() == "walls_special_01_9") then
                        table.insert( removeList, object );
                    end
                end
                if object == wallFrame then
                    insertIndex = i+1; --insert window after wallframe
                    if instanceof(object, "IsoThumpable") then
                        if string.sub(sprite:getName(),1,string.len("walls_exterior_wooden"))=="walls_exterior_wooden" then
                            object:setHoppable(false);
                        end
                    end
                end
            end
        end
    elseif self.type=="WindowObject" then
        obj = IsoCurtain.new( getCell(), _square, _spriteName, north );
        if self:hasFaces() and (self.facing == "S" or self.facing == "E") then          -- If facing south or east, make sure window object is placed directly after window or windowFrame
            local wallFrame = self:getWallForFacing( _square, north and "S" or "E", "WindowFrame" );
            local window    = _square:getWindow(north);

            local objects = _square:getObjects();
            for i=0, objects:size()-1 do
                local object 		= objects:get(i);

                if (window and object == window) or (wallFrame and object == wallFrame) then
                    insertIndex = i+1;
                end
            end
        end
    else
        --local isGenericThump = false;
        local itemSprite = _spriteName;
        local sprite = getSprite( itemSprite );
        local props = sprite and sprite:getProperties();
        local currentSurface = self:getTotalTableHeight(_square);
        if self.isMoveable and self.isTableTop and (not self.ignoreSurfaceSnap) then -- and self.facing ~= nil then		-- face correction when possible for items that are supposed to be on tables (like sinks)
            local faces = self:getFaces();

            local objects = _square:getObjects();
            for i=0, objects:size()-1 do
                local object 		= objects:get(i);
                local spr 			= object:getSprite();
                local mprops 		= ISMoveableSpriteProps.new( spr );
                if self.facing ~= nil and mprops.isMoveable and mprops.isTable and mprops:hasFaces() then
                    insertIndex = i+1;
                    local tmpSprite = self:getFaceSpriteFromParentObject( object );
                    if tmpSprite then
                        itemSprite = tmpSprite;
                        break;
                    end
                end
            end
        end

        local doDestroyAble = false;

        

        print(selfisotype)
        if selfisotype == "IsoBarbecue" then
            local bbqSprite = getSprite(itemSprite);
            if bbqSprite then
                obj = IsoBarbecue.new( getCell(), _square, bbqSprite );
                obj:setMovedThumpable(true);
            end
        elseif selfisotype == "IsoBrokenGlass" then
            obj = IsoBrokenGlass.new(getCell())
            obj:setSquare(_square);
        elseif selfisotype == "IsoCombinationWasherDryer" then
            obj = IsoCombinationWasherDryer.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif selfisotype == "IsoClothingDryer" then
            obj = IsoClothingDryer.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif selfisotype == "IsoClothingWasher" then
            obj = IsoClothingWasher.new(getCell(), _square, getSprite(itemSprite))
            obj:setMovedThumpable(true);
        elseif selfisotype == "IsoMannequin" then
            obj = IsoMannequin.new(getCell(), _square, getSprite(itemSprite))
            obj:setSquare(_square)
            obj:getCustomSettingsFromItem(_item)
            if self.cursorFacing then
                local facing = { "N", "W", "S", "E" }
                local dir = IsoDirections[facing[self.cursorFacing]]
                obj:setDir(dir)
            end
        -- elseif selfisotype == "IsoRadio" or selfisotype == "IsoTelevision" then
        --     if instanceof(_item,"Radio") then
        --         if selfisotype == "IsoRadio" then
        --             obj = IsoRadio.new( getCell(), _square, getSprite(itemSprite) );
        --             obj:setMovedThumpable(true);
        --         elseif selfisotype == "IsoTelevision" then
        --             obj = IsoTelevision.new( getCell(), _square, getSprite(itemSprite) );
        --             obj:setMovedThumpable(true);
        --         end
        --         local deviceData = _item:getDeviceData();
        --         if deviceData then
        --             if deviceData.setIsTurnedOn ~= nil then
        --                 deviceData:setIsTurnedOn(deviceData:getIsTurnedOn()); --checks if current placing allows turnedon state (tv cant be turned on outside housing)
        --             end
        --             obj:setDeviceData(deviceData);
        --         else
        --             print("Warning: device data missing?>?")
        --         end
        --     end
            --obj = IsoThumpable.new(getCell(), _square, itemSprite, false, {});
            --obj:setMaxHealth(self.rawWeight);
            --obj:setIsThumpable(true);
            --obj:setThumpDmg(1); --zeds needed to hurt obj
        elseif selfisotype == "IsoJukebox" then
            obj = IsoJukebox.new( getCell(), _square, getSprite(itemSprite) );
            obj:setMovedThumpable(true);
        elseif selfisotype == "IsoStove" then
            obj = IsoStove.new( getCell(), _square, getSprite(itemSprite) );
            obj:setMovedThumpable(true);
            --doDestroyAble = true;
        elseif selfisotype == "IsoFireplace" then
            obj = IsoFireplace.new( getCell(), _square, getSprite(itemSprite) );
        elseif selfisotype == "IsoMultiMedia" then
            obj = IsoMultiMedia.new( getCell(), _square, getSprite(itemSprite) );
        else
            -- print("elsenb-1")
            --obj = IsoObject.new( getCell(), self.square, itemSprite );

            --[[
            if props and (props:Is("chairN") or props:Is("chairE") or props:Is("chairS") or props:Is("chairW")) then
                obj = IsoObject.new( getCell(), _square, getSprite(itemSprite) );
            elseif props and props:Is("lightR") then
                obj = IsoLightSwitch.new( getCell(), _square, getSprite(itemSprite), _square:getRoomID() );
                obj:addLightSourceFromSprite();
                obj:getCustomSettingsFromItem(_item);
            elseif self.type == "FloorRug" or self.type == "WallObject" or self.type == "Vegitation" or self.isTableTop then
                obj = IsoObject.new( getCell(), _square, itemSprite );
                --]]
            local blockStyleSolid = props and (props:Is(IsoFlagType.solid) or props:Is(IsoFlagType.solidtrans)) or false;

            if props and props:Is("lightR") then
                obj = IsoLightSwitch.new( getCell(), _square, getSprite(itemSprite), _square:getRoomID() );
                obj:addLightSourceFromSprite();
                obj:getCustomSettingsFromItem(_item);
            elseif not blockStyleSolid  then
                -- obj = IsoObject.new( getCell(), _square, itemSprite );

                -- local stringtlies =""
                -- local arrayflag = getSprite(itemSprite):getProperties():getFlagsList()
                -- -- getSprite(BetterTilePickertiles):getProperties():getFlagsList()
                -- for i=1,arrayflag:size() do
                --     stringtlies=stringtlies..arrayflag:get(i-1)
                -- end

                -- print(getSprite(BetterTilePickertiles):getProperties():getFlagsList())
                -- print(getSprite(BetterTilePickertiles):getProperties():Is( IsoFlagType.doorW ))

                local iswallN=nil
                local FlagsList=getSprite(itemSprite):getProperties()

                if FlagsList:Is(IsoFlagType.WallN ) then
                    iswallN=1
                elseif FlagsList:Is( IsoFlagType.WallW ) then
                    iswallN=0

                    
                elseif FlagsList:Is( IsoFlagType.doorN ) then
                    iswallN=4
                    


                elseif  FlagsList:Is( IsoFlagType.doorW) then
                    iswallN=3


                elseif  FlagsList:Is( IsoFlagType.DoorWallN ) then
                    iswallN=6
                    


                elseif FlagsList:Is( IsoFlagType.DoorWallW ) then
                    iswallN=5


                end
                    
                    

                if iswallN==1 or iswallN==0 then

                    obj = IsoThumpable.new(getCell(), _square, itemSprite, iswallN==1, {})
            
                        
                        
                    
                        

                elseif iswallN==3 or iswallN==4 then
                    obj = IsoThumpable.new(getCell(), _square, itemSprite, string.sub(itemSprite,1,string.len(itemSprite)-1)..tostring(tonumber(string.sub(itemSprite,string.len(itemSprite),string.len(itemSprite)) )+2), iswallN==4, nil);

                    -- print(tonumber(string.sub(itemSprite,string.len(itemSprite),string.len(itemSprite)) )+2)
                    -- print(string.sub(itemSprite,1,string.len(itemSprite)-1))
                    obj:setIsDoor(true)
                    _square:AddSpecialObject( obj, insertIndex )
                    if isClient() then obj:transmitCompleteItemToServer(); end
                    return
                    -- print("door")
                    
                elseif iswallN==5 or iswallN==6 then
                    -- obj = IsoThumpable.new(getCell(), _square, itemSprite, nil, iswallN==6, nil);
                    -- obj=IsoThumpable.new(getCell(), _square, itemSprite, iswallN==6, nil)

                    obj = IsoObject.new( getCell(), _square, itemSprite )
                    -- obj:setIsHoppable(true)
                    _square:AddSpecialObject( obj, insertIndex )
                    -- obj:setCanPassThrough(true)
                    if isClient() then obj:transmitCompleteItemToServer(); end
                    
                    return

                    -- print("framedoor")
                    
                else

                    obj = IsoObject.new( getCell(), _square, itemSprite )
                
                    


                end
            else

                obj = IsoThumpable.new(getCell(), _square, itemSprite, false, {}); --IsoObject.new( getCell(), self.square, itemSprite );
                obj:setMaxHealth(self:getObjectHealth());
                obj:setHealth(obj:getMaxHealth());
                obj:setThumpDmg(1); --zeds needed to hurt obj
                obj:setIsThumpable(true);
                obj:setBlockAllTheSquare(true);
                obj:setCanPassThrough(false);
                obj:setCanPassThrough(false);
                obj:setHoppable(false);
                obj:setBreakSound("BreakObject");
                --isGenericThump = true;
                if _item:hasModData() then
                    local modData = _item:getModData()
                    if type(modData.name) == "string" then
                        obj:setName(modData.name)
                    end
                    if tonumber(modData.health) and tonumber(modData.maxHealth) then
                        obj:setHealth(tonumber(modData.health))
                        obj:setMaxHealth(tonumber(modData.maxHealth))
                    end
                    if type(modData.thumpSound) == "string" then
                        obj:setThumpSound(modData.thumpSound)
                    end
                    if type(modData.modData) == "table" then
                        for key,value in pairs(modData.modData) do
                            obj:getModData()[key] = value
                        end
                    end
                end
            end

        end

        if obj and _item and _item:hasModData() and _item:getModData().movableData then
            obj:getModData().movableData = copyTable(_item:getModData().movableData);
        end

        --fix for radio vehicle parts having condition
        if obj and _item and _item:getConditionMax()>0 then
            obj:getModData().itemCondition = { value = _item:getCondition(), max = _item:getConditionMax() };
        end

        if obj and doDestroyAble then
            if instanceof(obj,"IsoThumpable") then
                obj:setMaxHealth(self:getObjectHealth());
                obj:setHealth(obj:getMaxHealth());
                obj:setThumpDmg(1); --zeds needed to hurt obj
                obj:setIsThumpable(true);
                obj:setBreakSound("BreakObject");
            end
        end

        if obj and self.isTableTop then             --adjust y render mod if needed.
            --s.surface s.surfaceIsOffset
            if self.surface and self.surfaceIsOffset then
                currentSurface = currentSurface - self.surface;
            end
            obj:setRenderYOffset(currentSurface);
            --print(currentSurface);
        end

        if obj and self.isTable then
            obj:setRenderYOffset(currentSurface);
        end

        --local sprite = getSprite( itemSprite );
        if props and obj then --sprite and obj then
            --local props = sprite:getProperties();
            obj:createContainersFromSpriteProperties()
            for i=1,obj:getContainerCount() do
                obj:getContainerByIndex(i-1):setExplored(true)
            end

            if props:Is(IsoFlagType.waterPiped) then -- the item need to be re-piped inside a house or player's build safehouse
				obj:getModData().canBeWaterPiped = true;
--                obj:setUsesExternalWaterSource(true);
            end

            if props:Is("waterAmount") then
                --print("water place");
                -- obj:setWaterAmount(0); --set water to zero after moving
                if (not props:Is(IsoFlagType.waterPiped)) and _item and _item:hasModData() then
                    local modData = _item:getModData()
                    if modData.waterAmount and tonumber(modData.waterAmount) then
                        obj:setWaterAmount(tonumber(modData.waterAmount));
                        obj:getModData().waterAmount = tonumber(modData.waterAmount);
                        obj:getModData().taintedWater = modData.taintedWater;
                        --print("setting water amount "..tostring(modData.waterAmount));
                    end
                end
            end

            --if isGenericThump and props:Is("lightR") then
            --obj:createLightSource(10, 5, 5, 0, 0, nil, nil, _character);
            --end
        end
    end

    if self.type == "FloorRug" and _square:getObjects() then
        local objects = _square:getObjects()
        for i=objects:size(),1,-1 do
            local obj2 = objects:get(i-1)
            if obj2:getProperties() and obj2:getProperties():Is(IsoFlagType.solidfloor) then
                insertIndex = i
                break
            end
        end
    end

    if _square:getObjects() and insertIndex > _square:getObjects():size() then
        insertIndex = _square:getObjects():size();
    end

    if obj then
        _square:AddSpecialObject( obj, insertIndex );
        if isClient() then obj:transmitCompleteItemToServer(); end
        triggerEvent("OnObjectAdded", obj) -- for RainCollectorBarrel in singleplayer
    end

    for _,remObject in ipairs(removeList) do
        --print("removing dummy window");
        if isClient() then _square:transmitRemoveItemFromSquare(remObject) end
        _square:RemoveTileObject(remObject);
    end

    getTileOverlays():fixTableTopOverlays(_square);

    _square:RecalcProperties();
    _square:RecalcAllWithNeighbours(true);
    --_character:getInventory():Remove(item);

    --ISMoveableCursor.clearCacheForAllPlayers();

    triggerEvent("OnContainerUpdate")
end


