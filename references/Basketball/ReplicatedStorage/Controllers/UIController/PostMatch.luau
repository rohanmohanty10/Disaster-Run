 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.Effects);
local StatsSettings = require(ReplicatedStorage.Shared.Tables.StatsSettings);
local IsMatch = require(ReplicatedStorage.Shared.Functions.IsMatch);
local v3 = Knit.CreateController({
    Name = "PostMatch"
});
local u4 = nil;
local u5 = nil;
local u6 = {
    Points3 = 0,
    Points = 0,
    Blocks = 0,
    Assists = 0,
    AnkleBreaks = 0,
    Dunks = 0,
    Matches = 0
};

function v3.Stats(p7) -- Line: 36
    -- upvalues: u4 (ref), ReplicatedStorage (copy), LocalPlayer (copy), u6 (ref)
    local u8 = {};

    for i, v in u4.Player.Statistics do
        table.insert(u8, { i, v });
    end;

    ReplicatedStorage.Controllers.NewData:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 42
        -- upvalues: LocalPlayer (ref), u4 (ref), u8 (copy), u6 (ref)
        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        local v9 = false;

        for i, v in u4.Player.Statistics do
            local v10 = v;
            local v11 = i;

            for _, v2 in u8 do
                if v2[1] == v11 and v2[2] ~= v10 then
                    v9 = true;
                    break;
                end;
            end;
        end;

        if v9 then
            for i, _ in u4.Player.Statistics do
                local v12 = i;

                for _, v in u8 do
                    if v[1] == v12 then
                        local math_round_ret = math.round(u4.Player.Statistics[v12] - v[2]);

                        if u6[v12] then
                            local v13 = u6;
                            v13[v12] = v13[v12] + math_round_ret;
                        end;
                    end;
                end;
            end;

            table.clear(u8);

            for i, v in u4.Player.Statistics do
                table.insert(u8, { i, v });
            end;
        end;
    end);
end;

function v3.OVR(p14) -- Line: 75
    -- upvalues: LocalPlayer (copy), StatsSettings (copy), u4 (ref)
    local _ = LocalPlayer.PlayerGui.PostMatch;
    local v15 = 50;

    for i, v in StatsSettings.CalculateOVR do
        v15 = v15 + u4.Player.Statistics[i] / v.OnePoint / math.clamp((u4.Player.Statistics.Matches + 1) / 15, 1, v.MatchFactor);
    end;

    return math.ceil(v15 >= 100 and 100 or v15);
end;

