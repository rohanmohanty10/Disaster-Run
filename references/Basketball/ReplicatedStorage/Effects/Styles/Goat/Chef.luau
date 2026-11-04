 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, u2) -- Line: 20
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = u2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if u2.Task ~= "Cutscene" then
        local v5 = u2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 37
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
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
    task.delay(10.433 - u3, function() -- Line: 59
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(10.433 - u3, function() -- Line: 72
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);

    if u2.OriginalCharacter and u2.OriginalCharacter.Parent then
        Essentials:HideCharacter(u2.OriginalCharacter, {}, nil, 0);
    end;

    SfxManager:playSound({
        Sound = "BBZ Goat Chef",
        Parent = workspace
    }).TimePosition = u3;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local Vignette1 = u12.Vignette1;
    u12.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    task.delay(10.433, function() -- Line: 111
        -- upvalues: u13 (copy), Lighting (ref), ColorCorrection (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(1.0833333333333333 - u3, function() -- Line: 118
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Vignette1 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Heart);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 123, 150);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(4.733333333333333 - u3, function() -- Line: 128
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition2);
    end);
    task.delay(5.033333333333333 - u3, function() -- Line: 134
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Bounce);
    end);
    task.delay(6.666666666666667 - u3, function() -- Line: 140
        -- upvalues: Folder (copy), u10 (copy), PlayerGui (copy), TweenService (ref), u2 (copy), RunService (ref), BALL (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BillboardGui = u10.YellowLine.A1.Attachment.BillboardGui;
        local Beam = u10.YellowLine.A0.Beam;
        BillboardGui.Parent = PlayerGui;
        TweenService:Create(BillboardGui.TextLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            TextTransparency = 0
        }):Play();
        Beam.Enabled = true;
        local Width0 = Beam.Width0;
        local Width1 = Beam.Width1;
        Beam.Width0 = 0;
        Beam.Width1 = 0;
        TweenService:Create(Beam, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Width0 = Width0,
            Width1 = Width1
        }):Play();
        u10.YellowLine.A1.WorldPosition = u2.HoopPos;
        local u14 = nil;
        u14 = RunService.RenderStepped:Connect(function() -- Line: 161
            -- upvalues: BALL (ref), u10 (ref), u14 (ref)
            if BALL and (u10 and u10.Parent) then
                u10.YellowLine.A0.WorldPosition = BALL.Position;

                return;
            end;

            u14:Disconnect();
            u14 = nil;
        end);
        task.delay(1.4166666666666667, function() -- Line: 171
            -- upvalues: u14 (ref), u10 (ref), BillboardGui (copy)
            if u14 then
                u14:Disconnect();
            end;

            u10.YellowLine:Destroy();
            BillboardGui:Destroy();
        end);
    end);
    task.delay(8.083333333333334 - u3, function() -- Line: 181
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(9.983333333333333 - u3, function() -- Line: 187
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Land);
    end);
    local u15 = {};

    local function v16() -- Line: 194
        -- upvalues: u15 (ref), Folder (copy), u2 (copy), Essentials (ref), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u2.OriginalCharacter and u2.OriginalCharacter.Parent then
            Essentials:UnhideCharacter(u2.OriginalCharacter, {});
        end;

        if u12 then
            u12:Destroy();
        end;

        if u13 then
            u13:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;