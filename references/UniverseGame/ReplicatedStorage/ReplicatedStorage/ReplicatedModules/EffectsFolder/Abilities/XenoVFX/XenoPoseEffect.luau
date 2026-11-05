  

 

local _ = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
EffectsHandler.GetEffect("Emit Particle V3");

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local Attacker = p1.Attacker;

    if not (Attacker and Attacker:IsDescendantOf(workspace)) then
        return;
    end;

    local HumanoidRootPart = Attacker:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local function CloneVFX(p2) -- Line: 18
        local v3 = p2:Clone();
        v3.CanCollide = false;
        v3.Anchored = true;
        v3.CastShadow = false;

        return v3;
    end;

    local v4 = AssetHandler.GetAsset("PoseVFX", {
        AbilityName = "Xeno"
    });
    local v5 = v4.PoseTrails:Clone();
    v5.CanCollide = false;
    v5.Anchored = true;
    v5.CastShadow = false;
    ParticleHandler.EnableAllParticles(v5, true);
    v5.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -3, 0);
    v5.Parent = workspace.Effects;
    TweenService:Create(v5, TweenInfo.new(0.5833333333333334, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        CFrame = (v5.CFrame + Vector3.new(0, 8, 0)) * CFrame.Angles(0, -2.8797932657906435, 0)
    }):Play();
    task.wait(0.5833333333333334);
    v5:Destroy();
    local v6 = v4.XenoPose:Clone();
    v6.CanCollide = false;
    v6.Anchored = true;
    v6.CastShadow = false;
    v6.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -3, 0);
    v6.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(v6, true);

    local function Emit(p7, p8) -- Line: 48
        -- upvalues: ParticleHandler (ref)
        local v9 = p7:Clone();
        v9.CanCollide = false;
        v9.Anchored = true;
        v9.CastShadow = false;
        v9.CFrame = p8;
        v9.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v9);
        ParticleHandler.DestroyParticle(v9);
    end;

    local v10 = HumanoidRootPart.CFrame + Vector3.new(0, -3, 0);
    local v11 = v4.PoseStartEmit:Clone();
    v11.CanCollide = false;
    v11.Anchored = true;
    v11.CastShadow = false;
    v11.CFrame = v10;
    v11.Parent = workspace.Effects;
    ParticleHandler.EmitFromAttribute(v11);
    ParticleHandler.DestroyParticle(v11);
    local CFrame2 = HumanoidRootPart.CFrame;
    local v12 = v4.StandTorsoEffect:Clone();
    v12.CanCollide = false;
    v12.Anchored = true;
    v12.CastShadow = false;
    v12.CFrame = CFrame2;
    v12.Parent = workspace.Effects;
    ParticleHandler.EmitFromAttribute(v12);
    ParticleHandler.DestroyParticle(v12);
    local Stand = Attacker:FindFirstChild("Stand");

    if Stand and Stand:FindFirstChild("Stand Torso") then
        local CFrame3 = Stand["Stand Torso"].CFrame;
        local v13 = v4.StandTorsoEffect:Clone();
        v13.CanCollide = false;
        v13.Anchored = true;
        v13.CastShadow = false;
        v13.CFrame = CFrame3;
        v13.Parent = workspace.Effects;
        ParticleHandler.EmitFromAttribute(v13);
        ParticleHandler.DestroyParticle(v13);
    end;

    local v14 = {};

    for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
        local v15 = Attacker:FindFirstChild(v);

        if v15 then
            for _, child in v4.PoseAura:GetChildren() do
                local v16 = child:Clone();
                v16.Enabled = true;
                v16.Parent = v15;
                table.insert(v14, v16);
            end;
        end;
    end;

    while Attacker:GetAttribute("Posing") and Attacker.Parent do
        task.wait(0.1);
    end;

    ParticleHandler.EnableAllParticles(v6, false);
    ParticleHandler.DestroyParticle(v6);

    for _, v in v14 do
        ParticleHandler.DestroyParticle(v);
    end;

    table.clear(v14);
end;