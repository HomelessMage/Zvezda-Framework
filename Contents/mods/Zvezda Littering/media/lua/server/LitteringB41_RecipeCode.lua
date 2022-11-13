-- Littering, B41 Continued
-- (41.68)(07may22)

--Return Jar Lid
function Recipe.OnCreate.LitteringB41_ReturnLid(items, result, player)
    player:getInventory():AddItems("Base.JarLid", 1);
end

--Return Egg Carton
function Recipe.OnCreate.LitteringB41_OpenEggCarton(items, result, player)
    result:setAge(items:get(0):getAge());
	player:getInventory():AddItems("LitteringB41.EggCartonEmpty", 1);
end

--Return Empty Candy Bag
function Recipe.OnCreate.LitteringB41_OpenCandyPackage(items, result, player)
	player:getInventory():AddItems("LitteringB41.CandyPackageEmpty", 1);
end

--Return Empty Nail Box
function Recipe.OnCreate.LitteringB41_OpenNailBox(items, result, player)
	player:getInventory():AddItems("LitteringB41.EmptyNailsBox", 1);
end

--Return Empty Screw Box
function Recipe.OnCreate.LitteringB41_OpenScrewsBox(items, result, player)
	player:getInventory():AddItems("LitteringB41.EmptyScrewsBox", 1);
end

--Return Empty Paperclip Box
function Recipe.OnCreate.LitteringB41_OpenPaperclipBox(items, result, player)
	player:getInventory():AddItems("LitteringB41.EmptyPaperclipBox", 1);
end

--Return Empty 9mm Box
function Recipe.OnCreate.LitteringB41_Open9mmBox(items, result, player)
	player:getInventory():AddItems("LitteringB41.9mmAmmoBoxEmpty", 1);
end

--Return Empty 45 Box
function Recipe.OnCreate.LitteringB41_Open45Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.45AmmoBoxEmpty", 1);
end

--Return Empty 38 Box
function Recipe.OnCreate.LitteringB41_Open38Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.38AmmoBoxEmpty", 1);
end

--Return Empty 44 Box
function Recipe.OnCreate.LitteringB41_Open44Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.44AmmoBoxEmpty", 1);
end

--Return Empty 223 Box
function Recipe.OnCreate.LitteringB41_Open223Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.223AmmoBoxEmpty", 1);
end

--Return Empty 308 Box
function Recipe.OnCreate.LitteringB41_Open308Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.308AmmoBoxEmpty", 1);
end

--Return Empty Shotgun Shell Box
function Recipe.OnCreate.LitteringB41_OpenShellBox(items, result, player)
	player:getInventory():AddItems("LitteringB41.ShotgunAmmoBoxEmpty", 1);
end

--Return Empty 556 Box
function Recipe.OnCreate.LitteringB41_Open556Box(items, result, player)
	player:getInventory():AddItems("LitteringB41.556AmmoBoxEmpty", 1);
end

-- Cut Fish and Return Bone Scraps
-- function Recipe.OnTest.LitteringB41_CutFish(sourceItem, result)
    -- if instanceof(sourceItem, "Food") then
        -- return sourceItem:getActualWeight() > 0.6
    -- end
    -- return true
-- end


function Recipe.OnCreate.LitteringB41_CutFish(items, result, player)
	player:getInventory():AddItems("LitteringB41.BoneScraps", 1);
    local fish = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            fish = items:get(i);
            break;
        end
    end
    if fish then
        local hunger = math.max(fish:getBaseHunger(), fish:getHungChange())
        result:setBaseHunger(hunger / 2);
        result:setHungChange(hunger / 2);
        result:setActualWeight((fish:getActualWeight() * 0.9) / 2)
        result:setWeight(result:getActualWeight());
        result:setCustomWeight(true)
        result:setCarbohydrates(fish:getCarbohydrates() / 2);
        result:setLipids(fish:getLipids() / 2);
        result:setProteins(fish:getProteins() / 2);
        result:setCalories(fish:getCalories() / 2);
        result:setCooked(fish:isCooked());
    end
end

--Slice Ham and get bone
function Recipe.OnCreate.LitteringB41_SliceHam(items, result, player)
	player:getInventory():AddItems("LitteringB41.BoneScraps", 1);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Ham" then
            result:setBaseHunger(item:getBaseHunger() / 6);
            result:setHungChange(item:getHungChange() / 6);
            result:setBoredomChange(item:getBoredomChange() / 6)
            result:setUnhappyChange(item:getUnhappyChange() / 6)
            result:setCalories(item:getCalories() / 6)
            result:setCarbohydrates(item:getCarbohydrates() / 6)
            result:setLipids(item:getLipids() / 6)
            result:setProteins(item:getProteins() / 6)
        end
    end
end

-- Just Bone Scraps
function Recipe.OnTest.LitteringB41_JustBoneScraps(sourceItem, result)
	player:getInventory():AddItems("LitteringB41.BoneScraps", 1);
end

-- Just Bone Scraps
function Recipe.OnCreate.LitteringB41_OpenBoxOfJars(items, result, player)
    player:getInventory():AddItems("Base.JarLid", 6);
    player:getInventory():AddItems("Base.CardboardFlat", 1);
end

-- Tea Bag Gox Return
function Recipe.OnCreate.LitteringB41_TeaBoxEmpty(items, result, player)
    player:getInventory():AddItems("Base.TeaBoxEmpty", 1);
end
