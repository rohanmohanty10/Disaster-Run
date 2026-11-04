 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Enemy1 = p2.Enemy1;
    local Enemy2 = p2.Enemy2;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name) or Character.Name;
    local u7 = Enemy1 and (Players:FindFirstChild(Enemy1.Name) or (Enemy1.Name == "Player1" and "Chrollo" or (Enemy1.Name or ""))) or "";
    local u8 = Enemy2 and (Players:FindFirstChild(Enemy2.Name) or (Enemy2.Name == "Player2" and "Tatlis" or (Enemy2.Name or ""))) or "";
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:FindFirstChild(Character.Name .. script.Parent.Name .. "Dinosaur");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(3 - u3, function() -- Line: 39
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "IT\'S A TRAP!", 1 },
            { u7, "THIS WHOLE THING WAS A SETUP!", 1.75 },
            { u7, "THIS WAS ALL PART OF HIS PLAN TO LOSE!", 2 }
        });
    end);
    task.delay(9.5 - u3, function() -- Line: 59
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "Wait...", 0.5 },
            { u8, "...is...", 0.5 },
            { u8, "...is he...", 1 },
            { u8, "<animation style=\"glitch\">...Kira?!</animation>", 1.5 }
        });
    end);
    task.delay(15.5 - u3, function() -- Line: 84
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "That\'s right...", 2.5 },
            { u6, "<animation style=\"glitch\">I am Kira.</animation>", 1.5 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 102
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u3;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(26.083 - u3, function() -- Line: 124
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(26.083 - u3, function() -- Line: 137
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Kira Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Enemy1 then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v16 = Enemy1:FindFirstChild(child.Name);

            if v16 then
                local v17 = child:Clone();
                v17.CFrame = v16.CFrame;
                v17.Parent = Model2;
                Essentials:Weld(v17, v16);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local Vignette = u18.Vignette;
    local _ = u18.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(99, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(99, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 0.8;
    local u19;

    if Enemy1 then
        u19 = Instance.new("Highlight", Enemy1);
        u19.DepthMode = Enum.HighlightDepthMode.Occluded;
        u19.FillColor = Color3.fromRGB(0, 0, 0);
        u19.OutlineColor = Color3.fromRGB(255, 255, 255);
        u19.OutlineTransparency = 0;
        u19.FillTransparency = 1;
    else
        u19 = nil;
    end;

    local u20;

    if Enemy2 then
        u20 = Instance.new("Highlight", Enemy2);
        u20.DepthMode = Enum.HighlightDepthMode.Occluded;
        u20.FillColor = Color3.fromRGB(0, 0, 0);
        u20.OutlineColor = Color3.fromRGB(255, 255, 255);
        u20.OutlineTransparency = 0;
        u20.FillTransparency = 1;
    else
        u20 = nil;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u21 = ColorCorrection:Clone();
    u21.Name = "CC";
    u21.Parent = Lighting;
    u21.Enabled = true;
    u21.Brightness = -0.175;
    u21.Contrast = 0.75;
    u21.Saturation = -0.5;
    task.delay(26.083, function() -- Line: 225
        -- upvalues: u21 (copy), Lighting (ref), ColorCorrection (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 232
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(0.5833333333333334 - u3, function() -- Line: 240
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Dribble1);
    end);
    task.delay(1.6333333333333333 - u3, function() -- Line: 246
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Dribble2);
    end);
    task.delay(3.533333333333333 - u3, function() -- Line: 252
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.CameraFX);
    end);
    task.delay(3.85 - u3, function() -- Line: 258
        -- upvalues: Folder (copy), u13 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.White, CamRig.Camera.CameraLines, CamRig.Camera["1"], CamRig.Camera["2"]);
    end);
    task.delay(6.05 - u3, function() -- Line: 264
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.CameraFX);
    end);
    task.delay(8.45 - u3, function() -- Line: 270
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Black);
    end);
    task.delay(12.716666666666667 - u3, function() -- Line: 276
        -- upvalues: Folder (copy), u13 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Twirl, CamRig.Camera["Light Yagami"]);
    end);
    task.delay(18.15 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model.Head.att, Model.Head.att1);
    end);
    task.delay(17.933333333333334 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), TweenService (ref), u21 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u21, TweenInfo.new(0.25), {
            Contrast = 2.25,
            Saturation = -0.85,
            TintColor = Color3.fromRGB(255, 144, 144)
        }):Play();
    end);
    task.delay(19.633333333333333 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), Model (copy), TweenService (ref), u21 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model.Head.breathe);
        TweenService:Create(u21, TweenInfo.new(0.25), {
            Contrast = 0.75,
            Saturation = -0.5,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(22.3 - u3, function() -- Line: 302
        -- upvalues: Folder (copy), u13 (copy), CamRig (copy), Highlight (copy), Character (copy), HumanoidRootPart (copy), ReplicatedStorage (ref), u3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Laugh, CamRig.Camera.k2.k11, CamRig.Camera.k1.k22, CamRig.Camera["1.5"], CamRig.Camera["2.5"]);
        Highlight.FillColor = Color3.fromRGB(99, 0, 0);
        Highlight.OutlineColor = Color3.new(99, 0, 0);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = -1;
        Character.Archivable = true;
        local v22 = Character:Clone();
        Character.Archivable = false;
        v22.Parent = Folder;
        v22.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(9.993, 3.893, -0.518) * CFrame.fromEulerAnglesXYZ(0.05719443958785418, 0, 0);
        v22:ScaleTo(1.353);
        v22.HumanoidRootPart.RootJoint.C1 = CFrame.new(-1.042, 1.288, -8.778) * CFrame.fromEulerAnglesXYZ(-1.4350620708672976, 0.13398892667560466, 3.128066351886837);

        for _, child in v22.Torso:GetChildren() do
            if child:IsA("Motor6D") and script.Torso:FindFirstChild(child.Name) then
                child.C0 = script.Torso[child.Name].C0;
                child.C1 = script.Torso[child.Name].C1;
            end;
        end;

        for _, descendant in v22:GetDescendants() do
            if descendant.Name == "PlrBall" or (descendant.Name == "BALL" or (descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Highlight") or (descendant:IsA("Sound") or (descendant:IsA("SurfaceGui") or (descendant:IsA("BillboardGui") or (descendant:IsA("Decal") or (descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail"))))))))))) then
                descendant:Destroy();
            elseif descendant:IsA("Humanoid") then
                descendant.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            end;
        end;

        local Highlight2 = Instance.new("Highlight", v22);
        Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight2.OutlineColor = Color3.new(99, 0, 0);
        Highlight2.OutlineTransparency = 0;
        Highlight2.FillTransparency = -1;
        local v23 = v22.Humanoid:LoadAnimation(ReplicatedStorage.Assets.StyleAnimations.Kira.AwakeningShadow);
        v23:Play();
        v23.TimePosition = 22.3 - u3;
    end);
    local u24 = {};

    local function v25() -- Line: 352
        -- upvalues: u24 (ref), Folder (copy), u18 (copy), Highlight (copy), u19 (ref), u20 (ref), u21 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u19 then
            u19:Destroy();
        end;

        if u20 then
            u20:Destroy();
        end;

        if u21 then
            u21:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u24 = nil;
    end;

    table.insert(u24, Folder.AttributeChanged:Connect(v25));
    table.insert(u24, Folder.Destroying:Connect(v25));
end;