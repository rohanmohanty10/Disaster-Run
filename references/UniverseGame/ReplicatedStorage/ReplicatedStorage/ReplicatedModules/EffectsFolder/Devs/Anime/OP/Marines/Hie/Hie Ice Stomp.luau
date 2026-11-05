  

 

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
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 21
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), u2 (copy), TweenService (copy), u1 (copy)
    local v4 = p3 or {};
    local Character = v4.Character;
    local Origin = v4.Origin;
    local Awakened = v4.Awakened;
    AssetHandler.GetAbilityData(Character);
    local v5 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if Awakened then
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Stomp/ChargedRelease",
            AutoSerialize = true,
            AbilityName = "Hie",
            Origin = Origin,
            HSVShift = v5
        });
    end;

    local CFrame2 = Character.HumanoidRootPart.CFrame;
    local v6 = { Vector3.new(1.4, 0.5, 1.4), Vector3.new(2, 0.6, 2), Vector3.new(2.7, 0.7, 2.7), Vector3.new(3.4, 0.8, 3.4), Vector3.new(3.85, 0.85, 3.85), Vector3.new(4.2, 0.9, 4.2) };

    for i = 1, 3 + (Awakened and 3 or 0) do
        local v7 = i * 0.2 + 0.5;
        local v8 = CFrame2 * CFrame.new(0, v7 * 3 + 5, -(i * 6 + 4));
        local v9 = workspace:Raycast(v8.Position, Vector3.new(0, -18, 0), u2);

        if v9 then
            local Unit = v8.LookVector:Cross(v9.Normal).Unit;
            local v10 = CFrame.fromMatrix(v9.Position, Unit, v9.Normal, Unit:Cross(v9.Normal).Unit) * CFrame.new(0, 2, 0);
            local Angles = CFrame.Angles;
            local v11 = math.random(90, 215);
            local v12 = v10 * Angles(0, math.rad(v11), 0);
            local u13 = AssetHandler.CloneAsset("Models/Spike", {
                AbilityName = "Hie"
            });
            u13.CFrame = v12 * CFrame.new(0, -v7 * 12, 0);
            u13.Mesh.Scale = Vector3.new(1, 1, 1) * (v7 - 0.2);
            u13.Name = "Ice Spike " .. i;
            ParticleHandler.Unusualify(u13, {
                IncludeTextures = true,
                IncludeParts = true,
                HSVData = v5
            });
            u13.Parent = workspace.Effects;
            local Highlight = Instance.new("Highlight");
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.OutlineTransparency = 1;
            Highlight.FillTransparency = 0.25;
            Highlight.FillColor = Color3.new(1, 1, 1);
            Highlight.Parent = u13;
            local v14 = TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2), {
                FillTransparency = 1
            });
            v14.Completed:Connect(function() -- Line: 91
                -- upvalues: u13 (copy)
                u13.Transparency = 0.99;
            end);
            v14:Play();
            local v15 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
            TweenService:Create(u13, v15, {
                CFrame = v12
            }):Play();
            TweenService:Create(u13.Mesh, v15, {
                Scale = Vector3.new(v7, v7 + 0.4, v7)
            }):Play();
            local v16 = i * 0.15 + 0.85;
            local CallEffect = EffectsHandler.CallEffect;
            local v17 = {
                Path = "Particles/Stomp/Appear",
                AutoSerialize = true,
                AbilityName = "Hie"
            };
            local v18 = v12 * CFrame.new(0, -2, i * 2);
            local Angles2 = CFrame.Angles;
            local v19 = u1:NextNumber(15, 23);
            v17.Origin = v18 * Angles2(math.rad(v19), 0, 0);
            v17.HSVShift = v5;
            v17.Scale = v16;
            CallEffect("Emit Particle V3", v17);
            local CallEffect2 = EffectsHandler.CallEffect;
            local v20 = {
                Path = "Particles/Stomp/Ground",
                AutoSerialize = true,
                AbilityName = "Hie"
            };
            local v21 = v12 * CFrame.new(0, -2, i * 2);
            local Angles3 = CFrame.Angles;
            local v22 = u1:NextNumber(15, 23);
            v20.Origin = v21 * Angles3(math.rad(v22), 0, 0);
            v20.HSVShift = v5;
            v20.Scale = v16;
            CallEffect2("Emit Particle V3", v20);
            local u23 = AssetHandler.CloneAsset("Models/GroundIce", {
                AbilityName = "Hie"
            });
            local v24 = v12 * CFrame.new(1, -1.85, i == 1 and -2 or 0);
            local Angles4 = CFrame.Angles;
            local v25 = u1:NextNumber(-40, 40);
            u23.CFrame = v24 * Angles4(0, math.rad(v25), 0);
            u23.Decal.ZIndex = i;
            ParticleHandler.Unusualify(u23, {
                IncludeTextures = true,
                IncludeParts = true,
                HSVData = v5
            });
            u23.Parent = workspace.Effects;
            local Highlight2 = Instance.new("Highlight");
            Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight2.OutlineTransparency = 1;
            Highlight2.FillTransparency = 0.25;
            Highlight2.FillColor = Color3.new(1, 1, 1);
            Highlight2.Parent = u23;
            TweenService:Create(Highlight2, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.2), {
                FillTransparency = 1
            }):Play();
            TweenService:Create(u23.Mesh, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = v6[i]
            }):Play();
            task.delay(i * 0.2 + 0.55, function() -- Line: 152
                -- upvalues: TweenService (ref), u13 (copy), EffectsHandler (ref), u23 (copy)
                TweenService:Create(u13, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    CFrame = u13.CFrame * CFrame.new(0, -15, 0)
                }):Play();
                EffectsHandler.Wait(0.35);
                u23.Transparency = 0.99;
                u13.Transparency = 0.99;
                task.spawn(EffectsHandler.CallEffect, "Hie Ice Dissolve", {
                    Time = 0.022,
                    Flipbook = "Ground",
                    Mesh = u23
                });
                task.spawn(EffectsHandler.CallEffect, "Hie Ice Dissolve", {
                    Time = 0.022,
                    Flipbook = "Spike",
                    Mesh = u13
                });
            end);
        end;

        EffectsHandler.Wait(0.06);
    end;
end;