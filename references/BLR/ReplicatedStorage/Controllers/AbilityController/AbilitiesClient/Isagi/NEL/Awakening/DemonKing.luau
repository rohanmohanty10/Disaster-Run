  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

local function isPointInVolume(p1: vector, p2, p3: vector) -- Line: 18
    local v4 = p2:PointToObjectSpace(p1);
    local v5;

    if v4.X >= -p3.X / 2 and (v4.X <= p3.X / 2 and (v4.Y >= -p3.Y / 2 and (v4.Y <= p3.Y / 2 and v4.Z >= -p3.Z / 2))) then
        v5 = v4.Z <= p3.Z / 2;
    else
        v5 = false;
    end;

    return v5;
end;

return function(u6, p7, u8) -- Line: 28, Name: DemonKing
    -- upvalues: Popup (copy), ReplicatedStorage (copy), isPointInVolume (copy)
    if p7.PlayerStats.InAwakening.Value == false then
        return;
    end;

    if u6.AbilityOne > tick() then
        return;
    end;

    if u6.ABC then
        u6.ABC:Clean();
    end;

    if u8.Values.HasBall.Value then
        return Popup.Popup(p7, "You must not have the ball!");
    end;

    if u8.HumanoidRootPart.Anchored then
        return;
    end;

    local Value = ReplicatedStorage.Football.Value;

    if not Value then
        return;
    end;

    local v9 = { u8.HumanoidRootPart.CFrame * CFrame.new(0, 20, -6), Vector3.new(12, 24, 12) };

    if not (Value.Parent == workspace and not Value.OnPlayer.Value or u8.Values.HasBall.Value) then
        Popup.Popup(p7, "Ball must be directly above you!");
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.Neon;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CFrame = v9[1];
        Part.Size = v9[2];
        Part.Transparency = 0.9;
        Part.Parent = workspace.Debris;
        task.delay(0.2, Part.Destroy, Part);

        return;
    end;

    if not (u8.Values.HasBall.Value or isPointInVolume(Value.Position, v9[1], v9[2])) then
        Popup.Popup(p7, "Ball must be directly above you!");
        local Part = Instance.new("Part");
        Part.Anchored = true;
        Part.Color = Color3.fromRGB(255, 0, 0);
        Part.Material = Enum.Material.Neon;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CFrame = v9[1];
        Part.Size = v9[2];
        Part.Transparency = 0.9;
        Part.Parent = workspace.Debris;
        task.delay(0.2, Part.Destroy, Part);

        return;
    end;

    local Shiftlock = u6.Camera.Shiftlock;
    u6.Camera:SetShiftlock(false);
    u6.Camera.Cutscene = true;
    u6:AbilityCooldown("1", 70);
    u6.StatesController.States.Ability = true;
    u8.HumanoidRootPart.Anchored = true;
    u6.Animations:StopAnims();
    u6.Animations.Ball.DemonKingBall.Priority = Enum.AnimationPriority.Action4;
    u6.Animations.Ball.DemonKingBall:Play();
    u6.Animations.Abilities.DemonKing.Priority = Enum.AnimationPriority.Action4;
    u6.Animations.Abilities.DemonKing.Looped = false;
    u6.Animations.Abilities.DemonKing:Play();
    task.wait(0.1);
    u6.AbilityService.Ability:Fire("DemonKing");
    local Unit = (u8.HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit;
    u6.ABC:Connect(u6.AbilityService.Ability, function(p10) -- Line: 97
        -- upvalues: u6 (copy), Unit (copy)
        u6.ABC:Clean();
        p10.AssemblyLinearVelocity = (Unit + Vector3.new(0, 0.2, 0)) * 225;
        u6.BallController:DragBall(p10);
    end);
    task.delay(6.333333492279053, function() -- Line: 112
        -- upvalues: u6 (copy), u8 (copy), Shiftlock (copy)
        u6.Camera.Cutscene = false;
        u8.HumanoidRootPart.Anchored = false;
        u6.StatesController.States.Ability = false;
        u6.Camera:SetShiftlock(Shiftlock);
    end);
end;