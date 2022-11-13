require "OptionScreens/ISScoreboard"

function ISScoreboard:render()--7
	print("Scoreboard Render")
	ISScoreboard.instance = self
	self.listbox.doDrawItem = self.drawMap
    ISPanelJoypad.render(self)
	if canModifyPlayerScoreboard() then
		self:drawTextCentre(getText("UI_mainscreen_scoreboard") .. " ( " .. getText("UI_Scoreboard_PlayerConnected", self.playersConnected) .. " )", self.width / 2, 10, 1, 1, 1, 1, UIFont.Large);
	else
		self:drawTextCentre("PLAYER LIST NOT AVAILABLE TO NON-ADMINS", self.width / 2, 10, 1, 1, 1, 1, UIFont.Large);	
	end
    self:drawRectBorder(self.listbox:getX(), self.listbox:getY(), self.listbox:getWidth(), self.listbox:getHeight(), 0.9, 0.4, 0.4, 0.4)
end