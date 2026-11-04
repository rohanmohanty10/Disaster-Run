  

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Trove);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
u1.__index = u1;

function u1.Destroy(p2) -- Line: 11
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), interface (copy)
    if p2.Destroyed then
        return;
    end;

    p2.Destroyed = true;
    p2.Trove:Destroy();

    if not (p2.Acknowledged or (LocalPlayer.Character ~= p2.Character or not (p2.Character and (p2.Character.Parent and not ReplicatedStorage.GameValues.AwakeningCutscene.Value)))) then
        local HumanoidRootPart = p2.Character:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart.Anchored = false;
        end;

        p2.Character.Values.InCutscene.Value = false;

        if LocalPlayer.Team ~= game.Teams.Visitor then
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;
    end;

    interface.ZantetsuBulletTrainCharges = nil;
end;

function u1.new() -- Line: 25
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (copy), Knit (copy), interface (copy)
    local v3 = {
        Trove = Trove.new(),
        Character = LocalPlayer.Character
    };
    local u4 = setmetatable(v3, u1);
    local Character = LocalPlayer.Character;
    local Service = Knit.GetService("AwakeningService");
    interface.ZantetsuBulletTrainCharges = 0;
    u4.Trove:Connect(Service.StartAwakening, function() -- Line: 30
        -- upvalues: u4 (copy)
        u4.Acknowledged = true;
    end);
    u4.Trove:Connect(LocalPlayer.PlayerStats.InAwakening.Changed, function(p5) -- Line: 34
        -- upvalues: u4 (copy)
        if not p5 then
            u4:Destroy();
        end;
    end);
    u4.Trove:Connect(LocalPlayer.PlayerStats.Style.Changed, function() -- Line: 37
        -- upvalues: LocalPlayer (ref), u4 (copy)
        if LocalPlayer.PlayerStats.Style.Value ~= "Zantetsu" then
            u4:Destroy();
        end;
    end);
    Service.StartAwakening:Fire();
    task.delay(3, function() -- Line: 41
        -- upvalues: u4 (copy), LocalPlayer (ref), Character (copy)
        if u4.Acknowledged or u4.Destroyed then
            return;
        end;

        if LocalPlayer.Character == Character and (Character and Character.Parent) then
            Character.HumanoidRootPart.Anchored = false;
            Character.Values.InCutscene.Value = false;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                LocalPlayer.PlayerGui.InGameUI.Enabled = true;
            end;
        end;

        u4:Destroy();
    end);

    return u4;
end;

return u1;