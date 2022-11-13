--***********************************************************
--**                    Tchernobill                        **
--***********************************************************

require "TimedActions/ISBaseTimedAction"
require "Restrain_keybinding"

ISSelfRestrain = ISBaseTimedAction:derive("ISSelfRestrain");

ISSelfRestrain.allowedActions = {
["ISEnterVehicle"]=true,
["ISExitVehicle"]=true
}

function ISSelfRestrain:isValid()
    return true
end

function ISSelfRestrain:waitToStart()
    return false
end

function ISSelfRestrain:update()
    --in case an surrender action was broken by shove or other action:
    if self.character:getCharacterActions():isEmpty() then
        self:setActionAnim("surrender")--surrender action is also default action
    end
    
    --TODO restrain all other actions: ensure nothing available to non admin can do ISTimedActionQueue.clear
    --speed can be modified by adding an invisible wornbag with high speed reduction
    
    if self.subAction then
        if not self.subAction:isValid() then
            self.subAction:stop()--this is shitty, it could break the restraint.. which could be interesting anyway
        else
            self.subAction:update()
        end
        
    end
end

function ISSelfRestrain.OnServerCommand(mod, command, player, args)
    if Restrain.Verbose then print(mod .. " -aa- " .. command); end
    if mod ~= "BetterPrisonner" then return end--todo log
    if not ISSelfRestrain.instance then return end--todo log

    print("---aaa");
    
    ISSelfRestrain.onDetectedCommand(ISSelfRestrain.instance, mod, command, player, args);
end

function ISSelfRestrain:onDetectedCommand(mod, command, player, args)
    if Restrain.Verbose then print("---aaaa"); end
    if Restrain.Verbose then print ("ISSelfRestrain:onDetectedCommand mod= "..tostring(mod or "nil").." command= "..tostring(command or "nil").." player= "..tostring(player or "nil")) end
    if not self.character:getModData().isRestrained and command == "Restrain" then--and player == self.character ?
        self:doOverride()
    elseif self.character:getModData().isRestrained and command == "Free" then--and player == self.character ?
        self:releaseOverride()
    end
end

function ISSelfRestrain:start()
    if Restrain.Verbose then print ("ISSelfRestrain:start") end
    self:setActionAnim("surrender")--surrender action is also default action
    self:doSurrender()--discard all Timed Actions
    --self.character:setAsleep(false); --?? totest
    --self.character:setbFalling(true);--?? totest
    --self.character:setForceShove(true);--?? totest
    --self.character:setFallOnFront(true);--?? totest
    --self.character:setHitFromBehind(true);--?? totest
    --self.character:setBumpDone(true);--?? totest
    --self.character:setBumpFall(true);--?? totest
    --self.character:fallenOnKnees();--?? totest
end

function ISSelfRestrain:stop()
    if Restrain.Verbose then print ("ISSelfRestrain:stop") end
    
    self:releaseOverride()
    self:releaseSurrender()
    if self.subAction then self.subAction:forceStop() end
    --ISSelfRestrain.stopSubAction(subaction)--overkill? yes and dangerous for the self.action restart at character level
    self.subAction = nil
    if self.BaseTimedActionStop ~= nil then ISBaseTimedAction.stop = self.BaseTimedActionStop end
    self.BaseTimedActionStop = nil
    ISBaseTimedAction.forceStop(self);--stop anim action
    ISSelfRestrain.instance = nil;
end

function ISSelfRestrain:perform()
    if Restrain.Verbose then print ("ISSelfRestrain:perform") end
    self:stop();
end

function ISSelfRestrain:new(characterNum)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = getSpecificPlayer(characterNum);
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = 1147483646;--keep some margin on max int for the moodles time penalties
    o.hookedOnCommands = false;
    ISSelfRestrain.instance = o;--store single static instance for function to method forward.. stupid me.
    return o;
end


--actions override
function ISSelfRestrain:doSurrender()
    if not self.upperLayeradd then
        self.upperLayeradd = ISTimedActionQueue.add --store the previous clear function
        ISTimedActionQueue.add = ISSelfRestrain.add --replace the clear with a dummy one
    end
    if not self.hookedOnCommands then
        Events.OnServerCommand.Add(ISSelfRestrain.OnServerCommand);
        self.hookedOnCommands = true;
    end
