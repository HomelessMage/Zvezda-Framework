local original_create = CharacterCreationHeader.create

function CharacterCreationHeader:create()
	original_create(self)
	
	local x = self.genderCombo:getAbsoluteX() + self.genderCombo:getWidth() + 6
	local y = self.genderCombo:getAbsoluteY()
	local w = self.forenameEntry:getAbsoluteX() + self.forenameEntry:getWidth() - x
	local h = self.genderCombo:getHeight()
	
	self.rndNameButton = ISButton:new(x, y, w, h, getText("UI_NRK_RandomName_Button"), self, self.onNRKButton)
	self.rndNameButton:initialise()
	self.rndNameButton:instantiate()
	self.rndNameButton.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.rndNameButton)
end

function CharacterCreationHeader:onNRKButton()
	SurvivorFactory.randomName(MainScreen.instance.desc)
	self.forenameEntry:setText(MainScreen.instance.desc:getForename())
	self.surnameEntry:setText(MainScreen.instance.desc:getSurname())
end
