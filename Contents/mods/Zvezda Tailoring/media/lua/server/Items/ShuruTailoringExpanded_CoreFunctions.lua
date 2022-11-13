----------------------------------------------------------------------------------------------
-- Shuru's Tailoring Expanded - By Shurutsue / Yuhiko
-- Huge thanks to Chuck! Without his help i'd most likely still sit here working on it, or i'd have given up by now.
-- Things that're still planned:
--		* Requiring some table nearby for sewing
--		* Rebalaning requirements to learn clothing
--		* Maybe rebalance cost of the clothing
--		* Possibly optimize the scripts
--		* Add optional "special" support for Size mod and the ability to "choose" the size one wants to sew for (otherwise make it the size of the player)
--		* Open for ideas, though no promises
----------------------------------------------------------------------------------------------

function Recipe.OnGiveXP.ShuruTailoringExpandedSewClothing(recipe, ingredients, result, player)
	local sources = recipe:getSource();
	if sources:size() == 3 then
		local item = sources:get(1):getItems():get(0);
		local threadCount = sources:get(2):getCount();
		if item == "Base.RippedSheets" then
			local xp = math.floor(threadCount * 2);
			player:getXp():AddXP(Perks.Tailoring, xp)
		elseif item == "Base.DenimStrips" then
			local xp = math.floor(threadCount * 4);
			player:getXp():AddXP(Perks.Tailoring, xp)
		elseif item == "Base.LeatherStrips" then
			local xp = math.floor(threadCount * 6);
			player:getXp():AddXP(Perks.Tailoring, xp)
		end
	end
end

function Recipe.OnCreate.ShuruTailoringExpandedCreateLearn(items, result, player, selectedItem)
	local recipes = getAllRecipes()
	local correctRecipe = nil
	for i=0, recipes:size()-1 do
		local recipe = recipes:get(i)
		if recipe:getOriginalname() == 'Sew '..items:get(0):getType() then
			correctRecipe = recipe
			break
		end
	end
	if correctRecipe then
		local item = correctRecipe:getSource():get(1):getItems():get(0)
		local itemLevel = 0
		local mult = 0.0
		if item == "RippedSheets" or item == "Base.RippedSheets" then
			itemLevel = 0
			mult = 0.1
		elseif item == "DenimStrips" or item == "Base.DenimStrips" then
			itemLevel = 1
			mult = 0.2
		elseif item == "LeatherStrips" or item == "Base.LeatherStrips" then
			itemLevel = 2
			mult = 0.3
		end
		local itemCount = correctRecipe:getSource():get(1):getCount()
		local threadCount = correctRecipe:getSource():get(2):getCount()
		local level = itemLevel + math.floor(( itemCount + threadCount ) * mult)
		if not player:getKnownRecipes():contains(correctRecipe:getOriginalname()) then
			if player:getPerkLevel(Perks.Tailoring) >= level then
				player:getKnownRecipes():add(correctRecipe:getOriginalname())
			else
				local phrase = getText("IGUI_ShuruTailoring_CantLearn").. " ("..getText("IGUI_CraftCategory_Tailoring").." LV."..level..")"
				player:Say(phrase)
			end
		else
			player:Say("TailoringExpanded Error: Player knows the recipe already!")
		end
	else
		player:Say("TailoringExpanded Error: Recipe not found for ["..items:get(0):getFullType().."]")
	end
end

function Recipe.OnTest.ShuruTailoringExpandedTestLearn(sourceitem, result)
	if sourceitem:getScriptItem():getType() == Type.Clothing  and sourceitem:getFabricType() then -- check if clothing and has property fabricType
		local recipeName = 'Sew ' .. sourceitem:getType(); -- get recipe name by item's type
		if not getPlayer():getKnownRecipes():contains(recipeName)then -- if player does not already know the recipe
			return true -- he's allowed to learn it
		end
	end
	return false -- either does know the recipe or the item in question has no recipe made by my mod
end

