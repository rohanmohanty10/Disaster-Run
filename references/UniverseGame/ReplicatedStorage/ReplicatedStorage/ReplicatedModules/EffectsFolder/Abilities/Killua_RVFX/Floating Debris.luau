  

 

local Petal = _G.Petal;
local v1 = Petal("Util");
local Rng = Petal("Extensions").Rng;
local Raycast = v1.Raycast;
local TweenCallback = v1.TweenCallback;
script.Assets:FindFirstChild("Debris");
game:GetService("TweenService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p2) -- Line: 18
    -- upvalues: Rng (copy), Raycast (copy), AssetHandler (copy), ParticleHandler (copy), TweenCallback (copy)
    local OrigPos = p2.OrigPos;
    local v3 = p2.Spread or 5;
    local u4 = p2.Time or 0.5;
    local Character = p2.Character;

    for _ = 1, p2.Amount or 10 do
        local v5 = Rng(-v3, v3);
        local v6, u7 = Raycast(OrigPos + Vector3.new(v5, 0, Rng(-v3, v3)), Vector3.new(0, -15, 0), 15, { workspace.Effects });

        if v6 then
            task.spawn(function() -- Line: 31
                -- upvalues: AssetHandler (ref), Character (copy), ParticleHandler (ref), Rng (ref), u7 (copy), TweenCallback (ref), u4 (copy)
                local u8 = AssetHandler.CloneAsset("Particles/Killer\'s Instinct/DebrisTrail", AssetHandler.GetAbilityData(Character));

                if not u8 then
                    return;
                end;

                ParticleHandler.Unusualify(u8, {
                    Character = Character
                });
                local u9 = u8:GetDescendants();
                local v10 = Rng(1, 2);
                local v11 = Rng(1, 2);
                u8.Size = Vector3.new(v10, v11, Rng(1, 2)) / 4;
                u8.CFrame = CFrame.new(u7);
                u8.Parent = workspace.Effects;
                local new = CFrame.new;
                local Position = u8.Position;
                local v12 = Rng(5, 10);
                local v13 = new(Position + Vector3.new(0, v12, 0));
                local Angles = CFrame.Angles;
                local v14 = Rng(-180, 180);
                local v15 = math.rad(v14);
                local v16 = Rng(-180, 180);
                local v17 = math.rad(v16);
                local v18 = Rng(-180, 180);
                TweenCallback(u8, {
                    CFrame = v13 * Angles(v15, v17, (math.rad(v18)))
                }, function() -- Line: 44
                    -- upvalues: u8 (copy), u9 (copy), TweenCallback (ref), u4 (ref)
                    game:GetService("PhysicsService"):SetPartCollisionGroup(u8, "FX");
                    u8.CanCollide = true;
                    u8.Anchored = false;

                    for _, v in u9 do
                        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                            v.Enabled = false;
                        end;
                    end;

                    TweenCallback(u8, {
                        Transparency = 1
                    }, function() -- Line: 55
                        -- upvalues: u8 (ref)
                        u8:Destroy();
                    end, u4 / 2);
                end, u4);
            end);
        end;
    end;
end;