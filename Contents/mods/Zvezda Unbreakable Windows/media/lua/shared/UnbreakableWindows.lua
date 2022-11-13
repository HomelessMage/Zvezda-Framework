
local function LoadGridsquare(square)
  local objects = square:getObjects()
  for i = 0, objects:size() - 1 do
    local object = objects:get(i)
    if instanceof(object, "IsoWindow") then
      object:getProperties():Set(IsoFlagType.makeWindowInvincible)
      square:getProperties():Set(IsoFlagType.makeWindowInvincible)
      break
    end
  end
end

Events.LoadGridsquare.Add(LoadGridsquare)
