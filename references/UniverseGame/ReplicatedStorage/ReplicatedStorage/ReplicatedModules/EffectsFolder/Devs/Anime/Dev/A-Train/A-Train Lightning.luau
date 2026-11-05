  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

return function(p3, p4, p5) -- Line: 16
    -- upvalues: u2 (copy), u1 (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local v6 = p5 or {};
    local v7 = v6.Attribute or "ATrainLightning";
    local v8 = v6.PartCount or {};
    local v9 = v6.Thickness or {};
    local v10 = v6.Radius or {};
    local v11 = v6.Size or {};
    local PrimaryPart = p3.PrimaryPart;
    local v12 = v6.Part or p3:FindFirstChild("Torso");

    if not p4 then
        if not p3:GetAttribute(v7) then
            return;
        end;

        p3:SetAttribute(v7, nil);

        return;
    end;

    if p3:GetAttribute(v7) then
        return;
    end;

    p3:SetAttribute(v7, true);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v12;
    local v13 = os.clock();
    local v14;

    if game.Players:GetPlayerFromCharacter(p3) == nil then
        v14 = true;
    else
        v14 = false;
    end;

    while true do
        if not (p3:IsDescendantOf(game) and p3:GetAttribute(v7)) then
            task.delay(2, Attachment.Destroy, Attachment);

            return;
        end;

        local v15 = PrimaryPart.Velocity.Magnitude > 5;
        local v16 = v6.Cooldown or (v15 and 0.05 or 0.08);

        if p3:GetAttribute("Flashtime") then
            v16 = v16 * 7;
        end;

        if v16 < os.clock() - v13 then
            local v17;

            if v6.RandomizePosition then
                local v18 = v6.RandomizePosition.X and (u2:NextNumber(v6.RandomizePosition.X.Minimum or 0, v6.RandomizePosition.X.Maximum or 0) or 0) or 0;
                local v19 = v6.RandomizePosition.Y and (u2:NextNumber(v6.RandomizePosition.Y.Minimum or 0, v6.RandomizePosition.Y.Maximum or 0) or 0) or 0;
                local v20 = v6.RandomizePosition.Z and (u2:NextNumber(v6.RandomizePosition.Z.Minimum or 0, v6.RandomizePosition.Z.Maximum or 0) or 0) or 0;
                v17 = Vector3.new(v18, v19, v20) or Attachment.Position;
            else
                v17 = Attachment.Position;
            end;

            Attachment.Position = v17;
            local v21 = CFrame.new(v12.Position, v12.Position + PrimaryPart.CFrame.LookVector);
            local Angles = CFrame.Angles;
            local v22 = u2:NextNumber(180, 360);
            local v23 = math.rad(v22);
            local v24 = u2:NextNumber(v6.MinAngle or 30, v6.MaxAngle or 120);
            local v25 = math.random(1, 2) == 1 and -1 or 1;
            local LookVector = (v21 * Angles(v23, math.rad(v24 * v25), 0)).LookVector;
            local v26 = workspace:Raycast(v12.Position, LookVector * u2:NextNumber(22, 26) * (v6.RayDistance or (v15 and 1 or 0.5)), u1);

            if v26 then
                v13 = os.clock();
                local u27 = nil;
                local v28 = p3:GetAttribute("Flashtime") and u2:NextNumber(0.3, 0.45) or 1;
                local v29 = v9.Minimum or 0.85;
                local v30 = v9.Maximum or 1;
                local v31 = v10.Maximum or 1.3;
                local v32 = v10.Minimum or 0.8;
                local v33 = (v6.AnimationSpeed or u2:NextNumber(0, 12)) * v28;
                local v34 = (v6.PulseSpeed or u2:NextNumber(7.5, 8.85)) * v28;
                local v35 = (v6.Lifetime or u2:NextNumber(0.95, 1.4)) / v28;
                local v36 = v6.Curves or { u2:NextNumber(-5, 5), u2:NextNumber(-5, 5) };
                local v37 = v6.Color or ColorSequence.new(Color3.fromRGB(105, 141, 192));
                local v38;

                if typeof(v8) == "table" or not v8 then
                    if v15 then
                        v38 = v8.Moving or 22;
                    else
                        v38 = v8.Idle or 18;
                    end;
                else
                    v38 = v8;
                end;

                local v39;

                if typeof(v11) == "table" or not v11 then
                    local v40 = u2:NextNumber(0.15, 0.2);
                    local v41;

                    if v15 then
                        v41 = v11.Moving or 1;
                    else
                        v41 = v11.Idle or 0.55;
                    end;

                    v39 = v40 * v41;
                else
                    v39 = v11;
                end;

                local u42;

                if math.random(1, 5) == 1 and not v6.DisableParticles then
                    u27 = AssetHandler.GetAsset("Particles/CoilLightningImpact", {
                        AbilityName = "UGrain Dev"
                    }):Clone();
                    u27.Position = v26.Position;

                    if not v14 or v6.HSVData then
                        ParticleHandler.Unusualify(u27, {
                            Character = p3,
                            HSVData = v6.HSVData
                        });
                    end;

                    u27.Parent = workspace.Effects;
                    AssetHandler.ScaleAsset(u27, {
                        Scale = u2:NextNumber(0.95, 1.15)
                    });

                    for _, descendant in u27:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.TimeScale = descendant.TimeScale * v28;
                        end;
                    end;

                    u42 = u27.Attachment;
                else
                    u42 = Instance.new("Attachment");
                    u42.Parent = workspace.Terrain;
                    u42.WorldPosition = v26.Position;
                end;

                task.delay(1 / v34, function() -- Line: 100
                    -- upvalues: u27 (ref), ParticleHandler (ref), u42 (ref)
                    local v43 = u27 and ParticleHandler.GetMaxLifetime(u27) or 1;
                    task.delay(v43, u42.Destroy, u42);

                    if u27 then
                        task.delay(v43, u27.Destroy, u27);
                        ParticleHandler.Emit(u27, ParticleHandler.GenerateEmitInfo(u27));
                    end;
                end);

                if not v14 or v6.HSVData ~= nil then
                    v37 = ParticleHandler.TryHSVShift(v37, v6.HSVData or ParticleHandler.GetUnusualHSVData({
                        Character = p3
                    }));
                end;

                local v44 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                    Color = v37,
                    Curves = v36,
                    Speed = v34,
                    Length = v35,
                    A1 = Attachment,
                    A2 = u42,
                    Size = v39,
                    PartCount = v38
                });

                if v15 then
                    v44.MinRadius = v32;
                    v44.MaxRadius = v31;
                end;

                v44.AnimationSpeed = v33;
                v44.MinThicknessMultiplier = v29;
                v44.MaxThicknessMultiplier = v30;
            end;
        end;

        task.wait();
    end;
end;