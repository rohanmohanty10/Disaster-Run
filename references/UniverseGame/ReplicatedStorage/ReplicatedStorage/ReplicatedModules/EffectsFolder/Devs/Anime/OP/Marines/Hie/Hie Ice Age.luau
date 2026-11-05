  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    local v3 = p2 or {};
    local Origin = v3.Origin;
    local v4 = v3.Size or 45;
    local v5 = v3.Lifetime or 5;
    local v6 = v3.SpikeAmount or 17;
    local Character = v3.Player.Character;
    local _ = Character.HumanoidRootPart;
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local v8 = AssetHandler.GetAbilityData(Character);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/IceAge/Release",
        AutoSerialize = true,
        AbilityName = v8.AbilityName,
        SkinName = v8.SkinName,
        HSVShift = v7
    });
    local Model = Instance.new("Model");
    Model.Name = Character.Name .. " Ice Age";
    Model.Parent = workspace.Effects;
    task.delay(10, Model.Destroy, Model);
    local u9 = AssetHandler.CloneAsset("Particles/IceAge/FrozenArea", v8);
    u9.CFrame = Origin;
    u9.Size = Vector3.new(3, 0.4, 3) * v4;
    ParticleHandler.Unusualify(u9, {
        HSVData = v7
    });
    u9.Parent = Model;
    task.delay(v5, function() -- Line: 52
        -- upvalues: ParticleHandler (ref), u9 (copy)
        ParticleHandler.EnableAllParticles(u9, false);
    end);
    local v10 = RaycastParams.new();
    v10.FilterType = Enum.RaycastFilterType.Include;
    v10.FilterDescendantsInstances = { workspace.Map };
    local v11 = workspace:Raycast(Origin.Position, Vector3.new(0, -40, 0), v10);

    if v11 then
        local u12 = AssetHandler.CloneAsset("Models/IceFloor", v8);
        u12.Mesh.Scale = Vector3.new(0.115, 0.045, 0.115) * v4;
        local v13 = CFrame.new(v11.Position, v11.Position + v11.Normal);
        local Angles = CFrame.Angles;
        local v14 = math.random(-360, 360);
        u12.CFrame = v13 * Angles(-1.5707963267948966, math.rad(v14), 0) * CFrame.new(0, v4 / 20, 0);
        u12.Decal.ZIndex = math.random(1, 4);
        ParticleHandler.Unusualify(u12, {
            HSVData = v7
        });
        u12.Parent = Model;
        local Scale = u12.Mesh.Scale;
        u12.Mesh.Scale = Vector3.new(0, 0, 0);
        TweenService:Create(u12.Mesh, TweenInfo.new(0.55, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.075), {
            Scale = Scale
        }):Play();
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 0.25;
        Highlight.FillColor = Color3.new(1, 1, 1);
        Highlight.Parent = u12;
        TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2), {
            FillTransparency = 1
        }):Play();
        task.delay(v5, function() -- Line: 88
            -- upvalues: TweenService (ref), u12 (copy)
            local v15 = TweenService:Create(u12, TweenInfo.new(1.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0.75), {
                CFrame = u12.CFrame * CFrame.new(0, -7, 0)
            });
            v15:Play();
            v15.Completed:Connect(function() -- Line: 94
                -- upvalues: u12 (ref)
                u12:Destroy();
            end);
        end);
        local v16 = CFrame.new(v11.Position, v11.Position + v11.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        local v17 = v4 * 0.1;
        local v18 = v4 * 1.2;
        local v19 = 1;

        while v17 <= v18 do
            local v20 = v19 * 3 + 9;
            local v21 = 360 / v20;
            local v22 = {};

            for i = 1, v20 do
                local v23 = u1:NextNumber(-v21 / 4, v21 / 4);
                local v24 = i * v21 + v23;
                local Position = v16.Position;
                local v25 = math.rad(v24);
                local v26 = math.cos(v25);
                local v27 = math.rad(v24);
                local v28 = math.sin(v27);
                local v29 = Position + Vector3.new(v26, 0, v28) * v17;
                local v30 = workspace:Raycast(v29 + Vector3.new(0, 30, 0), Vector3.new(0, -60, 0), v10);
                local v31 = v5 + v5 * (v17 / v18) / 10;

                if v30 then
                    table.insert(v22, { v30.Position, v30, v31 });
                end;
            end;

            local Model2 = Instance.new("Model");
            Model2.Name = "Ice Cube Group " .. v19;
            Model2.Parent = Model;
            local Highlight2 = Instance.new("Highlight");
            Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight2.OutlineTransparency = 1;
            Highlight2.FillTransparency = 0.25;
            Highlight2.FillColor = Color3.new(1, 1, 1);
            Highlight2.Parent = Model2;
            TweenService:Create(Highlight2, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2), {
                FillTransparency = 1
            }):Play();

            for i, v in v22 do
                local v32 = v[1];
                local _ = v[2];
                local _ = v[3];
                local v33 = u1:NextNumber(v4 / 20, v4 / 17) * v19;
                local u34 = Vector3.new(0, v33, 0);
                local u35 = AssetHandler.CloneAsset("Models/Cube", v8);
                u35.Position = v32 - u34;
                local v36 = u1:NextNumber(0, 360);
                local v37 = u1:NextNumber(0, 360);
                u35.Orientation = Vector3.new(v36, v37, u1:NextNumber(0, 360));
                ParticleHandler.Unusualify(u35, {
                    HSVData = v7
                });
                u35.Parent = Model2;

                if i % 4 == 0 then
                    local v38 = AssetHandler.CloneAsset("Particles/IceAge/Aura", v8);
                    ParticleHandler.Unusualify(v38, {
                        HSVData = v7
                    });
                    ParticleHandler.ScaleParticle(v38, v33);

                    for _, child in v38:GetChildren() do
                        child.Parent = u35;
                    end;

                    v38:Destroy();
                end;

                TweenService:Create(u35, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Position = u35.Position + u34
                }):Play();
                TweenService:Create(u35.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Scale = u35.Mesh.Scale * v33
                }):Play();
                task.delay(v5, function() -- Line: 173
                    -- upvalues: TweenService (ref), u35 (copy), u34 (copy)
                    local v39 = TweenService:Create(u35, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        Position = u35.Position - u34 * 2
                    });
                    v39.Completed:Connect(function() -- Line: 178
                        -- upvalues: u35 (ref)
                        u35:Destroy();
                    end);
                    v39:Play();
                end);
            end;

            v17 = v17 + v4 / 13 * (v19 * 1.04);
            v19 = v19 + 1;
            EffectsHandler.Wait(0.1);
        end;

        local Model2 = Instance.new("Model");
        Model2.Name = "Ice Spikes";
        Model2.Parent = Model;
        local Highlight2 = Instance.new("Highlight");
        Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight2.OutlineTransparency = 1;
        Highlight2.FillTransparency = 0.25;
        Highlight2.FillColor = Color3.new(1, 1, 1);
        Highlight2.Parent = Model2;
        local v40 = TweenService:Create(Highlight2, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2), {
            FillTransparency = 1
        });
        v40:Play();

        for i = 0, v6 - 1 do
            local v41 = i / v6 * 360;
            local v42 = workspace;
            local new = CFrame.new;
            local v43 = math.rad(v41);
            local v44 = math.cos(v43) * v4 * 0.95;
            local v45 = math.rad(v41);
            local v46 = v42:Raycast((v16 * new(v44, 0, math.sin(v45) * v4 * 0.95) * CFrame.new(0, 15, 0)).Position, Vector3.new(0, -50, 0), v10);

            if v46 then
                local u47 = v4 / 7;
                local u48 = AssetHandler.CloneAsset("Models/Spike", v8);
                u48.CFrame = CFrame.new(v46.Position, v16.Position) * CFrame.new(u1:NextNumber(-v4 / 20, v4 / 20), u1:NextNumber(-v4 / 5, 0), u1:NextNumber(-v4 / 20, v4 / 20));
                local CFrame2 = u48.CFrame;
                local Angles2 = CFrame.Angles;
                local v49 = u1:NextNumber(-5, 15);
                local v50 = math.rad(v49);
                local v51 = u1:NextNumber(-5, 5);
                local v52 = math.rad(v51);
                local v53 = u1:NextNumber(-5, 5);
                u48.CFrame = CFrame2 * Angles2(v50, v52, (math.rad(v53)));
                u48.Position = u48.Position - Vector3.new(0, u47, 0);
                ParticleHandler.Unusualify(u48, {
                    HSVData = v7
                });
                u48.Parent = Model2;
                v40.Completed:Connect(function() -- Line: 224
                    -- upvalues: u48 (copy)
                    u48.Transparency = 0.99;
                end);
                TweenService:Create(u48.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Scale = Vector3.new(1, 1, 1) * v4 / 14
                }):Play();
                TweenService:Create(u48, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Position = u48.Position + Vector3.new(0, u47, 0)
                }):Play();
                task.delay(v5, function() -- Line: 236
                    -- upvalues: TweenService (ref), u48 (copy), u47 (copy)
                    local v54 = TweenService:Create(u48, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                        CFrame = u48.CFrame * CFrame.new(0, -u47 * 4, 0)
                    });
                    v54:Play();
                    v54.Completed:Connect(function() -- Line: 241
                        -- upvalues: u48 (ref)
                        u48:Destroy();
                    end);
                end);
            end;
        end;
    end;
end;