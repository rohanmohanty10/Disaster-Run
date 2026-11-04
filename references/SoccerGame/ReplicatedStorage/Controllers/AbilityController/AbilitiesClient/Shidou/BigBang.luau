  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local Popup = require(ReplicatedStorage.Shared.Popup);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

local function isPointInVolume(p1: vector, p2, p3: vector) -- Line: 15
    local v4 = p2:PointToObjectSpace(p1);
    local v5;

    if v4.X >= -p3.X / 2 and (v4.X <= p3.X / 2 and (v4.Y >= -p3.Y / 2 and (v4.Y <= p3.Y / 2 and v4.Z >= -p3.Z / 2))) then
        v5 = v4.Z <= p3.Z / 2;
    else
        v5 = false;
    end;

    return v5;
end;

local function showStartHitbox(p6, p7: vector) -- Line: 25
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.Color = Color3.fromRGB(255, 0, 0);
    Part.Material = Enum.Material.Neon;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CFrame = p6;
    Part.Size = p7;
    Part.Transparency = 0.9;
    Part.Parent = workspace.Debris;
    task.delay(0.2, Part.Destroy, Part);
end;

return function() -- Line: 40
    -- upvalues: AbilityBalancing (copy), LocalPlayer (copy), AbilityUtils (copy), ReplicatedStorage (copy), isPointInVolume (copy), Popup (copy), showStartHitbox (copy), interface (copy)
    local BigBang = AbilityBalancing.BigBang;
    local Character = LocalPlayer.Character;

    if not (Character and Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    if Character.HumanoidRootPart.Anchored then
        return;
    end;

    if Character.Values.IsInPenalty.Value then
        return;
    end;

    if not AbilityUtils.rules.slotReady(3) then
        return;
    end;

    if not AbilityUtils.rules.isAwakened(LocalPlayer, false) then
        return;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    local v8 = { Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, -6), Vector3.new(12, 24, 12) };

    if not Character.Values.HasBall.Value then
        local v9;

        if Value.Parent == workspace then
            v9 = not Value.OnPlayer.Value;
        else
            v9 = false;
        end;

        if not (v9 and isPointInVolume(Value.Position, v8[1], v8[2])) then
            Popup.Popup(LocalPlayer, "Ball must be directly above you!");
            showStartHitbox(v8[1], v8[2]);

            return;
        end;
    end;

    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, BigBang, 25, 3, true, LookVector);
end;