  

 

local Debris = game:GetService("Debris");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local LightningBolt = script.LightningBolt;

return function(p2, p3, p4) -- Line: 5
    -- upvalues: LightningBolt (copy), u1 (copy), Debris (copy)
    local u5 = require(LightningBolt);
    local LightningSparks = require(LightningBolt.LightningSparks);
    local LightningExplosion = require(LightningBolt.LightningExplosion);
    local v6 = p4.HitData[1];

    local function SpawnLightning(p7, u8, p9, p10, p11, p12, p13, u14) -- Line: 13
        -- upvalues: u5 (copy), LightningSparks (copy), LightningExplosion (copy)
        return (function(p15, u16, p17, p18, p19, p20, p21, p22) -- Line: 15, Name: lightning
            -- upvalues: u5 (ref), LightningSparks (ref), u14 (copy), LightningExplosion (ref), u8 (copy)
            local v23 = CFrame.fromAxisAngle((u16 - p15).Unit, 2 * math.random() * 3.141592653589793);
            local v24 = {};
            local v25 = {};
            v24.WorldPosition = p15;
            v24.WorldAxis = v23 * Vector3.new(0, 0, 0);
            v25.WorldPosition = u16;
            v25.WorldAxis = v23 * Vector3.new(0, 0, 0);
            local v26 = u5.new(v24, v25, 20, p22);
            local v27 = p18[2];
            v26.CurveSize0 = p18[1];
            v26.CurveSize1 = v27;
            v26.AnimationSpeed = 14;
            v26.PulseSpeed = p20;
            v26.PulseLength = p19;
            v26.FadeLength = 0.25;
            v26.Transparency = 0;
            v26.MaxRadius = p21;
            v26.Color = p17;
            LightningSparks.new(v26);

            if u14 then
                local u28 = u14[4];
                coroutine.wrap(function() -- Line: 35
                    -- upvalues: u28 (copy), LightningExplosion (ref), u16 (copy), u14 (ref), u8 (ref)
                    wait(u28);
                    LightningExplosion.new(u16, u14[1], u14[2], u8, u8, u14[3]);
                end)();
            end;

            return v26;
        end)(p7[1].Position, p7[2].Position, u8, p9, p10, p11, p12, p13);
    end;

    local v29 = v6.CFrames or { p3.PrimaryPart.CFrame * CFrame.new(0, 20, 0), p3.PrimaryPart.CFrame };
    local u30 = v6.Color or Color3.fromRGB(248, 217, 109);
    local v31 = v6.Curves or { 0, 0 };
    local v32 = v6.Length or 1;
    local v33 = v6.Speed or 3;
    local v34 = v6.Size or 3;
    local v35 = v6.Material or Enum.Material.Neon;
    local u36 = v6.ExplosionData or nil;

    if v6.CreateLightningParticles then
        local v37 = u1.Assets.Abilities["Weather Report"].LightningHitEffect:Clone();
        v37.CFrame = p2.PrimaryPart.CFrame;
        v37.Parent = p2.PrimaryPart;
        Debris:AddItem(v37, 4);

        for _, descendant in pairs(v37:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                coroutine.wrap(function() -- Line: 80
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                    task.wait(0.1);
                    descendant.Enabled = false;
                end)();
            end;
        end;
    end;

    (function(p38, u39, p40, p41, p42, p43, p44, p45) -- Line: 15, Name: lightning
        -- upvalues: u5 (copy), LightningSparks (copy), u36 (copy), LightningExplosion (copy), u30 (copy)
        local v46 = CFrame.fromAxisAngle((u39 - p38).Unit, 2 * math.random() * 3.141592653589793);
        local v47 = {};
        local v48 = {};
        v47.WorldPosition = p38;
        v47.WorldAxis = v46 * Vector3.new(0, 0, 0);
        v48.WorldPosition = u39;
        v48.WorldAxis = v46 * Vector3.new(0, 0, 0);
        local v49 = u5.new(v47, v48, 20, p45);
        local v50 = p41[2];
        v49.CurveSize0 = p41[1];
        v49.CurveSize1 = v50;
        v49.AnimationSpeed = 14;
        v49.PulseSpeed = p43;
        v49.PulseLength = p42;
        v49.FadeLength = 0.25;
        v49.Transparency = 0;
        v49.MaxRadius = p44;
        v49.Color = p40;
        LightningSparks.new(v49);

        if u36 then
            local u51 = u36[4];
            coroutine.wrap(function() -- Line: 35
                -- upvalues: u51 (copy), LightningExplosion (ref), u39 (copy), u36 (ref), u30 (ref)
                wait(u51);
                LightningExplosion.new(u39, u36[1], u36[2], u30, u30, u36[3]);
            end)();
        end;

        return v49;
    end)(v29[1].Position, v29[2].Position, u30, v31, v32, v33, v34, v35);
end;