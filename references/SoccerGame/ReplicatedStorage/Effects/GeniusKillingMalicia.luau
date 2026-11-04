  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService2 = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

local function cleanup(p1, p2) -- Line: 18
    -- upvalues: Debris (copy), Knit (copy), TweenService2 (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local v3 = Debris:FindFirstChild(p2);
    local Frame = LocalPlayer.PlayerGui.ScreenFlash.Frame;
    Knit.GetController("CameraController").Cutscene = false;

    for _, descendant in p1:GetDescendants() do
        if descendant:GetAttribute("GeniusKilling") then
            descendant:Destroy();
        end;
    end;

    if v3 then
        v3:Destroy();
    end;

    local GeniusKillingDepth = game.Lighting:FindFirstChild("GeniusKillingDepth");

    if GeniusKillingDepth then
        GeniusKillingDepth:Destroy();
    end;

    game.Lighting.DepthOfField.Enabled = true;
    TweenService2:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play();
    task.wait(0.5);
    Frame.Visible = false;
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    local GoldVignette = LocalPlayer.PlayerGui.Vignette.GoldVignette;
    GoldVignette.ImageTransparency = 1;

    for _, descendant in GoldVignette:GetDescendants() do
        descendant.ImageTransparency = 1;
    end;
end;

return function(p4) -- Line: 53
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), VfxManager (copy), Players (copy), ReplicatedStorage (copy), TweenService (copy), TweenService2 (copy), cleanup (copy), Knit (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p4.Char;
    local v5 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p4.Task == "Cutscene" then
        if not Char then
            return;
        end;

        if not Char:FindFirstChild("HumanoidRootPart") then
            return;
        end;

        SoundManager.SpawnSound("GeniusKillingMalicia", 0.7, workspace, 150);
        local Folder = Instance.new("Folder");
        Folder.Name = v5;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        local DepthOfField = game.Lighting.DepthOfField;
        local v6 = script.DepthOfField:Clone();
        v6.Name = "GeniusKillingDepth";
        v6.Parent = game.Lighting;
        DepthOfField.Enabled = false;

        return;
    end;

    if p4.Task == "Eyes" then
        for _, child in script.Head:GetChildren() do
            local v7 = child:Clone();
            v7.Parent = Char.Head;
            VfxManager.Enable(v7, true);
            v7:SetAttribute("GeniusKilling", true);
        end;

        return;
    end;

    if p4.Task ~= "ScreenChange1" then
        if p4.Task == "ScreenChange2" then
            local workspace_NagiCam = workspace.NagiCam;
            Debris:FindFirstChild(v5);
            local CamPart = workspace_NagiCam.CamPart;
            VfxManager.Enable(CamPart.Object3, true);
            VfxManager.Enable(CamPart.Object4, true);
            VfxManager.Enable(CamPart.Object5, true);
            VfxManager.Enable(CamPart.bea, true);

            return;
        end;

        if p4.Task ~= "DisableBackdrops" then
            if p4.Task == "SpeedBackdrop" then
                local workspace_NagiCam = workspace.NagiCam;
                Debris:FindFirstChild(v5);
                VfxManager.Enable(workspace_NagiCam.CamPart.at, true);

                return;
            end;

            if p4.Task == "Subtitles" then
                return;
            end;

            if p4.Task ~= "TweenBackdrop" then
                if p4.Task == "ScreenFlash" then
                    local u8 = Debris:FindFirstChild(v5);
                    local LocalPlayer = Players.LocalPlayer;
                    local Frame = LocalPlayer.PlayerGui.ScreenFlash.Frame;
                    Frame.BackgroundTransparency = 1;
                    Frame.Visible = true;
                    TweenService2:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, true), {
                        BackgroundTransparency = 0
                    }):Play();
                    local GoldVignette = LocalPlayer.PlayerGui.Vignette.GoldVignette;
                    TweenService2:Create(GoldVignette, TweenInfo.new(1), {
                        ImageTransparency = 1
                    }):Play();

                    for _, descendant in GoldVignette:GetDescendants() do
                        TweenService2:Create(descendant, TweenInfo.new(1), {
                            ImageTransparency = 1
                        }):Play();
                    end;

                    local Vignette = Players.LocalPlayer.PlayerGui.Vignette.Vignette;
                    TweenService2:Create(Vignette, TweenInfo.new(1), {
                        ImageTransparency = 0
                    }):Play();

                    for _, descendant in Vignette:GetDescendants() do
                        TweenService2:Create(descendant, TweenInfo.new(1), {
                            ImageTransparency = 0
                        }):Play();
                    end;

                    task.delay(0.25, function() -- Line: 249
                        -- upvalues: Char (copy), u8 (copy), VfxManager (ref)
                        local v9 = script.anger:Clone();
                        v9.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(1, -2, 0);
                        v9.Parent = u8;
                        VfxManager.Emit(v9);
                    end);
                    task.wait(1);
                    local Vignette2 = Players.LocalPlayer.PlayerGui.Vignette.Vignette;
                    TweenService2:Create(Vignette2, TweenInfo.new(0.25), {
                        ImageTransparency = 1
                    }):Play();

                    for _, descendant in Vignette2:GetDescendants() do
                        TweenService2:Create(descendant, TweenInfo.new(0.25), {
                            ImageTransparency = 1
                        }):Play();
                    end;

                    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                    TweenService2:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        BackgroundTransparency = 0
                    }):Play();
                    task.wait(1);
                    cleanup(Char, v5);

                    if LocalPlayer.Name == p4.Victim.Name then
                        local Controller = Knit.GetController("StatesController");
                        Controller.SpeedBoost = -20;
                        task.wait(5);
                        print(LocalPlayer.Character.Humanoid.WalkSpeed);
                        Controller.SpeedBoost = 0;

                        return;
                    end;
                elseif p4.Task == "Cleanup" then
                    cleanup(Char, v5);
                end;

                return;
            end;

            local workspace_NagiCam = workspace.NagiCam;
            Debris:FindFirstChild(v5);

            for _, child in workspace_NagiCam.CamPart.at:GetChildren() do
                TweenService2:Create(child, TweenInfo.new(0.5), {
                    Width0 = 0
                }):Play();
                TweenService2:Create(child, TweenInfo.new(0.5), {
                    Width1 = 0
                }):Play();
            end;

            return;
        end;

        local workspace_NagiCam = workspace.NagiCam;
        local v10 = Debris:FindFirstChild(v5);
        local CamPart = workspace_NagiCam.CamPart;
        VfxManager.Enable(CamPart.Object3, false);
        VfxManager.Enable(CamPart.Object4, false);
        VfxManager.Enable(CamPart.Object5, false);
        VfxManager.Enable(CamPart.bea, false);
        local Sphere = v10.Sphere;
        Sphere.Transparency = 1;
        VfxManager.Enable(Sphere, false);
        v10.Floor.Transparency = 1;

        for _, descendant in Char:GetDescendants() do
            if descendant:GetAttribute("GeniusKilling") then
                VfxManager.Enable(descendant, false);
            end;
        end;

        return;
    end;

    local workspace_NagiCam = workspace.NagiCam;
    local v11 = Debris:FindFirstChild(v5);
    VfxManager.Emit(workspace_NagiCam.CamPart);
    local v12 = script.Sphere:Clone();
    v12.CFrame = Char.HumanoidRootPart.CFrame;
    v12.Parent = v11;
    v12.Transparency = 0;
    VfxManager.Enable(v12, true);
    local v13 = script.Floor:Clone();
    v13.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    v13.Parent = v11;
    v13.Transparency = 0;
    local GoldVignette = Players.LocalPlayer.PlayerGui.Vignette.GoldVignette;
    GoldVignette.ImageTransparency = 0;

    for _, descendant in GoldVignette:GetDescendants() do
        descendant.ImageTransparency = 0;
    end;

    task.spawn(function() -- Line: 111
        -- upvalues: SoundManager (ref), ReplicatedStorage (ref), Players (ref), TweenService (ref)
        SoundManager.SpawnSound("GeniusKillingMaliciaVoiceline", 0.7, workspace, 150);
        local v14 = ReplicatedStorage.Assets.UI.Popup:Clone();
        v14.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
        v14.Position = UDim2.new(0.5, 0, 0.8, 0);
        v14.Size = UDim2.new(1, 0, 0.1, 0);
        v14.BackgroundTransparency = 1;
        v14.AnchorPoint = Vector2.new(0.5, 0.5);
        v14.Font = Enum.Font.ArialBold;
        v14.MaxVisibleGraphemes = 0;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Parent = v14;
        UIStroke.Thickness = 4;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v14.MaxVisibleGraphemes = 0;
        v14.TextTransparency = 0;
        v14.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v14.Text = "I\'m doing this... ";
        TweenService:Create(v14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v14.Text
        }):Play();
        task.wait(1);
        v14.MaxVisibleGraphemes = 0;
        v14.TextTransparency = 0;
        v14.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v14.Text = "If i lose I\'ll be a temple monk for the rest of my life...";
        TweenService:Create(v14, TweenInfo.new(1.3, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v14.Text
        }):Play();
        task.wait(2.3);
        v14.TextColor3 = Color3.fromRGB(255, 255, 0);
        v14.MaxVisibleGraphemes = 0;
        v14.TextTransparency = 0;
        v14.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        v14.Text = "BUDDHA BE PRAISED!";
        TweenService:Create(v14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #v14.Text
        }):Play();
        task.wait(1);
        TweenService:Create(v14, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.5166666666666667, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
end;