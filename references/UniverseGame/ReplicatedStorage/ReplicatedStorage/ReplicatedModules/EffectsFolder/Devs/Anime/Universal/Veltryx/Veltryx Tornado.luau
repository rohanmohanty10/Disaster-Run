  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 16
    -- upvalues: Trove (copy), u1 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), RunService (copy), EffectsHandler (copy)
    local v3 = p2 or {};
    local RootPart = v3.RootPart;
    local HSVData = v3.HSVData;
    local Player = v3.Player;
    local Duration = v3.Duration;
    local CFrame2 = RootPart.CFrame;
    local v4 = Trove.new();
    task.delay(Duration, v4.Destroy, v4);
    local u5 = os.clock() - 0.1;
    local u6 = {};
    local v7 = RaycastParams.new();
    v7.FilterType = Enum.RaycastFilterType.Include;
    v7.FilterDescendantsInstances = { workspace.Map };
    local v8 = workspace:Raycast(CFrame2.Position, Vector3.new(0, -15, 0), v7);

    if v8 then
        local Instance2 = v8.Instance;
        local v9 = math.random(11, 14);

        for i = 1, v9 do
            local v10 = 6.283185307179586 / v9;
            local v11 = v10 * i + u1:NextNumber(-v10 * 0.8, v10 * 0.8);
            local v12 = u1:NextNumber(0, 360);
            local v13 = math.rad(v12);
            local v14 = u1:NextNumber(-1.25, 1.25) + 0.33;
            local v15 = u1:NextNumber(13.5, 15.75);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = true;
            Part.CastShadow = false;
            Part.CollisionGroup = "Ghosted";
            Part.CanTouch = false;
            Part.Material = v8.Material;
            Part.Color = Instance2.Color;
            Part.CFrame = CFrame2 * CFrame.new(math.cos(v11) * v15, v14, -math.sin(v11) * v15) * CFrame.Angles(v13, v13, v13);
            Part.Size = Vector3.new(1, 1, 1) * u1:NextNumber(0.4, 1.75);
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;

            for _, child in pairs(Instance2:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Clone().Parent = Part;
                end;
            end;

            u6[Part] = {
                Angle = v11,
                Radius = v15,
                Height = v14
            };
        end;
    end;

    local u16 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/Particles", AssetHandler.GetAbilityData(Player));
    ParticleHandler.Unusualify(u16, {
        Character = Player.Character
    });
    u16.Parent = workspace.Effects;
    v4:Add(function() -- Line: 85
        -- upvalues: ParticleHandler (ref), u16 (copy)
        ParticleHandler.EnableAllParticles(u16, false);
        ParticleHandler.DestroyEmit(u16);
    end);
    local u17 = table.create(7, CFrame.identity);
    local Model = Instance.new("Model");
    Model.Name = "Tornado Container";
    Model.Parent = workspace.Effects;

    for i = 1, 7 do
        local v18 = u1:NextNumber(1.3, 1.5);
        local v19 = u1:NextNumber(2, 5.5);
        local u20 = AssetHandler.CloneAsset("Particles/IncalculableSpeed/Ring", AssetHandler.GetAbilityData(Player));
        u20.Name = "Ring" .. i;
        local v21 = CFrame2 * CFrame.new(0, v19, 0);
        local Angles = CFrame.Angles;
        local v22 = u1:NextNumber(-15, 15);
        local v23 = math.rad(v22);
        local v24 = u1:NextNumber(-15, 15);
        u20.CFrame = v21 * Angles(v23, 0, (math.rad(v24)));
        ParticleHandler.Unusualify(u20, {
            Character = Player.Character
        });
        u20.Parent = Model;
        local v25 = u1:NextNumber(1.7, 34);

        for _, descendant in u20:GetDescendants() do
            if descendant:IsA("Attachment") then
                descendant.Position = descendant.Position * v18;
                local CFrame3 = descendant.CFrame;
                descendant.CFrame = CFrame.identity;
                TweenService:Create(descendant, TweenInfo.new(0.5 + u1:NextNumber(-0.25, 0.25), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    CFrame = CFrame3
                }):Play();
            elseif descendant:IsA("Beam") then
                local v26 = descendant.CurveSize0 * v18;
                local v27 = descendant.CurveSize1 * v18;
                descendant.TextureSpeed = v25;
                descendant.CurveSize0 = 0;
                descendant.CurveSize1 = 0;
                descendant.Width0 = descendant.Width0 * (v18 * u1:NextNumber(0.3, 0.5));
                descendant.Width1 = descendant.Width1 * (v18 * u1:NextNumber(0.3, 0.5));
                TweenService:Create(descendant, TweenInfo.new(0.5 + u1:NextNumber(-0.25, 0.25), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    CurveSize0 = v26,
                    CurveSize1 = v27,
                    Width0 = descendant.Width0 * 1.1,
                    Width1 = descendant.Width1 * 1.1
                }):Play();
            end;
        end;

        task.spawn(function() -- Line: 141
            -- upvalues: Duration (copy), u1 (ref), TweenService (ref), u20 (copy), CFrame2 (ref), u17 (copy)
            local v28 = u1:NextNumber(3.5, 4.5);

            for i2 = 1, (Duration + 1) * v28 do
                local v29 = CFrame.new(0, u1:NextNumber(-0.5, 0.5), 0);
                local Angles2 = CFrame.Angles;
                local v30 = u1:NextNumber(-15, 15);
                local v31 = math.rad(v30);
                local v32 = u1:NextNumber(-15, 15);
                local v33 = v29 * Angles2(v31, 0, (math.rad(v32))) * CFrame.Angles(0, 3.12413936106985, 0);
                local v34 = TweenService:Create(u20, TweenInfo.new(1 / v28, Enum.EasingStyle.Linear), {
                    CFrame = CFrame2 * (u17[i2] or CFrame.identity) * v33
                });
                v34:Play();
                v34.Completed:Wait();

                if u17[i2] then
                    local v35 = u17;
                    v35[i2] = v35[i2] * v33;
                end;
            end;
        end);
    end;

    local u36 = u1:NextNumber(11.5, 13);
    local u37 = u36 * 0.7;
    local u38 = CFrame2;
    v4:Connect(RunService.RenderStepped, function(p39) -- Line: 165
        -- upvalues: CFrame2 (ref), RootPart (copy), u38 (ref), u5 (ref), EffectsHandler (ref), u1 (ref), HSVData (copy), u16 (copy), u37 (copy), u6 (copy), u36 (copy)
        CFrame2 = RootPart.CFrame;
        local v40 = u38:Lerp(CFrame2, 0.2);

        if os.clock() - u5 >= 0.14 then
            u5 = os.clock();
            local CallEffect = EffectsHandler.CallEffect;
            local v41 = {
                Effect = "Tornado Swirl"
            };
            local v42 = v40 * CFrame.new(0, 6, 0);
            local Angles = CFrame.Angles;
            local v43 = u1:NextNumber(-360, 360);
            v41.Origin = v42 * Angles(0, math.rad(v43), 0);
            v41.HSVData = HSVData;
            CallEffect("Mesh Emit", v41);
            u38 = CFrame2;
        end;

        if u16:IsDescendantOf(game) then
            u16.Position = v40.Position;
            local v44 = u16;
            v44.Orientation = v44.Orientation + Vector3.new(0, u37 * p39 * 60, 0);
        end;

        for i, v in u6 do
            local v45 = u6[i];
            v45.Angle = v45.Angle + math.rad(u36 * p39 * 60);
            i.Position = (v40 * CFrame.new(math.cos(v.Angle) * v.Radius, v.Height, -math.sin(v.Angle) * v.Radius)).Position;
        end;
    end);
    v4:Add(function() -- Line: 195
        -- upvalues: EffectsHandler (ref), Model (copy), u6 (copy), CFrame2 (ref), u1 (ref), TweenService (ref)
        EffectsHandler.CallEffect("FadeBeams", Model);
        task.delay(0.5, Model.Destroy, Model);

        for i, _ in u6 do
            i.Anchored = false;
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000);
            BodyVelocity.Velocity = (Vector3.new(0, 1, 0)):Cross(i.Position - CFrame2.Position).Unit * u1:NextNumber(50, 80);
            BodyVelocity.Parent = i;
            task.delay(0.03, BodyVelocity.Destroy, BodyVelocity);
            local v46 = TweenService:Create(i, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1.5), {
                Size = Vector3.new(0, 0, 0)
            });
            v46:Play();
            v46.Completed:Connect(function() -- Line: 214
                -- upvalues: i (copy)
                i:Destroy();
            end);
        end;
    end);
end;