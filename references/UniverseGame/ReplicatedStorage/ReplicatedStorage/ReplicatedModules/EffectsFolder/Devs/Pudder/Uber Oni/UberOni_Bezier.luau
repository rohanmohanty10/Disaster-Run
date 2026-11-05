  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Random.new();

local function CubicBezier(p2, p3, p4, p5, p6) -- Line: 10
    return (1 - p2) ^ 3 * p3 + 3 * (1 - p2) ^ 2 * p2 * p4 + 3 * (1 - p2) * p2 ^ 2 * p5 + p2 ^ 3 * p6;
end;

local function RandomNumber(p7, p8) -- Line: 14
    -- upvalues: u1 (copy)
    return u1:NextNumber(p7, p8);
end;

return function(u9) -- Line: 18
    -- upvalues: u1 (copy), RandomNumber (copy), ParticleHandler (copy), RunService (copy), EffectsHandler (copy)
    local Positions = u9.Positions;
    local Object = u9.Object;
    local Interval = u9.Interval;

    for _ = 1, u9.Amount do
        local u10 = typeof(u9.Duration) == "NumberRange" and u1:NextNumber(u9.Duration.Min, u9.Duration.Max) or u9.Duration;
        local v11 = typeof(u9.Radius) == "NumberRange" and u1:NextNumber(u9.Radius.Min, u9.Radius.Max) or u9.Radius;
        local v12 = typeof(u9.Curve) == "NumberRange" and u1:NextNumber(u9.Curve.Min, u9.Curve.Max) or u9.Curve;
        local u13 = os.clock();
        local v14 = u1:NextNumber(-v12, v12);
        local v15 = u1:NextNumber(0, v12);
        local u16 = Vector3.new(v14, v15, RandomNumber(-v12, v12));

        if not u16 then
            local v17 = u1:NextNumber(-15, 15);
            local v18 = u1:NextNumber(-5, 10);
            u16 = Vector3.new(v17, v18, RandomNumber(-15, 15));
        end;

        local v19 = CFrame.new(u1:NextNumber(-v11, v11), u1:NextNumber(-v11, v11), RandomNumber(-v11, v11));
        local v20 = ParticleHandler.TranslateToCFrame(Positions.Start);

        if not v20 then
            return;
        end;

        local u21 = v20 * v19;
        local u22 = Object:Clone();
        u22.Position = u21.Position;
        u22.Anchored = true;
        u22.Parent = workspace.Effects;
        local v23 = 0;

        if u9.Player and u9.Player.Data.Skin:GetAttribute("UnusualHueId") then
            v23 = v23 + u9.Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v23 > 0 then
            ParticleHandler.HSVShiftParticles(u22, {
                HueShift = v23
            });
        end;

        ParticleHandler.EnableAllParticles(u22, true);
        local u24 = nil;
        u24 = RunService.RenderStepped:Connect(function(p25) -- Line: 52
            -- upvalues: ParticleHandler (ref), Positions (copy), u21 (ref), u13 (copy), u10 (copy), u16 (copy), u24 (ref), u22 (copy), u9 (copy)
            local v26 = ParticleHandler.TranslateToCFrame(Positions.End) or u21;
            local v27 = (os.clock() - u13) / u10;
            local v28 = u21.Position:Lerp(v26.Position, 0.4) + u16;
            local v29 = u21.Position:Lerp(v26.Position, 0.65) + u16;
            local v30 = (1 - v27) ^ 3 * u21.Position + 3 * (1 - v27) ^ 2 * v27 * v28 + 3 * (1 - v27) * v27 ^ 2 * v29 + v27 ^ 3 * v26.Position;

            if v27 < 1 then
                u22.Position = v30;

                return;
            end;

            u24:Disconnect();
            u24 = nil;
            u22.Position = v26.Position;
            ParticleHandler.EnableAllParticles(u22, false);

            if u9.DestroyTime then
                task.delay(u9.DestroyTime, u22.Destroy, u22);

                return;
            end;

            ParticleHandler.DestroyEmit(u22);
        end);

        if Interval then
            EffectsHandler.Wait(Interval);
        end;
    end;
end;