  

 

local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

local function CubicBezier(p2, p3, p4, p5, p6) -- Line: 9
    return (1 - p2) ^ 3 * p3 + 3 * (1 - p2) ^ 2 * p2 * p4 + 3 * (1 - p2) * p2 ^ 2 * p5 + p2 ^ 3 * p6;
end;

local function RandomNumber(p7, p8) -- Line: 13
    -- upvalues: u1 (copy)
    return u1:NextNumber(p7, p8);
end;

return function(p9) -- Line: 17
    -- upvalues: u1 (copy), RandomNumber (copy), ParticleHandler (copy), RunService (copy)
    local Positions = p9.Positions;
    local Curve = p9.Curve;
    local Radius = p9.Radius;
    local Duration = p9.Duration;
    local Object = p9.Object;
    local Interval = p9.Interval;

    for _ = 1, p9.Amount do
        local u10 = os.clock();
        local v11 = u1:NextNumber(-Curve, Curve);
        local v12 = u1:NextNumber(0, Curve);
        local u13 = Vector3.new(v11, v12, RandomNumber(-Curve, Curve));

        if not u13 then
            local v14 = u1:NextNumber(-15, 15);
            local v15 = u1:NextNumber(-5, 10);
            u13 = Vector3.new(v14, v15, RandomNumber(-15, 15));
        end;

        local v16 = CFrame.new(u1:NextNumber(-Radius, Radius), u1:NextNumber(-Radius, Radius), RandomNumber(-Radius, Radius));
        local u17 = ParticleHandler.TranslateToCFrame(Positions.Start) * v16;
        local u18 = Object:Clone();
        u18.Position = u17.Position;
        u18.Parent = workspace.Effects;
        local v19 = not p9.Player and "" or p9.Player.Data.Skin:GetAttribute("SkinName");
        local v20 = ParticleHandler.GetSkinInfo(v19);

        if v20 and v20.Metadata then
            if v20.Metadata.HueShift then
                ParticleHandler.HueShiftParticles(u18, v20.Metadata.HueShift);
            end;

            if v20.Metadata.HSVShift then
                ParticleHandler.HSVShiftParticles(u18, v20.Metadata.HSVShift);
            end;
        end;

        local v21 = 0;

        if p9.Player and p9.Player.Data.Skin:GetAttribute("UnusualHueId") then
            v21 = v21 + p9.Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v21 > 0 and (v20 and (v20.Metadata and v20.Metadata.SaturationThreshold)) then
            ParticleHandler.HSVShiftParticles(u18, {
                SaturationThreshold = v20.Metadata.SaturationThreshold
            });
        end;

        if v21 > 0 then
            ParticleHandler.HSVShiftParticles(u18, {
                HueShift = v21
            });
        end;

        ParticleHandler.EnableParticle(u18, true);
        local u22 = nil;
        u22 = RunService.RenderStepped:Connect(function(p23) -- Line: 62
            -- upvalues: ParticleHandler (ref), Positions (copy), u17 (ref), u10 (copy), Duration (copy), u13 (copy), u22 (ref), u18 (copy)
            local v24 = ParticleHandler.TranslateToCFrame(Positions.End) or u17;
            local v25 = (os.clock() - u10) / Duration;
            local v26 = u17.Position:Lerp(v24.Position, 0.4) + u13;
            local v27 = u17.Position:Lerp(v24.Position, 0.65) + u13;
            local v28 = (1 - v25) ^ 3 * u17.Position + 3 * (1 - v25) ^ 2 * v25 * v26 + 3 * (1 - v25) * v25 ^ 2 * v27 + v25 ^ 3 * v24.Position;

            if v25 < 1 then
                u18.Position = v28;

                return;
            end;

            u22:Disconnect();
            u22 = nil;
            u18.Position = v24.Position;
            ParticleHandler.EnableParticle(u18, false);
            task.delay(8, u18.Destroy, u18);
        end);

        if Interval then
            task.wait(Interval);
        end;
    end;
end;