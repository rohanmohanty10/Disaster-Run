  

 

local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local CurrentCamera = workspace.CurrentCamera;
local CameraShaker = require(game:GetService("ReplicatedStorage").ClientModules:WaitForChild("CameraShaker"));
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 9
    -- upvalues: PlayerGui (copy), TweenService (copy), CameraShaker (copy), CurrentCamera (copy), LocalPlayer (copy), Debris (copy)
    local u3 = p2 or 2;
    local ScreenGui = Instance.new("ScreenGui", PlayerGui);
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Name = "VignetteGUI";
    local ImageLabel = Instance.new("ImageLabel", ScreenGui);
    ImageLabel.Size = UDim2.new(1, 0, 1, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://3124804643";
    ImageLabel.ImageColor3 = Color3.fromRGB(0, 46, 255);
    ImageLabel.ImageTransparency = 1;
    local BloomEffect = Instance.new("BloomEffect", game.Lighting);
    BloomEffect.Name = "TSpeedBloom";
    local v4 = BloomEffect:Clone();
    TweenService:Create(ImageLabel, TweenInfo.new(0.25), {
        ImageTransparency = 0,
        ImageColor3 = Color3.new(0, 0.8, 1)
    }):Play();
    spawn(function() -- Line: 26
        -- upvalues: u3 (copy), TweenService (ref), ImageLabel (copy), ScreenGui (copy)
        for _ = 2, u3 * 4 / 2 do
            wait(0.25);
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageColor3 = Color3.fromRGB(0, 46, 255)
            }):Play();
            wait(0.25);
            TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ImageColor3 = Color3.new(0, 0.8, 1)
            }):Play();
        end;

        wait(0.25);
        TweenService:Create(ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            ImageTransparency = 1
        }):Play();
        wait(0.25);
        ScreenGui:Destroy();
    end);

    if p1 then
        local v6 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p5) -- Line: 40
            -- upvalues: CurrentCamera (ref)
            CurrentCamera.CFrame = CurrentCamera.CFrame * p5;
        end);
        v6:Start();
        v6:Shake(CameraShaker.Presets.Bump);
        local v7 = LocalPlayer.Character.Omnitrix.PrimaryPart.TSBreak:Clone();
        v7.Parent = workspace;
        v7.TimePosition = 0.1;
        v7.PlaybackSpeed = 1.2;
        v7.PlayOnRemove = true;
        v7:Destroy();
    end;

    TweenService:Create(BloomEffect, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Intensity = 5,
        Size = 100,
        Threshold = 0.3
    }):Play();
    wait(u3);
    TweenService:Create(BloomEffect, TweenInfo.new(0.5), {
        Intensity = v4.Intensity,
        Size = v4.Size,
        Threshold = v4.Threshold
    }):Play();
    v4:Destroy();
    Debris:AddItem(BloomEffect, 0.6);
end;