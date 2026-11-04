 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), TweenService (copy), VfxManager (copy), UIController (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Teammate;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;
    local u5 = Character.Name .. script.Parent.Name .. script.Name .. "Domain";

    if p2.Task ~= "Cutscene" then
        if p2.Task == "Cleanup" then
            local v6 = Debris:FindFirstChild(v4);

            if v6 then
                v6:SetAttribute("Active", nil);

                return;
            end;
        else
            local v7 = p2.Task == "DomainCleanup" and Debris:FindFirstChild(u5);

            if v7 then
                v7:SetAttribute("Active", nil);
            end;
        end;

        return;
    end;

    local u8 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    task.delay(0.5 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "<animation style=\"glitch\">You hold your heads quite high...</animation>!", 2 }
        });
    end);
    task.delay(2.5 - u3, function() -- Line: 45
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "Come now...", 1.5 }
        });
    end);
    task.delay(4.5 - u3, function() -- Line: 55
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "You mustn\'t stop trying!", 3 }
        });
    end);
    task.delay(7.5 - u3, function() -- Line: 65
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "I\'ll play with you again and again <animation style=\"glitch\">until I\'m tired of this</animation>!", 6 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 78
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
    task.delay(15.983 - u3, function() -- Line: 100
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
    task.delay(15.983 - u3, function() -- Line: 113
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Curse King The King Of Curses",
        Parent = workspace
    }).TimePosition = u3;
    local v13 = script.Cutscene_VFX:Clone();
    v13:PivotTo(HumanoidRootPart.CFrame);
    v13.Parent = Folder;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local _ = u14.Vignette1;
    u14.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Saturation = 0.5;
    task.delay(15.983, function() -- Line: 144
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u16 = Bloom:Clone();
    u16.Name = "B";
    u16.Parent = Lighting;
    u16.Enabled = true;
    u16.Intensity = 1.35;
    u16.Threshold = 2;
    task.delay(15.983, function() -- Line: 161
        -- upvalues: u16 (copy), Lighting (ref), Bloom (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u17 = DepthOfField:Clone();
    u17.Name = "D";
    u17.Parent = Lighting;
    u17.Enabled = true;
    u17.FarIntensity = 1;
    u17.FocusDistance = 35.62;
    task.delay(15.983, function() -- Line: 178
        -- upvalues: u17 (copy), Lighting (ref), DepthOfField (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local u18 = script.FakeAtmo:Clone();
    u18.Parent = Lighting;
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(15.983 - u3, function() -- Line: 196
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    task.spawn(function() -- Line: 205
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 10
        }):Play();
        task.wait(1);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end);
    task.delay(1.4166666666666667 - u3, function() -- Line: 216
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 10
        }):Play();
        task.wait(1);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end);
    task.delay(2.75 - u3, function() -- Line: 227
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 10
        }):Play();
        task.wait(1);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end);
    task.delay(3.033333333333333 - u3, function() -- Line: 238
        -- upvalues: Folder (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), u3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v19 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v19.BackgroundTransparency = 0;
        v19.Parent = ScreenGui;
        UIController:PlayFlipbook(v19, "CurseKingFinger", 0.04288164665523156, u3);
        ScreenGui:Destroy();
    end);
    local u20 = {};

    local function v24() -- Line: 256
        -- upvalues: u20 (ref), Folder (copy), u14 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy), u16 (copy), Bloom (copy), u17 (copy), DepthOfField (copy), MapFolder (copy), u5 (copy), Debris (ref), VfxManager (ref), u18 (copy), ClockTime (copy)
        for _, v in pairs(u20) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        u20 = nil;
        local u21 = script.Domain:Clone();
        u21.Name = u5;
        u21.Parent = Debris;
        u21:SetAttribute("Active", true);
        VfxManager.Enable(u21, true);
        task.delay(20, function() -- Line: 303
            -- upvalues: u21 (copy)
            if not (u21 and u21:GetAttribute("Active")) then
                return;
            end;

            u21:SetAttribute("Active", nil);
        end);
        local v22 = {};

        local function v23() -- Line: 310
            -- upvalues: VfxManager (ref), u21 (copy), u18 (ref), ClockTime (ref), Lighting (ref)
            VfxManager.Enable(u21, false);
            VfxManager.DestroyEffect(u21, 4);

            if u18 then
                u18:Destroy();
            end;

            if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
                Lighting.ClockTime = ClockTime;
            end;
        end;

        table.insert(v22, u21.AttributeChanged:Connect(v23));
        table.insert(v22, u21.Destroying:Connect(v23));
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v24));
    table.insert(u20, Folder.Destroying:Connect(v24));
end;