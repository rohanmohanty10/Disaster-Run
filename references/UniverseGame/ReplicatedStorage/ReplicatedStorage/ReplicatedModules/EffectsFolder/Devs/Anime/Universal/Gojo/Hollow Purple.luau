  

 

game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(u1, p2, p3) -- Line: 12
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), Debris (copy), LocalPlayer (copy), CurrentCamera (copy), EffectsHandler (copy)
    local wait = task.wait;
    ({ function() -- Line: 16
            -- upvalues: ReplicatedStorage (ref), u1 (copy), TweenService (ref), wait (copy), Debris (ref), LocalPlayer (ref), CurrentCamera (ref)
            for _ = 1, 5 do
                spawn(function() -- Line: 18
                    -- upvalues: ReplicatedStorage (ref), u1 (ref), TweenService (ref), wait (ref), Debris (ref)
                    local v4 = ReplicatedStorage["Client Assets"].Shock:Clone();
                    v4.Parent = workspace.Effects;
                    v4.CFrame = u1.CFrame;
                    v4.Transparency = 1;
                    local v5 = math.random(0, 360);
                    local v6 = math.random(0, 360);
                    v4.Orientation = Vector3.new(v5, v6, math.random(0, 360));
                    v4.Size = Vector3.new(6, 6, 6);
                    TweenService:Create(v4, TweenInfo.new(1), {
                        Transparency = 0
                    }):Play();
                    local v7 = tick();

                    while tick() - v7 < 1.5 do
                        v4.Position = u1.Position;
                        v4.Orientation = v4.Orientation + Vector3.new(1, -1, 1);
                        wait();
                    end;

                    local v8 = TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
                    local v9 = {
                        Transparency = 1,
                        Size = Vector3.new(40, 40, 40)
                    };
                    local Orientation = v4.Orientation;
                    local v10 = math.random(-5, 5);
                    local v11 = math.random(-5, 5);
                    v9.Orientation = Orientation + Vector3.new(v10, v11, math.random(-5, 5));
                    TweenService:Create(v4, v8, v9):Play();
                    Debris:AddItem(v4, 0.7);
                end);
            end;

            if (u1.CFrame.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                TweenService:Create(CurrentCamera, TweenInfo.new(1.5), {
                    FieldOfView = 100
                }):Play();
                wait(1.5);
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
                    Saturation = -1,
                    Contrast = -2
                }):Play();
                TweenService:Create(CurrentCamera, TweenInfo.new(0.3), {
                    FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
                }):Play();
                wait(0.05);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
                    Saturation = 0,
                    Contrast = 0
                }):Play();
                Debris:AddItem(ColorCorrectionEffect, 0.5);
            end;
        end, function() -- Line: 47
            -- upvalues: u1 (copy), LocalPlayer (ref), EffectsHandler (ref), TweenService (ref), Debris (ref), ReplicatedStorage (ref)
            local v12 = u1;

            if (v12.Origin - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 50 then
                if LocalPlayer.Settings.CameraShake.Value then
                    task.spawn(EffectsHandler.CallEffect, "CameraShake", "Explosion2");
                end;

                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.05), {
                    Saturation = -1,
                    Contrast = -2
                }):Play();
                delay(0.05, function() -- Line: 57
                    -- upvalues: TweenService (ref), ColorCorrectionEffect (copy), Debris (ref)
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
                        Saturation = 0,
                        Contrast = 0
                    }):Play();
                    Debris:AddItem(ColorCorrectionEffect, 0.5);
                end);
            end;

            for _ = 1, 2 do
                local v13 = ReplicatedStorage["Client Assets"].Shock:Clone();
                v13.Parent = workspace.Effects;
                v13.CFrame = CFrame.new(v12.Origin, v12.Origin + v12.Direction);
                local v14 = math.random(0, 360);
                local v15 = math.random(0, 360);
                v13.Orientation = Vector3.new(v14, v15, math.random(0, 360));
                local v16 = TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
                local v17 = {
                    Transparency = 1,
                    Size = Vector3.new(40, 40, 40)
                };
                local Orientation = v13.Orientation;
                local v18 = math.random(-5, 5);
                local v19 = math.random(-5, 5);
                v17.Orientation = Orientation + Vector3.new(v18, v19, math.random(-5, 5));
                TweenService:Create(v13, v16, v17):Play();
                Debris:AddItem(v13, 1.2);
            end;

            local v20 = ReplicatedStorage["Client Assets"].Gojo.HollowPurpleBall:Clone();
            v20.CFrame = CFrame.new(v12.Origin, v12.Origin + v12.Direction);
            v20.Parent = workspace.Effects;
            v20.Size = v20.Size * 1.5;
            local v21 = os.clock();
            local v22 = 0;

            while os.clock() - v21 < v12.MaxDistance / v12.Velocity do
                local v23 = task.wait(0.03);
                v22 = (v22 >= 360 and 0 or v22) + 5;
                v20.Transparency = 0;
                v20.CFrame = v20.CFrame * CFrame.new(0, 0, -(v12.Velocity * v23)) * CFrame.Angles(0, 0, (math.rad(v22)));

                for i = 1, 2 do
                    local v24 = Ray.new((v20.CFrame * CFrame.new(i == 1 and 5 or -5, 0, 0)).Position, Vector3.new(0, -10, 0));
                    local v25, v26 = game.Workspace:FindPartOnRayWithIgnoreList(v24, { game.Workspace.Living, game.Workspace.Effects });

                    if v25 then
                        local v27 = math.random(3, 4);
                        local Part = Instance.new("Part");
                        Part.Parent = game.Workspace.Effects;
                        Part.Material = v25.Material;
                        Part.Color = v25.Color;
                        Part.Size = Vector3.new(v27, v27, v27);
                        Part.Anchored = true;
                        Part.CanCollide = false;
                        Part.Position = v26;
                        local CFrame2 = Part.CFrame;
                        local Angles = CFrame.Angles;
                        local v28 = math.random(-360, 360);
                        local v29 = math.rad(v28);
                        local v30 = math.random(-360, 360);
                        local v31 = math.rad(v30);
                        local v32 = math.random(-360, 360);
                        Part.CFrame = CFrame2 * Angles(v29, v31, (math.rad(v32)));
                        Part.TopSurface = Enum.SurfaceType.Smooth;
                        Part.BottomSurface = Enum.SurfaceType.Smooth;
                        task.delay(0.4, function() -- Line: 122
                            -- upvalues: TweenService (ref), Part (copy)
                            TweenService:Create(Part, TweenInfo.new(2), {
                                CFrame = Part.CFrame + Vector3.new(0, -10, 0)
                            }):Play();
                            task.delay(2, Part.Destroy, Part);
                        end);
                    end;
                end;
            end;

            v20:Destroy();
        end })[p2]();
end;