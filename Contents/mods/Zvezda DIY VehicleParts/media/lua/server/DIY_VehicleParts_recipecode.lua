--Функция на начисление опыта Автомеханика
--1ед.
function Recipe.OnGiveXP.Mechanics(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, 1);
end
--2ед
function Recipe.OnGiveXP.Mechanics2(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, 2);
end
--5ед.
function Recipe.OnGiveXP.Mechanics5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, 5);
end
--10ед.
function Recipe.OnGiveXP.Mechanics10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Mechanics, 10);
end

--Функция на начисление опыта Электрику
--1ед.
function Recipe.OnGiveXP.Electricity(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, 1);
end
--2ед
function Recipe.OnGiveXP.Electricity2(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, 2);
end
--5ед.
function Recipe.OnGiveXP.Electricity5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, 5);
end
--10ед.
function Recipe.OnGiveXP.Electricity10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Electricity, 10);
end

--Функция на начисление опыта сварщику
--1ед.
function Recipe.OnGiveXP.MetalWelding(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 1);
end
--2ед
function Recipe.OnGiveXP.MetalWelding2(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 2);
end
--5ед.
function Recipe.OnGiveXP.MetalWelding5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 5);
end
--10ед.
function Recipe.OnGiveXP.MetalWelding10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.MetalWelding, 10);
end

--Функция на начисление опыта строителю
--1ед.
function Recipe.OnGiveXP.WoodWork(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 1);
end
--2ед
function Recipe.OnGiveXP.WoodWork2(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 2);
end
--5ед.
function Recipe.OnGiveXP.WoodWorkg5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 5);
end
--10ед.
function Recipe.OnGiveXP.WoodWork10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Woodwork, 10);
end

--Функция на начисление опыта строителю
--1ед.
function Recipe.OnGiveXP.Tailoring(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 1);
end
--2ед
function Recipe.OnGiveXP.Tailoring2(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 2);
end
--5ед.
function Recipe.OnGiveXP.Tailoring5(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 5);
end
--10ед.
function Recipe.OnGiveXP.Tailoring10(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 10);
end