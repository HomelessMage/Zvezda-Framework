-- local item = ScriptManager.instance:getItem("Base.Pistol")				
-- if item then
	-- item:DoParam("Icon = Ber92,")	
-- end

local function notWeapon(item)
	if not item:contains("Base.") then item = tostring("Base." .. item) end
	local item = ScriptManager.instance:getItem(item)				
	if item then item:DoParam("Type = Normal")	end
end

local function makeObsolete(item)
	if not item:contains("Base.") then item = tostring("Base." .. item) end
	local item = ScriptManager.instance:getItem(item)				
	if item then item:DoParam("OBSOLETE = true")	end
end

notWeapon("BreadKnife")
notWeapon("ButterKnife")
notWeapon("Fork")
notWeapon("Spoon")
notWeapon("BluePen")
notWeapon("Pen")
notWeapon("RedPen")
notWeapon("Pencil")
notWeapon("SpearBreadKnife")
notWeapon("SpearButterKnife")
notWeapon("SpearFork")
notWeapon("SpearIcePick")
notWeapon("SpearLetterOpener")
notWeapon("SpearScalpel")
notWeapon("SpearScrewdriver")
notWeapon("SpearScissors")
notWeapon("SpearSpoon")

makeObsolete("SpearBreadKnife")
makeObsolete("SpearButterKnife")
makeObsolete("SpearFork")
makeObsolete("SpearIcePick")
makeObsolete("SpearLetterOpener")
makeObsolete("SpearScalpel")
makeObsolete("SpearScrewdriver")
makeObsolete("SpearScissors")
makeObsolete("SpearSpoon")