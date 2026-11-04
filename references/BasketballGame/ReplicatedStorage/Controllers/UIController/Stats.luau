 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.Effects);
local StatsSettings = require(ReplicatedStorage.Shared.Tables.StatsSettings);
local v3 = Knit.CreateController({
    Name = "StatsController"
});
local u4 = nil;
local u5 = {
    Points3 = "3 Pointers",
    Points = "Points",
    Blocks = "Blocks",
    Assists = "Assists",
    AnkleBreaks = "Ankle Breakers",
    Dunks = "Dunks",
    Matches = "Matches Played",
    MVP = "MVP"
};

function v3.KnitStart(p6) -- Line: 34
    -- upvalues: u4 (ref), Knit (copy), LocalPlayer (copy), u5 (copy), StatsSettings (copy)
    u4 = Knit.GetController("Network");
    local BG = LocalPlayer.PlayerGui.Stats.BG;
    local u7 = 50;
    BG.Player.Nickname.Text = LocalPlayer.Name;
    BG.Ranking.OVR.Text = tostring(u7);
    BG.PlayerIcon.Image = `rbxthumb://type=AvatarHeadShot&id={LocalPlayer.UserId}&w=420&h=420`;

    for i, v in u4.Player.Statistics do
        local v8 = script.Stat:Clone();
        v8.Value.Text = v;
        v8.StatName.Text = u5[i];
        v8.Name = i;
        v8.Parent = BG.Content;
    end;

    BG.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 53
        -- upvalues: u7 (ref), StatsSettings (ref), u4 (ref), BG (copy)
        u7 = 50;

        for i, v in StatsSettings.CalculateOVR do
            local v9 = u4.Player.Statistics[i];
            BG.Content[i].Value.Text = u4.Player.Statistics[i];
            u7 = u7 + v9 / v.OnePoint / math.clamp((u4.Player.Statistics.Matches + 1) / 15, 1, v.MatchFactor);
        end;

        if u7 >= 100 then
            u7 = 100;
        end;

        BG.Content.Matches.Value.Text = u4.Player.Statistics.Matches;
        u7 = math.ceil(u7);
        BG.Ranking.OVR.Text = tostring(u7);
    end);
end;

function v3.KnitInit(p10) -- Line: 74
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p11) -- Line: 75
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p11;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;