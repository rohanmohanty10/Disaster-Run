  

 

local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Output = game.ReplicatedStorage.Remotes.Output;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

local function toggleWater(p1) -- Line: 12
    -- upvalues: ReplicatedStorage (copy)
    if p1 then
        ReplicatedStorage["Client Assets"]["Big Glass Block"]:Clone().Parent = workspace.CurrentCamera;

        return;
    end;

    for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
        if child.Name == "Big Glass Block" then
            child:Destroy();
        end;
    end;
end;

local function Cutscene(p2, p3, p4) -- Line: 25
    -- upvalues: LocalPlayer (copy), RunService (copy), CollectionService (copy)
    local u5 = false;
    local u6 = p2:IsA("Model") and p2 and p2 or p2.Character;
    local u7 = {};

    local function v8() -- Line: 78
        -- upvalues: u5 (ref), u7 (copy)
        u5 = true;

        for _, v in pairs(u7) do
            for _, v2 in pairs(v) do
                v2:Disconnect();
            end;
        end;
    end;

    u7.User = {};
    u7.User.ParentChanged = u6:GetPropertyChangedSignal("Parent"):Connect(v8);
    u7.User.Died = u6.Humanoid.Died:Connect(v8);
    u7.Player = {};
    u7.Player.ParentChanged = LocalPlayer.Character:GetPropertyChangedSignal("Parent"):Connect(v8);
    u7.Player.Died = LocalPlayer.Character.Humanoid.Died:Connect(v8);

    if p3.ExtraConnections then
        u7.Extra = {};

        for i, v in pairs(p3.ExtraConnections) do
            if v[2] and (type(v[2]) ~= "string" or string.lower(v[2]) ~= "cancel") then
                u7[i] = v[1]:Connect(v[2]);
            else
                u7[i] = v[2]:Connect(v8);
            end;
        end;
    end;

    local function _(p9) -- Line: 108
        -- upvalues: RunService (ref), CollectionService (ref), u6 (copy), u5 (ref)
        local v10 = 0;
        local v11 = p9 or 0;

        while true do
            v10 = v10 + RunService.Heartbeat:Wait();

            if CollectionService:HasTag(u6, "Timestopped") then
                repeat
                    CollectionService:GetInstanceRemovedSignal("Timestopped"):Wait();
                until not CollectionService:HasTag(u6, "Timestopped");
            end;

            if v11 <= v10 or u5 == true then
                return v10;
            end;
        end;
    end;

    local v12 = 0;

    for _, v in pairs(p3.Actions) do
        local v13 = v[1];
        local v14 = v[2];

        if u5 == false then
            if v13 > 0 then
                if p4 then
                    task.wait(v13);
                else
                    task.wait(v13 - v12);
                end;
            else
                v13 = v12;
            end;

            if v[3] then
                coroutine.wrap(v[3])();
            end;

            coroutine.wrap(v14)();
            v12 = v13;
        elseif p3.Variables.Tweens then
            for _, v2 in pairs(p3.Variables.Tweens) do
                v2:Cancel();
            end;
        end;
    end;

    for _, v in pairs(u7) do
        for _, v2 in pairs(v) do
            v2:Disconnect();
        end;
    end;

    if p3.Cleanup and u5 == true then
        p3.cancel = true;
        p3.Cleanup();
    end;
end;

