  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(u1, p2, u3, u4, u5, u6) -- Line: 9
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), Players (copy), ParticleHandler (copy)
    local u7 = typeof(p2) == "number" and (p2 or 0.5) or 0.5;
    local u8 = {};
    task.spawn(function() -- Line: 14
        -- upvalues: u1 (copy), AssetHandler (ref), u6 (copy), u5 (copy), EffectsHandler (ref), u4 (copy), u7 (ref), u3 (copy), u8 (copy)
        for i, v in u1 do
            local v9 = AssetHandler.CloneAsset("Particles/Spada/Spada", AssetHandler.GetAbilityData(u6));
            v9.CFrame = v;
            v9.Parent = workspace.Effects;

            if (i % 6 == 0 or i == 1) and u5 then
                local v10 = u5:Clone();
                v10.Parent = v9;
                v10:Play();
            end;

            EffectsHandler.CallEffect("Rock Trail", {
                Offset = 1,
                Amount = 2,
                Size = 2,
                Down = true,
                Origin = v * CFrame.new(0, 0.5, 2),
                LookVector = v.LookVector,
                Distance = u4,
                Duration = u7 + 2,
                DurationOffset = i * u3 + 0.1
            });
            task.delay(u7 + 5, v9.Destroy, v9);
            table.insert(u8, v9);
            task.wait(u3 or 0.005);
        end;
    end);
    task.delay(u7 + u3 * #u1, function() -- Line: 49
        -- upvalues: Players (ref), u6 (copy), u8 (copy), ParticleHandler (ref)
        local v11 = 0;
        local v12 = Players:GetPlayerFromCharacter(u6);

        if v12 and v12.Data.Skin:GetAttribute("UnusualHueId") then
            v11 = v11 + v12.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        for _, v in u8 do
            if v11 > 0 then
                ParticleHandler.HSVShiftParticles(v, {
                    HueShift = v11
                });
            end;

            ParticleHandler.EnableParticles(v, true);
            v.PreSpada1.Enabled = false;
            v.PreSpada2.Enabled = false;
            task.delay(0.45, ParticleHandler.EnableParticles, v, false);
        end;
    end);
end;