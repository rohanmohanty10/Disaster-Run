  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

local function impactFrame() -- Line: 11
    local u1 = false;
    local ColorCorrection = game.Lighting.ColorCorrection;
    local u2 = {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast,
        Saturation = ColorCorrection.Saturation,
        TintColor = ColorCorrection.TintColor
    };
    ColorCorrection.Brightness = 0;
    ColorCorrection.Contrast = 100;
    ColorCorrection.Saturation = -1;
    task.delay(0.05, function() -- Line: 25
        -- upvalues: ColorCorrection (copy)
        ColorCorrection.Contrast = -100;
        ColorCorrection.TintColor = Color3.fromRGB(255);
    end);
    task.delay(0.1, function() -- Line: 29
        -- upvalues: ColorCorrection (copy)
        ColorCorrection.Contrast = 100;
        ColorCorrection.TintColor = Color3.fromRGB();
    end);
    task.delay(0.15, function() -- Line: 33
        -- upvalues: u1 (ref), ColorCorrection (copy), u2 (copy)
        u1 = true;
        ColorCorrection.Brightness = u2.Brightness;
        ColorCorrection.Contrast = u2.Contrast;
        ColorCorrection.Saturation = u2.Saturation;
        ColorCorrection.TintColor = u2.TintColor;
    end);
end;

return function(p3) -- Line: 43
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), TweenService (copy), VfxManager (copy), Debris (copy), impactFrame (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local _ = game.Workspace;
    local Char = p3.Char;

    if Char then
        local _ = Char.HumanoidRootPart;
    end;

    local Effect = p3.Effect;
    workspace.CurrentCamera.FieldOfView = 30;

    if Effect == "Atmosphere" then
        local v4 = game.Lighting:FindFirstChild("Atmosphere") or game.Lighting:FindFirstChildOfClass("Atmosphere");

        if v4 then
            v4.Parent = script;
            script.CutsceneAtmosphere.Parent = game.Lighting;
        end;
    else
        if Effect == "ScreenCover" then
            task.spawn(function() -- Line: 64
                -- upvalues: ReplicatedStorage (ref), TweenService (ref)
                local v5 = ReplicatedStorage.Assets.UI.Popup:Clone();
                v5.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
                v5.Position = UDim2.new(0.5, 0, 0.8, 0);
                v5.Size = UDim2.new(1, 0, 0.1, 0);
                v5.BackgroundTransparency = 1;
                v5.AnchorPoint = Vector2.new(0.5, 0.5);
                v5.Font = Enum.Font.ArialBold;
                v5.MaxVisibleGraphemes = 0;
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Parent = v5;
                UIStroke.Thickness = 4;
                UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
                v5.MaxVisibleGraphemes = 0;
                v5.TextTransparency = 0;
                v5.TextStrokeTransparency = 0;
                UIStroke.Transparency = 0;
                v5.Text = "Know your place and don\'t get the wrong idea, donkey";
                TweenService:Create(v5, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = #v5.Text
                }):Play();
                task.wait(2);
                v5.MaxVisibleGraphemes = 0;
                v5.TextTransparency = 0;
                v5.TextStrokeTransparency = 0;
                UIStroke.Transparency = 0;
                v5.Text = "My shooting range is actually 27 meters!";
                TweenService:Create(v5, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                    MaxVisibleGraphemes = #v5.Text
                }):Play();
                task.wait(1);
                TweenService:Create(v5, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                    TextTransparency = 1,
                    TextStrokeTransparency = 1
                }):Play();
                TweenService:Create(UIStroke, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
            end);
            local v6 = script.SCreencover:Clone();
            v6.CFrame = workspace.CurrentCamera.CFrame;
            v6.Parent = workspace.Debris;
            VfxManager.Emit(v6);
            Debris:AddItem(v6, 1);
            local u7 = 0;
            task.spawn(function() -- Line: 113
                -- upvalues: u7 (ref), impactFrame (ref)
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesKOTJ:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                game.Players.LocalPlayer.PlayerGui.ImpactFramesKOTJ.Enabled = true;

                for i = 1, 10 do
                    task.delay(u7, function() -- Line: 119
                        -- upvalues: i (copy)
                        local ImpactFramesKOTJ = game.Players.LocalPlayer.PlayerGui.ImpactFramesKOTJ;

                        if i > 1 then
                            ImpactFramesKOTJ[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                        end;

                        ImpactFramesKOTJ[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                    end);
                    u7 = u7 + 0.05;
                    local _ = i;
                end;

                task.delay(u7, function() -- Line: 129
                    -- upvalues: impactFrame (ref)
                    for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesKOTJ:GetChildren() do
                        child.Position = UDim2.new(0.5, 0, 1.5, 0);
                    end;

                    game.Players.LocalPlayer.PlayerGui.ImpactFramesKOTJ.Enabled = false;
                    impactFrame();
                end);
            end);

            return;
        end;

        if Effect == "Aura" then
            local CutsceneAtmosphere = game.Lighting:FindFirstChild("CutsceneAtmosphere");
            local v8 = script:FindFirstChild("Atmosphere") or script:FindFirstChildOfClass("Atmosphere");

            if CutsceneAtmosphere then
                CutsceneAtmosphere.Parent = script;
                v8.Parent = game.Lighting;
            end;

            local v9 = script.Aura:Clone();

            for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
                local v10 = v;

                for _, child in v9[v]:GetChildren() do
                    if child:IsA("Attachment") or child:IsA("ParticleEmitter") then
                        child.Parent = Char[v10];
                        child:SetAttribute("KingAura", true);
                    end;
                end;
            end;

            return;
        end;

        if Effect == "ShotCharge" then
            local v11 = script.shards:Clone();
            v11.CFrame = Char["Right Leg"].CFrame;
            v11.Parent = workspace.Debris;
            Debris:AddItem(v11, 3);
            VfxManager.Enable(v11, true);
            task.wait(2);
            VfxManager.Enable(v11, false);

            for _, descendant in Char:GetDescendants() do
                if descendant:GetAttribute("KingAura") then
                    Debris:AddItem(descendant, 1);
                end;
            end;

            for _, child in Char:GetChildren() do
                if child:IsA("BasePart") then
                    VfxManager.Enable(child, false);
                end;
            end;

            workspace.CurrentCamera.FieldOfView = 70;

            return;
        end;

        if Effect == "Cleanup" then
            if Char then
                for _, descendant in Char:GetDescendants() do
                    if descendant:GetAttribute("KingAura") then
                        Debris:AddItem(descendant, 1);
                    end;
                end;

                for _, child in Char:GetChildren() do
                    if child:IsA("BasePart") then
                        VfxManager.Enable(child, false);
                    end;
                end;
            end;

            local CutsceneAtmosphere = game.Lighting:FindFirstChild("CutsceneAtmosphere");
            local v12 = script:FindFirstChild("Atmosphere") or script:FindFirstChildOfClass("Atmosphere");

            if CutsceneAtmosphere then
                CutsceneAtmosphere.Parent = script;
                v12.Parent = game.Lighting;
            end;

            workspace.CurrentCamera.FieldOfView = 70;
        end;
    end;
end;