  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local CollectionService = game:GetService("CollectionService");
game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Trove = require(PathShortcuts.ReplicatedModules.KnitPackage.Trove);
local v1 = script:FindFirstAncestor("ReplicatedModules");
local EffectsHandler = require(v1.EffectsHandler);

return function(u2, p3, u4, p5, u6) -- Line: 13
    -- upvalues: Trove (copy), CollectionService (copy), RunService (copy), TweenService (copy), EffectsHandler (copy), PathShortcuts (copy)
    local v7 = u2:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart or (not v7 or game.Players.LocalPlayer.Settings.ExtraProps.Value ~= true) then
        return;
    end;

    if not p3 then
        local Pose = u2:FindFirstChild("Pose");

        if Pose then
            Pose.Name = "Pose Off";
            Pose:Destroy();
        end;

        return;
    end;

    local u8 = Trove.new();
    local u9 = u8:Add(Instance.new("Model", u2));
    u9.Name = "Pose";
    local u10 = {};
    local u11 = {};

    for i = 1, 360, 8 do
        local Part = Instance.new("Part");
        Part.Size = Vector3.new(1, 1, 1);
        Part.CFrame = HumanoidRootPart.CFrame;
        Part.Material = Enum.Material.SmoothPlastic;
        Part.BrickColor = BrickColor.random();
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Parent = u9;
        u10[i] = Part;
    end;

    local u12 = nil;

    if not u12 then
        u12 = u2.Stand.StandHumanoidRootPart.PoseMusic;

        if u2.Stand.StandHumanoidRootPart:FindFirstChild("StandOffPoseMusic") and not CollectionService:HasTag(u2, "Summoned") then
            u12 = u2.Stand.StandHumanoidRootPart:FindFirstChild("StandOffPoseMusic");
        end;
    end;

    u8:Add((RunService.Heartbeat:Connect(function() -- Line: 55
        -- upvalues: u12 (ref), u2 (copy)
        if u12 and not u12.IsPlaying then
            for _, child in pairs(u2.Stand.StandHumanoidRootPart:GetChildren()) do
                if child:IsA("Sound") and (child ~= u12 and (string.find(child.Name, "PoseMusic") or string.find(child.Name, "StandOffPoseMusic"))) and child.IsPlaying then
                    u12 = child;

                    return;
                end;
            end;
        end;
    end)));
    local u13 = 1;
    local u14 = nil;
    local u15 = u8:Add(Instance.new("Highlight"));
    u15.DepthMode = Enum.HighlightDepthMode.Occluded;
    u15.OutlineColor = u4 or Color3.new(0.435294, 0.878431, 1);
    u15.FillColor = u4 or Color3.new(0.435294, 0.878431, 1);
    u15.FillTransparency = 0.9;
    u15.OutlineTransparency = 0;
    u15.Parent = u9;
    u15.Adornee = u2;
    local Part = Instance.new("Part");
    Part.Shape = Enum.PartType.Block;
    Part.Size = Vector3.new(0, 0, 0);
    Part.CFrame = HumanoidRootPart.CFrame;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Transparency = 0.4;
    Part.Material = Enum.Material.Neon;
    Part.Color = u4 or Color3.new(0.435294, 0.878431, 1);
    Part.Parent = u9;
    Part.CastShadow = false;
    local Part2 = Instance.new("Part");
    Part2.Shape = Enum.PartType.Block;
    Part2.Size = Vector3.new(0, 0, 0);
    Part2.Transparency = 0.8;
    Part2.CFrame = HumanoidRootPart.CFrame;
    Part2.Anchored = true;
    Part2.CanCollide = false;
    Part2.Material = Enum.Material.Neon;
    Part2.Color = u6 or (u4 or Color3.new(0.435294, 0.878431, 1));
    Part2.Parent = u9;
    Part2.CastShadow = false;
    local Model = Instance.new("Model", u9);
    math.floor(60 / (p5 / 60));
    local u16 = 1 / (p5 / 60);
    coroutine.wrap(function() -- Line: 114
        -- upvalues: u2 (copy), u15 (copy), TweenService (ref), u16 (copy)
        while u2:FindFirstChild("Pose") do
            u15.OutlineTransparency = 0;
            TweenService:Create(u15, TweenInfo.new(u16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                OutlineTransparency = 1
            }):Play();
            task.wait(u16);
        end;
    end)();
    u8:Add(RunService.RenderStepped:Connect(function(p17) -- Line: 122
        -- upvalues: u2 (copy), u8 (copy), u12 (ref), u9 (copy), HumanoidRootPart (copy), u13 (ref), u14 (ref), Part2 (copy), Part (copy), Model (copy), u15 (copy), EffectsHandler (ref), PathShortcuts (ref), u4 (copy), u6 (copy), TweenService (ref), u10 (copy), u11 (copy)
        if not u2:FindFirstChild("Pose") then
            u8:Destroy();
        end;

        if game.Players.LocalPlayer.Settings.ExtraProps.Value ~= true then
            u8:Destroy();
        end;

        local v18 = u12.TimePosition / u12.TimeLength;
        u9:GetChildren();
        local v19 = u12.PlaybackLoudness / 2;
        local v20 = 25 / (workspace.CurrentCamera.CFrame.p - HumanoidRootPart.CFrame.p).Magnitude;
        u13 = u13 + (1 + v19 / 360 - u13) * math.clamp(p17 * 10, 0, 1);
        u13 = u13 * 1;
        u14 = math.clamp(u13 - 1.5, 0, 1) * 8;
        Part2.Size = Part2.Size:Lerp(Vector3.new(0, 0, 0), p17 * 0.65);
        workspace.CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value + u14 * 5 * v20;
        Part.Size = Vector3.new(1, 1, 1) * u14 * 6 * v20;
        Part.CFrame = HumanoidRootPart.CFrame;
        Part2.CFrame = HumanoidRootPart.CFrame;

        if Part.Size.Magnitude > Part2.Size.Magnitude then
            Part2.Size = Part.Size;
        end;

        for _, child in pairs(Model:GetChildren()) do
            for _, child2 in pairs(child.Attachment:GetChildren()) do
                child2.TimeScale = (u13 - 0.9) / 1.7 - 0.3 - 0.01 * u15.OutlineTransparency ^ 4;
                child2.Transparency = NumberSequence.new(u15.OutlineTransparency);
            end;
        end;

        if u13 > 1.75 and not u9:FindFirstChild("FloorRippleGrid") then
            EffectsHandler.GetEffect("ChronoWarden_Ripple")(u2, {
                GridSize = 26,
                CellSize = 1.85,
                EffectParent = u9,
                Resonance = u13 ^ 2 / 5 + 20
            });
        end;

        if u13 > 1.7 then
            local u21 = PathShortcuts.ClientAssets["P//S_R"].PoseParticle:Clone();
            u21.CFrame = HumanoidRootPart.CFrame;
            u21.Parent = Model;
            task.delay(2, function() -- Line: 162
                -- upvalues: u21 (copy)
                u21:Destroy();
            end);

            for _, child in pairs(u21.Attachment:GetChildren()) do
                local v22 = math.random(0, 1) == 1 and u4 or u6;
                child.Color = ColorSequence.new(v22);
                child:Emit(1);
            end;
        end;

        if u13 > 1.5 then
            local Part3 = Instance.new("Part");
            Part3.Shape = Enum.PartType.Block;
            Part3.Material = Enum.Material.SmoothPlastic;
            Part3.Transparency = 0;
            Part3.Color = u4 or Color3.new(0.678431, 0.160784, 1);

            if math.random(0, 1) == 1 then
                Part3.Color = u6 or Color3.new(1, 1, 1);
            end;

            Part3.Size = Vector3.new(3, 3, 3) * (u13 / 1.7);
            Part3.Anchored = true;
            Part3.CanCollide = false;
            Part3.CastShadow = false;
            Part3.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10), math.random(0, 5), math.random(-10, 10));
            Part3.Parent = u9;
            TweenService:Create(Part3, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(0, 0, 0)
            }):Play();
            game.Debris:AddItem(Part3, 0.6);
        end;

        for i, v in pairs(u10) do
            if not u11[v] then
                u11[v] = 0;
            end;

            local v23 = u11;
            v23[v] = v23[v] + (0 - u11[v]) * math.clamp(p17 * 5, 0, 1);
            local v24 = CFrame.Angles(0, math.rad(i), 0) * CFrame.new(0, 0, u13 * -6);
            local v25 = CFrame.Angles(0, math.rad(v19), 0) * CFrame.new(0, 0, u13 * -6);
            local v26 = u11;
            v26[v] = v26[v] + (10 / ((v24.Position - v25.Position).Magnitude * 8 + 1) - u11[v]) * math.clamp(p17 * 10, 0, 1);
            v.Size = Vector3.new(1, 1.5 * u11[v], 1);
            v.CFrame = HumanoidRootPart.CFrame * v24 * CFrame.new(0, v.Size.Y / 2, 0) * CFrame.new(0, u15.OutlineTransparency * 0.8 * v18, 0);
            math.abs(i - 180);

            if not u6 then
                Color3.new(1, 1, 1);
            end;
        end;
    end));
end;