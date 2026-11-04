  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Atmosphere = game.Lighting.Atmosphere;
local u1 = {
    Density = Atmosphere.Density,
    Offset = Atmosphere.Offset,
    Color = Atmosphere.Color,
    Decay = Atmosphere.Decay,
    Glare = Atmosphere.Glare,
    Haze = Atmosphere.Haze
};
local script_Atmosphere = script.Atmosphere;
local u2 = {
    Density = script_Atmosphere.Density,
    Offset = script_Atmosphere.Offset,
    Color = script_Atmosphere.Color,
    Decay = script_Atmosphere.Decay,
    Glare = script_Atmosphere.Glare,
    Haze = script_Atmosphere.Haze
};
local ColorCorrection = game.Lighting.ColorCorrection;
local u3 = {
    Brightness = ColorCorrection.Brightness,
    Contrast = ColorCorrection.Contrast,
    Saturation = ColorCorrection.Saturation,
    TintColor = ColorCorrection.TintColor
};

local function impactFrame() -- Line: 39
    -- upvalues: ColorCorrection (copy), u3 (copy)
    ColorCorrection.Brightness = 0;
    ColorCorrection.Contrast = 100;
    ColorCorrection.Saturation = -1;
    task.delay(0.05, function() -- Line: 43
        -- upvalues: ColorCorrection (ref)
        ColorCorrection.Contrast = -100;
    end);
    task.delay(0.1, function() -- Line: 46
        -- upvalues: ColorCorrection (ref)
        ColorCorrection.Contrast = 100;
    end);
    task.delay(0.15, function() -- Line: 49
        -- upvalues: ColorCorrection (ref), u3 (ref)
        ColorCorrection.Brightness = u3.Brightness;
        ColorCorrection.Contrast = u3.Contrast;
        ColorCorrection.Saturation = u3.Saturation;
        ColorCorrection.TintColor = u3.TintColor;
    end);
end;

