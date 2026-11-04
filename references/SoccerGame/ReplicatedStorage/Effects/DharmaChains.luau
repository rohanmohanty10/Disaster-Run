  

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
end;

return function(p3) -- Line: 22
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), ReplicatedStorage (copy), Players (copy), TweenService (copy), VfxManager (copy), TweenService2 (copy), Knit (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p3.Char;
    local v4 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p3.Task == "Cutscene" then
        if not Char then
            return;
        end;

        if not Char:FindFirstChild("HumanoidRootPart") then
            return;
        end;

        SoundManager.SpawnSound("DharmaChains", 0.7, workspace, 150);
        SoundManager.SpawnSound("DharmaChainsVoiceline", 0.7, workspace, 150);
        local Folder = Instance.new("Folder");
        Folder.Name = v4;
        Folder.Parent = Debris;
        Folder:SetAttribute("Active", true);
        local DepthOfField = game.Lighting.DepthOfField;
        local v5 = script.DepthOfField:Clone();
        v5.Name = "DharmaDepth";
        v5.Parent = game.Lighting;
        DepthOfField.Enabled = false;
        task.spawn(function() -- Line: 48
            -- upvalues: ReplicatedStorage (ref), Players (ref), TweenService (ref)
            local v6 = ReplicatedStorage.Assets.UI.Popup:Clone();
            v6.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            v6.Position = UDim2.new(0.5, 0, 0.8, 0);
            v6.Size = UDim2.new(1, 0, 0.1, 0);
            v6.BackgroundTransparency = 1;
            v6.AnchorPoint = Vector2.new(0.5, 0.5);
            v6.Font = Enum.Font.ArialBold;
            v6.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = v6;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            v6.MaxVisibleGraphemes = 0;
            v6.TextTransparency = 0;
            v6.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            task.wait(3);
            v6.Text = "You left yourself open! Amen!";
            TweenService:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v6.Text
            }):Play();
            task.wait(2.3);
            TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.wait(0.5);
            v6.MaxVisibleGraphemes = 0;
            v6.TextTransparency = 0;
            v6.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v6.Text = "Gotcha!";
            TweenService:Create(v6, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v6.Text
            }):Play();
            task.wait(1);
            TweenService:Create(v6, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
        end);

        return;
    end;

    if p3.Task ~= "Start" then
        if p3.Task == "ScreenChange" then
            local workspace_NagiCam = workspace.NagiCam;
            Debris:FindFirstChild(v4);
            VfxManager.Enable(workspace_NagiCam.Torso.at, true);
            task.wait(0.2);

            return;
        end;

        if p3.Task ~= "ClearBackdrop" then
            if p3.Task == "CamLines" then
                local workspace_NagiCam = workspace.NagiCam;
                Debris:FindFirstChild(v4);
                workspace_NagiCam.Torso.ee.Enabled = true;
                workspace_NagiCam.Torso.eeee.Enabled = true;
                task.wait(0.35);
                workspace_NagiCam.Torso.ee.Enabled = false;
                workspace_NagiCam.Torso.eeee.Enabled = false;
                local Frame = game.Players.LocalPlayer.PlayerGui.ScreenFlash.Frame;
                Frame.BackgroundTransparency = 1;
                Frame.BackgroundColor3 = Color3.fromRGB();
                Frame.Visible = true;
                TweenService2:Create(Frame, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 0
                }):Play();
                task.wait(0.25);
                local v7 = Debris:FindFirstChild(v4);

                if v7 then
                    v7:Destroy();
                end;

                local DharmaDepth = game.Lighting:FindFirstChild("DharmaDepth");

                if DharmaDepth then
                    DharmaDepth:Destroy();
                end;

                game.Lighting.DepthOfField.Enabled = true;
                task.wait(0.5);
                TweenService2:Create(Frame, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1
                }):Play();
                task.delay(1, function() -- Line: 203
                    -- upvalues: Frame (copy)
                    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                    Frame.Visible = false;
                end);

                if game.Players.LocalPlayer.Name == p3.Victim.Name then
                    local Controller = Knit.GetController("StatesController");
                    Controller.SpeedBoost = -20;
                    task.wait(5);
                    Controller.SpeedBoost = 0;

                    return;
                end;
            elseif p3.Task == "Cleanup" then
                local v8 = Debris:FindFirstChild(v4);

                if v8 then
                    v8:Destroy();
                end;

                local DharmaDepth = game.Lighting:FindFirstChild("DharmaDepth");

                if DharmaDepth then
                    DharmaDepth:Destroy();
                end;

                game.Lighting.DepthOfField.Enabled = true;
            end;

            return;
        end;

        local workspace_NagiCam = workspace.NagiCam;
        local v9 = Debris:FindFirstChild(v4);
        VfxManager.Enable(workspace_NagiCam.Torso.at, false);
        task.wait(0.2);
        local v10 = script["Dash Away"]:Clone();
        v10.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(
            -11.4573936,
            -2.49999309,
            -18.7997932,
            0.86133045,
            0,
            -0.508045077,
            0,
            1,
            0,
            0.508045077,
            0,
            0.86133045
        );
        v10.Parent = v9;
        VfxManager.Emit(v10);

        return;
    end;

    local v11 = Debris:FindFirstChild(v4);
    local GoldVignette = Players.LocalPlayer.PlayerGui.Vignette.GoldVignette;
    GoldVignette.ImageTransparency = 0;

    for _, descendant in GoldVignette:GetDescendants() do
        descendant.ImageTransparency = 0;
    end;

    local u12 = script.Sphere:Clone();
    u12.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-12.0993299, 2.66468048, -19.2131119, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    u12.Parent = v11;
    u12.Transparency = 0;
    VfxManager.Enable(u12, true);
    local u13 = script.floor:Clone();
    u13.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-14.7478638, -3.1521244, -17.9065475, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    u13.Parent = v11;
    u13.Transparency = 0;
    local v14 = script.AuraEmit:Clone();
    v14:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(-12.4760361, -2.55840373, -15.4158325, 1, 0, 0, 0, 1, 0, 0, 0, 1));
    v14.Parent = v11;
    VfxManager.Emit(v14);
    task.delay(0.4, function() -- Line: 123
        -- upvalues: VfxManager (ref), u12 (copy), TweenService2 (ref), u13 (copy), Players (ref)
        VfxManager.Enable(u12, false);
        TweenService2:Create(u12, TweenInfo.new(0.5), {
            Transparency = 1
        }):Play();
        TweenService2:Create(u13, TweenInfo.new(0.5), {
            Transparency = 1
        }):Play();
        local GoldVignette2 = Players.LocalPlayer.PlayerGui.Vignette.GoldVignette;
        TweenService2:Create(GoldVignette2, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();

        for _, descendant in GoldVignette2:GetDescendants() do
            TweenService2:Create(descendant, TweenInfo.new(0.5), {
                ImageTransparency = 1
            }):Play();
        end;
    end);
    task.wait(1.2);
    local v15 = script.GroundFX:Clone();
    v15.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(-10.3552742, -2.92238593, -17.8140297, 1, 0, 0, 0, 0.999996781, 0, 0, 0, 0.999996781);
    v15.Parent = v11;
    VfxManager.Emit(v15);
end;