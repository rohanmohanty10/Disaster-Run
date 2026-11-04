 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 22
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u6 = Character:FindFirstChild(script.Name .. "Duck");
    task.delay(1 - PassedTime, function() -- Line: 36
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Let\'s play a little game, shall we?", 2 }
        });
    end);
    task.delay(4.5 - PassedTime, function() -- Line: 46
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "You ever play with toys?", 2 }
        });
    end);
    task.delay(7.5 - PassedTime, function() -- Line: 56
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">Catch!</animation>", 2 }
        });
    end);
    task.delay(11 - PassedTime, function() -- Line: 66
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "AHAHAHAHA", 1 },
            { u5, "Guess not!", 1 }
        });
    end);
    task.delay(15 - PassedTime, function() -- Line: 81
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">Show\'s over!</animation>", 1 },
            { u5, "AHAHAHAHAHA", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 99
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    task.delay(18.5 - PassedTime, function() -- Line: 121
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(18.5, function() -- Line: 134
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Joker DUCKY",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
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
    task.delay(18.5, function() -- Line: 164
        -- upvalues: u13 (copy), Lighting (ref), ColorCorrection (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u14 = DepthOfField:Clone();
    u14.Name = "D";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(18.5, function() -- Line: 179
        -- upvalues: u14 (copy), Lighting (ref), DepthOfField (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);

    if CamRig and CamRig:FindFirstChild("camera") then
        VfxManager.Enable(CamRig.camera.camatmo, true);
    end;

    task.delay(0.16666666666666666 - PassedTime, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce1);
    end);
    task.delay(0.7166666666666667 - PassedTime, function() -- Line: 196
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce2);
    end);
    task.delay(1.4833333333333334 - PassedTime, function() -- Line: 202
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce3);
    end);
    task.delay(2.2333333333333334 - PassedTime, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce4);
    end);
    task.delay(2.9166666666666665 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce5);
    end);
    task.delay(3.683333333333333 - PassedTime, function() -- Line: 220
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Bounce6);
    end);
    task.delay(3.8333333333333335 - PassedTime, function() -- Line: 226
        -- upvalues: CamRig (copy), VfxManager (ref)
        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.camatmo, false);
        end;
    end);
    task.delay(4.583333333333333 - PassedTime, function() -- Line: 232
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Emit(u6.Duck.Bone.ExplodeFollow);
        end;

        VfxManager.Emit(u11.DuckSwitch);
    end);
    task.delay(5.3 - PassedTime, function() -- Line: 242
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6.Duck.Bone.Enable, true);
            VfxManager.Emit(u6.Duck.Bone.ExplodeFollow);
        end;
    end);
    task.delay(6.6 - PassedTime, function() -- Line: 251
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(142, 209, 117);
        TweenService:Create(Vignette1, TweenInfo.new(0.9333333333333333), {
            ImageTransparency = 0.5
        }):Play();
        task.wait(0.9333333333333333);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(8.666666666666666 - PassedTime, function() -- Line: 262
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Vignette1 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Catch2);
        Vignette1.ImageColor3 = Color3.fromRGB(142, 209, 117);
        TweenService:Create(Vignette1, TweenInfo.new(0.6833333333333333), {
            ImageTransparency = 0
        }):Play();
        task.wait(1.15);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(8.85 - PassedTime, function() -- Line: 275
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6.Duck.Bone.SuperAura, true);
        end;
    end);
    task.delay(9.816666666666666 - PassedTime, function() -- Line: 283
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6.Duck.Bone.SuperAura, false);
        end;
    end);
    task.delay(10.3 - PassedTime, function() -- Line: 290
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Enable(u6.Duck.Bone.Enable, false);
        end;
    end);
    task.delay(11.233333333333333 - PassedTime, function() -- Line: 298
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.W, true);
        end;
    end);
    task.delay(12.5 - PassedTime, function() -- Line: 306
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightCinematicBars, true);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, true);
            VfxManager.Enable(CamRig.camera.camatmo, true);
            VfxManager.Enable(CamRig.camera.W, false);
        end;
    end);
    task.delay(13.266666666666667 - PassedTime, function() -- Line: 317
        -- upvalues: Folder (copy), u6 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            VfxManager.Emit(u6.Duck.Bone.Throw);
        end;
    end);
    task.delay(13.633333333333333 - PassedTime, function() -- Line: 325
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightCinematicBars, false);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, false);
            VfxManager.Enable(CamRig.camera.camatmo, false);
        end;
    end);
    task.delay(15.416666666666666 - PassedTime, function() -- Line: 335
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.camatmo, true);
        end;

        VfxManager.Emit(u11.Explode);
    end);
    task.delay(16.8 - PassedTime, function() -- Line: 345
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Goal);
    end);
    task.delay(18.5 - PassedTime, function() -- Line: 351
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.camatmo, false);
        end;
    end);
    local u15 = {};

    local function v16() -- Line: 360
        -- upvalues: u15 (ref), Folder (copy), u6 (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), DepthOfField (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u6 then
            u6:Destroy();
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

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;