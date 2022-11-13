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