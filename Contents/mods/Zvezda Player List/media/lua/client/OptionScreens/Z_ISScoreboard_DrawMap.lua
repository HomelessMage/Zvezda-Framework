require "OptionScreens/ISScoreboard"
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
function ISScoreboard:drawMap(y, item, alt)--C
    if not item.height then item.height = self.itemheight end -- compatibililty
    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15);
        if self.parent.selectedPlayer ~= item.text then
            self.parent.selectedPlayer = item.text;
            self.parent:doAdminButtons()
        end
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05);
    end
    self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    local fontHgtLarge = FONT_HGT_LARGE
	if canModifyPlayerScoreboard() then
		if getSteamScoreboard() then
			local avatarW = 32
			local avatarH = 32
			if item.item.avatar then
				self:drawTexture(item.item.avatar, 4, y + (item.height - 32) / 2, avatarW, avatarH, 1, 1, 1, 1)
			end			
			self:drawText( item.text, 4 + avatarW + 8, y+(item.height-fontHgtLarge)/2, 0.9, 0.9, 0.9, 0.9, UIFont.Large);			
			if self.mouseoverselected ~= item.index then
				local fontHgtSmall = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
				local profileText = getText("UI_Scoreboard_SteamName", item.item.profileName)
				self:drawText(profileText, 4 + avatarW + 8 + self.parent.maxNameWid + 20, y+(item.height - fontHgtSmall)/2, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
				if ISScoreboard.isAdmin then
					local textWid2 = getTextManager():MeasureStringX(UIFont.Small, profileText)
					self:drawText(getText("UI_Scoreboard_SteamID", item.item.steamID), 4 + avatarW + 8 + self.parent.maxNameWid + 20 + textWid2 + 20, y+(item.height - fontHgtSmall)/2, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
				end
			end
			item.height = 2 + avatarH + 2
		else
			self:drawText(item.text, 24, y+(item.height-fontHgtLarge)/2, 0.9, 0.9, 0.9, 0.9, UIFont.Large);
			item.height = self.fontHgt + (self.itemPadY or 0) * 2
		end
	end
    self.itemheight = item.height
    y = y + item.height;
    return y;
end