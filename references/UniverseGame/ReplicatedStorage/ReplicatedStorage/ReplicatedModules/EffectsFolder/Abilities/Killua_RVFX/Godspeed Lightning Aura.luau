  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
local u2 = Petal("New");
local v3 = Petal("Extensions");
local Value = Fusion.Value;
local Tween = Fusion.Tween;
local Observer = Fusion.Observer;
local Rng = v3.Rng;

return function(p4, p5, p6) -- Line: 23
    -- upvalues: u2 (copy), AssetHandler (copy), Rng (copy), u1 (copy), ParticleHandler (copy), EffectsHandler (copy), Value (copy), Tween (copy), Observer (copy)
    local v7 = p6 or {};
    local v8 = v7.Attribute or "Godspeed_Lightning";
    local v9 = v7.PartCount or {};
    local _ = v7.Thickness;
    local _ = v7.Radius;
    local _ = v7.Size;

    if not (p5 or p4:GetAttribute(v8)) or p5 and p4:GetAttribute(v8) then
        return;
    end;

    if not p5 then
        p4:SetAttribute(v8, nil);

        return;
    end;

    local Torso = p4:FindFirstChild("Torso");

    if Torso == nil then
        return;
    end;

    p4:SetAttribute(v8, true);
    local v10 = u2("Attachment")({
        Name = "TorsoAttachment",
        Parent = Torso
    });
    v10.CFrame = CFrame.Angles(0, 0, 1.5707963267948966);
    local v11 = AssetHandler.GetAbilityData(p4);

    if v11 then
        v11 = v11.SkinName == "Powerplex";
    end;

    local v12;

    if v11 then
        v10:Destroy();
        v12 = 0;
    else
        v12 = 0;
    end;

    while p4:IsDescendantOf(workspace) and p4:GetAttribute(v8) do
        local v13 = p4.HumanoidRootPart.Velocity.Magnitude > 5;
        local v14 = v13 and 0.125 or 0.15;

        if v11 then
            v14 = v14 / 1.5;
        end;

        if v14 < os.clock() - v12 then
            if v11 then
                local v15 = {};

                if p4:FindFirstChild("Stand") then
                    for _, descendant in p4:FindFirstChild("Stand"):GetDescendants() do
                        if descendant:IsA("Attachment") and descendant.Name == "AbsorberAttachment" then
                            table.insert(v15, descendant);
                        end;
                    end;
                end;

                if #v15 > 0 then
                    v10 = v15[math.random(1, #v15)];
                    table.clear(v15);
                end;
            end;

            local v16 = CFrame.lookAlong(Torso.Position, p4.HumanoidRootPart.CFrame.LookVector);
            local Angles = CFrame.Angles;
            local v17 = Rng(180, 360);
            local v18 = math.rad(v17);
            local v19 = Rng(40, 120);
            local v20 = math.random(1, 2) == 1 and -1 or 1;
            local LookVector = (v16 * Angles(v18, math.rad(v19 * v20), 0)).LookVector;
            local v21 = workspace:Raycast(Torso.Position, LookVector * Rng(24.5, 26) * (v13 and 0.85 or 0.65), u1);

            if v21 then
                v12 = os.clock();
                local u22 = nil;
                local Magnitude = (v10.WorldPosition - v21.Position).Magnitude;
                local v23 = p4:GetAttribute("Flashtime") and Rng(0.3, 0.45) or 1;
                local v24 = (v7.AnimationSpeed or Rng(1.5, 3)) * v23;
                local v25 = (v7.PulseSpeed or Rng(7.5, 8.85)) * 0.875;
                local v26 = Rng(1.5, 2) / v23;
                local v27 = { 0, 0 };
                local v28 = v7.Color or ColorSequence.new(Color3.fromRGB(105, 141, 192));
                local v29;

                if typeof(v9) == "table" or not v9 then
                    if v13 then
                        v29 = v9.Moving or 22;
                    else
                        v29 = v9.Idle or 18;
                    end;
                else
                    v29 = v9;
                end;

                local v30 = Rng(0.125, 0.19);
                local u31;

                if math.random(1, 5) == 1 and not v7.DisableParticles then
                    u22 = AssetHandler.GetAsset("Particles/CoilLightningImpact", {
                        AbilityName = "UGrain"
                    }):Clone();
                    u22.Position = v21.Position;
                    u22.Parent = workspace.Effects;
                    AssetHandler.ScaleAsset(u22, {
                        Scale = Rng(0.95, 1.15)
                    });

                    for _, descendant in u22:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.TimeScale = descendant.TimeScale * v23;
                        end;
                    end;

                    u31 = u22.Attachment;
                else
                    u31 = Instance.new("Attachment");
                    u31.Parent = workspace.Terrain;
                    u31.WorldCFrame = CFrame.new(v21.Position) * CFrame.Angles(0, 0, 1.5707963267948966);
                end;

                task.delay(1 / v25, function() -- Line: 130
                    -- upvalues: u22 (ref), ParticleHandler (ref), u31 (ref)
                    local v32 = u22 and ParticleHandler.GetMaxLifetime(u22) or 1;
                    task.delay(v32 * 2.2, u31.Destroy, u31);

                    if u22 then
                        task.delay(v32, u22.Destroy, u22);
                        ParticleHandler.Emit(u22, ParticleHandler.GenerateEmitInfo(u22));
                    end;
                end);
                local u33 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                    FadeLength = 0.4,
                    Color = v28,
                    Curves = v27,
                    Speed = v25,
                    Length = v26 * 2,
                    A1 = v10,
                    A2 = u31,
                    Size = v30,
                    PartCount = v29,
                    Transparency = NumberRange.new(0.075, 1)
                });
                local v34 = Value(0);
                local u35 = Tween(v34, TweenInfo.new(v26 * 2.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut));
                local u36 = v11 and Rng(-1, 1) or Rng(0.75, 1.25);
                local u37 = Rng(0.75, 1.25);
                local v38 = Observer(u35):onChange(function() -- Line: 158
                    -- upvalues: u33 (copy), u35 (copy), u36 (copy), u37 (copy)
                    u33.CurveSize0 = u35:get() * u36;
                    u33.CurveSize1 = -u35:get() * u37;
                end);
                v34:set(Magnitude * (v11 and 15 or 5.75));
                task.delay(v26 * 2.1, v38);
                u33.MinRadius = Magnitude / 13;
                u33.MaxRadius = Magnitude / 10;
                u33.AnimationSpeed = v24;
                u33.MinThicknessMultiplier = 0.2;
                u33.MaxThicknessMultiplier = 1.3;
            end;
        end;

        task.wait();
    end;

    if not v11 then
        task.delay(2, v10.Destroy, v10);
    end;
end;