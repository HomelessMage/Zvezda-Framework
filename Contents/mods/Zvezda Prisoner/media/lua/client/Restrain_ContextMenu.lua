
Restrain = Restrain or {}
Restrain.Verbose = Restrain.Verbose or false--set to true for logs
Restrain.solodebug = false;

--remove trade action that would free ourselves. I would prefer to remove the button but I won't mess with createMenu insides
local upperLayerOnTrade = ISWorldObjectContextMenu.onTrade
ISWorldObjectContextMenu.onTrade = function(worldobjects, playerObj, otherPlayerObj)
    if Restrain.isSurrendering(playerObj) or Restrain.isSurrendering(otherPlayerObj) then return end
    
    upperLayerOnTrade(worldobjects, playerObj, otherPlayerObj)
end

--remove sit down action that would stuck us on ground.
local upperLayerOnSitOnGround = ISWorldObjectContextMenu.onSitOnGround
ISWorldObjectContextMenu.onSitOnGround = function(playerNum)
    if Restrain.Verbose then print ("Restrain.onSitOnGround "..tostring(playerNum)) end
    if Restrain.isSurrendering(getSpecificPlayer(playerNum)) then return end
    
    upperLayerOnSitOnGround(playerNum)
end

--add contextual option to restrain
local upperLayerCreateMenu = ISWorldObjectContextMenu.createMenu
ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
    local context = upperLayerCreateMenu(player, worldobjects, x, y, test)
    
    --contextual option for action on other
    local playerObj = getSpecificPlayer(player)

    if clickedPlayer and clickedPlayer ~= playerObj and isClient() then
        if math.abs(playerObj:getX() - clickedPlayer:getX()) <= 2 and math.abs(playerObj:getY() - clickedPlayer:getY()) <= 2 then
            if Restrain.Verbose then print("distancia CERTA ##########################"); end
            createMenuNew(context, clickedPlayer, playerObj);
        else
            if Restrain.Verbose then print("distancia errada ##########################"); end
        end        
    elseif Restrain.solodebug then--just for standalone pseudo MP tests before MP tests
        createMenuNew(context, playerObj, playerObj);
    end
    
    return context
end

function createMenuNew(context, clickedPlayer, playerObj)
    --enable check inventory
    if ModData.getOrCreate("BPplayerData")[clickedPlayer:getUsername()].isSurrendering and SandboxVars.Prisonner.Inspect then
        local option3 = context:addOption(getText("ContextMenu_Inventary", clickedPlayer:getDisplayName()), playerObj, ISWorldObjectContextMenu.onInventaryCheck, clickedPlayer);
    end

    --check if this is surrender and not restrained
    if ModData.getOrCreate("BPplayerData")[clickedPlayer:getUsername()].isSurrendering and ModData.getOrCreate("BPplayerData")[clickedPlayer:getUsername()].isRestrained == false then
        local option2 = context:addOption(getText("ContextMenu_Restrain", clickedPlayer:getDisplayName()), playerObj, ISWorldObjectContextMenu.onRestrain, clickedPlayer )
    end

    --check if will need to be restrain
    if ModData.getOrCreate("BPplayerData")[clickedPlayer:getUsername()].isRestrained then
        local option1 = context:addOption(getText("ContextMenu_Free", clickedPlayer:getDisplayName()), playerObj, ISWorldObjectContextMenu.onFree, clickedPlayer )
    end

end

ISWorldObjectContextMenu.onInventaryCheck = function (playerObj, clickedPlayer)
    local array = ModData.getOrCreate("BPplayerData")[clickedPlayer:getUsername()]["inventory"];

    if Restrain.Verbose then print("INICIANDO O INV " .. tostring(#array)); end

    for i = 1, #array do
        ISTimedActionQueue.add(ISCheckInv:new(playerObj:getOnlineID(), 50, array[i], clickedPlayer));
	end
    
    --sendClientCommand(playerObj, 'Prisonner', 'Inventary', {target=clickedPlayer:getOnlineID()});
end

ISWorldObjectContextMenu.onRestrain = function (playerObj, clickedPlayer)
    if Restrain.Verbose then print("humm 1"); end
    --MPTC.sendCommand(playerObj, "Restrain "..clickedPlayer:getUsername())
    sendClientCommand(playerObj, 'Prisonner', 'Restrain', {target=clickedPlayer:getOnlineID()});
end

ISWorldObjectContextMenu.onFree = function (playerObj, clickedPlayer)
    --MPTC.sendCommand(playerObj, "Free "..clickedPlayer:getUsername())
    sendClientCommand(playerObj, 'Prisonner', 'Free', {target=clickedPlayer:getOnlineID()});
end