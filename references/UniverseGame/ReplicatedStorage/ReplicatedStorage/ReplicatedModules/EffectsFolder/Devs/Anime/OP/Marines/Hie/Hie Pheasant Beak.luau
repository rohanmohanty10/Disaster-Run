  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 21
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), u2 (copy), ParticleHandler (copy), u1 (copy), TweenService (copy)
    local v4 = p3 or {};
    local CosmeticBullet = v4.CosmeticBullet;
    local Character = v4.Character;

    if CosmeticBullet and CosmeticBullet:GetAttribute("Inactive") then
        return;
    end;

    local v5 = AssetHandler.GetAbilityData(Character);
    task.spawn(EffectsHandler.CallEffect, "Hie Ice Trail", CosmeticBullet.PrimaryPart, {
        Scalar = 1.3,
        MinDistance = 5,
        Character = Character
    });
    local v6 = AssetHandler.CloneAsset("Particles/Pheasant/GroundRaycast", v5);
    v6.CFrame = CosmeticBullet.PrimaryPart.CFrame;
    v6.Parent = workspace.Effects;
    local _ = CosmeticBullet.PrimaryPart.CFrame;

    while true do
        local v7 = workspace:Raycast(CosmeticBullet.PrimaryPart.Position, Vector3.new(0, -100, 0), u2);
        local CFrame2 = CosmeticBullet.PrimaryPart.CFrame;

        if v7 then
            local Unit = CFrame2.LookVector:Cross(v7.Normal).Unit;
            v6.CFrame = CFrame.fromMatrix(v7.Position, Unit, v7.Normal, Unit:Cross(v7.Normal).Unit);
        end;

        ParticleHandler.EnableAllParticles(v6, v7 ~= nil);
        task.wait(0.1);

        if not CosmeticBullet:IsDescendantOf(game) or CosmeticBullet:GetAttribute("Inactive") then
            ParticleHandler.EnableAllParticles(v6, false);
            ParticleHandler.DestroyEmit(v6);
            local v8 = NumberRange.new(1, 3);
            local v9 = NumberRange.new(-20, 20);
            local v10 = NumberRange.new(7, 33);

            for _ = 1, 8 do
                local Part = Instance.new("Part");
                Part.CFrame = CFrame2;
                Part.Transparency = 0;
                local v11 = u1:NextNumber(-180, 180);
                local v12 = u1:NextNumber(-180, 180);
                Part.Orientation = Vector3.new(v11, v12, u1:NextNumber(-180, 180));
                local v13 = u1:NextNumber(v8.Min, v8.Max);
                local v14 = u1:NextNumber(v8.Min, v8.Max);
                Part.Size = Vector3.new(v13, v14, u1:NextNumber(v8.Min, v8.Max));
                Part.Anchored = false;
                Part.CanCollide = true;
                Part.CollisionGroup = "Ghosted";
                Part.Massless = true;
                Part.Color = Color3.fromRGB(102, 163, 255);
                Part.Material = Enum.Material.Ice;
                Part.Parent = workspace.Effects;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = Part;
                local BodyAngularVelocity = Instance.new("BodyAngularVelocity");
                BodyAngularVelocity.MaxTorque = Vector3.new(1000000, 1000000, 1000000);
                local v15 = u1:NextNumber(-10, 10);
                local v16 = u1:NextNumber(-10, 10);
                BodyAngularVelocity.AngularVelocity = Vector3.new(v15, v16, u1:NextNumber(-10, 10));
                BodyAngularVelocity.Parent = Part;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                local v17 = u1:NextNumber(v9.Min, v9.Max);
                local v18 = u1:NextNumber(v10.Min, v10.Max);
                LinearVelocity.VectorVelocity = Vector3.new(v17, v18, u1:NextNumber(v9.Min, v9.Max));
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.Parent = Attachment;
                task.delay(0.2, BodyAngularVelocity.Destroy, BodyAngularVelocity);
                task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
                task.delay(0.4, function() -- Line: 100
                    -- upvalues: TweenService (ref), Part (copy)
                    TweenService:Create(Part, TweenInfo.new(1), {
                        Size = Vector3.new(0, 0, 0)
                    }):Play();
                    task.delay(1, Part.Destroy, Part);
                end);
            end;

            return;
        end;
    end;
end;