  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);

return function(u1, u2, p3, p4) -- Line: 18, Name: DemonDrive
    -- upvalues: Players (copy), ReplicatedStorage (copy), AbilityBalancing (copy), TweenService (copy), RunService (copy)
    if u2:GetAttribute("CRRequest") == "DragonDriveCR" then
        local Attribute = u2:GetAttribute("CRRequestToken");
        local Attribute2 = u2:GetAttribute("CRSender");
        local v5;

        if typeof(Attribute2) == "number" then
            v5 = Players:GetPlayerByUserId(Attribute2) or nil;
        else
            v5 = nil;
        end;

        local v6;

        if v5 then
            v6 = v5:FindFirstChild("PlayerStats");
        end;

        if v6 then
            v6 = v6:FindFirstChild("Style");
        end;

        local v7;

        if v5 then
            v7 = v5.Character;
        end;

        local v8;

        if v7 then
            v8 = v7:FindFirstChildOfClass("Humanoid");
        else
            v8 = v7;
        end;

        local Value = ReplicatedStorage.Football.Value;

        if u2.Character == p3 and (typeof(Attribute) == "string" and (v5 and (v5 ~= u2 and (v5.Team == u2.Team and (v6 and (v6.Value == "Sae" and (v7 and (v8 and (v8.Health > 0 and (Value and (Value:IsDescendantOf(workspace) and (Value:FindFirstChild("OnPlayer") and not Value.OnPlayer.Value)))))))))))) then
            local v9 = u1.UngroupedAbilities and u1.UngroupedAbilities.DragonDriveCR;

            if v9 then
                v9(u1, u2, p3);
            end;
        end;

        return;
    end;

    if u1.AbilityTwo > tick() then
        return;
    end;

    if u1.ABC then
        u1.ABC:Clean();
    end;

    u1.InAbility = true;
    u1:AbilityCooldown("2", 45);
    u1.Animations:StopAnims();
    task.delay(0.78, function() -- Line: 65
        -- upvalues: u1 (copy)
        u1.ABC:Clean();
    end);
    u1.Animations.Abilities.ShidouDemonDrive.Priority = Enum.AnimationPriority.Action4;
    u1.Animations.Abilities.ShidouDemonDrive:Play();

    for _, child in pairs(p3.HumanoidRootPart:GetChildren()) do
        if child:IsA("BodyVelocity") or child:IsA("BodyGyro") then
            child:Destroy();
        end;
    end;

    u1.AbilityService.Ability:Fire("DemonDrive");

    for _, child in pairs(p3.HumanoidRootPart:GetChildren()) do
        if child:IsA("BodyVelocity") or child:IsA("BodyGyro") then
            child:Destroy();
        end;
    end;

    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Parent = u2.Character.HumanoidRootPart;
    BodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000);
    BodyVelocity.Velocity = u2.Character.HumanoidRootPart.CFrame.LookVector * AbilityBalancing.DemonDrive.Speed;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 1;
    task.delay(0.33, function() -- Line: 92
        -- upvalues: TweenService (ref), NumberValue (copy)
        TweenService:Create(NumberValue, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = 0.2
        }):Play();
    end);
    local u10 = nil;
    u10 = RunService.Heartbeat:Connect(function() -- Line: 95
        -- upvalues: u2 (copy), BodyVelocity (copy), AbilityBalancing (ref), NumberValue (copy), u10 (ref)
        if u2 and (u2.Character and (u2.Character:FindFirstChild("HumanoidRootPart") and BodyVelocity)) then
            BodyVelocity.Velocity = u2.Character.HumanoidRootPart.CFrame.LookVector * AbilityBalancing.DemonDrive.Speed * NumberValue.Value;

            return;
        end;

        u10:Disconnect();
        NumberValue:Destroy();
    end);
    task.delay(0.73, BodyVelocity.Destroy, BodyVelocity);
    u1.ABC:Add(function() -- Line: 109
        -- upvalues: u1 (copy)
        u1.InAbility = false;
    end);
end;