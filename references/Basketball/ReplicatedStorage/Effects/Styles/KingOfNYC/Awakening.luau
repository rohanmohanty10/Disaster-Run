 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), Part_Icles (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u7 = workspace:FindFirstChild(script.Parent.Name .. "Room");
    Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 37
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({
            { "Chrollo", "King of New York, huh?", 1 },
            { "Chrollo", `Do you know how many..<animation timeBetweenStep="{0.5}">.</animation> have <animation style="glitch">fallen</animation> trying to wear that crown?`, 4.5 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 52
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Then I\'ll be the one who doesn\'t.", 1.5 }
        });
    end);
    task.delay(9.5 - u3, function() -- Line: 62
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Chrollo", "That crown crushed legends before you...", 3 } });
    end);
    task.delay(13 - u3, function() -- Line: 73
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, `Then I'll becom<animation timeBetweenStep="{1}">e</animation> a <animation style="glitch" timeBetweenStep="{0.1}">legend</animation>.`, 3 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 86
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u3;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(15.617 - u3, function() -- Line: 108
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15.617 - u3, function() -- Line: 121
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ King Of NYC Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    Vignette.ImageTransparency = 0;
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Intensity = 0.2;
    u15.Size = 24;
    u15.Threshold = 2.35;
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(15.617 - u3, function() -- Line: 159
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 166
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play();
        Part_Icles:AbsoluteEmit(u13.CamAtmo.WindScene);
    end);
    task.delay(5.266666666666667 - u3, function() -- Line: 176
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 2.183333333333333);
        TweenService:Create(BlurEffect, TweenInfo.new(0.1), {
            Size = 20
        }):Play();
        task.wait(0.1);
        TweenService:Create(BlurEffect, TweenInfo.new(2.0833333333333335), {
            Size = 0
        }):Play();
    end);
    task.delay(8.083333333333334 - u3, function() -- Line: 189
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Haha);
    end);
    task.delay(10.816666666666666 - u3, function() -- Line: 195
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 1.45);
        TweenService:Create(BlurEffect, TweenInfo.new(0.2), {
            Size = 20
        }):Play();
        task.wait(0.2);
        TweenService:Create(BlurEffect, TweenInfo.new(1.25), {
            Size = 0
        }):Play();
    end);
    task.delay(11.383333333333333 - u3, function() -- Line: 208
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.CameraTransition1);
    end);
    task.delay(11.783333333333333 - u3, function() -- Line: 214
        -- upvalues: Folder (copy), u7 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            u7:Destroy();
        end;
    end);
    task.delay(12.166666666666666 - u3, function() -- Line: 222
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.CameraTransition2);
    end);
    task.delay(12.333333333333334 - u3, function() -- Line: 228
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Emit);
    end);
    task.delay(13.6 - u3, function() -- Line: 234
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.EndEmit);
    end);
    local u16 = {};

    local function v17() -- Line: 241
        -- upvalues: u16 (ref), Folder (copy), u7 (copy), u14 (copy), u15 (copy), Lighting (ref), Bloom (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u7 then
            u7:Destroy();
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