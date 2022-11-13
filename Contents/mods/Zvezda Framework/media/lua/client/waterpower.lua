require "Chat/ISChat";

local vanillaCmdEntered = ISChat["onCommandEntered"];

ISChat["onCommandEntered"] = function(self)
	local text = ISChat.instance.textEntry:getText();

	if not text or text == ""
	then
		return;
	end

    if text
    then
		-- /globalwater|globalpower on|off

        local isWater = luautils.stringStarts(text, "/globalwater ");
        local isPower = luautils.stringStarts(text, "/globalpower ");

        if (isWater or isPower) and isAdmin()
        then
            local state = string.trim(string.sub(text, 13));

            wpOnOff(isWater
                and "water"
                or "power",
            state);

            ISChat.instance:unfocus();

            ISChat.instance.timerTextEntry = 20;
            doKeyPress(false);

            return;
        end
    end

    vanillaCmdEntered();
end

function wpOnOff(wp, state)
    local option = nil;

    if wp == "power"
    then
        option = "ElecShut";
    elseif wp == "water"
    then
        option = "WaterShut";
    end

    if option
    then
        local options = SandboxOptions.new();

        if state == "on" or state == "off"
        then
            options:copyValuesFrom(getSandboxOptions());
            options:getOptionByName(option .. "Modifier"):setValue(state == "on"
                and 2147483647
                or -1
            );

            getPlayer():setHaloNote(getText(wp == "power"
                and "IGUI_WPCmd_Power"
                or "IGUI_WPCmd_Water"
            ) .. " " .. getText(state == "on"
                and "IGUI_WPCmd_TurnedOn"
                or "IGUI_WPCmd_TurnedOff"
            ), 255, 87, 87, 300);
        end

        options:sendToServer();
    end
end