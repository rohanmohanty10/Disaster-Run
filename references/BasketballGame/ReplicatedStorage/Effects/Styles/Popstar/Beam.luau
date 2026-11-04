 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 20
    -- upvalues: Players (copy), LocalPlayer (copy), SfxManager (copy), TweenService (copy), Debris (copy), Lighting (copy), VfxManager (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        if p2.Task ~= "Map" then
            if p2.Task == "CutsceneCleanup" then
                local v5 = Debris:FindFirstChild(v4);

                if v5 then
                    v5:SetAttribute("Active", nil);

                    return;
                end;
            else
                local v6 = p2.Task == "MapCleanup" and Debris:FindFirstChild(Character.Name .. script.Name .. "MapAura");

                if v6 then
                    v6:SetAttribute("Active", nil);
                end;
            end;

            return;
        end;

        local u7 = script.MapAura:Clone();
        u7.Name = Character.Name .. script.Name .. "MapAura";
        u7.Parent = Debris;
        u7.CFrame = CFrame.new(0, 8.605, -297.5) * CFrame.Angles(0, 1.5707963267948966, 0);
        u7:SetAttribute("Active", true);
        task.delay(20, function() -- Line: 342
            -- upvalues: u7 (copy)
            if not (u7 and u7:GetAttribute("Active")) then
                return;
            end;

            u7:SetAttribute("Active", nil);
        end);
        local u8 = script.FakeAtmo:Clone();
        u8.Parent = Lighting;
        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        ColorCorrection.Enabled = false;
        local u9 = ColorCorrection:Clone();
        u9.Name = "CC";
        u9.Parent = Lighting;
        u9.Enabled = true;
        u9.TintColor = Color3.fromRGB(207, 188, 255);
        task.delay(20, function() -- Line: 360
            -- upvalues: TweenService (ref), u9 (copy), ColorCorrection (copy), Lighting (ref)
            TweenService:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TintColor = ColorCorrection.TintColor
            }):Play();
            task.delay(0.25, function() -- Line: 363
                -- upvalues: u9 (ref), Lighting (ref), ColorCorrection (ref)
                u9:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end);
        end);
        local u10 = {};

        local function v11() -- Line: 372
            -- upvalues: u10 (ref), u7 (copy), TweenService (ref), VfxManager (ref), u8 (copy), u9 (copy), ColorCorrection (copy), Lighting (ref)
            for _, v in pairs(u10) do
                v:Disconnect();
            end;

            for _, descendant in pairs(u7:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                elseif descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;

            VfxManager.DestroyEffect(u7, 4);

            if u8 then
                u8:Destroy();
            end;

            if u9 then
                TweenService:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TintColor = ColorCorrection.TintColor
                }):Play();
                task.delay(0.25, function() -- Line: 393
                    -- upvalues: u9 (ref), Lighting (ref), ColorCorrection (ref)
                    u9:Destroy();

                    if not Lighting:FindFirstChild("CC") then
                        ColorCorrection.Enabled = true;
                    end;
                end);
            end;

            u10 = nil;
        end;

        table.insert(u10, RunService.Heartbeat:Connect(function() -- Line: 404
            -- upvalues: u9 (copy), Lighting (ref), ColorCorrection (copy)
            if u9 and (u9:IsDescendantOf(Lighting) and ColorCorrection.Enabled) then
                ColorCorrection.Enabled = false;
            end;
        end));
        table.insert(u10, u7.AttributeChanged:Connect(v11));
        table.insert(u10, u7.Destroying:Connect(v11));

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u12 = workspace:FindFirstChild(script.Name .. "Guitar");
    local u13 = workspace:FindFirstChild(script.Name .. "Piano");
    local u14 = workspace:FindFirstChild(script.Name .. "Drums");
    local u15 = workspace:FindFirstChild(script.Name .. "Stage");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Vignette1 = u16.Vignette1;
    u16.Vignette.ImageTransparency = 0;
    local v17 = script.PopstarText["It\'s Time"]:Clone();
    v17.Parent = PlayerGui;
    v17.DisplayOrder = 4;
    task.wait(0.5 - v3);
    local u18 = SfxManager:playSound({
        Sound = "BBZ Popstar Beam",
        Parent = workspace
    });
    u18.TimePosition = v3;

    for _, child in pairs(v17.Frame:GetChildren()) do
        if child:IsA("Frame") then
            task.delay((child:GetAttribute("Delay") or 0) - v3, function() -- Line: 58
                -- upvalues: child (copy)
                child.Visible = true;
            end);
            task.delay(3.933 - v3, function() -- Line: 62
                -- upvalues: TweenService (ref), child (copy)
                TweenService:Create(child.TextLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    TextTransparency = 1
                }):Play();
            end);
        end;
    end;

    task.wait(4.183);
    v17:Destroy();

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.667, function() -- Line: 81
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u19 = script.Cutscene_VFX:Clone();
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.Parent = Folder;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u20 = ColorCorrection:Clone();
    u20.Name = "CC";
    u20.Parent = Lighting;
    u20.Enabled = true;
    task.delay(9.667, function() -- Line: 99
        -- upvalues: u20 (copy), Lighting (ref), ColorCorrection (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u21 = Bloom:Clone();
    u21.Name = "B";
    u21.Parent = Lighting;
    u21.Enabled = true;
    local ClockTime = Lighting.ClockTime;
    Lighting.ClockTime = 0;
    task.delay(9.667, function() -- Line: 117
        -- upvalues: u21 (copy), Lighting (ref), Bloom (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.delay(0.8, function() -- Line: 124
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u19 (copy), Lighting (ref), TweenService (ref), u21 (copy), Bloom (copy), u20 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.camera.CameraAtmosphereAttachment, false);
        end;

        if u12 and u12:FindFirstChild("guitar") then
            VfxManager.Emit(u12.guitar.Bone.Emit);
        end;

        if u13 and u13:FindFirstChild("keyboard") then
            VfxManager.Emit(u13.keyboard.Bone.Emit);
        end;

        if u14 and u14:FindFirstChild("Meshes/1_Cylinder.008 (10)") then
            VfxManager.Emit(u14["Meshes/1_Cylinder.008 (10)"].Emit);
        end;

        if u15 and u15:FindFirstChild("Meshes/1_Cube.010 (8)") then
            VfxManager.Enable(u15, true);
            u15.Light1.Transparency = 0;
            u15.Light2.Transparency = 0;
            u15.Light3.Transparency = 0;
        end;

        u19.AuraMusic.Attachment.SpotLight.Enabled = true;
        u19.Box.Sphere.Transparency = 1;
        VfxManager.Enable(u19.AuraMusic, true);
        VfxManager.Enable(u19.Box, true);
        VfxManager.Emit(u19.AuraMusic.Glitchy);
        VfxManager.Emit(u19.One);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u21.Intensity = 20;
        u21.Threshold = 0.5;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u20.Brightness = 1;
        u20.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u20, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        TweenService:Create(Vignette1, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(2.183333333333333, function() -- Line: 176
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u13 (copy), u14 (copy), u19 (copy), Lighting (ref), TweenService (ref), u21 (copy), Bloom (copy), u20 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u12 and u12:FindFirstChild("guitar") then
            VfxManager.Emit(u12.guitar.Bone.Emit);
        end;

        if u13 and u13:FindFirstChild("keyboard") then
            VfxManager.Emit(u13.keyboard.Bone.Emit);
        end;

        if u14 and u14:FindFirstChild("Meshes/1_Cylinder.008 (10)") then
            VfxManager.Emit(u14["Meshes/1_Cylinder.008 (10)"].Emit);
        end;

        VfxManager.Emit(u19.AuraMusic.Glitchy);
        VfxManager.Emit(u19.Two);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u21.Intensity = 15;
        u21.Threshold = 0.5;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u20.Brightness = 0.5;
        u20.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u20, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0.5;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        TweenService:Create(Vignette1, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(3.566666666666667, function() -- Line: 212
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u13 (copy), u14 (copy), u19 (copy), Lighting (ref), TweenService (ref), u21 (copy), Bloom (copy), u20 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u12 and u12:FindFirstChild("guitar") then
            VfxManager.Emit(u12.guitar.Bone.Emit);
        end;

        if u13 and u13:FindFirstChild("keyboard") then
            VfxManager.Emit(u13.keyboard.Bone.Emit);
        end;

        if u14 and u14:FindFirstChild("Meshes/1_Cylinder.008 (10)") then
            VfxManager.Emit(u14["Meshes/1_Cylinder.008 (10)"].Emit);
        end;

        VfxManager.Emit(u19.AuraMusic.Glitchy);
        VfxManager.Emit(u19.Three);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u21.Intensity = 15;
        u21.Threshold = 0.5;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u20.Brightness = 0.5;
        u20.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u20, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0.5;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        TweenService:Create(Vignette1, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(5.783333333333333, function() -- Line: 248
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), Lighting (ref), TweenService (ref), u21 (copy), Bloom (copy), u20 (copy), ColorCorrection (copy), Vignette1 (copy), PlayerGui (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u19.PinkBackground, true);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u21.Intensity = 20;
        u21.Threshold = 0.5;
        TweenService:Create(u21, TweenInfo.new(0.45, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u20.Brightness = 1;
        u20.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u20, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        local v22 = tick();

        repeat
            TweenService:Create(Vignette1, TweenInfo.new(0.2), {
                ImageColor3 = Color3.fromRGB(191, 116, 229)
            }):Play();
            task.wait(0.2);
            TweenService:Create(Vignette1, TweenInfo.new(0.2), {
                ImageColor3 = Color3.fromRGB(116, 229, 229)
            }):Play();
            task.wait(0.2);
        until tick() - v22 > 3.8833333333333333 or not (Vignette1 and Vignette1:IsDescendantOf(PlayerGui));
    end);
    local u23 = {};

    local function v24() -- Line: 279
        -- upvalues: u23 (ref), Folder (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), u16 (copy), u18 (copy), VfxManager (ref), u20 (copy), Lighting (ref), ColorCorrection (copy), u21 (copy), Bloom (copy), ClockTime (copy)
        for _, v in pairs(u23) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u18 then
            VfxManager.DestroyEffect(u18, 10);
        end;

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u21 then
            u21:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        u23 = nil;
    end;

    table.insert(u23, Folder.AttributeChanged:Connect(v24));
    table.insert(u23, Folder.Destroying:Connect(v24));
end;