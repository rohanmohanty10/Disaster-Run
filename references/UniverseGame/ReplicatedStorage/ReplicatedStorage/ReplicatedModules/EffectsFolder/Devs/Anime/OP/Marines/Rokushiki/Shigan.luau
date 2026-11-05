  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
Random.new();

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (ref), TweenService (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local StartPos = v3.StartPos;
    local EndPos = v3.EndPos;

    if not (Character and (StartPos and EndPos)) then
        return;
    end;

    local v4 = AssetHandler.GetAbilityData(v3.Player);
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = (StartPos.Position - EndPos.Position).Magnitude;
    local v5 = AssetHandler.CloneAsset("Particles/Shigan/Pierce", v4);
    v5.CFrame = HumanoidRootPart.CFrame;
    v5.Parent = workspace.Effects;
    ParticleHandler.AttachTo(v5, {
        Part = HumanoidRootPart
    });
    ParticleHandler.Emit(v5, ParticleHandler.GenerateEmitInfo(v5));
    ParticleHandler.DestroyEmit(v5);
    u1.Wait(0.05);
    local v6 = AssetHandler.CloneAsset("Particles/Shigan/PierceMesh", v4);
    v6.CFrame = HumanoidRootPart.CFrame;
    v6.Parent = workspace.Effects;
    TweenService:Create(v6, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Position = (v6.CFrame * CFrame.new(0, 0, -(EndPos.Position - HumanoidRootPart.Position).Magnitude * 1.4)).Position
    }):Play();
    TweenService:Create(v6, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Orientation = v6.Orientation + Vector3.new(0, 0, 70)
    }):Play();
    TweenService:Create(v6.Mesh, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Scale = v6.Mesh.Scale * Vector3.new(2.86, 2.86, 1.85)
    }):Play();
    TweenService:Create(v6.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    task.delay(1, v6.Destroy, v6);
    local u7 = AssetHandler.CloneAsset("Particles/Shigan/Rotate", v4);
    u7.CFrame = HumanoidRootPart.CFrame;
    u7.Parent = workspace.Effects;
    local v8 = TweenService:Create(u7, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Position = (u7.CFrame * CFrame.new(0, 0, -(EndPos.Position - HumanoidRootPart.Position).Magnitude * 1.6)).Position,
        Orientation = u7.Orientation + Vector3.new(0, 0, 180)
    });
    v8:Play();
    v8.Completed:Connect(function() -- Line: 85
        -- upvalues: ParticleHandler (ref), u7 (copy)
        ParticleHandler.EnableAllParticles(u7, false);
        task.delay(2, u7.Destroy, u7);
    end);
    local v9 = AssetHandler.CloneAsset("Particles/Shigan/Forward", v4);
    v9.Parent = workspace.Effects;
    task.delay(4, v9.Destroy, v9);
    v9:PivotTo(HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
    TweenService:Create(v9.PrimaryPart, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        CFrame = v9.PrimaryPart.CFrame * CFrame.new(0, -6, 0)
    }):Play();
    TweenService:Create(v9.Shock, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();

    for _, descendant in v9.Ground:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
        elseif descendant:IsA("Beam") then
            u1.CallEffect("Boat Tween", descendant, {
                Time = 0.4,
                EasingStyle = "ExitExpressive",
                EasingDirection = "Out",
                StepType = "Stepped",
                Goal = {
                    Transparency = NumberSequence.new(1)
                }
            });
        end;
    end;
end;