end
function ISSelfRestrain:releaseSurrender()
    if self.hookedOnCommands then
        Events.OnServerCommand.Remove(ISSelfRestrain.OnServerCommand);
        self.hookedOnCommands = false;
    end
    if self.upperLayeradd then
        ISTimedActionQueue.add = self.upperLayeradd
        self.upperLayeradd = nil
    end
end

function ISSelfRestrain:doOverride()
    self.character:dropHandItems();
    if not self.upperLayerClear then
        self.upperLayerClear = ISTimedActionQueue.clear --store the previous clear function
        ISTimedActionQueue.clear = ISSelfRestrain.clear --replace the clear with a dummy one
    end
    Restrain.inhibitKeyBinding()
    self.character:setIgnoreAimingInput(true);
    self.character:getModData().isRestrained = true

    playerdataClient.updatePlayer(self.character:getDisplayName(), "isRestrained", true);
end

function ISSelfRestrain:releaseOverride()
    self.character:getModData().isRestrained = nil
    
    playerdataClient.updatePlayer(self.character:getDisplayName(), "isRestrained", false);

    self.character:setIgnoreAimingInput(false)--TODO ensure it must be set to true..
    Restrain.exhibitKeyBinding()
    if self.upperLayerClear then
        ISTimedActionQueue.clear = self.upperLayerClear
        self.upperLayerClear = nil
    end
end

ISSelfRestrain.clear = function(character)
    local self = ISSelfRestrain.instance
    if not self then return end--shit error
    if self.character == character then
        return ISTimedActionQueue.getTimedActionQueue(character)
    end
    return nil
end

ISSelfRestrain.add = function(action)
    local self = ISSelfRestrain.instance
    if not self then return end--shit error
    if not self.upperLayeradd then return end
    if not self.character == action.character then self.upperLayeradd(action) end
    if ISSelfRestrain.allowedActions[action.Type] and self.upperLayeradd and not self.subAction and action:isValid() then
        --todo add the action before SelfRestrain or play it as a subaction like ISSelfRestrain were a composite
        if not self.BaseTimedActionStop then
            self.BaseTimedActionStop = ISBaseTimedAction.stop;
            ISBaseTimedAction.stop = ISSelfRestrain.stopSubAction;--inhibit queue reset from subaction (smells fishy)
        end
        if not self.BaseTimedActionPerform then
            self.BaseTimedActionPerform = ISBaseTimedAction.perform;
            ISBaseTimedAction.perform = ISSelfRestrain.stopSubAction;--inhibit queue reset from subaction (smells fishy)
        end

        self.subAction = action;
        self.subAction:begin()--should I start it instead?
        if Restrain.Verbose then print ("ISSelfRestrain:add subaction began "..action.Type) end
    end
    if action == self and self.upperLayeradd then--lol just handling part of the fishy state that I should correct instead.
        self.upperLayeradd(self)--go back in the bugged queue. should I inhibit queue tick instead ?
    end
end

function ISSelfRestrain:releaseSubAction()
    self.subAction = nil;
    if self.BaseTimedActionStop then ISBaseTimedAction.stop = self.BaseTimedActionStop; end
    if self.BaseTimedActionPerform then ISBaseTimedAction.perform = self.BaseTimedActionPerform; end
    self.BaseTimedActionStop = nil
    self.BaseTimedActionPerform = nil
end
function ISSelfRestrain.stopSubAction(subaction)
    if Restrain.Verbose then print ("ISSelfRestrain:stopSubAction subaction stopped "..subaction.Type) end
    local self = ISSelfRestrain.instance
    if not self or not self.subAction then return end--shit error
    if self.subAction == subaction then
        self:releaseSubAction()
        if self.character and self.action then
            self.character:StartAction(self.action);--Yeepah! that's done
            
            if Restrain.Verbose then print ("ISSelfRestrain:stopSubAction subaction stopped surrender restarted Yeepah! "..subaction.Type) end
        else
            if Restrain.Verbose then print ("ISSelfRestrain:stopSubAction subaction stopped surrender not restarted "..subaction.Type) end
        end
    else
        if Restrain.Verbose then print ("ISSelfRestrain:stopSubAction subaction not stopped surrender not restarted "..subaction.Type) end
    end
end

