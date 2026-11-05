  

 

local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LocalPlayer = Players.LocalPlayer;
local u1 = Random.new();

local function IsExtraEnabled(p2) -- Line: 13
    -- upvalues: LocalPlayer (copy)
    local Value = LocalPlayer.Settings.PoseExtrasVisibility.Value;

    if p2 == LocalPlayer.Character then
        return Value < 3;
    end;

    return Value < 2;
end;

return function(p3, p4) -- Line: 18
    -- upvalues: Players (copy), ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), u1 (copy), LocalPlayer (copy)
    local v5 = Players:GetPlayerFromCharacter(p3);
    local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");
    local TWOHPoseLightning = v5.Settings.TWOHPoseLightning;
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = p3
    });

    if not HumanoidRootPart then
        return;
    end;

    local v7 = AssetHandler.GetAbilityData(v5);

    if not v7 then
        error("COULD NOT FETCH ABILITY DATA");

        return;
    end;

    if not p4 then
        local TWOH_POSE_CONTAINER = HumanoidRootPart:FindFirstChild("TWOH_POSE_CONTAINER");

        if TWOH_POSE_CONTAINER then
            TWOH_POSE_CONTAINER.Parent = workspace.Effects;
            local Aura = TWOH_POSE_CONTAINER.Aura;
            ParticleHandler.EnableParticle(TWOH_POSE_CONTAINER.Cloud, false);
            ParticleHandler.EnableParticle(Aura, false);
            local v8 = ParticleHandler.GetMaxLifetime(TWOH_POSE_CONTAINER);
            task.delay(v8, TWOH_POSE_CONTAINER.Destroy, TWOH_POSE_CONTAINER);
        end;

        return;
    end;

    local v9 = game.Players.LocalPlayer.Character == p3;
    local v10 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
    local Model = Instance.new("Model");
    Model.Parent = HumanoidRootPart;
    Model.Name = "TWOH_POSE_CONTAINER";
    local u11 = AssetHandler.CloneAsset("Pose/Cloud", v7);
    ParticleHandler.Unusualify(u11, {
        HSVData = v6
    });

    if v6 and v6.Chroma then
        ParticleHandler.Chromaify(u11, {
            Character = p3
        });
    end;

    u11.Parent = Model;
    local v12 = AssetHandler.GetAsset("Pose/MiniLightning", v7);
    u11.CFrame = v10 * CFrame.new(0, v12.Beam.Size.Y + u11.Size.Y / 2, 0);
    ParticleHandler.EnableParticle(u11, TWOHPoseLightning.Value);
    local u13 = AssetHandler.CloneAsset("Pose/Aura", v7);
    ParticleHandler.Unusualify(u13, {
        HSVData = v6
    });

    if v6 and v6.Chroma then
        ParticleHandler.Chromaify(u13, {
            Character = p3
        });
    end;

    u13.Parent = Model;
    u13.CFrame = v10;
    ParticleHandler.EnableParticle(u13, TWOHPoseLightning.Value);
    local u14 = nil;
    u14 = TWOHPoseLightning:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 70
        -- upvalues: u11 (copy), Model (copy), u13 (copy), u14 (ref), ParticleHandler (ref), TWOHPoseLightning (copy)
        if not (u11 and (Model and u13)) then
            u14:Disconnect();

            return;
        end;

        ParticleHandler.EnableParticle(u11, TWOHPoseLightning.Value);
        ParticleHandler.EnableParticle(u13, TWOHPoseLightning.Value);
    end);
    Model.Destroying:Once(function() -- Line: 79
        -- upvalues: u14 (ref)
        u14:Disconnect();
    end);

    while p3:IsDescendantOf(workspace) do
        EffectsHandler.Wait(u1:NextNumber(1, 2));

        if TWOHPoseLightning.Value then
            if not Model:IsDescendantOf(HumanoidRootPart) then
                break;
            end;

            local v15 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            u11.CFrame = v15 * CFrame.new(0, v12.Beam.Size.Y + u11.Size.Y / 2, 0);
            u13.CFrame = v15;
            local Value = LocalPlayer.Settings.PoseExtrasVisibility.Value;
            local v16;

            if p3 == LocalPlayer.Character then
                v16 = Value < 3;
            else
                v16 = Value < 2;
            end;

            if v16 then
                local v17 = CFrame.new(math.random(-15, 15), 0, math.random(-15, 15));
                local v18 = true;
                local Position = workspace.CurrentCamera.CFrame.Position;

                if (Position - (v15 * v17).Position).Magnitude <= 200 then
                    if not v9 then
                        for _, _ in { v17, v17 * CFrame.new(0, 10, 0) } do
                            local Position2 = (v15 * v17).Position;
                            local _, v19 = workspace.CurrentCamera:WorldToScreenPoint(Position2);

                            if v19 ~= true or (Position - Position2).Magnitude > 120 then
                                v18 = false;
                                break;
                            end;
                        end;
                    end;

                    local v20 = ParticleHandler.GetUnusualHSVData({
                        Character = p3
                    });
                    local v21 = v12:Clone();
                    ParticleHandler.Unusualify(v21, {
                        HSVData = v20
                    });
                    v21.Parent = Model;
                    v21.CFrame = v15 * v17;
                    ParticleHandler.Emit(v21, ParticleHandler.GenerateEmitInfo(v21));
                    ParticleHandler.DestroyEmit(v21);

                    if v18 then
                        EffectsHandler.CallEffect("Rock Debris", {
                            Lifetime = 2.5,
                            Radius = 3.5,
                            Amount = 7,
                            Origin = v15 * v17
                        });
                    end;

                    EffectsHandler.CallEffect("Play Sound At", {
                        Object = AssetHandler.GetAsset("Global/Impact", v7),
                        Origin = v15 * v17
                    });

                    if v5 == LocalPlayer then
                        EffectsHandler.CallEffect("Camera Shake Preset", "Slam");
                    end;
                end;
            end;
        end;
    end;
end;