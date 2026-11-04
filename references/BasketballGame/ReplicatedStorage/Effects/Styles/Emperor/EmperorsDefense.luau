 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
game:GetService("Debris");
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local UIController = require(ReplicatedStorage.Controllers.UIController);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;
local u1 = Trove.new();

return function(p2, u3) -- Line: 21
    -- upvalues: SfxManager (copy), Debris (copy), u1 (copy), CameraShaker (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Essentials (copy), LocalPlayer (copy), ReplicatedStorage (copy), UIController (copy), RunService (copy), Trove (copy)
    local BallController = p2.BallController;
    local CameraController = p2.CameraController;
    local TimeSent = u3.TimeSent;
    local v4 = workspace:GetServerTimeNow() - TimeSent;
    local Char = u3.Char;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - u3.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if u3.Task ~= "Catch" then
        if u3.Task ~= "Cleanup" then
            if u3.Task == "Defense" then
                SfxManager:playSound({
                    Sound = "BBZ Emperor Defense",
                    Parent = HumanoidRootPart
                });

                if Debris:FindFirstChild(v5) then
                    Debris:FindFirstChild(v5):Destroy();
                end;

                local Folder = Instance.new("Folder");
                Folder.Name = v5;
                Folder.Parent = Debris;
                Folder:SetAttribute("Active", true);
                u1:Add(task.delay(15, function() -- Line: 131
                    -- upvalues: Folder (copy)
                    if Folder == nil or Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    Folder:SetAttribute("Active", nil);
                end));
                local u6 = nil;
                u6 = RunService.RenderStepped:Connect(function() -- Line: 137
                    -- upvalues: BallController (copy), Char (copy), u6 (ref), Folder (copy)
                    if BallController:GetCharacterPossessingBall() ~= Char then
                        return;
                    end;

                    u6:Disconnect();
                    Folder:SetAttribute("Active", nil);
                end);
                u1:Add(u6);
                local v7 = script.AuraEmit:Clone();
                v7.CFrame = HumanoidRootPart.CFrame;
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
                local v8 = script.Zone:Clone();
                v8.CFrame = HumanoidRootPart.CFrame;
                v8.Parent = Folder;

                if u3.Char == LocalPlayer.Character then
                    VfxManager.Emit(v8);
                    Essentials:Weld(v8, HumanoidRootPart);
                    TweenService:Create(v8, TweenInfo.new(0.15), {
                        Transparency = 0
                    }):Play();
                else
                    VfxManager.Emit(v8);
                    Essentials:Weld(v8, HumanoidRootPart);
                    v8.Transparency = 0;
                    TweenService:Create(v8, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                    VfxManager.DestroyEffect(v8, 1);
                end;

                local ColorCorrection = game:GetService("Lighting"):FindFirstChild("ColorCorrection");
                local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
                local u9 = u1:Add(Trove.new());

                local function removecc() -- Line: 185
                    -- upvalues: u9 (copy)
                    u9:Clean();
                end;

                local function applycc() -- Line: 189
                    -- upvalues: ColorCorrection (copy), u9 (copy), Color3_fromRGB_ret (copy), LocalPlayer (ref), ReplicatedStorage (ref), HumanoidRootPart (copy), UIController (ref)
                    ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
                    ColorCorrection.Contrast = 1.2;
                    ColorCorrection.Brightness = -0.1;
                    ColorCorrection.Saturation = -1;
                    u9:Add(function() -- Line: 195
                        -- upvalues: ColorCorrection (ref), Color3_fromRGB_ret (ref)
                        ColorCorrection.TintColor = Color3_fromRGB_ret;
                        ColorCorrection.Contrast = 0.2;
                        ColorCorrection.Saturation = 0.3;
                        ColorCorrection.Brightness = -0.015;
                    end);
                    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
                    local v10 = u9:Add(ReplicatedStorage.Assets.VFX.Emotes.Vignette:Clone());
                    v10.Parent = PlayerGui;
                    v10.Enabled = true;
                    local Vignette = v10.Vignette;
                    local Vignette1 = v10.Vignette1;
                    Vignette.ImageTransparency = 0;
                    Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
                    Vignette1.ImageTransparency = 0;
                    Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
                    local u11 = u9:Add(Instance.new("ScreenGui"));
                    u11.Parent = LocalPlayer.PlayerGui;
                    u11.IgnoreGuiInset = true;
                    local u12 = u9:Add(ReplicatedStorage.Assets.UI.ImageFrame:Clone());
                    u12.Parent = u11;
                    u12.ImageTransparency = 0.85;
                    u9:Add(task.spawn(function() -- Line: 221
                        -- upvalues: u11 (copy), HumanoidRootPart (ref), UIController (ref), u12 (copy)
                        while u11.Parent ~= nil and HumanoidRootPart ~= nil do
                            UIController:PlayFlipbook(u12, "EmperorScreenLines", 0.03333333333333333);
                        end;
                    end));
                end;

                local workspace_CurrentCamera = workspace.CurrentCamera;
                local FieldOfView = workspace_CurrentCamera.FieldOfView;
                local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(u3.Char);

                if PlayerFromCharacter then
                    local _ = LocalPlayer.Team == PlayerFromCharacter.Team;
                end;

                if LocalPlayer ~= PlayerFromCharacter then
                    local u13 = false;
                    u1:Add((RunService.Heartbeat:Connect(function(p14) -- Line: 236
                        -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), u13 (ref), CameraController (copy), FieldOfView (ref), Essentials (ref), workspace_CurrentCamera (copy), applycc (copy), u9 (copy)
                        local v15 = u13;
                        u13 = (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < 45;
                        CameraController.FOVActive = not u13;

                        if u13 then
                            FieldOfView = Essentials:Lerp(FieldOfView, 40, p14 * 5);
                            workspace_CurrentCamera.FieldOfView = FieldOfView;
                        else
                            FieldOfView = workspace_CurrentCamera.FieldOfView;
                        end;

                        if v15 == u13 then
                            return;
                        end;

                        if u13 then
                            applycc();

                            return;
                        end;

                        u9:Clean();
                    end)));
                end;

                u1:Add(function() -- Line: 267
                    -- upvalues: u9 (copy), CameraController (copy), Folder (copy), VfxManager (ref)
                    u9:Clean();
                    CameraController.FOVActive = true;

                    if Folder then
                        Folder.Name = "_";
                        VfxManager.Enable(Folder, false);
                        VfxManager.DestroyEffect(Folder, 2);

                        for _, descendant in Folder:GetDescendants() do
                            if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                                descendant.Transparency = 1;
                            end;
                        end;
                    end;
                end);
                task.delay(15, function() -- Line: 287
                    -- upvalues: Folder (copy), u1 (ref)
                    if Folder.Name ~= "_" and Folder.Parent then
                        u1:Clean();
                    end;
                end);
            end;

            return;
        end;

        local v16 = Debris:FindFirstChild(v5);

        if v16 then
            v16:SetAttribute("Active", nil);
        end;

        u1:Clean();

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Emperor Defense Catch",
        Parent = HumanoidRootPart
    });
    local v17 = Debris:FindFirstChild(v5);

    if v17 then
        v17:SetAttribute("Active", nil);
    end;

    u1:Clean();
    task.delay(0.5 - v4, function() -- Line: 48
        -- upvalues: CameraController (copy), CameraShaker (ref), Lighting (ref), TweenService (ref), VfxManager (ref), Debris (ref), u3 (copy), HumanoidRootPart (copy), Essentials (ref)
        CameraController.CamShake:Shake(CameraShaker.Presets.Dunk);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CC";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(0.75, function() -- Line: 56
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 5;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        ColorCorrectionEffect.Brightness = 0.45;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 110, 110);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
        local v18 = script.CameraFX:Clone();
        v18.Parent = Debris;
        VfxManager.DestroyEffect(v18, 2);
        shared.vfx.emit(v18);
        local v19 = script.FlashStep:Clone();
        v19.Parent = Debris;
        v19.CFrame = CFrame.new(u3.Position or HumanoidRootPart.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
        Essentials:Weld(v19, HumanoidRootPart);
        VfxManager.DestroyEffect(v19, 2);
        shared.vfx.emit(v19);
    end);
    task.delay(0.6666666666666666 - v4, function() -- Line: 86
        -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
        local v20 = script.Steal:Clone();
        v20.Parent = Debris;
        v20:PivotTo(HumanoidRootPart.CFrame);
        Essentials:Weld(v20.PrimaryPart, HumanoidRootPart);
        VfxManager.DestroyEffect(v20, 2);
        shared.vfx.emit(v20);
    end);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    ScreenGui.IgnoreGuiInset = true;
    local v21 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
    v21.Parent = ScreenGui;
    UIController:PlayFlipbook(v21, "EmperorDefenseLightning", 0.03);
    task.wait(0.5);
    ScreenGui:Destroy();
end;