  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
local TeamColors = require(ReplicatedStorage.Shared.TeamColors);
local v1 = Knit.CreateController({
    Name = "Spectator"
});

function v1.KnitInit(p2) -- Line: 15
    -- upvalues: Knit (copy)
    p2.UI = Knit.Player.PlayerGui:WaitForChild("Spectate").BG;
end;

function v1.Setup(u3) -- Line: 19
    -- upvalues: TeamColors (copy), ReplicatedStorage (copy), TweenService (copy), RunService (copy), Essentials (copy), Knit (copy)
    local function getTeamColor(p4: string) -- Line: 20
        -- upvalues: TeamColors (ref), ReplicatedStorage (ref)
        return TeamColors[p4][ReplicatedStorage.GameValues[p4 .. "Index"].Value];
    end;

    local function getPosition(p5: userdata, p6: string) -- Line: 24
        -- upvalues: ReplicatedStorage (ref)
        for _, child in ReplicatedStorage.Teams[`{p6}Team`]:GetChildren() do
            if child.Value == p5 then
                return child.Name;
            end;
        end;
    end;

    u3.SpectatorController.TargetChanged:Connect(function(p7: userdata?) -- Line: 32
        -- upvalues: u3 (copy), TeamColors (ref), ReplicatedStorage (ref)
        if p7 == nil then
            return;
        end;

        u3.UI.Spectating.DisplayName.Text = typeof(p7) ~= "Instance" and "Ball" or p7.DisplayName;
        local DisplayName = u3.UI.Spectating.DisplayName;
        local v8;

        if typeof(p7) == "Instance" then
            local Name = p7.Team.Name;
            v8 = TeamColors[Name][ReplicatedStorage.GameValues[Name .. "Index"].Value];
        else
            v8 = Color3.new(1, 1, 1);
        end;

        DisplayName.TextColor3 = v8;

        if typeof(p7) == "Instance" then
            u3.UI.Spectating.Username.Text = `@{p7.Name}`;
            local Name = p7.Team.Name;
            u3.UI.Spectating.Username.TextColor3 = TeamColors[Name][ReplicatedStorage.GameValues[Name .. "Index"].Value];
            u3.UI.Spectating.Username.Visible = true;
        else
            u3.UI.Spectating.Username.Visible = false;
        end;

        local _, _, v9 = u3.UI.Spectating.DisplayName.TextColor3:ToHSV();
        local UIStroke = u3.UI.Spectating.DisplayName.UIStroke;
        local v10;

        if v9 <= 0.5 then
            v10 = Color3.new(1, 1, 1);
        else
            v10 = Color3.new(0, 0, 0);
        end;

        UIStroke.Color = v10;
        local UIStroke2 = u3.UI.Spectating.Username.UIStroke;
        local v11;

        if v9 <= 0.5 then
            v11 = Color3.new(1, 1, 1);
        else
            v11 = Color3.new(0, 0, 0);
        end;

        UIStroke2.Color = v11;
    end);
    local u12 = {};

    local function handleNewPlayer(u13: userdata) -- Line: 53
        -- upvalues: ReplicatedStorage (ref), u3 (copy), u12 (copy)
        local v14 = ReplicatedStorage.Assets.UI.SpectatorPlayer:Clone();
        local TextLabel = v14.TextLabel;
        local DisplayName = u13.DisplayName;
        local v15 = nil;

        for _, child in ReplicatedStorage.Teams[`{u13.Team.Name}Team`]:GetChildren() do
            if child.Value == u13 then
                v15 = child.Name;
                break;
            end;
        end;

        TextLabel.Text = `{DisplayName} | {v15}`;
        v14.Activated:Connect(function() -- Line: 57
            -- upvalues: u3 (ref), u13 (copy)
            u3.SpectatorController:Spectate(u13);
        end);
        v14.Parent = u3.UI.List.Content.Teams[u13.Team.Name];
        u12[u13] = v14;
    end;

    local function handleRemovedPlayer(p16: userdata) -- Line: 66
        -- upvalues: u12 (copy)
        if u12[p16] ~= nil then
            u12[p16]:Destroy();
        end;
    end;

    u3.SpectatorController.TargetListUpdated:Connect(function(p17, p18) -- Line: 72
        -- upvalues: handleNewPlayer (copy), u12 (copy)
        if p17 == nil then
            if u12[p18] ~= nil then
                u12[p18]:Destroy();
            end;

            return;
        end;

        handleNewPlayer(p17);
    end);

    for _, v in u3.SpectatorController.SpectateTargets do
        if v ~= "Ball" then
            handleNewPlayer(v);
        end;
    end;

    u3.UI.List.Content.Ball.Activated:Connect(function() -- Line: 86
        -- upvalues: u3 (copy)
        u3.SpectatorController:Spectate("Ball");
    end);
    local u19 = true;
    u3.UI.List.ShowHide.Activated:Connect(function() -- Line: 91
        -- upvalues: u19 (ref), u3 (copy), TweenService (ref)
        u19 = not u19;
        local UDim2_fromScale_ret = UDim2.fromScale(1, u19 and 1 or 1 + u3.UI.List.Size.Y.Scale);
        TweenService:Create(u3.UI.List, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Position = UDim2_fromScale_ret
        }):Play();
        u3.UI.List.ShowHide.Rotation = u19 and 180 or 0;
        TweenService:Create(u3.UI.List.ShowHide, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Rotation = u19 and 0 or -180
        }):Play();
    end);
    u3.UI.Quit.Activated:Connect(function() -- Line: 107
        -- upvalues: u3 (copy)
        u3.SpectatorController:StopSpectating();
    end);

    local function updateTeamColor(p20: string) -- Line: 111
        -- upvalues: u3 (copy), TeamColors (ref), ReplicatedStorage (ref)
        local Scoreboard = u3.UI.Scoreboard;
        Scoreboard[p20].ImageColor3 = TeamColors[p20][ReplicatedStorage.GameValues[p20 .. "Index"].Value];
        Scoreboard[p20 .. "BG"].BackgroundColor3 = TeamColors[p20][ReplicatedStorage.GameValues[p20 .. "Index"].Value];
        Scoreboard["Logo" .. p20].ImageColor3 = TeamColors[p20][ReplicatedStorage.GameValues[p20 .. "Index"].Value];
        u3.UI.List.Content.Teams[p20].BackgroundColor3 = TeamColors[p20][ReplicatedStorage.GameValues[p20 .. "Index"].Value];

        if u3.SpectatorController.SpectatingTarget ~= nil and (u3.SpectatorController.SpectatingTarget ~= "Ball" and u3.SpectatorController.SpectatingTarget.Team.Name == p20) then
            u3.UI.Spectating.TextColor3 = TeamColors[p20][ReplicatedStorage.GameValues[p20 .. "Index"].Value];
        end;
    end;

    ReplicatedStorage.GameValues.HomeIndex.Changed:Connect(function() -- Line: 125
        -- upvalues: updateTeamColor (copy)
        updateTeamColor("Home");
    end);
    ReplicatedStorage.GameValues.AwayIndex.Changed:Connect(function() -- Line: 129
        -- upvalues: updateTeamColor (copy)
        updateTeamColor("Away");
    end);
    updateTeamColor("Home");
    updateTeamColor("Away");
    RunService.Heartbeat:Connect(function() -- Line: 136
        -- upvalues: u3 (copy), ReplicatedStorage (ref), Essentials (ref)
        local TextLabel = u3.UI.Scoreboard.Away.TextLabel;
        local math_round_ret = math.round(ReplicatedStorage.Goals.Away.Value);
        TextLabel.Text = tostring(math_round_ret);
        local TextLabel2 = u3.UI.Scoreboard.Home.TextLabel;
        local math_round_ret2 = math.round(ReplicatedStorage.Goals.Home.Value);
        TextLabel2.Text = tostring(math_round_ret2);
        u3.UI.Scoreboard.Timer.TextLabel.Text = Essentials:formatTime(ReplicatedStorage.GameValues.Timer.Value);
    end);
    local HUD = Knit.Player.PlayerGui:WaitForChild("HUD");
    HUD:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 145
        -- upvalues: HUD (copy), u3 (copy)
        if not (HUD.Enabled and u3.SpectatorController:Spectating()) then
            return;
        end;

        u3.SpectatorController:StopSpectating();
    end);
end;

function v1.KnitStart(p21) -- Line: 153
    -- upvalues: Knit (copy)
    p21.SpectatorController = Knit.GetController("SpectatorController");
    p21:Setup();
end;

return v1;