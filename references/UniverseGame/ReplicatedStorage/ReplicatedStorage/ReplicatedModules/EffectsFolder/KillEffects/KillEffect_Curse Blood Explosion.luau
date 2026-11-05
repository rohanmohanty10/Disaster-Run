  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Petal = _G.Petal;
local u1 = Petal("New");
local v2 = Petal("Util");
local u3 = Petal("Extensions");
local Tween = v2.Tween;

return function(p4) -- Line: 15
    -- upvalues: u1 (copy), u3 (copy), Tween (copy), EffectsHandler (copy)
    local TargetCharacter = p4.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Parent = TargetCharacter;

    local function CreateCysts(p5, p6) -- Line: 32
        -- upvalues: u1 (ref), u3 (ref), Folder (copy), Tween (ref)
        for _ = 1, p6 or 3 do
            local v7 = u1("Part")({
                Size = Vector3.new(0, 0, 0),
                CanCollide = false,
                CanQuery = false,
                Anchored = false,
                Massless = true,
                Shape = Enum.PartType.Ball,
                Color = p5.Color,
                Material = Enum.Material.SmoothPlastic
            });
            u1("Weld")({
                Name = "CystWeld",
                Part0 = p5,
                Part1 = v7,
                Parent = v7,
                C0 = CFrame.new(u3.Rng(-p5.Size.X / 2, p5.Size.X / 2), u3.Rng(-p5.Size.Y / 2, p5.Size.Y / 2), u3.Rng(-p5.Size.Z / 2, p5.Size.Z / 2))
            });
            v7.Parent = Folder;
            v7.Name = "Cyst";
            Tween(v7, u3.Rng(0.4, 1.5), "Quad", "Out", {
                Size = Vector3.new(1, 1, 1) * u3.Rng(0.4, 0.7)
            });
        end;
    end;

    local u8 = { "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" };

    for _, child in TargetCharacter:GetChildren() do
        if table.find(u8, child.Name) then
            CreateCysts(child, math.random(3, 7));
        end;
    end;

    task.delay(1.25, function() -- Line: 73
        -- upvalues: TargetCharacter (copy), u8 (copy), EffectsHandler (ref), HumanoidRootPart (copy), u1 (ref), u3 (ref)
        if not (TargetCharacter.Parent and TargetCharacter.Torso) then
            return;
        end;

        for _, child in TargetCharacter.Torso:GetChildren() do
            if child:IsA("JointInstance") and (table.find(u8, child.Part0 and (child.Part0.Name or "") or "") or table.find(u8, child.Part1 and (child.Part1.Name or "") or "")) then
                child:Destroy();
            end;
        end;

        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Curse Blood Explosion/CurseExplosionBlood",
            AbilityName = "KillEffects",
            Scale = 1.7,
            Origin = HumanoidRootPart.CFrame,
            Offset = CFrame.identity
        });

        for _, child in TargetCharacter:GetChildren() do
            if table.find(u8, child.Name) then
                local v9 = u1("BodyVelocity")({
                    Name = "Velocity"
                });
                local v10 = u3.Rng(-35, 35);
                local v11 = u3.Rng(-35, 35);
                v9.Velocity = Vector3.new(v10, v11, u3.Rng(-35, 35));
                v9.MaxForce = Vector3.new(10000, 10000, 10000);
                v9.Parent = child;
                task.delay(u3.Rng(0.1, 0.2), v9.Destroy, v9);
                child.CanCollide = true;
            end;
        end;
    end);
    task.delay(1.5, Folder.Destroy, Folder);
end;