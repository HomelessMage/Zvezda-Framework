function RemoveAllZombies1b(zombie)
	if zombie and instanceof(zombie, "IsoZombie") then
		zombie:removeFromWorld()
		zombie:removeFromSquare()
	end
end