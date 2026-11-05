  

 

local _ = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local wait = task.wait;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.Classes.Sequence_V2);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 13
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (copy), wait (copy)
    local v5 = AssetHandler.GetAsset("ProjectileHoleOrb", p4);
    local u6 = AssetHandler.GetAsset("SigilExplosion", p4);
    local u7 = p4.HueShift and {
        HueShift = p4.HueShift
    } or nil;
    local v8 = Random.new();
    local v9 = {};

    for _ = 1, p3 do
        local u10 = p2 * CFrame.new(v8:NextNumber(-10, 10), v8:NextNumber(0, 5), v8:NextNumber(-10, 10));
        local u11 = v5:Clone();
        u11.Anchored = true;
        u11.CFrame = p2;
        local v12;

        if u7 then
            ParticleHandler.HSVShiftParticles(u11, u7);
            v12 = 0;
        else
            v12 = 0;
        end;

        local v13;

        repeat
            v13 = false;

            for _, v in v9 do
                if (v.Position - u10.Position).Magnitude < 5 then
                    v13 = true;
                end;
            end;

            if v13 then
                u10 = p2 * CFrame.new(v8:NextNumber(-10, 10), v8:NextNumber(0, 5), v8:NextNumber(-10, 10));
            end;

            v12 = v12 + 1;
        until not v13 or v12 >= 5;

        table.insert(v9, u10);
        u11.Parent = workspace.Effects;
        TweenService:Create(u11, TweenInfo.new(0.5), {
            CFrame = u10
        }):Play();
        task.delay(0.5, function() -- Line: 60
            -- upvalues: u1 (ref), u11 (copy), u7 (copy)
            u1({
                Clone = false,
                Destroy = false,
                Parent = false,
                Particle = u11.TrailActive,
                HSVShift = u7
            });
        end);
        task.delay(0.5, function() -- Line: 69
            -- upvalues: u1 (ref), u10 (ref), u6 (copy), u7 (copy), u11 (copy)
            u1({
                Origin = u10,
                Particle = u6,
                HSVShift = u7
            });
            u11:Destroy();
        end);
        wait();
    end;
end;