local function ShuruTailoringExpandedCreateRecipes()
	print("Initializing Shuru's Tailoring Expanded")
	local missingRecipes = ArrayList.new()
	local fixedRecipes = ArrayList.new()
	local initStartTime = os.time() -- Used to check how long the code took to execute later on
	local allScriptItems = getScriptManager():getAllItems() -- Get a list of all script items
	local recipeString = 'module ShuruTailoringExpanded{' -- This string will be loaded later! Same format as recipes usually have
	local recipesAdded = 0 -- Keeping track of how many recipes actually get added.
	for i=0,allScriptItems:size()-1 do -- iterate all script items we received
		local scriptItem = allScriptItems:get(i) -- we take an item from the list, depending on current iteration
		if (scriptItem:getType() == Type.Clothing) and scriptItem:getFabricType() then -- if the item is a clothing item and it has a fabric type
			local tempItem = InventoryItemFactory.CreateItem(scriptItem:getFullName()) -- then we continue, here we "create" the item for the next step
			local amount = math.floor(tempItem:getNbrOfCoveredParts()*1.25) -- here we get the amount of parts a clothing covers or the amount of holes it could have in theory
			if not amount or amount == 0 then
				amount = 3 -- Base cost for items that do not have possible holes / an inspect menu. Subject to change in the future, maybe
			end
			local threadAmount = math.ceil(amount*0.5) -- we half that amount to get the amount of thread required for sewing it
			if (amount and amount > 0 and threadAmount and threadAmount > 0) then -- only if it costs more than nothing
				if ClothingRecipesDefinitions["FabricType"][tempItem:getFabricType()] then
					local sICost = ClothingRecipesDefinitions["FabricType"][tempItem:getFabricType()].material -- here we get what fabric it actually takes
					local recipeName = replaceWith(getText("IGUI_ShuruTailoring_Sew"), '\\$\\$\\$', tempItem:getDisplayName())
					getScriptManager():ParseScript(recipeString .. 'recipe ' .. recipeName .. '{' -- now we fill the string that's to be loaded later
					.. 'keep Base.Needle/Base.SutureNeedle,'
					.. sICost .. "=" .. amount
					.. ",Base.Thread=" .. threadAmount
					.. ',Result:' .. scriptItem:getFullName() .. '=1'
					.. ',Category:Tailoring'
					.. ',Time:' .. (threadAmount * 250)
					.. ',OnGiveXP:Recipe.OnGiveXP.ShuruTailoringExpandedSewClothing'
					.. ',NeedToBeLearn:true' .. '}}');
					local curRecipe = getScriptManager():getRecipe('ShuruTailoringExpanded.'..recipeName)
					if curRecipe and curRecipe:getOriginalname() == recipeName then
						curRecipe:setOriginalname('Sew '..tempItem:getType())
					else
						local found = false;
						for i=getAllRecipes():size()-1, 0, -1 do
							local rec = getAllRecipes():get(i)
							if rec:getOriginalname() == recipeName then
								rec:setOriginalname('Sew '..tempItem:getType())
								fixedRecipes:add('Sew '..tempItem:getType())
								--print("Fix for recipe: [Sew "..tempItem:getType().."]")
								found = true;
								break;
							end
						end
						if not found then
							missingRecipes:add(recipeName.."|"..tempItem:getType())
						end
					end
					recipesAdded = recipesAdded + 1 -- we increase the amount of recipes we added by one!
				else
					print("Err Missing ClothingRecipesDefinitions for ["..tempItem:getFabricType().."]")
				end
			end
		end
	end
	print('Missing Recipes: ',missingRecipes:size())
	print('Fixed Recipes: ',fixedRecipes:size())
	print("(Shuru's Tailoring Expanded) Created [" .. recipesAdded .. '] recipes.') -- Just to ensure we know it works?
	print("Finished Initializing Shuru's Tailoring Expanded (Elapsed Time:" .. (os.time() - initStartTime) .. ")") -- To know it finished and how long it took
end
Events.OnGameStart.Add(ShuruTailoringExpandedCreateRecipes) -- Now we're gonna run this function whenever the game starts! yay.
