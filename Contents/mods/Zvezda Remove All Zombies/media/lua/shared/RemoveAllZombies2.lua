local function RemoveAllZombies2(zombie)
	if zombie then RemoveAllZombies1b(zombie) end
	if zombie then RemoveAllZombies1a(zombie) end
end

Events.OnZombieUpdate.Add ( RemoveAllZombies2 )