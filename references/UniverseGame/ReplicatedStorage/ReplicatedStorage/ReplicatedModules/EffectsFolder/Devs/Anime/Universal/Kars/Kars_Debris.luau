  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 24
    -- upvalues: ParticleHandler (copy), u2 (copy), u1 (copy), TweenService (copy)
    local v4 = p3.Origin or error("No location data");
    local v5 = p3.Radius or 10;
    local v6 = p3.RockCount or 8;
    local v7 = p3.Lifetime or 2;
    local u8 = p3.TweenTime or 0.6;
    local v9 = p3.ExpandTime or 0.15;
    local v10 = v5 * 2 * 3.141592653589793 / v6;
    local v11 = p3.BaseHeight or v10 * 0.4;
    local v12 = p3.BaseLength or v10;
    local v13 = ParticleHandler.TranslateToCFrame(v4);
    local v14 = workspace:Raycast(v13.Position, -v13.UpVector * 20, u2);

    if v14 then
        local u15 = CFrame.new(v14.Position, v14.Position + v14.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 2, 0);

        for i = 1, v6 do
            local v16 = 360 / v6 * i + u1:NextNumber(-20, 20);
            local v17 = v10 * u1:NextNumber(0.8, 1.2);
            local v18 = v11 * u1:NextNumber(0.8, 1.2);
            local v19 = v12 * u1:NextNumber(0.8, 1.2);
            local u20 = Vector3.new(v17, v18, v19) * (p3.SizeMultiplier or 1);
            local v21 = u20.Z / 2 + v5;
            local v22 = u15 * CFrame.Angles(0, math.rad(v16), 0) * CFrame.new(v21 * u1:NextNumber(0.8, 1.5), 0, 0);
            local v23 = CFrame.Angles(0, 1.5707963267948966, 0);
            local Angles = CFrame.Angles;
            local v24 = -u1:NextNumber(20, 40);
            local v25 = v22 * (v23 * Angles(math.rad(v24), 0, 0));
            local v26 = workspace:Raycast(v25.Position, u15.UpVector * -20, u2);

            if v26 then
                local Position = v25.Position;
                local u27 = v25 - Position + Vector3.new(Position.X, v26.Position.Y, Position.Z) + u15.UpVector * (-u20.Y * 0.3);
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.Material = v26.Material;
                Part.Color = v26.Instance.Color;
                Part.Size = u20 * 0.1;
                Part.CFrame = u27;
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Parent = workspace.Effects;

                for _, child in pairs(v26.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                TweenService:Create(Part, TweenInfo.new(v9 * u1:NextNumber(0.8, 1.2)), {
                    Size = u20
                }):Play();
                task.delay(v7 * u1:NextNumber(0.8, 1.2), function() -- Line: 80
                    -- upvalues: TweenService (ref), Part (copy), u8 (copy), u27 (ref), u15 (copy), u20 (copy)
                    local v28 = TweenService:Create(Part, TweenInfo.new(u8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0, 0, 0),
                        CFrame = u27 + u15.UpVector * -u20.Y
                    });
                    v28.Completed:Connect(function() -- Line: 86
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                    v28:Play();
                end);
            end;
        end;
    end;
end;