return function(p15, u16, p17) -- Line: 156
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), RunService (copy), Debris (copy), TweenService (copy), PlayerGui (copy), EffectsHandler (copy), Output (copy), Cutscene (copy)
    for _, v in pairs(p17) do
        v:Destroy();
    end;

    local u18;

    if u16 == LocalPlayer.Character then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://6864077728";
        u18 = u16.Humanoid:LoadAnimation(Animation);
    else
        u18 = nil;
    end;

    local v19 = ReplicatedStorage["Client Assets"].Gojo.DomainExpansionCutscene:Clone();
    v19.Parent = workspace;
    local CurrentCamera = game.Workspace.CurrentCamera;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local Part = Instance.new("Part");
    Part.Parent = game.Workspace;
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    local u20 = {};

    for _, child in ipairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if child:IsA("ScreenGui") and child.Enabled == true then
            table.insert(u20, child);
            child.Enabled = false;
        end;
    end;

    Part.CFrame = u16.Head.CFrame * CFrame.new(3, 0, -1) * CFrame.Angles(0, 1.5707963267948966, 0);
    local u21 = Random.new();
    local u22 = {
        Variables = {
            CC = game.Workspace.CurrentCamera,
            ClearParts = {},
            EnabledGuis = u20,
            GojoParts = {},
            ogAmbient = game.Lighting.Ambient,
            lightingObjects = game.Lighting:GetChildren(),
            OGC0 = u16.HumanoidRootPart.RootJoint.C0,
            OGBC0 = u16.Head.BlindfoldWeld.C0,
            RandomColors = {
                Color3.fromRGB(255, 0, 127),
                Color3.fromRGB(170, 0, 0),
                Color3.fromRGB(255, 0, 0),
                Color3.fromRGB(170, 0, 255)
            },
            anim = u18,
            delet = v19,
            Part = Part,
            CamConnection = RunService.Heartbeat:Connect(function() -- Line: 213
                -- upvalues: CurrentCamera (copy), Part (copy)
                CurrentCamera.CFrame = Part.CFrame;
            end),
            opos = u16.HumanoidRootPart.CFrame,
            Tweens = {}
        }
    };
    local Variables = u22.Variables;

    function u22.Cleanup() -- Line: 223
        -- upvalues: Variables (copy), u22 (ref), CurrentCamera (copy), u16 (copy), Debris (ref), TweenService (ref), u20 (copy)
        if Variables.Clouds then
            Variables.Clouds.Parent = workspace.Terrain;
        end;

        if u22.cancel then
            workspace.GameMusic.DomainExpansion:Stop();
        end;

        CurrentCamera.FieldOfView = 70;

        for _, v in pairs(Variables.lightingObjects) do
            pcall(function() -- Line: 232
                -- upvalues: v (copy)
                v.Parent = game.Lighting;
            end);
        end;

        game.Lighting.Brightness = 3;
        game.Lighting.Ambient = Variables.ogAmbient;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        pcall(function() -- Line: 239
            -- upvalues: Variables (ref), u16 (ref)
            if Variables.GojoParts then
                for i, v in pairs(Variables.GojoParts) do
                    i.Transparency = v;
                end;
            end;

            u16.HumanoidRootPart.CFrame = Variables.opos;

            for _, child in ipairs(u16:GetChildren()) do
                if string.find(child.Name, "NormalGojoHair") then
                    child.Transparency = 0;

                    for _, child2 in ipairs(child:GetChildren()) do
                        child2.Transparency = 0;
                    end;
                elseif string.find(child.Name, "GojoHair") then
                    child.Transparency = 1;

                    for _, child2 in ipairs(child:GetChildren()) do
                        child2.Transparency = 1;
                    end;
                end;
            end;

            u16.Head.BlindfoldWeld.C0 = Variables.OGBC0;
            u16.Blindfold.Transparency = 0;
        end);

        for _, child in pairs(workspace.CurrentCamera:GetChildren()) do
            if child.Name == "Big Glass Block" then
                child:Destroy();
            end;
        end;

        game.StarterGui:SetCore("ResetButtonCallback", true);

        if Variables.sb then
            Variables.sb:Destroy();
        end;

        if Variables.b then
            Variables.b:Destroy();
        end;

        if Variables.bababooey then
            Variables.bababooey:Destroy();
        end;

        if Variables.gamerfolder then
            Variables.gamerfolder:Destroy();
        end;

        if Variables.delet then
            Variables.delet:Destroy();
        end;

        if Variables.CamConnection then
            Variables.CamConnection:Disconnect();
        end;

        if Variables.lineC then
            Variables.lineC:Disconnect();
        end;

        if Variables.cc then
            Variables.cc.TintColor = Color3.new(1, 1, 1);
            Debris:AddItem(Variables.cc, 0.6);
            TweenService:Create(Variables.cc, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end;

        if Variables.BlS then
            Variables.BlS:Destroy();
        end;

        if Variables.ClearParts and next(Variables.ClearParts) then
            for i, v in pairs(Variables.ClearParts) do
                if type(v) == "boolean" then
                    i.Enabled = v;
                else
                    i.Transparency = v;
                end;
            end;
        end;

        if Variables.WhiteScreen then
            Variables.WhiteScreen:Destroy();
        end;

        if u20 and u20 ~= {} then
            for _, v in pairs(u20) do
                v.Enabled = true;
            end;
        end;
    end;

    u22.Actions = {
        { 0.5, function() -- Line: 296
                -- upvalues: Variables (copy), TweenService (ref), u16 (copy)
                Variables.Tweens.T = TweenService:Create(u16.Head.BlindfoldWeld, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    C0 = u16.Head.BlindfoldWeld.C0 * CFrame.new(0, -0.55, 0)
                });
                Variables.Tweens.T:Play();
            end },
        { 0.65, function() -- Line: 300
                -- upvalues: u16 (copy), TweenService (ref)
                for _, child in ipairs(u16:GetChildren()) do
                    if string.find(child.Name, "NormalGojoHair") then
                        child.Transparency = 1;

                        for _, child2 in ipairs(child:GetChildren()) do
                            TweenService:Create(child2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Transparency = 1
                            }):Play();
                        end;
                    elseif string.find(child.Name, "GojoHair") then
                        child.Transparency = 0;

                        for _, child2 in ipairs(child:GetChildren()) do
                            TweenService:Create(child2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end;
            end },
        { 1, function() -- Line: 315
                -- upvalues: u16 (copy), Variables (copy)
                u16.Blindfold.Transparency = 1;
                Variables.Part.CFrame = u16.Head.CFrame * CFrame.new(-0.3, 0, -1) * CFrame.Angles(0, 3.141592653589793, 0);
            end },
        { 2.5, function() -- Line: 319
                -- upvalues: TweenService (ref), Variables (copy)
                TweenService:Create(Variables.Part, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = Variables.Part.CFrame * CFrame.new(0, 0, 7)
                }):Play();
            end },
        { 3.8, function() -- Line: 322
                -- upvalues: Variables (copy), u16 (copy), TweenService (ref), CurrentCamera (copy), Part (copy)
                Variables.ModelStreamingCrap = {};

                for _, descendant in pairs(workspace:GetDescendants()) do
                    if not (descendant:IsDescendantOf(u16) or descendant:IsDescendantOf(workspace.DomainExpansionCutscene)) then
                        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("ParticleEmitter")) then
                            Variables.ClearParts[descendant] = descendant:FindFirstChild("OGTransparency") and descendant.OGTransparency.Value or descendant.Transparency;
                            descendant.Transparency = descendant:IsA("ParticleEmitter") and NumberSequence.new(1) or 1;
                        elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("SurfaceGui") or descendant:IsA("Beam")) then
                            Variables.ClearParts[descendant] = descendant.Enabled;
                            descendant.Enabled = false;
                        end;
                    end;
                end;

                Variables.Clouds = workspace.Terrain.Clouds;
                Variables.Clouds.Parent = nil;
                Variables.Bloom = Instance.new("BloomEffect");
                Variables.Bloom.Parent = game.Lighting;
                Variables.Bloom.Threshold = 4;
                local HumanoidRootPart = u16.HumanoidRootPart;
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 200, 0);
                local Part2 = Variables.Part;
                Part2.CFrame = Part2.CFrame * CFrame.new(0, 200, 0);
                Variables.T = TweenService:Create(CurrentCamera, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 120
                });
                Variables.T:Play();
                TweenService:Create(Variables.Part, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = Part.CFrame * CFrame.new(0, 0, 4)
                }):Play();
                Variables.DomainWalls = game.ReplicatedStorage["Client Assets"].Gojo.DomainWalls:Clone();
                Variables.DomainWalls.Parent = game.Workspace.Effects;
                Variables.DomainWalls:SetPrimaryPartCFrame(u16.HumanoidRootPart.CFrame);
                Variables.sb = game.ReplicatedStorage["Client Assets"].Galaxy:Clone();
                Variables.sb.Parent = game.Lighting;
                wait(0.5);
                Variables.DomainWalls:Destroy();
                Variables.Bloom:Destroy();
            end },
        { 4.3, function() -- Line: 358
                -- upvalues: Variables (copy), PlayerGui (ref), TweenService (ref), ReplicatedStorage (ref), RunService (ref), u16 (copy), Debris (ref), EffectsHandler (ref)
                Variables.WhiteScreen = Instance.new("ScreenGui", PlayerGui);
                Variables.WhiteScreen.Name = "WhiteScreen";
                Variables.WhiteScreen.IgnoreGuiInset = true;
                Variables.WS = Instance.new("Frame", Variables.WhiteScreen);
                Variables.WS.BackgroundColor3 = Color3.new(1, 1, 1);
                Variables.WS.Size = UDim2.new(1, 0, 1, 0);
                Variables.WS.BackgroundTransparency = 1;
                Variables.WS.ZIndex = 10000;
                Variables.WhiteScreen.Enabled = true;
                Variables.WhiteScreen.Frame.BackgroundTransparency = 0;
                TweenService:Create(Variables.WhiteScreen.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play();
                game.Lighting.Brightness = 0;
                game.Lighting.Ambient = Color3.fromRGB(136, 0, 255);

                for _, v in pairs(Variables.lightingObjects) do
                    pcall(function() -- Line: 376
                        -- upvalues: v (copy)
                        v.Parent = nil;
                    end);
                end;

                ReplicatedStorage["Client Assets"]["Big Glass Block"]:Clone().Parent = workspace.CurrentCamera;
                Variables.lineC = RunService.Heartbeat:Connect(function() -- Line: 383
                    -- upvalues: Variables (ref), u16 (ref), TweenService (ref), Debris (ref)
                    for _ = 1, 15 do
                        local v23 = Variables.RandomColors[math.random(#Variables.RandomColors)];
                        local v24 = game.ReplicatedStorage["Client Assets"].Gojo.DomainPart:Clone();
                        v24.Parent = game.Workspace.Effects;
                        v24.Trail.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v23), ColorSequenceKeypoint.new(1, v23) });
                        v24.CFrame = u16.HumanoidRootPart.CFrame * CFrame.new(math.random(-20, 20), math.random(-20, 20), 100);
                        TweenService:Create(v24, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            CFrame = v24.CFrame * CFrame.new(0, 0, -200)
                        }):Play();
                        Debris:AddItem(v24, 0.6);
                    end;
                end);
                task.spawn(EffectsHandler.CallEffect, "CameraShake", "LongerExplosion");
                TweenService:Create(Variables.Part, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    CFrame = u16.HumanoidRootPart.CFrame * CFrame.Angles(0, 2.6179938779914944, 0) * CFrame.new(3, 2, 13)
                }):Play();

                for _, descendant in pairs(u16:GetDescendants()) do
                    if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                        Variables.GojoParts[descendant] = descendant.Transparency;
                        TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Transparency = 1
                        }):Play();
                    end;
                end;

                TweenService:Create(u16.HumanoidRootPart.RootJoint, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    C0 = u16.HumanoidRootPart.RootJoint.C0 * CFrame.new(0, 10, 0)
                }):Play();
            end },
        { 4.8, function() -- Line: 411
                -- upvalues: Variables (copy), TweenService (ref), u16 (copy)
                Variables.Tweens.T = TweenService:Create(Variables.CC, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
                });
                Variables.Tweens.T:Play();
                TweenService:Create(Variables.Part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = u16.HumanoidRootPart.CFrame * CFrame.new(10, 2, -25) * CFrame.Angles(0, 1.5707963267948966, 0)
                }):Play();
            end },
        { 5.1, function() -- Line: 416
                -- upvalues: u16 (copy), Variables (copy), TweenService (ref)
                u16.HumanoidRootPart.RootJoint.C0 = Variables.OGC0;
                TweenService:Create(Variables.Part, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = u16.HumanoidRootPart.CFrame * CFrame.new(8, 2, -30) * CFrame.Angles(0, 0.6981317007977318, 0)
                }):Play();
            end },
        { 5.4, function() -- Line: 420
                -- upvalues: TweenService (ref), Variables (copy)
                TweenService:Create(Variables.Part, TweenInfo.new(20, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = Variables.Part.CFrame * CFrame.new(0, 0, -5)
                }):Play();
            end },
        { 6.4, function() -- Line: 423
                -- upvalues: Variables (copy), TweenService (ref)
                game.Workspace.DomainExpansionCutscene.Bubbles1.ParticleEmitter.Enabled = true;
                Variables.Part.CFrame = game.Workspace.DomainExpansionCutscene.Cam1.CFrame;
                Variables.Tweens.T = TweenService:Create(Variables.Part, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = game.Workspace.DomainExpansionCutscene.Cam1.CFrame * CFrame.new(0, 0, -10)
                });
                Variables.Tweens.T:Play();
            end },
        { 6.9, function() -- Line: 429
                -- upvalues: Variables (copy), u16 (copy)
                game.Workspace.DomainExpansionCutscene.Bubbles1.ParticleEmitter.Enabled = false;
                Variables.Tweens.T:Pause();
                Variables.Part.CFrame = u16.HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-50, 2, 5);
            end },
        { 7.6, function() -- Line: 434
                -- upvalues: Variables (copy), TweenService (ref)
                Variables.Part.CFrame = game.Workspace.DomainExpansionCutscene.Cam2.CFrame;
                Variables.Tweens.T = TweenService:Create(Variables.Part, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = game.Workspace.DomainExpansionCutscene.Cam2.CFrame * CFrame.new(0, 0, -10)
                });
                Variables.Tweens.T:Play();
                game.Workspace.DomainExpansionCutscene.Bubbles2.ParticleEmitter.Enabled = true;
                game.Workspace.DomainExpansionCutscene.Bubbles2.ParticleEmitter2.Enabled = true;
            end },
        { 8.1, function() -- Line: 441
                -- upvalues: Variables (copy), u16 (copy)
                Variables.Tweens.T:Pause();
                Variables.Part.CFrame = u16.HumanoidRootPart.CFrame * CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(-50, 2, 5);
            end },
        { 8.9, function() -- Line: 445
                -- upvalues: Variables (copy), TweenService (ref)
                Variables.Part.CFrame = game.Workspace.DomainExpansionCutscene.Cam3.CFrame;
                Variables.Tweens.T = TweenService:Create(Variables.Part, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    CFrame = game.Workspace.DomainExpansionCutscene.Cam3.CFrame * CFrame.new(0, 0, -10)
                });
                Variables.Tweens.T:Play();
            end },
        { 9.5, function() -- Line: 450
                -- upvalues: Variables (copy), u16 (copy), TweenService (ref), EffectsHandler (ref)
                Variables.Tweens.T:Pause();
                Variables.Part.CFrame = u16.HumanoidRootPart.CFrame * CFrame.Angles(0, -3.490658503988659, 0.2617993877991494) * CFrame.new(-2, 2, 5);
                Variables.Tweens.T = TweenService:Create(Variables.Part, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = u16.HumanoidRootPart.CFrame * CFrame.Angles(0, -3.2288591161895095, 0) * CFrame.new(0, 2, 40)
                });
                Variables.Tweens.T2 = TweenService:Create(Variables.CC, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    FieldOfView = 80
                });
                Variables.Tweens.T:Play();
                Variables.Tweens.T2:Play();
                task.spawn(EffectsHandler.CallEffect, "CameraShake", "IntensifyingShake");
            end },
        { 11.5, function() -- Line: 459
                -- upvalues: TweenService (ref), Variables (copy)
                TweenService:Create(Variables.WhiteScreen.Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    BackgroundTransparency = 0
                }):Play();
            end },
        { 12, function() -- Line: 462
                -- upvalues: Variables (copy), u16 (copy), TweenService (ref)
                game.Lighting.Ambient = Color3.fromRGB(119, 119, 119);
                Variables.Tweens.T:Pause();
                Variables.Part.CFrame = u16.HumanoidRootPart.CFrame * CFrame.new(0, 1.5, -10) * CFrame.Angles(0, 3.141592653589793, 0);
                Variables.CC.FieldOfView = 70;
                Variables.gamerfolder = Instance.new("Folder", workspace.Effects);
                Variables.gamerfolder.Name = "DEStuff";
                local Part2 = Instance.new("Part", Variables.gamerfolder);
                Part2.Size = Vector3.new(1000, 600, 0);
                Part2.CFrame = Variables.Part.CFrame * CFrame.new(0, 0, -300) * CFrame.Angles(0, 3.141592653589793, 0);
                Part2.Anchored = true;
                Part2.Transparency = 1;
                Part2.CanCollide = false;
                Instance.new("SurfaceGui", Part2).LightInfluence = 0;
                local ImageLabel = Instance.new("ImageLabel", Part2.SurfaceGui);
                ImageLabel.Image = "rbxassetid://6829158377";
                ImageLabel.Size = UDim2.new(1, 0, 1, 0);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.ImageTransparency = 0.05;
                Variables.lineC:Disconnect();
                TweenService:Create(Variables.WhiteScreen.Frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1
                }):Play();
                local Part3 = Instance.new("Part", Variables.gamerfolder);
                Part3.Size = Vector3.new(1000, 400, 0);
                Part3.CFrame = Variables.Part.CFrame * CFrame.new(0, 3, -230) * CFrame.Angles(0.08726646259971647, 3.141592653589793, -0.3490658503988659);
                Part3.Anchored = true;
                Part3.Transparency = 1;
                Part3.CanCollide = false;
                local SurfaceGui = Instance.new("SurfaceGui", Part3);
                local Frame = Instance.new("Frame", SurfaceGui);
                Frame.ClipsDescendants = true;
                Frame.Size = UDim2.new(0, 0, 1, 0);
                Frame.BackgroundTransparency = 1;
                local ImageLabel2 = Instance.new("ImageLabel", Frame);
                ImageLabel2.BackgroundTransparency = 1;
                ImageLabel2.Image = "http://www.roblox.com/asset/?id=6548710932";
                ImageLabel2.Size = UDim2.new(2, 0, 1, 0);
                wait(1.5);
                TweenService:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(1, 0, 1, 0)
                }):Play();
                TweenService:Create(ImageLabel2, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(1, 0, 1, 0)
                }):Play();
            end },
        { 14, function() -- Line: 503
                -- upvalues: Variables (copy), u21 (copy)
                local Part2 = Instance.new("Part", Variables.gamerfolder);
                Part2.Size = Vector3.new(600, 600, 0);
                Part2.CFrame = Variables.Part.CFrame * CFrame.new(-20, 5, -280) * CFrame.Angles(0, 3.490658503988659, 0.2617993877991494);
                Part2.Anchored = true;
                Part2.Transparency = 1;
                Part2.CanCollide = false;
                local SurfaceGui = Instance.new("SurfaceGui", Part2);
                local Frame = Instance.new("Frame", SurfaceGui);
                Frame.Size = UDim2.new(1, 0, 1, 0);
                Frame.BackgroundTransparency = 1;
                local ImageLabel = Instance.new("ImageLabel", Frame);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Image = "http://www.roblox.com/asset/?id=6548709859";
                ImageLabel.Size = UDim2.new(1, 0, 1, 0);
                spawn(function() -- Line: 518
                    -- upvalues: Frame (copy), u21 (ref)
                    for i = 0.05, 0, -0.01 do
                        Frame.Position = UDim2.new(u21:NextNumber(-i, i), 0, u21:NextNumber(-i, i), 0);
                        wait();
                    end;

                    Frame.Position = UDim2.new(0, 0, 0, 0);
                end);
            end },
        { 14.25, function() -- Line: 526
                -- upvalues: Variables (copy), u21 (copy)
                local Part2 = Instance.new("Part", Variables.gamerfolder);
                Part2.Size = Vector3.new(500, 500, 0);
                Part2.CFrame = Variables.Part.CFrame * CFrame.new(20, -10, -230) * CFrame.Angles(0, 2.792526803190927, 3.3161255787892263);
                Part2.Anchored = true;
                Part2.Transparency = 1;
                Part2.CanCollide = false;
                local SurfaceGui = Instance.new("SurfaceGui", Part2);
                local Frame = Instance.new("Frame", SurfaceGui);
                Frame.Size = UDim2.new(1, 0, 1, 0);
                Frame.BackgroundTransparency = 1;
                local ImageLabel = Instance.new("ImageLabel", Frame);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Image = "http://www.roblox.com/asset/?id=6548711741";
                ImageLabel.Size = UDim2.new(1, 0, 1, 0);
                spawn(function() -- Line: 541
                    -- upvalues: Frame (copy), u21 (ref)
                    for i = 0.05, 0, -0.01 do
                        Frame.Position = UDim2.new(u21:NextNumber(-i, i), 0, u21:NextNumber(-i, i), 0);
                        wait();
                    end;

                    Frame.Position = UDim2.new(0, 0, 0, 0);
                end);
                local Part3 = Instance.new("Part", Variables.gamerfolder);
                Part3.Size = Vector3.new(250, 250, 0);
                Part3.CFrame = Variables.Part.CFrame * CFrame.new(20, -10, -230) * CFrame.Angles(0, 3.141592653589793, 2.9670597283903604);
                Part3.Anchored = true;
                Part3.Transparency = 1;
                Part3.CanCollide = false;
                local SurfaceGui2 = Instance.new("SurfaceGui", Part3);
                local Frame2 = Instance.new("Frame", SurfaceGui2);
                Frame2.Size = UDim2.new(1, 0, 1, 0);
                Frame2.BackgroundTransparency = 1;
                local ImageLabel2 = Instance.new("ImageLabel", Frame2);
                ImageLabel2.BackgroundTransparency = 1;
                ImageLabel2.Image = "http://www.roblox.com/asset/?id=6548711741";
                ImageLabel2.Size = UDim2.new(1, 0, 1, 0);
                spawn(function() -- Line: 562
                    -- upvalues: Frame2 (copy), u21 (ref)
                    for i = 0.05, 0, -0.01 do
                        Frame2.Position = UDim2.new(u21:NextNumber(-i, i), 0, u21:NextNumber(-i, i), 0);
                        wait();
                    end;

                    Frame2.Position = UDim2.new(0, 0, 0, 0);
                end);
            end },
        { 14.75, function() -- Line: 570
                -- upvalues: Variables (copy), TweenService (ref), u16 (copy), Debris (ref), PlayerGui (ref), u18 (ref), u21 (copy)
                for i, v in pairs(Variables.GojoParts) do
                    TweenService:Create(i, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = v
                    }):Play();
                end;

                local v25 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

                for _, child in pairs(u16:GetChildren()) do
                    if child:IsA("BasePart") and table.find(v25, child.Name) then
                        local v26 = child:Clone();
                        v26.Parent = workspace.Effects;
                        v26.Size = v26.Size + Vector3.new(1, 1, 1);
                        v26.BrickColor = BrickColor.new("Institutional white");
                        v26.Material = Enum.Material.Neon;
                        v26.Transparency = 0;
                        TweenService:Create(v26, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Transparency = 1,
                            Size = v26.Size - Vector3.new(1, 1, 1)
                        }):Play();
                        Debris:AddItem(v26, 0.5);
                    end;
                end;

                spawn(function() -- Line: 588
                    -- upvalues: u16 (ref), PlayerGui (ref), TweenService (ref)
                    local FakeHead = u16.FakeHead;
                    local ScreenGui = Instance.new("ScreenGui", PlayerGui);
                    ScreenGui.Name = "Subtitles";
                    local TextLabel = Instance.new("TextLabel", ScreenGui);
                    TextLabel.Size = UDim2.new(0.7, 0, 0.08, 0);
                    TextLabel.Position = UDim2.new(0.5, 0, 0.9, 0);
                    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
                    TextLabel.TextColor3 = Color3.new(1, 1, 1);
                    TextLabel.BackgroundTransparency = 1;
                    TextLabel.TextTransparency = 1;
                    TextLabel.TextScaled = true;
                    TextLabel.Font = Enum.Font.RobotoMono;
                    TextLabel.TextStrokeTransparency = 0;
                    local v27 = { { 0, "face" }, { 0.75, "talk1", "Ironic, isn\'t it?" }, { 0.85, "talk2" }, { 0.95, "talk1" }, { 1.05, "talk2" }, { 1.1, "talk1" }, { 1.2, "face" }, { 1.25, "talk2" }, { 1.4, "talk1" }, { 1.8, "face", true }, { 2.4, "talk1", "When granted everything, ", "you can\'t do anything." }, { 2.5, "talk2" }, { 2.65, "face" }, { 2.7, "talk2" }, { 2.75, "talk1" }, { 3, "talk2" }, { 3.1, "talk1" }, { 3.15, "talk2" }, { 3.2, "talk1" }, { 3.25, "talk2" }, { 3.3, "face" }, { 3.35, "talk2" }, { 3.4, "talk1" }, { 3.45, "talk2" }, { 3.5, "face" }, { 3.55, "talk1" }, { 3.6, "talk2" }, { 3.65, "face" }, { 3.7, "talk2" }, { 4, "face" }, { 4.5, "talk1", "you can\'t do anything.", true }, { 4.55, "talk2" }, { 4.65, "talk1" }, { 4.7, "talk2" }, { 4.8, "face" }, { 4.85, "talk2" }, { 4.95, "face" }, { 5, "talk1" }, { 5.1, "face" }, { 5.15, "talk2" }, { 5.2, "talk1" }, { 5.3, "talk2" }, { 5.6, "face", true } };

                    local function setframe(p28) -- Line: 590
                        -- upvalues: FakeHead (copy)
                        for _, child in pairs(FakeHead:GetChildren()) do
                            if child:IsA("Decal") then
                                child.Transparency = 1;
                            end;
                        end;

                        FakeHead[p28].Transparency = 0;
                    end;

                    for i, v in pairs(v27) do
                        if i > 1 then
                            wait(v[1] - v27[i - 1][1]);
                        end;

                        if v[3] then
                            if type(v[3]) == "boolean" then
                                TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                                    TextTransparency = 1,
                                    TextStrokeTransparency = 1
                                }):Play();
                            else
                                TextLabel.MaxVisibleGraphemes = (not v[4] or type(v[4]) ~= "boolean") and 0 or TextLabel.MaxVisibleGraphemes;
                                TextLabel.Text = not v[4] and v[3] or (type(v[4]) ~= "boolean" and v[3] .. v[4] or TextLabel.Text);
                                TweenService:Create(TextLabel, TweenInfo.new(0.75, Enum.EasingStyle.Linear), {
                                    MaxVisibleGraphemes = (v[4] and type(v[4]) == "boolean" or not v[4]) and #TextLabel.Text or #v[3]
                                }):Play();
                                TweenService:Create(TextLabel, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                                    TextTransparency = 0,
                                    TextStrokeTransparency = 0
                                }):Play();
                            end;
                        end;

                        setframe(v[2]);
                    end;
                end);

                if u18 then
                    u18:Play();
                end;

                spawn(function() -- Line: 673
                    -- upvalues: u16 (ref), u21 (ref)
                    local CFrame2 = u16.HumanoidRootPart.CFrame;

                    for i = 0.05, 0, -0.01 do
                        u16.HumanoidRootPart.CFrame = CFrame2 * CFrame.new(u21:NextNumber(-i, i), 0, 0);
                        wait();
                    end;

                    u16.HumanoidRootPart.CFrame = CFrame2;
                end);
            end },
        { 16.75, function() -- Line: 682
                -- upvalues: Variables (copy), TweenService (ref), u16 (copy), u21 (copy)
                Variables.b = Instance.new("BlurEffect", game.Lighting);
                Variables.b.Size = 0;
                Variables.b.Name = "DEblur";

                for i, _ in pairs(Variables.GojoParts) do
                    TweenService:Create(i, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                end;

                TweenService:Create(Variables.b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = 50
                }):Play();
                wait(0.1);
                TweenService:Create(Variables.b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = 0
                }):Play();
                local HumanoidRootPart = u16.HumanoidRootPart;
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -4);

                for i, v in pairs(Variables.GojoParts) do
                    TweenService:Create(i, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = v
                    }):Play();
                end;

                spawn(function() -- Line: 696
                    -- upvalues: u16 (ref), u21 (ref)
                    local CFrame2 = u16.HumanoidRootPart.CFrame;

                    for i = 0.05, 0, -0.01 do
                        u16.HumanoidRootPart.CFrame = CFrame2 * CFrame.new(u21:NextNumber(-i, i), 0, 0);
                        wait();
                    end;

                    u16.HumanoidRootPart.CFrame = CFrame2;
                end);
            end },
        { 18.75, function() -- Line: 705
                -- upvalues: Variables (copy), TweenService (ref), u16 (copy), u21 (copy)
                for i, _ in pairs(Variables.GojoParts) do
                    TweenService:Create(i, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Transparency = 1
                    }):Play();
                end;

                TweenService:Create(Variables.b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = 50
                }):Play();
                wait(0.1);
                TweenService:Create(Variables.b, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Size = 0
                }):Play();
                local HumanoidRootPart = u16.HumanoidRootPart;
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -4);

                for i, v in pairs(Variables.GojoParts) do
                    TweenService:Create(i, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = v
                    }):Play();
                end;

                spawn(function() -- Line: 716
                    -- upvalues: u16 (ref), u21 (ref)
                    local CFrame2 = u16.HumanoidRootPart.CFrame;

                    for i = 0.05, 0, -0.01 do
                        u16.HumanoidRootPart.CFrame = CFrame2 * CFrame.new(u21:NextNumber(-i, i), 0, 0);
                        wait();
                    end;

                    u16.HumanoidRootPart.CFrame = CFrame2;
                end);
            end },
        { 20.75, function() -- Line: 725
                -- upvalues: LocalPlayer (ref), u16 (copy), Output (ref), Variables (copy), TweenService (ref)
                if LocalPlayer.Character == u16 then
                    Output:FireServer("DEFinish");
                end;

                Variables.b:Destroy();
                Variables.cc = Instance.new("ColorCorrectionEffect", game.Lighting);
                Variables.cc.Name = "DEcc";
                Variables.bababooey = game.ReplicatedStorage["Client Assets"].Gojo.DomainWalls:Clone();
                Variables.bababooey.Parent = game.Workspace.Effects;
                Variables.bababooey:SetPrimaryPartCFrame(u16.HumanoidRootPart.CFrame);

                for _, child in pairs(Variables.bababooey:GetChildren()) do
                    if child ~= Variables.bababooey.PrimaryPart then
                        child.Transparency = 1;
                        TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                            Transparency = 0
                        }):Play();
                    end;
                end;
            end },
        { 21.25, function() -- Line: 743
                -- upvalues: Variables (copy), TweenService (ref), PlayerGui (ref), u21 (copy)
                Variables.cc.Brightness = 3;
                Variables.cc.TintColor = Color3.new(1, 0.4, 0.4);
                TweenService:Create(Variables.cc, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    TintColor = Color3.new(1, 0, 0)
                }):Play();
                Variables.BlS = Instance.new("ScreenGui", PlayerGui);
                Variables.BlS.Name = "TempB";
                local ImageLabel = Instance.new("ImageLabel", Variables.BlS);
                ImageLabel.Image = "rbxassetid://1483727717";
                ImageLabel.ImageColor3 = Color3.new(0, 0, 0);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Size = UDim2.new(1, 0, 1, 0);
                spawn(function() -- Line: 754
                    -- upvalues: ImageLabel (copy), u21 (ref)
                    for i = 0.05, 0, -0.01 do
                        ImageLabel.Position = UDim2.new(u21:NextNumber(-i, i), 0, u21:NextNumber(-i, i), 0);
                        wait();
                    end;

                    ImageLabel.Position = UDim2.new(0, 0, 0, 0);
                end);
            end },
        { 22.25, function() -- Line: 762
                -- upvalues: u22 (ref)
                u22.Cleanup();
            end }
    };
    game.Workspace.GameMusic.DomainExpansion:Play();
    game.StarterGui:SetCore("ResetButtonCallback", false);
    Cutscene(u16, u22);
end;