return function(p4) -- Line: 57
    -- upvalues: SpectatorController (copy), CollectionService (copy), VfxManager (copy), TweenService (copy), Atmosphere (copy), u2 (copy), u1 (copy), ReplicatedStorage (copy), Debris (copy), impactFrame (copy), Essentials (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local _ = game.Workspace;
    local Char = p4.Char;
    local _ = Char.HumanoidRootPart;

    local function EnableParticles(p5, u6) -- Line: 66
        local Descendants = p5:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 70
                    -- upvalues: v (copy), u6 (copy)
                    v.Enabled = u6;
                end);
            end;
        end;

        table.clear(Descendants);
    end;

    local function EmitParticles(p7) -- Line: 78
        local Descendants = p7:GetDescendants();

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") then
                task.defer(function() -- Line: 82
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            end;
        end;

        table.clear(Descendants);
    end;

    local Effect = p4.Effect;
    workspace.CurrentCamera.FieldOfView = 30;

    if Effect == "Ghouls" then
        local Demon = p4.Demon;
        local v8 = script.GhoulAura:Clone();
        v8.CFrame = Demon.PrimaryPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
        v8.Parent = workspace.Debris;
        CollectionService:AddTag(v8, "KingsAwakening");
        VfxManager.Enable(v8, true);
        TweenService:Create(Atmosphere, TweenInfo.new(0.5), u2):Play();
        task.delay(3.6, function() -- Line: 104
            -- upvalues: TweenService (ref), Atmosphere (ref), u1 (ref)
            TweenService:Create(Atmosphere, TweenInfo.new(0.5), u1):Play();
        end);
        task.spawn(function() -- Line: 108
            -- upvalues: ReplicatedStorage (ref), TweenService (ref)
            local v9 = ReplicatedStorage.Assets.UI.Popup:Clone();
            v9.Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
            v9.Position = UDim2.new(0.5, 0, 0.8, 0);
            v9.Size = UDim2.new(1, 0, 0.1, 0);
            v9.BackgroundTransparency = 1;
            v9.AnchorPoint = Vector2.new(0.5, 0.5);
            v9.Font = Enum.Font.ArialBold;
            v9.MaxVisibleGraphemes = 0;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Parent = v9;
            UIStroke.Thickness = 4;
            UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
            v9.MaxVisibleGraphemes = 0;
            v9.TextTransparency = 0;
            v9.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v9.Text = "What is clinging to me?";
            TweenService:Create(v9, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v9.Text
            }):Play();
            task.wait(1.6);
            TweenService:Create(v9, TweenInfo.new(0.275, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.275, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.wait(0.9583333333333334);
            v9.MaxVisibleGraphemes = 0;
            v9.TextTransparency = 0;
            v9.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v9.Text = "I see, the route for my goal is...";
            TweenService:Create(v9, TweenInfo.new(1.3, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v9.Text
            }):Play();
            task.wait(2.5);
            v9.MaxVisibleGraphemes = 0;
            v9.TextTransparency = 0;
            v9.TextStrokeTransparency = 0;
            UIStroke.Transparency = 0;
            v9.Text = "THIS TWISTED PATH!!!";
            TweenService:Create(v9, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                MaxVisibleGraphemes = #v9.Text
            }):Play();
            task.wait(0.4);
            TweenService:Create(v9, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            }):Play();
            TweenService:Create(UIStroke, TweenInfo.new(0.95, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
        end);

        return;
    end;

    if Effect == "Awaken" then
        local v10 = nil;

        for _, v in CollectionService:GetTagged("KingsAwakening") do
            if v.Name == "GhoulAura" then
                v10 = v;
            end;
        end;

        VfxManager.Enable(v10, false);
        Debris:AddItem(v10, 1);
        local v11 = script.Aura:Clone();

        for _, v in { "Left Arm", "Right Arm", "Left Leg", "Right Leg", "Torso" } do
            local v12 = v;

            for _, child in v11[v]:GetChildren() do
                if child:IsA("Attachment") or child:IsA("ParticleEmitter") then
                    child.Parent = Char:FindFirstChild(v12);
                    child:SetAttribute("KingAura", true);
                end;
            end;
        end;

        task.wait(4);

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

        return;
    end;

    if Effect == "Impact" then
        local u13 = 0;
        task.spawn(function() -- Line: 205
            -- upvalues: u13 (ref), impactFrame (ref)
            for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesKing:GetChildren() do
                child.Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            game.Players.LocalPlayer.PlayerGui.ImpactFramesKing.Enabled = true;

            for i = 1, 10 do
                task.delay(u13, function() -- Line: 211
                    -- upvalues: i (copy)
                    local ImpactFramesKing = game.Players.LocalPlayer.PlayerGui.ImpactFramesKing;

                    if i > 1 then
                        ImpactFramesKing[`Frame{tostring(i - 1)}`].Position = UDim2.new(0.5, 0, 2, 0);
                    end;

                    ImpactFramesKing[`Frame{tostring(i)}`].Position = UDim2.new(0.5, 0, 0.5, 0);
                end);
                u13 = u13 + 0.05;
                local _ = i;
            end;

            task.delay(u13, function() -- Line: 221
                -- upvalues: impactFrame (ref)
                for _, child in game.Players.LocalPlayer.PlayerGui.ImpactFramesKing:GetChildren() do
                    child.Position = UDim2.new(0.5, 0, 1.5, 0);
                end;

                game.Players.LocalPlayer.PlayerGui.ImpactFramesKing.Enabled = false;
                impactFrame();
            end);
        end);
        TweenService:Create(Atmosphere, TweenInfo.new(0.5), u1):Play();
        task.wait(3);
        workspace.CurrentCamera.FieldOfView = 70;

        return;
    end;

    if Effect ~= "Chop" then
        if Effect == "End" then
            workspace.CurrentCamera.FieldOfView = 70;
        end;

        return;
    end;

    if not Char:GetAttribute("Chopped") then
        local u14 = ReplicatedStorage.Assets.Vfx.Chops.ChopsFloorTrail:Clone();
        u14.Parent = Char.Torso;
        u14.CFrame = Char.Torso.CFrame * CFrame.new(0, -3, 0);
        Debris:AddItem(u14, 1);
        Essentials:Weld(u14, Char.Torso);
        local u15 = ReplicatedStorage.Assets.Vfx.KingsDribble.RunPlr:Clone();
        u15.Parent = Char.Torso;
        u15.CFrame = Char.Torso.CFrame;
        Debris:AddItem(u15, 1);
        Essentials:Weld(u15, Char.Torso);
        Char:SetAttribute("Chopped", true);
        task.delay(1, function() -- Line: 252
            -- upvalues: VfxManager (ref), u14 (copy), u15 (copy), Char (copy)
            VfxManager.Enable(u14, false);
            VfxManager.Enable(u15, false);
            Char:SetAttribute("Chopped", nil);
        end);
    end;

    local v16 = ReplicatedStorage.Assets.Vfx.Chops.EmitChopStart:Clone();
    v16.Anchored = true;
    v16.Parent = workspace.Debris;
    v16.CFrame = Char.Torso.CFrame;
    VfxManager.Emit(v16);
    Debris:AddItem(v16, 1);
end;