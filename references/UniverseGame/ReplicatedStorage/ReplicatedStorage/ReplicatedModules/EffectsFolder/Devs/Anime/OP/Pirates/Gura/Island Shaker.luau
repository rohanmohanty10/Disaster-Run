  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

return function(p4) -- Line: 19
    -- upvalues: u3 (copy), EffectsHandler (copy), u1 (copy), TweenService (copy), u2 (copy)
    local Origin = p4.Origin;
    local Scale = p4.Scale;
    local v5 = workspace:Raycast(Origin.Position, Vector3.new(0, -25, 0), u3);

    if v5 then
        local Position = v5.Position;
        local u6 = CFrame.new(Position, Position + v5.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0);
        EffectsHandler.CallEffect("Gura Crack", {
            Scale = 1.25,
            Origin = u6,
            CamSettings = { 12, 17, 0, 0.85, Vector3.new(1, 1, 1), Vector3.new(1, 1, 1) },
            Duration = { 0.07, 0.075 }
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = u6 * CFrame.new(0, 1, 0),
            Particle = u1.Gura.IslandShaker
        });

        for _ = 1, 2 do
            local CallEffect = EffectsHandler.CallEffect;
            local v7 = {};
            local v8 = Origin * CFrame.new(0, -4, 0);
            local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
            local v9 = math.random(0, 360);
            v7.Origin = v8 * fromEulerAnglesXYZ(0, math.rad(v9), 0);
            v7.Size = Vector3.new(1, 1, 1) * Scale;
            CallEffect("Anubis_Laceration", v7);
        end;

        EffectsHandler.CallEffect("Flying Debris", {
            Force = Vector3.new(45, 55, 45),
            Lifetime = 2,
            Amount = 9,
            Collision = true,
            Size = 5,
            TweenDelay = 1,
            Origin = Origin * CFrame.new(0, -4, 0),
            Tween = {
                Transparency = 1,
                Size = Vector3.new(0, 0, 0)
            }
        });
        EffectsHandler.CallEffect("Rock Debris", {
            Lifetime = 2.5,
            Amount = 33,
            Size = Vector3.new(6.3, 6.3, 6.3),
            Origin = u6 * CFrame.new(0, 0, -1),
            Radius = Scale
        });
        EffectsHandler.CallEffect("Q_RADIAL", {
            Effect = "Vignette Gui",
            Origin = u6,
            Distance = Scale * 1.25,
            Arguments = {
                {
                    TweenTime = 0.2,
                    Blur = 22,
                    StartingColor = Color3.new(0.137255, 0.415686, 0.862745),
                    EndingColor = Color3.new(0.0784314, 0.419608, 0.862745)
                }
            }
        });
        local v10 = u1.Gura.Shockwaves:Clone();
        v10:SetPrimaryPartCFrame(u6 * CFrame.new(0, 0, 1));
        v10.Parent = workspace.Effects;
        task.delay(0.45, v10.Destroy, v10);

        for _, child in v10:GetChildren() do
            local v11 = child.Size * (Scale / 3.25);
            TweenService:Create(child, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = v11,
                CFrame = child.CFrame * CFrame.new(0, 0, v11.Y / 15)
            }):Play();

            for _, child2 in child:GetChildren() do
                TweenService:Create(child2, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        local Part = Instance.new("Part");
        Part.Transparency = 0.3;
        Part.Shape = "Ball";
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3.new(0.494118, 0.647059, 1);
        Part.Size = Vector3.new(0, 0, 0);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.CFrame = u6 * CFrame.new(0, 4, 0);
        Part.Parent = workspace.Effects;
        task.delay(0.2, Part.Destroy, Part);
        TweenService:Create(Part, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(1, 1, 1) * Scale
        }):Play();
        local v12 = math.random(2, 3);
        local v13 = 360 / v12;

        for i = 1, v12 do
            local u14 = Scale + u2:NextNumber(-2, 3);
            local v15 = u2:NextNumber(-v13 / 5, v13 / 5);
            local u16 = v13 * i + v15;
            local u17 = u2:NextNumber(-1, 1);
            local u18 = u2:NextNumber(-300, -250);
            local u19 = u2:NextNumber(30, 35);
            local u20 = u1.Gura.CoilTrail:Clone();
            local new = CFrame.new;
            local v21 = math.rad(u16);
            local v22 = math.cos(v21) * u14;
            local v23 = math.rad(u16);
            u20.CFrame = u6 * new(v22, u17, math.sin(v23) * u14);
            u20.Parent = workspace.Effects;
            task.delay(3, u20.Destroy, u20);
            local u24 = os.clock();
            local u25 = u2:NextNumber(0.55, 0.85);
            task.spawn(function() -- Line: 122
                -- upvalues: u16 (ref), u6 (copy), u17 (ref), u18 (copy), u19 (copy), TweenService (ref), u20 (copy), u14 (copy), u24 (copy), u25 (copy)
                repeat
                    local v26 = task.wait();
                    local v27 = math.rad(u16);
                    local v28 = u6 * CFrame.new(0, math.sin(v27) ^ 2 * math.cos(v27) + u17, 0);
                    u16 = u16 + v26 * u18;
                    u17 = u17 + v26 * u19;
                    TweenService:Create(u20, TweenInfo.new(v26, Enum.EasingStyle.Linear), {
                        Position = (v28 * CFrame.new(math.cos(v27) * u14, 0, math.sin(v27) * u14)).Position
                    }):Play();
                until not u20:IsDescendantOf(game) or u25 < os.clock() - u24;

                if u20:IsDescendantOf(game) then
                    for _, descendant in u20:GetDescendants() do
                        if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;
                end;
            end);
        end;

        local v29 = { Color3.new(1, 1, 1), Color3.new(0.435294, 0.54902, 1) };

        for _ = 1, math.random(15, 20) do
            local v30 = u2:NextNumber(0, 6.283185307179586);
            local _ = CFrame.new(math.cos(v30), u2:NextNumber(0.25, 0.65), (math.sin(v30))).LookVector;
            local v31 = u1.Gura.Line:Clone();
            local Angles = CFrame.Angles;
            local v32 = math.random(-65, 65);
            local v33 = math.rad(v32);
            local v34 = math.random(-65, 65);
            local v35 = math.rad(v34);
            local v36 = math.random(-65, 65);
            v31.CFrame = u6 * Angles(v33, v35, (math.rad(v36)));
            v31.Color = v29[math.random(1, #v29)];
            local v37 = v31.Size.X * u2:NextNumber(1, 1.25);
            local v38 = v31.Size.Y * u2:NextNumber(0.9, 1.15);
            local v39 = v31.Size.Z * u2:NextNumber(1, 1.25);
            v31.Size = Vector3.new(v37, v38, v39);
            v31.Parent = workspace.Effects;
            task.delay(0.33, v31.Destroy, v31);
            TweenService:Create(v31, TweenInfo.new(0.33, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = Vector3.new(0, v31.Size.Y / 2, 0),
                CFrame = v31.CFrame * CFrame.new(0, u2:NextNumber(49, 69), 0)
            }):Play();
        end;
    end;
end;