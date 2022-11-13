require 'NPCs/ZombiesZoneDefinition'

FBI_ZombiesZoneDefinition = ZombiesZoneDefinition or {};

FBI_ZombiesZoneDefinition.Fbiofficer = {
	Fbiofficer = {        -- Term for the ZombieZoneDefinitions.lua file 
		name="Fbiofficer",  -- Name of the Outfit in Clothing.xml **/
		chance=3,                    -- Small chance of 5% to spawn in the zone (police station) .   
	},
};
FBI_ZombiesZoneDefinition.Fbiofficer2 = {
	Fbiofficer = {        -- Term for the ZombieZoneDefinitions.lua file 
		name="Fbiofficer2",  -- Name of the Outfit in Clothing.xml **/
		chance=3,                    -- Small chance of 5% to spawn in the zone (police station) .   
	},
};
FBI_ZombiesZoneDefinition.AntiriotofficerLG = {
	AntiriotofficerLG = {        -- Term for the ZombieZoneDefinitions.lua file 
		name="AntiriotofficerLG",  -- Name of the Outfit in Clothing.xml **/
		chance=3,                    -- Small chance of 5% to spawn in the zone (police station) .   
	},
};

local AntiriotofficerLG = {
		name="AntiriotofficerLG",	
		chance=3,
	};
local Fbiofficer = {
		name="Fbiofficer",	
		chance=3,
	};
local Fbiofficer2 = {
		name="Fbiofficer2",
		chance=2,
	};
ZombiesZoneDefinition.Police[Fbiofficer] = Fbiofficer;
ZombiesZoneDefinition.Police[Fbiofficer2] = Fbiofficer2;
ZombiesZoneDefinition.Police[AntiriotofficerLG] = AntiriotofficerLG;
-- total chance can be over 100% we don't care as we'll roll on the totalChance and not a 100 (unlike the specific outfits on top of this)
FBI_ZombiesZoneDefinition.Default = ZombiesZoneDefinition.Default or {};

-- General Pop --
table.insert(ZombiesZoneDefinition.Default,{name = "Police", chance=3});


