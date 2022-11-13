require "OptionScreens/ISScoreboard"

-- Do the admin buttons
function ISScoreboard:doAdminButtons()--9
    self.kickButton.enable = false;
    self.banButton.enable = false;
    if self.banIpButton then self.banIpButton.enable = false; end
    self.teleportButton.enable = false;
    self.teleportToYouButton.enable = false;
    self.invisibleButton.enable = false;
    self.godmodButton.enable = false;
    self.voipmuteButton.enable = false;
    self.muteButton.enable = false;

    self.kickButton:setVisible(ISScoreboard.isAdmin);
    self.banButton:setVisible(ISScoreboard.isAdmin);
    if self.banIpButton then self.banIpButton:setVisible(ISScoreboard.isAdmin); end
    self.godmodButton:setVisible(ISScoreboard.isAdmin);
    self.invisibleButton:setVisible(ISScoreboard.isAdmin);
    self.teleportButton:setVisible(ISScoreboard.isAdmin);
    self.teleportToYouButton:setVisible(ISScoreboard.isAdmin);

    if self.selectedPlayer and canModifyPlayerScoreboard() then
        local dy = self.listbox:getYScroll()
		local username = self.selectedPlayer
        if username ~= getSpecificPlayer(0):getDisplayName() then
            self.kickButton.enable = not (isAccessLevel("gm") or isAccessLevel("observer"));
            self.banButton.enable = (isAccessLevel("admin") or isAccessLevel("moderator"));
            self.teleportButton.enable = true;
            self.teleportToYouButton.enable = true;
            self.invisibleButton.enable = not isAccessLevel("observer");
            self.godmodButton.enable = not isAccessLevel("observer");
            self.voipmuteButton.enable = true;
            self.muteButton.enable = true;

            if self.banIpButton then
                self.banIpButton.enable = (isAccessLevel("admin") or isAccessLevel("moderator"));
            end

            local muted = ISChat.instance:isMuted(username)
            self.muteButton:setTitle(muted and getText("UI_Scoreboard_Unmute") or getText("UI_Scoreboard_Mute"))
            self.muteButton:setX(self.buttonPos[self.muteButton].x)
            self.muteButton:setY(self.buttonPos[self.muteButton].y)

            local voipmuted = VoiceManager:playerGetMute(username)
            self.voipmuteButton:setTitle(voipmuted and getText("UI_Scoreboard_VOIPUnmute") or getText("UI_Scoreboard_VOIPMute"))
            self.voipmuteButton:setX(self.buttonPos[self.voipmuteButton].x)
            self.voipmuteButton:setY(self.buttonPos[self.voipmuteButton].y)
        else
            self.invisibleButton.enable = not isAccessLevel("observer");
            self.godmodButton.enable = not isAccessLevel("observer");
        end
    elseif self.selectedPlayer then
        local dy = self.listbox:getYScroll()
        local username = self.selectedPlayer
        if username ~= getSpecificPlayer(0):getDisplayName() then
            self.voipmuteButton.enable = true;
            self.muteButton.enable = true;

            local muted = ISChat.instance:isMuted(username)
            self.muteButton:setTitle(muted and getText("UI_Scoreboard_Unmute") or getText("UI_Scoreboard_Mute"))
            self.muteButton:setX(self.listbox.x + self.listbox.width + 10);
            self.muteButton:setY(self.listbox.y);

            local voipmuted = VoiceManager:playerGetMute(username)
            self.voipmuteButton:setTitle(voipmuted and getText("UI_Scoreboard_VOIPUnmute") or getText("UI_Scoreboard_VOIPMute"))
            self.voipmuteButton:setX(self.muteButton:getRight() + 10);
            self.voipmuteButton:setY(self.listbox.y);

        end
    end
end
