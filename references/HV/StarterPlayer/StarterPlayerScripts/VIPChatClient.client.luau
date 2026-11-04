 

 

local Players = game:GetService("Players");
local TextChatService = game:GetService("TextChatService");
local ChatWindowConfiguration = TextChatService:WaitForChild("ChatWindowConfiguration");
local RankedConfig = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("RankedConfig"));

local function escape(p1) -- Line: 6
    return p1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
end;

local function tag(p2, p3) -- Line: 7
    if type(p2) ~= "string" or p2 == "" then
        return "";
    end;

    local v4 = p2:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");

    return "<font color=\"#" .. (typeof(p3) == "Color3" and (p3:ToHex() or "E4CB89") or "E4CB89") .. "\">[" .. v4 .. "]</font> ";
end;

function TextChatService.OnChatWindowAdded(p5) -- Line: 13
    -- upvalues: Players (copy), RankedConfig (copy), ChatWindowConfiguration (copy)
    local TextSource = p5.TextSource;

    if TextSource then
        TextSource = Players:GetPlayerByUserId(TextSource.UserId);
    end;

    if not TextSource then
        return nil;
    end;

    local Attribute = TextSource:GetAttribute("OverheadTitle");
    local Attribute2 = TextSource:GetAttribute("OverheadTitleColor");
    local v6 = TextSource:GetAttribute("LookAsUserId") ~= nil;

    if not (v6 or (TextSource:GetAttribute("IsTopWins") ~= true or TextSource:GetAttribute("BoardRankHidden") == true)) then
        Attribute2 = Color3.fromRGB(255, 222, 112);
        Attribute = "#1 WINS";
    end;

    local v7;

    if type(Attribute) == "string" and Attribute ~= "" then
        local v8 = Attribute:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
        v7 = "<font color=\"#" .. (typeof(Attribute2) == "Color3" and (Attribute2:ToHex() or "E4CB89") or "E4CB89") .. "\">[" .. v8 .. "]</font> ";
    else
        v7 = "";
    end;

    local v9 = not v6 and RankedConfig.Tiers[TextSource:GetAttribute("RankTier") or 0];
    local v10;

    if v9 then
        v10 = TextSource:GetAttribute("RankChampion");
    else
        v10 = v9;
    end;

    if v9 then
        local v11 = (RankedConfig.TierColors[v9.Name] or Color3.new(1, 1, 1)):ToHex();
        local v12;

        if v10 then
            v12 = "Champion #" .. v10;
        else
            v12 = v9.Name;
        end;

        v7 = "<font color=\"#" .. v11 .. "\">◆ " .. v12 .. "</font> " .. v7;
    end;

    local Attribute3 = TextSource:GetAttribute("JourneyTitle");

    if Attribute3 ~= Attribute then
        local Attribute4 = TextSource:GetAttribute("JourneyTitleColor");
        local v13;

        if type(Attribute3) == "string" and Attribute3 ~= "" then
            local v14 = Attribute3:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;");
            v13 = "<font color=\"#" .. (typeof(Attribute4) == "Color3" and (Attribute4:ToHex() or "E4CB89") or "E4CB89") .. "\">[" .. v14 .. "]</font> ";
        else
            v13 = "";
        end;

        v7 = v7 .. v13;
    end;

    local Attribute4 = TextSource:GetAttribute("LookDisplayName");
    local PrefixText = p5.PrefixText;
    local v15;

    if type(Attribute4) == "string" then
        v15 = PrefixText:find(TextSource.DisplayName, 1, true);
    else
        v15 = false;
    end;

    if v15 then
        PrefixText = PrefixText:sub(1, v15 - 1) .. Attribute4:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;") .. PrefixText:sub(v15 + #TextSource.DisplayName);
    end;

    if v7 == "" and PrefixText == p5.PrefixText then
        return nil;
    end;

    local v16 = ChatWindowConfiguration:DeriveNewMessageProperties();
    v16.PrefixText = v7 .. PrefixText;

    return v16;
end;