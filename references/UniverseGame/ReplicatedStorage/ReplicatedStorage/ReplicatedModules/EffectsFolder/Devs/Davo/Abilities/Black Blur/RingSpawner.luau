  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Trove = require(PathShortcuts.KnitPath.Trove);
local LocalPlayer = game.Players.LocalPlayer;
local u1 = {};

return function(u2, u3, u4, u5) -- Line: 12
    -- upvalues: u1 (copy), EffectsHandler (copy), Trove (copy), ParticleHandler (copy), RunService (copy), LocalPlayer (copy)
    if not u4 then
        local v6 = u1[u2];

        if v6 then
            if u3 then
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Particles/RingVFX",
                    AbilityName = "Black Blur",
                    PlaySounds = true,
                    Origin = v6.Ring.CFrame,
                    Character = u3
                });
            end;

            v6:Destroy();
        end;

        return;
    end;

    local u7 = 0;
    local Random1 = u5.Random1;
    local Random2 = u5.Random2;
    local u8 = Trove.new();
    local u9 = u8:Clone(script.RingContainer);
    ParticleHandler.Unusualify(u9, {
        IncludeParts = true,
        Character = u3
    });
    local Hitbox = u9.Hitbox;
    local v10 = math.sin(Random1) * Random2;
    local v11 = math.cos(Random1) * Random2;
    Hitbox.AssemblyLinearVelocity = Vector3.new(v10, Random2 * 0.6, v11);
    u9.Hitbox.CollisionGroup = "FX";
    u9.Parent = workspace.Effects;
    u9:PivotTo(CFrame.new(u5.Position));
    u1[u2] = u9;
    u8:Connect(RunService.PreSimulation, function(p12) -- Line: 43
        -- upvalues: u9 (copy), u5 (copy), u7 (ref)
        u9.Hitbox.Ring.Transform = CFrame.Angles(0, tick() * 3.141592653589793 * 1.25 % 3.141592653589793, 0);

        if u5.Blink and os.clock() - u7 > 0.125 then
            u7 = os.clock();
            u9.Ring.Transparency = u9.Ring.Transparency < 1 and 1 or 0;
        end;
    end);

    if u3 == LocalPlayer.Character then
        task.spawn(function() -- Line: 53
            -- upvalues: EffectsHandler (ref), u5 (copy), u1 (ref), u2 (copy), u9 (copy), u8 (copy), u3 (copy), u4 (copy)
            EffectsHandler.Wait(u5.CollectionWait or 0.75);

            if u1[u2] ~= u9 then
                return;
            end;

            u9.Hitbox.CollisionGroup = "Default";
            u8:Connect(u9.Hitbox.Touched, function(p13) -- Line: 57
                -- upvalues: u3 (ref), u4 (ref), u2 (ref), EffectsHandler (ref), u9 (ref), u8 (ref)
                if p13.Parent == u3 then
                    u4:FireServer(u2);
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/RingVFX",
                        AbilityName = "Black Blur",
                        PlaySounds = true,
                        Origin = u9.Ring.CFrame,
                        Character = u3
                    });
                    u8:Destroy();
                end;
            end);
        end);
    end;

    u8:Add(function() -- Line: 74
        -- upvalues: u1 (ref), u2 (copy)
        u1[u2] = nil;
    end);
    u8:AttachToInstance(u9);
end;