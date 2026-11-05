  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(p2, u3, p4) -- Line: 11
    -- upvalues: EffectsHandler (copy), u1 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    for i = 0, 7 do
        local v5 = u3:Lerp(u3 * CFrame.new(0, 0, -p4.Size.Z), i / 7);
        EffectsHandler.CallEffect("Rock Trail", {
            Amount = 1,
            Size = 2.5,
            Duration = 2,
            DurationOffset = 0.025,
            Down = true,
            Origin = v5,
            LookVector = u3.LookVector,
            Offset = p4.Size.X / 1.45 + i * 0.4,
            Distance = p4.Size.Z / 7
        });
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Vento/Explosion",
        AutoSerialize = true,
        Origin = u3 * p4.Offset * CFrame.new(0, 1.1, 0) * CFrame.Angles(0, 3.141592653589793, 0),
        Player = p2
    });
    local v6 = 0;

    if p2 and p2.Data.Skin:GetAttribute("UnusualHueId") then
        v6 = v6 + p2.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local v7 = math.random(2, 3);
    local v8 = 360 / v7;

    for i = 1, v7 do
        local v9 = u1:NextNumber(-v8 / 5, v8 / 5);
        local u10 = v8 * i + v9;
        local u11 = u1:NextNumber(-1, 1);
        local u12 = u1:NextNumber(-300, -250);
        local u13 = u1:NextNumber(30, 35);
        local u14 = AssetHandler.CloneAsset("Particles/Vento/Trail", AssetHandler.GetAbilityData(p2));
        local new = CFrame.new;
        local v15 = math.rad(u10);
        local v16 = math.cos(v15) * 8;
        local v17 = math.rad(u10);
        u14.CFrame = u3 * new(v16, math.sin(v17) * 8, -u11);
        u14.Parent = workspace.Effects;
        task.delay(3, u14.Destroy, u14);

        if v6 > 0 then
            ParticleHandler.HSVShiftParticles(u14, {
                HueShift = v6
            });
        end;

        local u18 = os.clock();
        local u19 = u1:NextNumber(0.55, 0.85);
        task.spawn(function() -- Line: 70
            -- upvalues: u10 (ref), u12 (copy), u11 (ref), u13 (copy), TweenService (ref), u14 (copy), u3 (copy), u18 (copy), u19 (copy)
            repeat
                local v20 = task.wait();
                math.rad(u10);
                u10 = u10 + v20 * u12;
                u11 = u11 + v20 * u13;
                local v21 = TweenInfo.new(v20, Enum.EasingStyle.Linear);
                local v22 = {};
                local new2 = CFrame.new;
                local v23 = math.rad(u10);
                local v24 = math.cos(v23) * 8;
                local v25 = math.rad(u10);
                v22.CFrame = u3 * new2(v24, math.sin(v25) * 8, -u11);
                TweenService:Create(u14, v21, v22):Play();
            until not u14:IsDescendantOf(game) or u19 < os.clock() - u18;

            if u14:IsDescendantOf(game) then
                for _, descendant in u14:GetDescendants() do
                    if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end;
        end);
    end;
end;