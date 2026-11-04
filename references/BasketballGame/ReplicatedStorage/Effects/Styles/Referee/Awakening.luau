 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Teammate = p2.Teammate;
    local Enemy = p2.Enemy;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local u6 = Character:FindFirstChild("Right Arm");
    local u7 = Character:FindFirstChild("Left Arm");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u8 = workspace:FindFirstChild(script.Parent.Name .. "Cart");
    local u9 = workspace:FindFirstChild(script.Parent.Name .. "Book");
    local u10 = workspace:FindFirstChild(script.Parent.Name .. "Whistle");
    local u11 = workspace:FindFirstChild(script.Parent.Name .. "Clipboard");
    Character:FindFirstChild("BALL", true);
    task.delay(11.5 - PassedTime, function() -- Line: 41
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "The <animation style=\"glitch\">REF</animation> is finally here!", 3 }
        });
    end);
    task.delay(21 - PassedTime, function() -- Line: 51
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">You can\'t do that!</animation>", 2 }
        });
    end);
    local u12 = 0;
    local u13 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u13 = RunService.RenderStepped:Connect(function(p14) -- Line: 64
        -- upvalues: u1 (copy), u13 (ref), u12 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u13:Disconnect();

            return;
        end;

        if u12 <= 0 then
            u12 = p14 * 60 * PassedTime;
        end;

        u12 = u12 + p14 * 60;
        local v15 = script_Fov[math.ceil(u12)];

        if v15 ~= nil then
            if math.ceil(u12) >= #script_Fov then
                u13:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v15, p14 * 6);
        end;
    end);
    task.delay(22.45 - PassedTime, function() -- Line: 86
        -- upvalues: u13 (ref)
        u13:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(22.45 - PassedTime, function() -- Line: 99
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Referee Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;

    if Teammate then
        local Model = Instance.new("Model");
        Model.Parent = Folder;

        for _, child in pairs(script.AuraBodyPartsToWeldToTeammate:GetChildren()) do
            local v17 = Character:FindFirstChild(child.Name);

            if v17 then
                local v18 = child:Clone();
                v18.CFrame = v17.CFrame;
                v18.Parent = Model;
                Essentials:Weld(v18, v17);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local Vignette1 = u19.Vignette1;
    u19.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local Highlight2 = Instance.new("Highlight", u8);
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.OutlineColor = Color3.new(255, 255, 255);
    Highlight2.OutlineTransparency = 0;
    Highlight2.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u20 = ColorCorrection:Clone();
    u20.Name = "CC";
    u20.Parent = Lighting;
    u20.Enabled = true;
    task.delay(22.45, function() -- Line: 158
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
    task.delay(22.45, function() -- Line: 173
        -- upvalues: u21 (copy), Lighting (ref), Bloom (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local Atmosphere = Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local u22 = nil;
    local u23 = nil;
    local u24 = nil;
    local u25 = nil;
    task.delay(0.25 - PassedTime, function() -- Line: 188
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local Enable1 = CamRig:FindFirstChild("Enable1");

        if Enable1 then
            VfxManager.Enable(Enable1, true);
        end;
    end);
    task.delay(0.8166666666666667 - PassedTime, function() -- Line: 197
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local Enable1 = CamRig:FindFirstChild("Enable1");
        local RightLines = CamRig:FindFirstChild("RightLines");
        local LeftLines = CamRig:FindFirstChild("LeftLines");

        if Enable1 then
            VfxManager.Enable(Enable1, false);
        end;

        if RightLines then
            VfxManager.Enable(RightLines, true);
        end;

        if LeftLines then
            VfxManager.Enable(LeftLines, true);
        end;
    end);
    task.delay(2.6166666666666667 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.Hit);
    end);
    task.delay(3.7 - PassedTime, function() -- Line: 220
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.Slam);
    end);
    task.delay(4.516666666666667 - PassedTime, function() -- Line: 226
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local RightLines = CamRig:FindFirstChild("RightLines");
        local LeftLines = CamRig:FindFirstChild("LeftLines");

        if RightLines then
            VfxManager.Enable(RightLines, false);
        end;

        if LeftLines then
            VfxManager.Enable(LeftLines, false);
        end;
    end);
    task.delay(4.566666666666666 - PassedTime, function() -- Line: 239
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u16.Teleport, true);
    end);
    task.delay(4.583333333333333 - PassedTime, function() -- Line: 245
        -- upvalues: Folder (copy), Enemy (copy), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy then
            local Highlight3 = Instance.new("Highlight", Enemy);
            Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight3.FillColor = Color3.fromRGB(255, 0, 0);
            Highlight3.OutlineColor = Color3.new(0, 0, 0);
            Highlight3.OutlineTransparency = 1;
            Highlight3.FillTransparency = 1;
            VfxManager.DestroyEffect(Highlight3, 0.21666666666666667);
            TweenService:Create(Highlight3, TweenInfo.new(0.06666666666666667), {
                FillTransparency = 0
            }):Play();
            task.wait(0.06666666666666667);
            TweenService:Create(Highlight3, TweenInfo.new(0.15), {
                FillTransparency = 1
            }):Play();
        end;
    end);
    task.delay(5.933333333333334 - PassedTime, function() -- Line: 265
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local Enable2 = CamRig:FindFirstChild("Enable2");

        if Enable2 then
            VfxManager.Enable(Enable2, true);
        end;
    end);
    task.delay(6.433333333333334 - PassedTime, function() -- Line: 274
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u8 (copy), u21 (copy), Lighting (ref), u22 (ref), TweenService (ref), u20 (copy), u25 (ref), Bloom (copy), u23 (ref), u24 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.Teleport);
        VfxManager.Enable(u16.Teleport, false);

        if u8 and u8:FindFirstChild("CartToRig") then
            VfxManager.Emit(u8.CartToRig.MainBone.Attachment);
        end;

        u21.Intensity = 2;
        u21.Threshold = 0.5;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        VfxManager.DestroyEffect(BlurEffect, 0.855);
        u22 = TweenService:Create(u20, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.2
        }):Play();
        u25 = TweenService:Create(u21, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.067);
        u23 = TweenService:Create(u20, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = -0.5,
            Saturation = -1
        }):Play();
        task.wait(0.055);
        u24 = TweenService:Create(u20, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
            Brightness = 0.05,
            Saturation = 0.3
        }):Play();
    end);
    task.delay(6.983333333333333 - PassedTime, function() -- Line: 304
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.GroundHit);
    end);
    task.delay(7.3 - PassedTime, function() -- Line: 310
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u8 and u8:FindFirstChild("CartToRig") then
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.009"].Attachment, true);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.010"].Attachment, true);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.012"].Attachment, true);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.013"].Attachment, true);
        end;
    end);
    task.delay(8.616666666666667 - PassedTime, function() -- Line: 321
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local Enable2 = CamRig:FindFirstChild("Enable2");

        if Enable2 then
            VfxManager.Enable(Enable2, false);
        end;
    end);
    task.delay(9.5 - PassedTime, function() -- Line: 330
        -- upvalues: Folder (copy), u8 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u8 and u8:FindFirstChild("CartToRig") then
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.009"].Attachment, false);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.010"].Attachment, false);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.012"].Attachment, false);
            VfxManager.Enable(u8.CartToRig.MainBone["Bone.013"].Attachment, false);
        end;
    end);
    task.delay(10.3 - PassedTime, function() -- Line: 341
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.Land2);
    end);
    task.delay(10.533333333333333 - PassedTime, function() -- Line: 347
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u10, true);
    end);
    task.delay(11.316666666666666 - PassedTime, function() -- Line: 353
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u10, false);
    end);
    task.delay(11.6 - PassedTime, function() -- Line: 359
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            local v26 = script.Throw:Clone();
            v26.Parent = Folder;
            v26.CFrame = u6.CFrame;
            VfxManager.Emit(v26);
            VfxManager.DestroyEffect(v26, 2);
        end;

        if u7 then
            local v27 = script.Throw:Clone();
            v27.Parent = Folder;
            v27.CFrame = u7.CFrame;
            VfxManager.Emit(v27);
            VfxManager.DestroyEffect(v27, 2);
        end;
    end);
    task.delay(12.266666666666667 - PassedTime, function() -- Line: 379
        -- upvalues: Folder (copy), Head (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Head then
            local v28 = script.Head:Clone();
            v28.Parent = Folder;
            v28.CFrame = Head.CFrame;
            VfxManager.Emit(v28);
            VfxManager.DestroyEffect(v28, 2);
        end;
    end);
    task.delay(14.733333333333333 - PassedTime, function() -- Line: 391
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u16 (copy), VfxManager (ref), u9 (copy), Atmosphere (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u16.Box.PrimaryPart.Transparency = 0;
        VfxManager.Enable(u16.Box, true);

        if u9 and u9:FindFirstChild("BookToRig") then
            VfxManager.Emit(u9.BookToRig.Bone.Emit);
        end;

        Atmosphere.Density = 0;
    end);
    task.delay(16.633333333333333 - PassedTime, function() -- Line: 408
        -- upvalues: Folder (copy), u9 (copy), VfxManager (ref), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u9 and u9:FindFirstChild("BookToRig") then
            VfxManager.Enable(u9.BookToRig.Bone["Bone.001"], true);
            VfxManager.Enable(u9.BookToRig.Bone["Bone.002"], true);
        end;

        TweenService:Create(Vignette1, TweenInfo.new(2.533333333333333), {
            ImageTransparency = 0
        }):Play();
        task.wait(2.533333333333333);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(20.733333333333334 - PassedTime, function() -- Line: 423
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            local v29 = script.End:Clone();
            v29.Parent = Folder;
            v29.CFrame = u6.CFrame;
            VfxManager.Emit(v29);
            VfxManager.DestroyEffect(v29, 2);
        end;
    end);
    task.delay(20.783333333333335 - PassedTime, function() -- Line: 435
        -- upvalues: Folder (copy), u9 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u9 and u9:FindFirstChild("BookToRig") then
            VfxManager.Enable(u9.BookToRig.Bone["Bone.002"], false);
        end;
    end);
    task.delay(22.45 - PassedTime, function() -- Line: 443
        -- upvalues: Folder (copy), u16 (copy), u9 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u16.Box:Destroy();

        if u9 and u9:FindFirstChild("BookToRig") then
            VfxManager.Enable(u9.BookToRig.Bone["Bone.001"], false);
        end;
    end);
    local u30 = {};

    local function v31() -- Line: 454
        -- upvalues: u30 (ref), Folder (copy), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u8 (copy), u9 (copy), u10 (copy), u11 (copy), Highlight (copy), u19 (copy), u20 (copy), Lighting (ref), ColorCorrection (copy), u21 (copy), Bloom (copy), Atmosphere (copy), Density (copy)
        for _, v in pairs(u30) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u22 then
            u22:Pause();
        end;

        if u23 then
            u23:Pause();
        end;

        if u24 then
            u24:Pause();
        end;

        if u25 then
            u25:Pause();
        end;

        if u8 then
            u8:Destroy();
        end;

        if u9 then
            u9:Destroy();
        end;

        if u10 then
            u10:Destroy();
        end;

        if u11 then
            u11:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u19 then
            u19:Destroy();
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

        Atmosphere.Density = Density;
        u30 = nil;
    end;

    table.insert(u30, Folder.AttributeChanged:Connect(v31));
    table.insert(u30, Folder.Destroying:Connect(v31));
end;