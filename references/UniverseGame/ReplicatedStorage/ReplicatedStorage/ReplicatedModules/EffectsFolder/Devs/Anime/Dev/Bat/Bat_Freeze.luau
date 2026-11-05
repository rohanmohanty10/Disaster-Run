  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy)
    local v3 = {
        Position = p2.Position,
        Normal = p2.Normal
    };
    local Lifetime = p2.Lifetime;
    local u4 = AssetHandler.CloneAsset("Particles/FrozenArea", {
        AbilityName = "The Dark Knight"
    });
    u4.CFrame = CFrame.new(v3.Position, v3.Position + v3.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0);
    u4.Parent = workspace.Effects;
    local v5 = os.clock();
    local v6 = os.clock();

    while os.clock() - v5 <= Lifetime do
        local u7 = game.ReplicatedStorage["Client Assets"].Misc.IcePlatform:Clone();
        u7.Size = u7.Size * u1:NextNumber(1.6, 2);
        local Size = u7.Size;
        local v8 = u1:NextNumber(0, 0.3);
        u7.Size = Size + Vector3.new(0, v8, 0);
        local v9 = CFrame.new(v3.Position, v3.Position + v3.Normal);
        local Angles = CFrame.Angles;
        local v10 = math.random(-360, 360);
        u7.CFrame = v9 * Angles(-1.5707963267948966, math.rad(v10), 0);
        u7.CFrame = u7.CFrame * CFrame.new(u1:NextNumber(-8, 8), 0, u1:NextNumber(-8, 8));
        u7.Parent = workspace.Effects;
        local Size2 = u7.Size;
        u7.Size = Vector3.new(0, 0, 0);
        TweenService:Create(u7, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = Size2
        }):Play();
        task.delay(2.5, function() -- Line: 42
            -- upvalues: TweenService (ref), u7 (copy)
            local v11 = TweenService:Create(u7, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                Size = Vector3.new(0, 0, 0)
            });
            v11.Completed:Connect(function() -- Line: 46
                -- upvalues: u7 (ref)
                u7:Destroy();
            end);
            v11:Play();
        end);

        if os.clock() - v6 > Lifetime * 0.085 then
            task.spawn(function() -- Line: 53
                -- upvalues: AssetHandler (ref), u1 (ref), u4 (copy), EffectsHandler (ref), TweenService (ref)
                local v12 = AssetHandler.GetAsset("Particles/IceTrail", {
                    AbilityName = "The Dark Knight"
                }):Clone();
                local v13 = u1:NextNumber(1.03, 1.135);
                local v14 = u4.Size.X / 6 * v13 * u1:NextNumber(0.85, 1.25);
                local v15 = u1:NextNumber(-360, 360);
                local v16 = u1:NextNumber(-8, 8);
                local v17 = os.clock();
                local v18 = u1:NextNumber(1, 1.35);

                while v16 > -3 and v16 < 3 do
                    v16 = u1:NextNumber(-8, 8);
                end;

                local v19 = u1:NextNumber(-360, 360);
                local v20 = math.rad(v19);
                local v21 = u4.CFrame * CFrame.new(u1:NextNumber(-u4.Size.X / 2.25, u4.Size.X / 2.25), -u4.Size.Y / 2, u1:NextNumber(-u4.Size.Z / 2.25, u4.Size.Z / 2.25));
                local Angles2 = CFrame.Angles;
                local v22 = u1:NextNumber(-360, 360);
                local v23 = math.rad(v22);
                local v24 = u1:NextNumber(-360, 360);
                local v25 = math.rad(v24);
                local v26 = u1:NextNumber(-360, 360);
                local v27 = v21 * Angles2(v23, v25, (math.rad(v26)));
                local new = CFrame.new;
                local v28 = math.rad(v15);
                local v29 = math.cos(v28) * v14;
                local v30 = math.rad(v15);
                v12.CFrame = v27 * new(v29, 0, math.sin(v30) * v14);
                v12.Parent = workspace.Effects;
                task.delay(v18 + 1, v12.Destroy, v12);

                while v12:IsDescendantOf(game) and os.clock() - v17 <= v18 do
                    local v31 = EffectsHandler.Wait();
                    local v32 = TweenInfo.new(v31, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
                    local v33 = {};
                    local new2 = CFrame.new;
                    local v34 = math.rad(v15);
                    local v35 = math.cos(v34) * v14;
                    local v36 = math.rad(v15);
                    v33.CFrame = v27 * new2(v35, 0, math.sin(v36) * v14) * CFrame.Angles(0, v20, 0);
                    TweenService:Create(v12, v32, v33):Play();
                    v15 = v15 + v16;
                end;

                v12.Trail.Enabled = false;
            end);
        end;

        EffectsHandler.Wait(u1:NextNumber(0.07, 0.125));
    end;

    task.delay(ParticleHandler.EnableAllParticles(u4, false), u4.Destroy, u4);
end;