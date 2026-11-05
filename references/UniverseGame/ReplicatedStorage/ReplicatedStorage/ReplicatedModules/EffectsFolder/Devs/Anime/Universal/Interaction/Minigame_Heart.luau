  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = require(ReplicatedStorage.ReplicatedModules.AnimationHandler).CreateAnimationById("Heartbeat", 14445320967);
local u2 = { Vector3.new(-3.5, 0, 0), Vector3.new(-1.4, 0, 0), Vector3.new(-0.9, 0.25, 0), Vector3.new(-0.35, -0.15, 0), Vector3.new(0, 1.2, 0), Vector3.new(0.35, -0.4, 0), Vector3.new(0.9, 0.2, 0), Vector3.new(3.5, 0, 0) };
local u3 = ColorSequence.new(Color3.fromRGB(100, 15, 15), Color3.fromRGB(140, 25, 25));

local function SpawnECG(p4) -- Line: 36
    -- upvalues: u2 (copy), u3 (copy), TweenService (copy), EffectsHandler (copy)
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(0.1, 0.1, 0.1);
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CFrame = p4;
    Part.Parent = workspace.CurrentCamera;
    local v5 = {};

    for i, v in u2 do
        local Attachment = Instance.new("Attachment");
        Attachment.Position = v;
        Attachment.Parent = Part;
        v5[i] = Attachment;
    end;

    local u6 = {};

    for i = 1, #v5 - 1 do
        local Beam = Instance.new("Beam");
        Beam.Attachment0 = v5[i];
        Beam.Attachment1 = v5[i + 1];
        Beam.Color = u3;
        Beam.Width0 = 0;
        Beam.Width1 = 0;
        Beam.LightEmission = 0.6;
        Beam.LightInfluence = 0;
        Beam.FaceCamera = true;
        Beam.Segments = 1;
        Beam.Transparency = NumberSequence.new(1);
        Beam.Parent = Part;
        u6[i] = Beam;
    end;

    task.spawn(function() -- Line: 72
        -- upvalues: u6 (copy), TweenService (ref), EffectsHandler (ref), Part (copy)
        local v7 = 0.25 / #u6;

        for _, v in u6 do
            v.Transparency = NumberSequence.new(0);
            v.Width0 = 0;
            v.Width1 = 0;
            TweenService:Create(v, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Width0 = 0.045,
                Width1 = 0.045
            }):Play();
            EffectsHandler.Wait(v7);
        end;

        EffectsHandler.CallEffect("FadeBeams", u6, {
            Delay = 0.3
        });
        task.delay(0.6, Part.Destroy, Part);
    end);

    return Part;
end;

return function() -- Line: 100
    -- upvalues: Trove (copy), AssetHandler (copy), TweenService (copy), LocalPlayer (copy), RunService (copy), CurrentCamera (copy), SpawnECG (copy), u1 (copy)
    local Heart = workspace.CurrentCamera:FindFirstChild("Heart");

    if Heart then
        if not LocalPlayer:GetAttribute("InMinigame") then
            Heart:Destroy();

            return;
        end;

        local Animator = Heart.AnimationController.Animator;

        for _, v in Animator:GetPlayingAnimationTracks() do
            v:Stop(0.1);
        end;

        local v8 = Animator:LoadAnimation(u1);
        v8.Priority = Enum.AnimationPriority.Action4;
        v8.Looped = false;
        v8:Play(0);
        Heart:SetAttribute("_Beat", os.clock());
    else
        local u9 = Trove.new();
        local u10 = AssetHandler.CloneAsset("Models/Heart", {
            AbilityName = "Thunder Breathing"
        });
        u10.Parent = workspace.CurrentCamera;
        u9:Add(function() -- Line: 108
            -- upvalues: TweenService (ref), u10 (ref)
            local v11 = TweenService:Create(u10.Heart, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            });
            v11.Completed:Connect(function() -- Line: 112
                -- upvalues: u10 (ref)
                u10:Destroy();
            end);
            v11:Play();
        end);
        local HeartRootPart = u10:WaitForChild("HeartRootPart");

        if not HeartRootPart then
            u9:Destroy();

            return;
        end;

        local Part = Instance.new("Part");
        Part.Size = Vector3.new(4, 4, 0.05);
        Part.Color = Color3.new(0, 0, 0);
        Part.Material = Enum.Material.Neon;
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanQuery = false;
        Part.CanTouch = false;
        Part.CastShadow = false;
        Part.CFrame = HeartRootPart.CFrame * CFrame.new(0, 0, 0.3);
        Part.Parent = u10;
        u9:Add(Part);
        u9:AttachToInstance(u10);
        u9:Connect(LocalPlayer:GetAttributeChangedSignal("InMinigame"), function() -- Line: 136
            -- upvalues: LocalPlayer (ref), u9 (copy)
            if not LocalPlayer:GetAttribute("InMinigame") then
                u9:Destroy();
            end;
        end);
        local u12 = CFrame.new();
        local u13 = {};
        u9:Connect(RunService.RenderStepped, function(p14) -- Line: 145
            -- upvalues: HeartRootPart (copy), CurrentCamera (ref), u12 (ref), u13 (copy), Part (copy)
            if HeartRootPart and HeartRootPart.Parent ~= nil then
                local v15 = CurrentCamera.CFrame * CFrame.new(0, 0.125, -1.25) * CFrame.Angles(0, 3.141592653589793, 0);
                HeartRootPart.CFrame = v15 * u12;

                for i = #u13, 1, -1 do
                    local v16 = u13[i];

                    if v16 and v16.Parent then
                        v16.CFrame = v15 * CFrame.new(0, -0.43, 0.15);
                    else
                        table.remove(u13, i);
                    end;
                end;

                Part.CFrame = v15 * CFrame.new(0, 0, 0.3);
            end;
        end);
        u10:GetAttributeChangedSignal("_Beat"):Connect(function() -- Line: 161
            -- upvalues: u10 (ref), TweenService (ref), u12 (ref), RunService (ref), SpawnECG (ref), HeartRootPart (copy), u13 (copy)
            local Highlight = Instance.new("Highlight");
            Highlight.FillColor = Color3.fromRGB(158, 0, 0);
            Highlight.FillTransparency = 0.4;
            Highlight.OutlineColor = Color3.fromRGB(89, 13, 13);
            Highlight.OutlineTransparency = 0;
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
            Highlight.Adornee = u10.Heart;
            Highlight.Parent = u10;
            TweenService:Create(Highlight, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
            task.delay(0.65, Highlight.Destroy, Highlight);
            u10:ScaleTo(1.2);
            task.delay(0.06, function() -- Line: 179
                -- upvalues: u10 (ref)
                if u10 and u10.Parent then
                    u10:ScaleTo(1);
                end;
            end);
            task.spawn(function() -- Line: 185
                -- upvalues: u12 (ref), RunService (ref)
                local v17 = os.clock();

                while os.clock() - v17 < 0.15 do
                    local v18 = 1 - (os.clock() - v17) / 0.15;
                    u12 = CFrame.new((math.random() - 0.5) * 2 * 0.035 * v18, (math.random() - 0.5) * 2 * 0.035 * v18, 0);
                    RunService.RenderStepped:Wait();
                end;

                u12 = CFrame.new();
            end);
            local v19 = SpawnECG(HeartRootPart.CFrame);
            table.insert(u13, v19);
        end);
    end;
end;