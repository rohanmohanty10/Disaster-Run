  

 

local TweenService = game:GetService("TweenService");
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function() -- Line: 22
    -- upvalues: PlayerGui (copy), EffectsHandler (copy), TweenService (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 100;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.new(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = ScreenGui;

    local function MakeLabel(p1) -- Line: 35
        -- upvalues: Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(0.8, 0.15);
        TextLabel.Position = UDim2.fromScale(0.5, 0.5);
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = 56;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextTransparency = 1;
        TextLabel.Text = p1;
        TextLabel.TextWrapped = true;
        TextLabel.Parent = Frame;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromHex("#afc8ff"));
        UIGradient.Rotation = 90;
        UIGradient.Parent = TextLabel;

        return TextLabel;
    end;

    local function TypeText(p2, p3) -- Line: 57
        local Text = p2.Text;
        p2.MaxVisibleGraphemes = 0;
        p2.TextTransparency = 0;
        local v4 = utf8.len(Text);
        local v5 = p3 / v4;

        for i = 1, v4 do
            p2.MaxVisibleGraphemes = i;
            task.wait(v5);
        end;
    end;

    local function FadeLabel(p6, p7, p8, p9) -- Line: 69
        -- upvalues: TypeText (copy), EffectsHandler (ref), TweenService (ref)
        TypeText(p6, p7);
        EffectsHandler.Wait(p8);
        TweenService:Create(p6, TweenInfo.new(p9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
        EffectsHandler.Wait(p9);
    end;

    TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0
    }):Play();
    EffectsHandler.Wait(0.7);
    local v10 = MakeLabel("You were struck by lightning...");
    v10.Position = UDim2.fromScale(0.5, 0.45);
    FadeLabel(v10, 0.8, 0.6, 0.3);
    v10:Destroy();
    EffectsHandler.Wait(0.2);
    local v11 = MakeLabel("Dominate the thunder. Channel your will and spirit to survive.");
    v11.Position = UDim2.fromScale(0.5, 0.45);
    TypeText(v11, 0.9);
    EffectsHandler.Wait(0.7);
    TweenService:Create(v11, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1
    }):Play();
    TweenService:Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();
    EffectsHandler.Wait(0.6);
    ScreenGui:Destroy();
end;