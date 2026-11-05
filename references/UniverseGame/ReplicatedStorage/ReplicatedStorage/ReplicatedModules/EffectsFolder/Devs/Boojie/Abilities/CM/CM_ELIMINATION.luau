  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function CreateEffect(u2, u3) -- Line: 14
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    return function(p4, p5) -- Line: 15
        -- upvalues: AssetHandler (ref), u2 (copy), u3 (copy), ParticleHandler (ref), u1 (ref)
        local v6 = p5 or {};
        local HumanoidRootPart = p4:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return;
        end;

        local v7 = AssetHandler.GetAsset(`Particles/{u2}`, v6):Clone();
        v7.CFrame = HumanoidRootPart.CFrame * u3;
        ParticleHandler.Unusualify(v7, {
            Character = p4
        });
        v7.Parent = workspace.Effects;
        u1({
            Clone = false,
            Destroy = false,
            Parent = false,
            Particle = v7,
            SkinName = v6.SkinName
        });
        task.delay(3, v7.Destroy, v7);
    end;
end;

local u8 = {};
local u9 = CFrame.new(0, 6, -5) * CFrame.Angles(-1.5707963267948966, 0, 0);
local u10 = "UltimateTouch";

u8[1] = function(p11, p12) -- Line: 15
    -- upvalues: AssetHandler (copy), u10 (copy), u9 (copy), ParticleHandler (copy), u1 (copy)
    local v13 = p12 or {};
    local HumanoidRootPart = p11:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v14 = AssetHandler.GetAsset(`Particles/{u10}`, v13):Clone();
    v14.CFrame = HumanoidRootPart.CFrame * u9;
    ParticleHandler.Unusualify(v14, {
        Character = p11
    });
    v14.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v14,
        SkinName = v13.SkinName
    });
    task.delay(3, v14.Destroy, v14);
end;

local u15 = CFrame.new(0, -2.3, -5.5) * CFrame.Angles(1.5707963267948966, 0, 0);
local u16 = "UltimateInversion";

u8[2] = function(p17, p18) -- Line: 15
    -- upvalues: AssetHandler (copy), u16 (copy), u15 (copy), ParticleHandler (copy), u1 (copy)
    local v19 = p18 or {};
    local HumanoidRootPart = p17:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v20 = AssetHandler.GetAsset(`Particles/{u16}`, v19):Clone();
    v20.CFrame = HumanoidRootPart.CFrame * u15;
    ParticleHandler.Unusualify(v20, {
        Character = p17
    });
    v20.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v20,
        SkinName = v19.SkinName
    });
    task.delay(3, v20.Destroy, v20);
end;

local u21 = CFrame.new(0, 0, -8.5) * CFrame.Angles(0, 3.141592653589793, 0);
local u22 = "Pull";

u8[3] = function(p23, p24) -- Line: 15
    -- upvalues: AssetHandler (copy), u22 (copy), u21 (copy), ParticleHandler (copy), u1 (copy)
    local v25 = p24 or {};
    local HumanoidRootPart = p23:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v26 = AssetHandler.GetAsset(`Particles/{u22}`, v25):Clone();
    v26.CFrame = HumanoidRootPart.CFrame * u21;
    ParticleHandler.Unusualify(v26, {
        Character = p23
    });
    v26.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v26,
        SkinName = v25.SkinName
    });
    task.delay(3, v26.Destroy, v26);
end;

u8[4] = function(p27, p28, p29) -- Line: 42
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v30 = p29 or {};

    if not p27:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if not p28 then
        local PullHand = p27:FindFirstChild("PullHand");

        if PullHand then
            PullHand.Name = "PullHandOff";

            for _, descendant in pairs(PullHand:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            task.delay(2.5, function() -- Line: 78
                -- upvalues: PullHand (copy)
                PullHand:Destroy();
            end);
        end;

        return;
    end;

    local v31 = AssetHandler.GetAsset("Particles/PullHand", v30):Clone();
    v31.CFrame = p27["Right Arm"].CFrame;
    ParticleHandler.Unusualify(v31, {
        Character = p27
    });
    v31.Parent = p27;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p27["Right Arm"];
    WeldConstraint.Part1 = v31;
    WeldConstraint.Parent = v31;
    u1({
        Enabled = true,
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v31,
        SkinName = v30.SkinName
    });
    v31.Parent = p27;
end;

local u32 = CFrame.new(0.5, 0.96, -5.5);
local u33 = "SlowMoHitVFX";

u8[5] = function(p34, p35) -- Line: 15
    -- upvalues: AssetHandler (copy), u33 (copy), u32 (copy), ParticleHandler (copy), u1 (copy)
    local v36 = p35 or {};
    local HumanoidRootPart = p34:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v37 = AssetHandler.GetAsset(`Particles/{u33}`, v36):Clone();
    v37.CFrame = HumanoidRootPart.CFrame * u32;
    ParticleHandler.Unusualify(v37, {
        Character = p34
    });
    v37.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v37,
        SkinName = v36.SkinName
    });
    task.delay(3, v37.Destroy, v37);
end;

local u38 = CFrame.new(0, -2.8, -9.8) * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
local u39 = "AirEffects";

u8[6] = function(p40, p41) -- Line: 15
    -- upvalues: AssetHandler (copy), u39 (copy), u38 (copy), ParticleHandler (copy), u1 (copy)
    local v42 = p41 or {};
    local HumanoidRootPart = p40:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v43 = AssetHandler.GetAsset(`Particles/{u39}`, v42):Clone();
    v43.CFrame = HumanoidRootPart.CFrame * u38;
    ParticleHandler.Unusualify(v43, {
        Character = p40
    });
    v43.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v43,
        SkinName = v42.SkinName
    });
    task.delay(3, v43.Destroy, v43);
end;

local u44 = CFrame.new(0.45, 6.2, -11.8) * CFrame.Angles(0.3490658503988659, 0, -1.5707963267948966);
local u45 = "LastPunchAirVFX";

u8[7] = function(p46, p47) -- Line: 15
    -- upvalues: AssetHandler (copy), u45 (copy), u44 (copy), ParticleHandler (copy), u1 (copy)
    local v48 = p47 or {};
    local HumanoidRootPart = p46:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v49 = AssetHandler.GetAsset(`Particles/{u45}`, v48):Clone();
    v49.CFrame = HumanoidRootPart.CFrame * u44;
    ParticleHandler.Unusualify(v49, {
        Character = p46
    });
    v49.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = v49,
        SkinName = v48.SkinName
    });
    task.delay(3, v49.Destroy, v49);
end;

return function(p50, ...) -- Line: 89
    -- upvalues: u8 (copy)
    if u8[p50] then
        u8[p50](...);
    end;
end;