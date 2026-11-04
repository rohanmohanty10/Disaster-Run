 

 

local TextChatService = game:GetService("TextChatService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local LastRunnerChatEvent = game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("LastRunnerChatEvent");
local RBXGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral");
local u1 = {
    Color3.fromRGB(253, 41, 67),
    Color3.fromRGB(1, 162, 255),
    Color3.fromRGB(2, 184, 87),
    BrickColor.new("Bright violet").Color,
    BrickColor.new("Bright orange").Color,
    BrickColor.new("Bright yellow").Color,
    BrickColor.new("Light reddish violet").Color,
    BrickColor.new("Brick yellow").Color
};

local function nameColor(p2) -- Line: 18
    -- upvalues: u1 (copy)
    local v3 = 0;

    for i = 1, #p2 do
        local string_byte_ret = string.byte(p2, i);
        local v4 = #p2 - i + 1;

        if #p2 % 2 == 1 then
            v4 = v4 - 1;
        end;

        if v4 % 4 >= 2 then
            string_byte_ret = -string_byte_ret;
        end;

        v3 = v3 + string_byte_ret;
        local _ = i;
    end;

    return u1[v3 % #u1 + 1];
end;

local function escape(p5) -- Line: 34
    return p5:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
end;

local u6 = {};
LastRunnerChatEvent.OnClientEvent:Connect(function(p7) -- Line: 39
    -- upvalues: LocalPlayer (copy), u6 (copy), nameColor (copy), RBXGeneral (copy)
    if LocalPlayer:GetAttribute("ChatNotificationsEnabled") ~= true then
        return;
    end;

    if type(p7) ~= "table" or (type(p7.id) ~= "string" or (u6[p7.id] or (type(p7.displayName) ~= "string" or (type(p7.username) ~= "string" or (type(p7.chasers) ~= "number" or (p7.chasers < 1 or (p7.chasers > 100 or p7.chasers % 1 ~= 0))))))) then
        return;
    end;

    u6[p7.id] = os.clock();

    for i, v in u6 do
        if os.clock() - v > 300 then
            u6[i] = nil;
        end;
    end;

    local v8 = nameColor(p7.username);
    local Color3_new_ret = Color3.new(v8.R * 0.7, v8.G * 0.7, v8.B * 0.7);
    local v9 = p7.displayName:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
    local v10 = p7.username:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
    local math_floor_ret = math.floor(p7.chasers);
    RBXGeneral:DisplaySystemMessage(string.format("<font color=\"#%s\">%s</font> <font color=\"#%s\">(%s)</font> <font color=\"#FFFF00\">was the last runner standing and crossed against %d %s!</font>", v8:ToHex(), v9, Color3_new_ret:ToHex(), v10, math_floor_ret, math_floor_ret == 1 and "chaser" or "chasers"), "LastRunnerCrossing");
end);