 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local _ = p2.Teammate;
    local _ = p2.Enemy;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 34
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "You don\'t get it...", 2.25 },
            { u5, "<animation style=\"glitch\">I am a completely different breed of beast.</animation>", 4 }
        });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 52
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * PassedTime;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(7.183 - PassedTime, function() -- Line: 74
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(7.183 - PassedTime, function() -- Line: 87
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Silver Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local v10 = script.Cutscene_VFX:Clone();
    v10:PivotTo(HumanoidRootPart.CFrame);
    v10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v12 = Character:FindFirstChild(child.Name);

        if v12 then
            local v13 = child:Clone();
            v13.CFrame = v12.CFrame;
            v13.Parent = Model;
            Essentials:Weld(v13, v12);
        end;
    end;

    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Intensity = 3;
    u15.Size = 24;
    u15.Threshold = 1.062;
    task.delay(7.183 - PassedTime, function() -- Line: 144
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 151
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), Model (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u11.CamShade, true);
    end);
    task.delay(4 - PassedTime, function() -- Line: 162
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.CameraDinasour);
        TweenService:Create(Highlight, TweenInfo.new(0.293, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            OutlineColor = Color3.fromRGB(47, 255, 116)
        }):Play();
    end);
    local u16 = {};

    local function v17() -- Line: 171
        -- upvalues: u16 (ref), Folder (copy), Highlight (copy), u14 (copy), u15 (copy), Lighting (ref), Bloom (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;