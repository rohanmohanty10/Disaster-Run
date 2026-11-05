  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: EffectsHandler (copy), u1 (copy), ParticleHandler (copy)
    local Torso = p2:FindFirstChild("Torso");
    local v3 = p2:GetChildren();
    local v4 = 0;
    local u5 = {};
    local u6 = script.Container:Clone();
    u6.Parent = workspace.Effects;
    task.spawn(function() -- Line: 24
        -- upvalues: EffectsHandler (ref), Torso (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Origin = Torso.CFrame,
            Particle = script.BloodExplosion
        });
    end);

    if p2:FindFirstChildWhichIsA("Shirt") then
        p2:FindFirstChildWhichIsA("Shirt"):Clone().Parent = u6;
    end;

    if p2:FindFirstChildWhichIsA("Pants") then
        p2:FindFirstChildWhichIsA("Pants"):Clone().Parent = u6;
    end;

    local v7 = p2:FindFirstChildWhichIsA("BodyColors") or {
        RightArmColor3 = Color3.fromRGB(255, 205, 144),
        LeftArmColor3 = Color3.fromRGB(255, 205, 144),
        RightLegColor3 = Color3.fromRGB(255, 205, 144),
        LeftLegColor3 = Color3.fromRGB(255, 205, 144)
    };

    for _, v in next, v3 do
        if v:IsA("BasePart") and (v.Name ~= "HumanoidRootPart" and (v.Name ~= "Head" and v.Name ~= "Torso")) then
            local v8 = v.Name ~= "Left Leg" and v7.RightLegColor3 or v7.LeftLegColor3;
            v.Transparency = 1;
            table.insert(u5, v);
            local v9 = u6:FindFirstChild(v.Name);

            if v9 then
                v9.Color = v8;
                v9.CFrame = v.CFrame;
                v9.CollisionGroup = "Ghosted";
                v9.CanCollide = true;
                v9.Transparency = 0;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = v9;
                v4 = v4 + 1;
                local AngularVelocity = Instance.new("AngularVelocity");
                AngularVelocity.Attachment0 = Attachment;
                AngularVelocity.MaxTorque = 10000;
                AngularVelocity.AngularVelocity = Vector3.new(0, 5000, 0);
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
                local v10 = math.sin(v4 * 2 * 3.141592653589793 / #v3);
                local v11 = math.cos(v4 * 2 * 3.141592653589793 / #v3);
                BodyVelocity.Velocity = Vector3.new(20, 20, 20) * Vector3.new(v10, 1, v11) * u1:NextNumber(0.1, 1);
                BodyVelocity.Parent = v9;
                task.delay(0.3, function() -- Line: 82
                    -- upvalues: AngularVelocity (copy), BodyVelocity (copy)
                    AngularVelocity:Destroy();
                    BodyVelocity:Destroy();
                end);
            end;
        end;
    end;

    task.delay(5, function() -- Line: 88
        -- upvalues: u5 (copy), u6 (copy), ParticleHandler (ref)
        for _, v in u5 do
            v.Transparency = 0;
        end;

        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                ParticleHandler.EnableAllParticles(descendant, false);
                game.TweenService:Create(descendant, TweenInfo.new(0.4), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(5, u6.Destroy, u6);
    end);
end;