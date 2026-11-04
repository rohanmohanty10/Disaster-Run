 

 

local TextChatService = game:GetService("TextChatService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Weapons = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Weapons");
local CombineConfig = require(Weapons:WaitForChild("CombineConfig"));
local RBXGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral");

local function escape(p1) -- Line: 11
    return p1:gsub(
        "[&<>\"\']",
        {
            ["&"] = "&amp;",
            ["<"] = "&lt;",
            [">"] = "&gt;",
            ["\""] = "&quot;",
            ["\'"] = "&apos;"
        }
    );
end;

local u2 = {};
Weapons:WaitForChild("CombineEvent").OnClientEvent:Connect(function(p3, p4) -- Line: 22
    -- upvalues: LocalPlayer (copy), u2 (copy), CombineConfig (copy), RBXGeneral (copy)
    if p3 ~= "Announce" or LocalPlayer:GetAttribute("ChatNotificationsEnabled") ~= true then
        return;
    end;

    if type(p4) ~= "table" or (type(p4.id) ~= "string" or (u2[p4.id] or (type(p4.displayName) ~= "string" or (#p4.displayName > 100 or type(p4.skin) ~= "string")))) then
        return;
    end;

    local v5 = CombineConfig.nameOf(p4.skin);

    if not v5 then
        return;
    end;

    u2[p4.id] = os.clock();

    for i, v in u2 do
        if os.clock() - v > 300 then
            u2[i] = nil;
        end;
    end;

    local v6 = CombineConfig.UltimateLine:format(p4.displayName:gsub(
        "[&<>\"\']",
        {
            ["&"] = "&amp;",
            ["<"] = "&lt;",
            [">"] = "&gt;",
            ["\""] = "&quot;",
            ["\'"] = "&apos;"
        }
    ), (v5:gsub(
        "[&<>\"\']",
        {
            ["&"] = "&amp;",
            ["<"] = "&lt;",
            [">"] = "&gt;",
            ["\""] = "&quot;",
            ["\'"] = "&apos;"
        }
    )));
    RBXGeneral:DisplaySystemMessage(("<font color=\"#%s\">%s</font>"):format(CombineConfig.TierColors[3]:ToHex(), v6), "CombineUltimate");
end);