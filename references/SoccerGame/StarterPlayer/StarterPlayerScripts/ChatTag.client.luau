  

local TextChatService = game:GetService("TextChatService");
local Players = game:GetService("Players");
game:GetService("ReplicatedStorage");
local u8 = {
    {
        Text = "Team Isagi",
        Color = "#0388fc",

        Check = function(p1) -- Line: 12, Name: Check
            return false;
        end
    },
    {
        Text = "Team Rin",
        Color = "#0068f0",

        Check = function(p2) -- Line: 19, Name: Check
            return false;
        end
    },
    {
        Text = "DEV",
        Color = "#2ecc71",

        Check = function(p3) -- Line: 27, Name: Check
            return p3:GetAttribute("isDev");
        end
    },
    {
        Text = "STAFF",
        Color = "#c3eeee",

        Check = function(p4) -- Line: 35, Name: Check
            return p4:GetAttribute("isStaff");
        end
    },
    {
        Text = "Content Creator",
        Color = "#db1518",

        Check = function(p5) -- Line: 43, Name: Check
            return p5:GetAttribute("isCC");
        end
    },
    {
        Text = "Tester",
        Color = "#cc27cf",

        Check = function(p6) -- Line: 51, Name: Check
            return p6:GetAttribute("isTester");
        end
    },
    {
        Text = "VIP",
        Color = "#ffc20b",

        Check = function(p7) -- Line: 59, Name: Check
            return p7.HasVIP.Value;
        end
    }
};
local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration;

function TextChatService.OnIncomingMessage(p9: userdata) -- Line: 68
    -- upvalues: ChatWindowConfiguration (copy), Players (copy), u8 (copy)
    local v10 = ChatWindowConfiguration:DeriveNewMessageProperties();

    if p9.TextSource then
        local PlayerByUserId = Players:GetPlayerByUserId(p9.TextSource.UserId);
        local v11 = "";

        for _, v in u8 do
            if v.Check(PlayerByUserId) then
                v11 = v11 .. "<font color=\'" .. v.Color .. "\'>[" .. v.Text .. "]</font> ";
            end;
        end;

        if PlayerByUserId then
            local Attribute = PlayerByUserId:GetAttribute("EquippedTitle");

            if Attribute and Attribute ~= "" then
                v11 = v11 .. "<font color=\'" .. (PlayerByUserId:GetAttribute("EquippedTitleColor") or "#FFFFFF") .. "\'>[" .. Attribute .. "]</font> ";
            end;
        end;

        v10.PrefixText = v11 .. p9.PrefixText;
    end;

    return v10;
end;