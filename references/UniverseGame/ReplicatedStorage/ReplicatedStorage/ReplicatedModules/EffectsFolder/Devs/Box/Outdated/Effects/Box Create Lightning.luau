  

 

local LightningBolt = game:GetService("ReplicatedStorage").ClientModules.LightningBolt;

return function(p1, p2) -- Line: 3
    -- upvalues: LightningBolt (copy)
    local u3 = require(LightningBolt);
    local LightningSparks = require(LightningBolt.LightningSparks);
    local LightningExplosion = require(LightningBolt.LightningExplosion);

    local function SpawnLightning(p4, u5, p6, p7, p8, p9, p10, u11) -- Line: 8
        -- upvalues: u3 (copy), LightningSparks (copy), LightningExplosion (copy)
        return (function(p12, u13, p14, p15, p16, p17, p18, p19) -- Line: 10, Name: lightning
            -- upvalues: u3 (ref), LightningSparks (ref), u11 (copy), LightningExplosion (ref), u5 (copy)
            local v20 = CFrame.fromAxisAngle((u13 - p12).Unit, 2 * math.random() * 3.141592653589793);
            local v21 = {};
            local v22 = {};
            v21.WorldPosition = p12;
            v21.WorldAxis = v20 * Vector3.new(0, 0, 0);
            v22.WorldPosition = u13;
            v22.WorldAxis = v20 * Vector3.new(0, 0, 0);
            local v23 = u3.new(v21, v22, 20, p19);
            local v24 = p15[2];
            v23.CurveSize0 = p15[1];
            v23.CurveSize1 = v24;
            v23.AnimationSpeed = 14;
            v23.PulseSpeed = p17;
            v23.PulseLength = p16;
            v23.FadeLength = 0.25;
            v23.Transparency = 0;
            v23.MaxRadius = p18;
            v23.Color = p14;
            LightningSparks.new(v23);

            if u11 then
                local v25 = u11[4];

                local function DoExplosion() -- Line: 30
                    -- upvalues: LightningExplosion (ref), u13 (copy), u11 (ref), u5 (ref)
                    return LightningExplosion.new(u13, u11[1], u11[2], u5, u5, u11[3]);
                end;

                if type(v25) == "number" and v25 > 0 then
                    task.delay(v25, DoExplosion);

                    return v23;
                end;

                task.spawn(DoExplosion);
            end;

            return v23;
        end)(p4[1].Position, p4[2].Position, u5, p6, p7, p8, p9, p10);
    end;

    local v26 = p2.CFrames or { p1.PrimaryPart.CFrame * CFrame.new(0, 20, 0), p1.PrimaryPart.CFrame };
    local u27 = p2.Color or Color3.fromRGB(248, 217, 109);
    local v28 = p2.Curves or { 0, 0 };
    local u29 = p2.ExplosionData or nil;
    (function(p30, u31, p32, p33, p34, p35, p36, p37) -- Line: 10, Name: lightning
        -- upvalues: u3 (copy), LightningSparks (copy), u29 (copy), LightningExplosion (copy), u27 (copy)
        local v38 = CFrame.fromAxisAngle((u31 - p30).Unit, 2 * math.random() * 3.141592653589793);
        local v39 = {};
        local v40 = {};
        v39.WorldPosition = p30;
        v39.WorldAxis = v38 * Vector3.new(0, 0, 0);
        v40.WorldPosition = u31;
        v40.WorldAxis = v38 * Vector3.new(0, 0, 0);
        local v41 = u3.new(v39, v40, 20, p37);
        local v42 = p33[2];
        v41.CurveSize0 = p33[1];
        v41.CurveSize1 = v42;
        v41.AnimationSpeed = 14;
        v41.PulseSpeed = p35;
        v41.PulseLength = p34;
        v41.FadeLength = 0.25;
        v41.Transparency = 0;
        v41.MaxRadius = p36;
        v41.Color = p32;
        LightningSparks.new(v41);

        if u29 then
            local v43 = u29[4];

            local function v44() -- Line: 30
                -- upvalues: LightningExplosion (ref), u31 (copy), u29 (ref), u27 (ref)
                return LightningExplosion.new(u31, u29[1], u29[2], u27, u27, u29[3]);
            end;

            if type(v43) == "number" and v43 > 0 then
                task.delay(v43, v44);

                return v41;
            end;

            task.spawn(v44);
        end;

        return v41;
    end)(v26[1].Position, v26[2].Position, u27, v28, p2.Length or 1, p2.Speed or 3, p2.Size or 3, p2.Material or "Neon");
end;