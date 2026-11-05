  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");
local u2 = Random.new();

local function AddEffects(p3, p4) -- Line: 15
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v5 = p4 or {};
    local v6 = AssetHandler.GetAsset("Particles/DebrisLift", v5):Clone();
    ParticleHandler.Unusualify(v6, {
        Character = v5.Character
    });
    v6.CFrame = p3.CFrame;
    v6.Parent = p3;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p3;
    WeldConstraint.Part1 = v6;
    WeldConstraint.Parent = v6;
    u1({
        Enabled = true,
        Clone = false,
        Destroy = false,
        Parent = false,
        Character = v5.Character,
        Particle = v6,
        SkinName = v5.SkinName
    });
    v6.Parent = p3;
end;

local function RemoveEffects(p7) -- Line: 40
    for _, descendant in pairs(p7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;
end;

return function(u8, u9, u10, p11, p12) -- Line: 48
    -- upvalues: u2 (copy), AddEffects (copy), RemoveEffects (copy)
    local u13 = p12 or {};

    for _ = 1, p11 do
        task.spawn(function() -- Line: 51
            -- upvalues: u8 (copy), u2 (ref), u9 (copy), AddEffects (ref), u13 (ref), u10 (copy), RemoveEffects (ref)
            local Angles = CFrame.Angles;
            local v14 = u2:NextNumber(-360, 360);
            local v15 = u8 * Angles(0, math.rad(v14), 0) * CFrame.new(0, 0, -u2:NextNumber(0, u9));
            local v16 = RaycastParams.new();
            v16.FilterType = Enum.RaycastFilterType.Whitelist;
            v16.FilterDescendantsInstances = { workspace.Map };
            local v17 = workspace:Raycast(v15.Position, Vector3.new(0, -8, 0), v16);

            if not (v17 and v17.Instance) then
                return;
            end;

            local Part = Instance.new("Part");
            local v18 = u2:NextNumber(0.5, 1.5);
            local v19 = u2:NextNumber(0.5, 1.5);
            Part.Size = Vector3.new(v18, v19, u2:NextNumber(0.5, 1.5));
            local v20 = CFrame.new(v17.Position);
            local Angles2 = CFrame.Angles;
            local v21 = u2:NextNumber(-360, 360);
            local v22 = math.rad(v21);
            local v23 = u2:NextNumber(-360, 360);
            local v24 = math.rad(v23);
            local v25 = u2:NextNumber(-360, 360);
            Part.CFrame = v20 * Angles2(v22, v24, (math.rad(v25)));
            Part.Color = v17.Instance.Color;
            Part.Material = v17.Instance.Material;
            Part.Transparency = v17.Instance.Transparency;
            Part.CanCollide = false;
            Part.Parent = workspace.Effects;
            game:GetService("PhysicsService"):SetPartCollisionGroup(Part, "FX");
            AddEffects(Part, u13);
            local BodyPosition = Instance.new("BodyPosition");
            BodyPosition.Name = "KnockbackPosition";
            BodyPosition.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyPosition.D = u2:NextNumber(750, 1750);
            local Position = Part.Position;
            local v26 = u2:NextNumber(1, 14);
            BodyPosition.Position = Position + Vector3.new(0, v26, 0);
            BodyPosition.Parent = Part;
            local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
            BodyAngularVelocity.MaxTorque = Vector3.new(100000, 100000, 100000);
            local v27 = u2:NextNumber(-7.5, 7.5);
            local v28 = u2:NextNumber(-7.5, 7.5);
            BodyAngularVelocity.AngularVelocity = Vector3.new(v27, v28, u2:NextNumber(-7.5, 7.5));
            BodyAngularVelocity.Parent = Part;
            task.wait(u10);
            RemoveEffects(Part);
            BodyPosition:Destroy();
            BodyAngularVelocity:Destroy();
            Part.CanCollide = true;
            task.wait(5);
            game:GetService("TweenService"):Create(Part, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
            task.wait(5);
            Part:Destroy();
        end);
    end;
end;