function v3.UI(u16) -- Line: 91
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u5 (ref), IsMatch (copy), u4 (ref), TweenService (copy), u6 (ref), RunService (copy)
    local PostMatch = LocalPlayer.PlayerGui.PostMatch;
    local _ = ReplicatedStorage.GameValues.State;
    local _ = LocalPlayer.Team;

    local function Increase(u17, u18) -- Line: 98
        -- upvalues: PostMatch (copy)
        task.spawn(function() -- Line: 99
            -- upvalues: u18 (copy), PostMatch (ref), u17 (copy)
            local v19 = 0;

            for i = tonumber(u18), 1, -1 do
                task.wait(0.1 / i);

                if not PostMatch.Enabled then
                    break;
                end;

                v19 = v19 + 1;
                u17.Text = tostring(v19);
                local _ = i;
            end;

            u17.Text = u18;
        end);
    end;

    u5.EndMatch:Connect(function() -- Line: 113
        -- upvalues: IsMatch (ref), u4 (ref), ReplicatedStorage (ref), PostMatch (copy), LocalPlayer (ref), u16 (copy), TweenService (ref), u6 (ref), RunService (ref)
        if IsMatch(u4.Gamemode) then
            return;
        end;

        ReplicatedStorage.GameValues.State:GetPropertyChangedSignal("Value"):Once(function() -- Line: 115
            -- upvalues: PostMatch (ref), LocalPlayer (ref), u16 (ref), TweenService (ref), u4 (ref), u6 (ref), ReplicatedStorage (ref), RunService (ref)
            PostMatch.Enabled = true;
            LocalPlayer.PlayerGui.HUD.Enabled = false;
            task.spawn(function() -- Line: 119
                -- upvalues: u16 (ref), PostMatch (ref), TweenService (ref)
                local v20 = u16:OVR() or 50;
                local StatsText = PostMatch.BG.OVR.StatsText;
                local v21 = nil;
                local v22 = 0;

                for i = v20, 1, -1 do
                    task.wait(0.1 / i);

                    if v21 then
                        v21:Cancel();
                    end;

                    PostMatch.BG.OVR.UIScale.Scale = 1.2;
                    v21 = TweenService:Create(PostMatch.BG.OVR.UIScale, TweenInfo.new(0.2), {
                        Scale = 1
                    });
                    v21:Play();
                    v22 = math.ceil(v22 + 1);
                    StatsText.Text = tostring(v22);
                    local _ = i;
                end;

                StatsText.Text = math.ceil(v20);
                PostMatch.BG.OVR.UIScale.Scale = 1.4;
                TweenService:Create(PostMatch.BG.OVR.UIScale, TweenInfo.new(1), {
                    Scale = 1
                });
            end);
            local TotalStats = PostMatch.BG.TotalStats;
            local MatchStats = PostMatch.BG.MatchStats;
            local StatsText = TotalStats.GameStats.Points3.StatsText;
            local Points3 = u4.Player.Statistics.Points3;
            task.spawn(function() -- Line: 99
                -- upvalues: Points3 (copy), PostMatch (ref), StatsText (copy)
                local v23 = 0;

                for i = tonumber(Points3), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v23 = v23 + 1;
                    StatsText.Text = tostring(v23);
                    local _ = i;
                end;

                StatsText.Text = Points3;
            end);
            local StatsText2 = TotalStats.GameStats.Points.StatsText;
            local Points = u4.Player.Statistics.Points;
            task.spawn(function() -- Line: 99
                -- upvalues: Points (copy), PostMatch (ref), StatsText2 (copy)
                local v24 = 0;

                for i = tonumber(Points), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v24 = v24 + 1;
                    StatsText2.Text = tostring(v24);
                    local _ = i;
                end;

                StatsText2.Text = Points;
            end);
            local StatsText3 = TotalStats.GameStats.Dunks.StatsText;
            local Dunks = u4.Player.Statistics.Dunks;
            task.spawn(function() -- Line: 99
                -- upvalues: Dunks (copy), PostMatch (ref), StatsText3 (copy)
                local v25 = 0;

                for i = tonumber(Dunks), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v25 = v25 + 1;
                    StatsText3.Text = tostring(v25);
                    local _ = i;
                end;

                StatsText3.Text = Dunks;
            end);
            local StatsText4 = MatchStats.GameStats.Points.StatsText;
            local Points2 = u6.Points;
            task.spawn(function() -- Line: 99
                -- upvalues: Points2 (copy), PostMatch (ref), StatsText4 (copy)
                local v26 = 0;

                for i = tonumber(Points2), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v26 = v26 + 1;
                    StatsText4.Text = tostring(v26);
                    local _ = i;
                end;

                StatsText4.Text = Points2;
            end);
            local StatsText5 = MatchStats.GameStats.Assists.StatsText;
            local Assists = u6.Assists;
            task.spawn(function() -- Line: 99
                -- upvalues: Assists (copy), PostMatch (ref), StatsText5 (copy)
                local v27 = 0;

                for i = tonumber(Assists), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v27 = v27 + 1;
                    StatsText5.Text = tostring(v27);
                    local _ = i;
                end;

                StatsText5.Text = Assists;
            end);
            local StatsText6 = MatchStats.GameStats.AnkleBreaker.StatsText;
            local AnkleBreaks = u6.AnkleBreaks;
            task.spawn(function() -- Line: 99
                -- upvalues: AnkleBreaks (copy), PostMatch (ref), StatsText6 (copy)
                local v28 = 0;

                for i = tonumber(AnkleBreaks), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v28 = v28 + 1;
                    StatsText6.Text = tostring(v28);
                    local _ = i;
                end;

                StatsText6.Text = AnkleBreaks;
            end);
            local StatsText7 = MatchStats.GameStats.Blocks.StatsText;
            local Blocks = u6.Blocks;
            task.spawn(function() -- Line: 99
                -- upvalues: Blocks (copy), PostMatch (ref), StatsText7 (copy)
                local v29 = 0;

                for i = tonumber(Blocks), 1, -1 do
                    task.wait(0.1 / i);

                    if not PostMatch.Enabled then
                        break;
                    end;

                    v29 = v29 + 1;
                    StatsText7.Text = tostring(v29);
                    local _ = i;
                end;

                StatsText7.Text = Blocks;
            end);
            ReplicatedStorage.Assets.SFX.Base.PostMatch:Play();
            local u30 = nil;
            u30 = RunService.Heartbeat:Connect(function() -- Line: 158
                -- upvalues: PostMatch (ref), LocalPlayer (ref), u30 (ref), TweenService (ref), ReplicatedStorage (ref)
                if PostMatch.Enabled ~= false then
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
                    workspace.CurrentCamera.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -18) * CFrame.fromEulerAngles(0, 3.141592653589793, 0);

                    return;
                end;

                LocalPlayer.PlayerGui.HUD.Enabled = true;
                u30:Disconnect();
                TweenService:Create(ReplicatedStorage.Assets.SFX.Base.PostMatch, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                task.delay(0.25, function() -- Line: 164
                    -- upvalues: ReplicatedStorage (ref)
                    if ReplicatedStorage.Assets.SFX.Base.PostMatch.Volume <= 0.1 then
                        ReplicatedStorage.Assets.SFX.Base.PostMatch:Stop();
                    end;
                end);
            end);
        end);
    end);
    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() -- Line: 181
        -- upvalues: LocalPlayer (ref), u6 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            table.clear(u6);
            u6 = {
                Points3 = 0,
                Points = 0,
                Blocks = 0,
                Assists = 0,
                AnkleBreaks = 0,
                Dunks = 0,
                Matches = 0
            };
        end;
    end);

    for _, child in LocalPlayer.InMatch:GetChildren() do
        child.Changed:Connect(function() -- Line: 196
            -- upvalues: LocalPlayer (ref), u6 (ref), child (copy)
            if LocalPlayer.Team == game.Teams.Visitor then
                return;
            end;

            u6[child.Name] = child.Value;
        end);
        u6[child.Name] = child.Value;
    end;
end;

function v3.KnitStart(p31) -- Line: 204
    -- upvalues: u4 (ref), Knit (copy), u5 (ref)
    u4 = Knit.GetController("Network");
    u5 = Knit.GetService("MatchService");
    p31:UI();
end;

function v3.KnitInit(p32) -- Line: 211
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p33) -- Line: 212
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p33;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return v3;