 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TextChatService = game:GetService("TextChatService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"));
local u1 = nil;
local u2 = Knit.CreateController({
    Name = "CommandController"
});

function u2.CanRunCommands(p3: userdata, p4: string) -- Line: 15
    -- upvalues: u1 (ref)
    if p3.UserId < 0 then
        return true;
    end;

    local v5 = game.PlaceId == 82710350236919;
    local RankInGroup = p3:GetRankInGroup(34852864);

    if v5 and RankInGroup == 200 then
        return true;
    end;

    if (p4 == "Tester" or (p4 == "LeadTester" or (p4 == "HeadTester" or p4 == "SpecialTester"))) and RankInGroup == 200 then
        if p4 == "Tester" or (p4 == "LeadTester" or p4 == "HeadTester") and table.find(u1.Player.Customization.Inventory.ChatTags, "Skarp2") or (p4 == "HeadTester" and table.find(u1.Player.Customization.Inventory.ChatTags, "Head Of Testers") or p4 == "SpecialTester" and (table.find(u1.Player.Customization.Inventory.ChatTags, "Skarp3") and table.find(u1.Player.Customization.Inventory.ChatTags, "Head Of Testers"))) then
            return true;
        end;

        return false, "Rank in group is not high enough";
    end;

    if RankInGroup < 235 then
        return false, "Rank in group is not high enough";
    end;

    return true;
end;

function u2.KnitInit(p6) -- Line: 38
end;

function u2.KnitStart(p7) -- Line: 42
    -- upvalues: u1 (ref), Knit (copy), CmdrClient (copy), u2 (copy), TextChatService (copy)
    u1 = Knit.GetController("Network");
    CmdrClient.Registry:RegisterHook("BeforeRun", function(p8) -- Line: 45
        -- upvalues: u2 (ref)
        local v9, v10 = u2.CanRunCommands(game.Players.LocalPlayer, p8.Group);

        if not v9 then
            return v10;
        end;
    end, 1);
    CmdrClient:SetActivationKeys({ Enum.KeyCode.Semicolon, Enum.KeyCode.F2 });
    local TextChatCommands = TextChatService:WaitForChild("TextChatCommands");
    local TextChatCommand = Instance.new("TextChatCommand");
    TextChatCommand.PrimaryAlias = "/cmds";
    TextChatCommand.AutocompleteVisible = u2.CanRunCommands(game.Players.LocalPlayer, "Tester");
    TextChatCommand.Name = "OpenCmdr";
    TextChatCommand.Parent = TextChatCommands;
    TextChatCommand.Triggered:Connect(function() -- Line: 61
        -- upvalues: CmdrClient (ref)
        CmdrClient:Show();
    end);
end;

return u2;