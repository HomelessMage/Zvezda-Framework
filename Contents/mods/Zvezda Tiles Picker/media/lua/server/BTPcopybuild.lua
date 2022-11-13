local twosquare={}
local copybuildsave={}
function Recipe.OnCreate.copybuildfirst(items, result, player)
    
    local square = player:getCurrentSquare()
    twosquare[1]={square:getX(),square:getY(),square:getZ()}
    player:Say("First Point!")
    
end

function Recipe.OnCreate.copybuildsecond(items, result, player)
    local square = player:getCurrentSquare()
    twosquare[2]={square:getX(),square:getY(),square:getZ()} 
    player:Say("Second Point!")
end

function Recipe.OnCreate.copybuildcopy(items, result, player)
    copybuildsave={}

    local lenth = twosquare[2][1]-twosquare[1][1]+1
    local width = twosquare[2][2]-twosquare[1][2]+1
    for i=1,lenth do
        for k=1,width do
            for z=1,8 do
                local gsquare=getCell():getGridSquare(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                if gsquare==nil then
                    gsquare=debugScenarios.Trailer3Scenario_Building.getSQ(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                    
                end
                if gsquare then
                    local gobject=gsquare:getObjects()
                    if gobject then
                        local posion = tostring(i).."_"..tostring(k).."_"..tostring(z)
                        copybuildsave[posion]={}
                        for i=1,gobject:size() do
                            if gobject:get(i-1):getSprite() then
                                local spritename = gobject:get(i-1):getSprite():getName()
                                if spritename then
                                    table.insert(copybuildsave[posion],spritename)
                                    -- print(spritename) 
                                end                                
                            end                        
                        end                                                                     
                    end                    
                end           
            end
        end    
    end
    for i=1,lenth do
        for k=1,width do
            for z=1,8 do
                local square = player:getCurrentSquare()
                local objects=copybuildsave[tostring(i).."_"..tostring(k).."_"..tostring(z)]
                if objects~=nil and objects~={} then
                    debugScenarios.Trailer3Scenario_Building.getSQ(square:getX()+i-1,square:getY()+k-1,z-1)
                    local squarez=getCell():getGridSquare(square:getX()+i-1,square:getY()+k-1,z-1)
                    for i=1,#objects do
                        local tilesname = objects[i]
                        local Spiobj=ISMoveableSpriteProps.new(IsoObject.new(squarez, tilesname):getSprite())
                        local itemz = player:getInventory():AddItem("Money")
                        ISMoveableSpriteProps:placeMoveableInternalfix(squarez, itemz, tilesname)
                        player:getInventory():Remove("Money")
                    
                    end 
                end
            end

        
        end
    end 
end

function Recipe.OnCreate.copybuildcut(items, result, player)
    copybuildsave={}
    local alltilesremove={}

    local lenth = twosquare[2][1]-twosquare[1][1]+1
    local width = twosquare[2][2]-twosquare[1][2]+1
    for i=1,lenth do
        for k=1,width do
            for z=1,8 do
                local gsquare=getCell():getGridSquare(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                if gsquare==nil then
                    gsquare=debugScenarios.Trailer3Scenario_Building.getSQ(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                    
                end
                if gsquare then
                    local gobject=gsquare:getObjects()
                    if gobject then
                        local posion = tostring(i).."_"..tostring(k).."_"..tostring(z)
                        copybuildsave[posion]={}
                        for i=1,gobject:size() do
                            if gobject:get(i-1):getSprite() then
                                local spritename = gobject:get(i-1):getSprite():getName()
                                if spritename then
                                    table.insert(copybuildsave[posion],spritename)

                                    table.insert(alltilesremove,gobject:get(i-1))
                                    -- print(spritename) 
                                end                                
                            end                        
                        end                                                                     
                    end                    
                end           
            end
        end    
    end

    for i=1,#alltilesremove do

        if isClient() then 
            sledgeDestroy(alltilesremove[i]) 
        else
            alltilesremove[i]:getSquare():RemoveTileObjectErosionNoRecalc(alltilesremove[i])
        
        
        end
        
    
    end
    for i=1,lenth do
        for k=1,width do
            for z=1,8 do
                local square = player:getCurrentSquare()
                local objects=copybuildsave[tostring(i).."_"..tostring(k).."_"..tostring(z)]
                if objects~=nil and objects~={} then
                    debugScenarios.Trailer3Scenario_Building.getSQ(square:getX()+i-1,square:getY()+k-1,z-1)
                    local squarez=getCell():getGridSquare(square:getX()+i-1,square:getY()+k-1,z-1)
                    for i=1,#objects do
                        local tilesname = objects[i]
                        local Spiobj=ISMoveableSpriteProps.new(IsoObject.new(squarez, tilesname):getSprite())
                        local itemz = player:getInventory():AddItem("Money")
                        ISMoveableSpriteProps:placeMoveableInternalfix(squarez, itemz, tilesname)
                        player:getInventory():Remove("Money")
                    
                    end 
                end
            end

        
        end
    end 

    
end

function Recipe.OnCreate.copybuilddelete(items, result, player)
    copybuildsave={}

    local alltilesremove={}

    local lenth = twosquare[2][1]-twosquare[1][1]+1
    local width = twosquare[2][2]-twosquare[1][2]+1
    for i=1,lenth do
        for k=1,width do
            for z=1,8 do
                local gsquare=getCell():getGridSquare(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                if gsquare==nil then
                    gsquare=debugScenarios.Trailer3Scenario_Building.getSQ(twosquare[1][1]+i-1,twosquare[1][2]+k-1,z-1)
                    
                end
                if gsquare then
                    local gobject=gsquare:getObjects()
                    if gobject then
                        -- local posion = tostring(i).."_"..tostring(k).."_"..tostring(z)
                        -- copybuildsave[posion]={}
                        for i=1,gobject:size() do

                            local getSprite_= gobject:get(i-1):getSprite()
                            if getSprite_ then

                                if not getSprite_:getProperties():Is(IsoFlagType.solidfloor) then
                                    

                                    table.insert(alltilesremove,gobject:get(i-1))
                                    
                                end
                                -- local spritename = gobject:get(i-1):getSprite():getName()
                                
                                -- if spritename then
                                --     table.insert(copybuildsave[posion],spritename)
                                --     -- print(spritename) 
                                -- end                                
                            end                        
                        end                                                                     
                    end                    
                end           
            end
        end    
    end

    for i=1,#alltilesremove do

        if isClient() then 
            sledgeDestroy(alltilesremove[i]) 
        else
            alltilesremove[i]:getSquare():RemoveTileObjectErosionNoRecalc(alltilesremove[i])
        
        
        end
        
    
    end

    -- local item = player:getPrimaryHandItem()
    -- item:setWeightReduction(item:getWeightReduction()+5)
    -- player:Say(getText("IGUI_beibaojianzhong")..tostring(item:getWeightReduction()))



    
end