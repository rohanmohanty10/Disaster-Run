  

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Trove);
local LocalPlayer = Players.LocalPlayer;

function u1.Awaken(u2) -- Line: 14
    -- upvalues: LocalPlayer (copy)
    if u2.Acknowledged then
        return;
    end;

    u2.Acknowledged = true;
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character then
        Character.Anchored = false;
    end;

    u2.Camera.Cutscene = true;
    task.delay(6.666666666666667, function() -- Line: 27
        -- upvalues: u2 (copy), LocalPlayer (ref)
        if u2.Destroyed then
            return;
        end;

        u2.Camera.Cutscene = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

            if PlayerGui then
                PlayerGui = PlayerGui:FindFirstChild("InGameUI");
            end;

            if PlayerGui then
                PlayerGui.Enabled = true;
            end;
        end;

        u2:Awakening();
    end);
end;

function u1.Awakening(u3) -- Line: 43
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("Values");
    end;

    if Character then
        Character = Character:FindFirstChild("InCutscene");
    end;

    if Character then
        Character.Value = false;
    end;

    u3.Trove:Connect(RunService.Heartbeat, function() -- Line: 51
        -- upvalues: LocalPlayer (ref), u3 (copy)
        local PlayerStats = LocalPlayer:FindFirstChild("PlayerStats");
        local v4;

        if PlayerStats then
            v4 = PlayerStats:FindFirstChild("AwakeningBar");
        else
            v4 = PlayerStats;
        end;

        if PlayerStats then
            PlayerStats = PlayerStats:FindFirstChild("InAwakening");
        end;

        if not (v4 and (v4.Value > 0 and (PlayerStats and (PlayerStats.Value and LocalPlayer.Team ~= game.Teams.Visitor)))) then
            u3:Destroy();
        end;
    end);
end;

function u1.Destroy(p5) -- Line: 66
    -- upvalues: LocalPlayer (copy)
    if p5.Destroyed then
        return;
    end;

    p5.Destroyed = true;

    if p5.Camera then
        p5.Camera.Cutscene = false;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character then
        Character.Anchored = false;
    end;

    if p5.Trove then
        p5.Trove:Destroy();
    end;
end;

function u1.new() -- Line: 86
    -- upvalues: u1 (copy), Trove (copy), Knit (copy), LocalPlayer (copy)
    local u6 = setmetatable({}, u1);
    u6.Trove = Trove.new();
    u6.Camera = Knit.GetController("CameraController");
    u6.AwakeningService = Knit.GetService("AwakeningService");
    local Character = LocalPlayer.Character;
    local u7;

    if Character then
        u7 = Character:FindFirstChild("HumanoidRootPart");
    else
        u7 = Character;
    end;

    if u7 then
        u7.Anchored = true;
    end;

    u6.Trove:Connect(u6.AwakeningService.StartAwakening, function() -- Line: 98
        -- upvalues: u6 (copy)
        u6:Awaken();
    end);
    u6.AwakeningService.StartAwakening:Fire();
    task.delay(3, function() -- Line: 103
        -- upvalues: u6 (copy), u7 (copy), Character (copy), LocalPlayer (ref)
        if u6.Acknowledged or u6.Destroyed then
            return;
        end;

        if u7 and u7.Parent == Character then
            u7.Anchored = false;
        end;

        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");

        if PlayerGui then
            PlayerGui = PlayerGui:FindFirstChild("InGameUI");
        end;

        if PlayerGui then
            PlayerGui.Enabled = true;
        end;

        u6:Destroy();
    end);

    return u6;
end;

return u1;