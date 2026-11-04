 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = game.Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.Effects);
local StatsSettings = require(ReplicatedStorage.Shared.Tables.StatsSettings);
local Icons = require(ReplicatedStorage.Shared.Tables.RankingBrackets).Icons;
local v3 = Knit.CreateController({
    Name = "Leaderboard"
});
local u4 = nil;

function v3.KnitStart(p5) -- Line: 22
    -- upvalues: u4 (ref), Knit (copy), LocalPlayer (copy), Icons (copy), StatsSettings (copy), UserInputService (copy)
    u4 = Knit.GetController("Network");
    local Leaderboard = LocalPlayer.PlayerGui.Leaderboard;

    local function clean(p6) -- Line: 27
        for _, child in p6:GetChildren() do
            if child:IsA("ImageLabel") then
                child:Destroy();
            end;
        end;
    end;

    local function updateTeam(u7) -- Line: 33
        -- upvalues: Leaderboard (copy)
        return function() -- Line: 34
            -- upvalues: Leaderboard (ref), u7 (copy)
            Leaderboard.BG.Teams[u7][`{u7}Team_Title`].Text.Text = game.Teams[u7]:GetAttribute("DisplayName"):upper();
        end;
    end;

    local u8 = "Home";
    game.Teams.Home:GetAttributeChangedSignal("DisplayName"):Connect(function() -- Line: 34
        -- upvalues: Leaderboard (copy), u8 (copy)
        Leaderboard.BG.Teams[u8][`{u8}Team_Title`].Text.Text = game.Teams[u8]:GetAttribute("DisplayName"):upper();
    end);
    local u9 = "Away";
    game.Teams.Away:GetAttributeChangedSignal("DisplayName"):Connect(function() -- Line: 34
        -- upvalues: Leaderboard (copy), u9 (copy)
        Leaderboard.BG.Teams[u9][`{u9}Team_Title`].Text.Text = game.Teams[u9]:GetAttribute("DisplayName"):upper();
    end);

    local function spawnIn(p10) -- Line: 42
        -- upvalues: Leaderboard (copy), u4 (ref), Icons (ref), StatsSettings (ref)
        for _, v in p10:GetPlayers() do
            local Frame = Leaderboard.BG.Teams[p10.Name].Frame;
            local u11;

            if u4.Gamemode == "Normal" then
                u11 = script[`{p10.Name}TeamPlayer`]:Clone();
            else
                u11 = script[`{p10.Name}TeamPlayer_Ranked`]:Clone();
            end;

            u11.PlrName.Text = v.Name;
            u11.Assists.Text = tostring(v.InMatch.Assists.Value);
            u11.Blocks.Text = tostring(v.InMatch.Blocks.Value);
            u11.Points.Text = tostring(v.InMatch.Points.Value);
            u11.Points3.Text = tostring(v.InMatch.Points3.Value);
            u11.AnkleBreakers.Text = tostring(v.InMatch.AnkleBreaks.Value);
            u11.MS.Text = tostring(v.Ping.Value);

            if u4.Gamemode ~= "Normal" then
                local function updateRankIcon(p12) -- Line: 56
                    -- upvalues: u11 (copy), Icons (ref)
                    local string_split_ret = string.split(p12, ",");
                    local v13 = string_split_ret[1];
                    local v14 = tonumber(string_split_ret[2]);

                    if v14 == nil then
                        u11.RankIcon.Image = Icons[v13];

                        return;
                    end;

                    u11.RankIcon.Image = Icons[v13][v14];
                end;

                local Attribute = v:GetAttribute("Rank");

                if Attribute then
                    local string_split_ret = string.split(Attribute, ",");
                    local v15 = string_split_ret[1];
                    local v16 = tonumber(string_split_ret[2]);

                    if v16 == nil then
                        u11.RankIcon.Image = Icons[v15];
                    else
                        u11.RankIcon.Image = Icons[v15][v16];
                    end;
                else
                    v:GetAttributeChangedSignal("Rank"):Once(function() -- Line: 70
                        -- upvalues: v (copy), u11 (copy), Icons (ref)
                        local Attribute2 = v:GetAttribute("Rank");
                        local string_split_ret = string.split(Attribute2, ",");
                        local v17 = string_split_ret[1];
                        local v18 = tonumber(string_split_ret[2]);

                        if v18 == nil then
                            u11.RankIcon.Image = Icons[v17];

                            return;
                        end;

                        u11.RankIcon.Image = Icons[v17][v18];
                    end);
                end;
            end;

            local v19 = v;
            local v20 = 0;

            for _, child in v.InMatch:GetChildren() do
                v20 = v20 + StatsSettings.InGamePoints[child.Name] * child.Value;
            end;

            u11.Total.Text = tostring(v20);

            for _, child in u11.MS_Icons:GetChildren() do
                child.Visible = false;
            end;

            if v19.Ping.Value < 80 then
                u11.MS_Icons.Good_Connection.Visible = true;
            elseif v19.Ping.Value < 135 then
                u11.MS_Icons.Average_Connection.Visible = true;
            elseif v19.Ping.Value < 200 then
                u11.MS_Icons.Bad_Connection.Visible = true;
            else
                u11.MS_Icons.Worst_Connection.Visible = true;
            end;

            u11.Parent = Frame;
        end;
    end;

    Leaderboard:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 103
        -- upvalues: clean (copy), Leaderboard (copy), spawnIn (copy)
        clean(Leaderboard.BG.Teams.Away.Frame);
        clean(Leaderboard.BG.Teams.Home.Frame);
        Leaderboard.BG.Teams.Home.HomeTeam_Title.UIGradient.Color = ColorSequence.new(game.Teams.Home:GetAttribute("Color"));
        Leaderboard.BG.Teams.Home.HomeTeam_Background.UIGradient.Color = ColorSequence.new(game.Teams.Home:GetAttribute("Color"));
        Leaderboard.BG.Teams.Away.AwayTeam_Title.UIGradient.Color = ColorSequence.new(game.Teams.Away:GetAttribute("Color"));
        Leaderboard.BG.Teams.Away.AwayTeam_Background.UIGradient.Color = ColorSequence.new(game.Teams.Away:GetAttribute("Color"));
        Leaderboard.BG.Teams.Home.HomeTeam_Title.Text.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, game.Teams.Home:GetAttribute("Color")), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
        Leaderboard.BG.Teams.Away.AwayTeam_Title.Text.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, game.Teams.Away:GetAttribute("Color")), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
        spawnIn(game.Teams.Home);
        spawnIn(game.Teams.Away);
    end);
    UserInputService.InputBegan:Connect(function(p21, p22) -- Line: 128
        -- upvalues: Leaderboard (copy)
        if p22 then
            return;
        end;

        if p21.KeyCode == Enum.KeyCode.Tab or p21.KeyCode == Enum.KeyCode.DPadDown then
            Leaderboard.Enabled = true;
        end;
    end);
    UserInputService.InputEnded:Connect(function(p23, p24) -- Line: 136
        -- upvalues: Leaderboard (copy)
        if p24 then
            return;
        end;

        if p23.KeyCode == Enum.KeyCode.Tab or p23.KeyCode == Enum.KeyCode.DPadDown then
            Leaderboard.Enabled = false;
        end;
    end);
end;

function v3.KnitInit(p25) -- Line: 145
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p26) -- Line: 146
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p26;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;