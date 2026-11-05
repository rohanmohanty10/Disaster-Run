  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(u1) -- Line: 9
    -- upvalues: LocalPlayer (copy), Trove (copy), TweenService (copy)
    local v2 = script.ChargeUI:Clone();
    v2.Parent = LocalPlayer.PlayerGui;
    local u3 = Trove.new();
    local Character = u1.Character;
    local Hook = u1.Hook;
    local Bolt = v2.Container.Bolt;
    local Spectrum = v2.Container.Spectrum;
    local TextLabel = v2.Container.TextLabel;
    local v4 = ColorSequence.new({ ColorSequenceKeypoint.new(0, u1.BackgroundColor), ColorSequenceKeypoint.new(0.99, u1.BackgroundColor), ColorSequenceKeypoint.new(1, u1.Color) });
    TextLabel.TextColor3 = u1.Color;
    Bolt.UIGradient.Color = v4;
    Spectrum.UIGradient.Color = v4;
    TextLabel.Text = "0%";
    TextLabel.TextColor3 = u1.BackgroundColor;
    TextLabel.Visible = true;
    local u5 = TweenService:Create(Bolt, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        ImageTransparency = 1
    });
    u5:Play();

    local function Update() -- Line: 37
        -- upvalues: Character (copy), Hook (copy), u3 (copy), Spectrum (copy), Bolt (copy), TextLabel (copy), u1 (copy), u5 (copy)
        local v6 = Character:GetAttribute(Hook);

        if not v6 then
            u3:Destroy();

            return;
        end;

        Spectrum.UIGradient.Offset = Vector2.new(v6, 0);
        Bolt.UIGradient.Offset = Vector2.new(0, v6);
        local v7 = math.floor(100 * v6);
        TextLabel.Text = math.clamp(v7, 0, 100) .. "%";
        TextLabel.TextColor3 = u1.BackgroundColor:Lerp(u1.Color, v6);

        if v6 < 1 or u5.PlaybackState ~= Enum.PlaybackState.Playing then
            if v6 < 1 and u5.PlaybackState ~= Enum.PlaybackState.Playing then
                u5:Play();
            end;

            return;
        end;

        u5:Cancel();
        Bolt.ImageTransparency = 0;
    end;

    u3:Add(v2);
    u3:AttachToInstance(Character);
    u3:Connect(Character:GetAttributeChangedSignal(Hook), Update);
    Update();
    v2.Enabled = true;
end;