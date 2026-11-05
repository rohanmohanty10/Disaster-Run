  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage:FindFirstChild("Client Assets").Pirates;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();
local Lighting = game:GetService("Lighting");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

return function(p1) -- Line: 19
    -- upvalues: LocalPlayer (copy), PlayerGui (copy), ParticleHandler (copy), Lighting (copy), TweenService (copy)
    local u2 = p1 or LocalPlayer.Character;
    local v3 = Color3.fromRGB(74, 128, 255);
    local v4 = Color3.fromRGB(16, 72, 156);
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "VignetteScreen";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Parent = PlayerGui;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.ImageColor3 = ParticleHandler.TryHSVShift(v3, {
        Character = u2
    });
    ImageLabel.Image = "rbxassetid://3124804643";
    ImageLabel.ImageTransparency = 0;
    ImageLabel.Parent = ScreenGui;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 7;
    BlurEffect.Parent = Lighting;
    task.delay(0.5, BlurEffect.Destroy, BlurEffect);
    local u5 = TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true), {
        Size = 11
    });
    u5:Play();
    local u6 = TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true, 0.25), {
        ImageTransparency = 0.4,
        ImageColor3 = v4
    });
    u6:Play();

    local function FadeGuis() -- Line: 55
        -- upvalues: u6 (ref), u5 (ref), TweenService (ref), BlurEffect (copy), ImageLabel (copy), ScreenGui (copy)
        u6:Pause();
        u5:Pause();
        u5 = TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = 0
        });
        u5.Completed:Connect(function() -- Line: 62
            -- upvalues: u5 (ref)
            u5:Destroy();
        end);
        u5:Play();
        u6 = TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            ImageTransparency = 1
        });
        u6.Completed:Connect(function() -- Line: 70
            -- upvalues: ScreenGui (ref)
            ScreenGui:Destroy();
        end);
        u6:Play();
    end;

    local u7 = nil;
    u7 = u2:GetAttributeChangedSignal("ATrainRun"):Connect(function() -- Line: 76
        -- upvalues: u2 (copy), u7 (ref), FadeGuis (copy)
        if not u2:GetAttribute("ATrainRun") then
            u7:Disconnect();
            FadeGuis();
        end;
    end);
    u2.AncestryChanged:Connect(FadeGuis);
end;