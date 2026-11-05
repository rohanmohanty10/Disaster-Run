  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = game.ReplicatedStorage["Client Assets"];
local u2 = {
    ["Starless Patriot"] = {
        beamname = "LTBeamStarless Patriot",
        color = Color3.new(0.47451, 0.172549, 1),
        color2 = Color3.new(0, 0, 0),
        vignette = Color3.fromRGB(132, 60, 255)
    },
    ["D4C:LT: Lovestruck"] = {
        beamname = "LTBeamLovestruck",
        color = Color3.fromRGB(255, 76, 241),
        color2 = Color3.fromRGB(255, 76, 241),
        vignette = Color3.fromRGB(255, 76, 241)
    },
    Default = {
        beamname = "LTBeam",
        color = Color3.new(1, 0.627451, 0.027451),
        color2 = Color3.new(0.964706, 1, 0.294118),
        vignette = Color3.fromRGB(255, 217, 26)
    }
};

return function(u3, u4, u5) -- Line: 30
    -- upvalues: u2 (copy), ParticleHandler (copy), TweenService (copy), Debris (copy), u1 (copy)
    game.Players:GetPlayerFromCharacter(u4);
    local u6 = game.Players:GetPlayerFromCharacter(u4);
    local u7 = u2[u6.Data.Skin:GetAttribute("SkinName")] or u2.Default;

    if u5 then
        u5 = u5.HSVData;
    end;

    task.spawn(function() -- Line: 40
        -- upvalues: u6 (copy), ParticleHandler (ref), u7 (copy), u5 (copy), TweenService (ref), Debris (ref)
        if not u6:FindFirstChild("PlayerGui") then
            return;
        end;

        local v8 = ParticleHandler.TryHSVShift(u7.color, u5);
        ParticleHandler.TryHSVShift(u7.color2, u5);
        local ScreenGui = Instance.new("ScreenGui", u6.PlayerGui);
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.Name = "VignetteGUI";
        local ImageLabel = Instance.new("ImageLabel", ScreenGui);
        ImageLabel.Size = UDim2.new(1, 0, 1, 0);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://3124804643";
        ImageLabel.ImageColor3 = ParticleHandler.TryHSVShift(u7.vignette, u5);
        ImageLabel.ImageTransparency = 1;
        local BloomEffect = Instance.new("BloomEffect", game.Lighting);
        BloomEffect.Name = "TSpeedBloom";
        local v9 = BloomEffect:Clone();
        TweenService:Create(ImageLabel, TweenInfo.new(0.1), {
            ImageTransparency = 0,
            ImageColor3 = v8
        }):Play();
        task.spawn(function() -- Line: 60
            -- upvalues: TweenService (ref), ImageLabel (copy), ScreenGui (copy)
            wait(0.1);
            TweenService:Create(ImageLabel, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ImageTransparency = 1
            }):Play();
            wait(0.1);
            ScreenGui:Destroy();
        end);
        TweenService:Create(BloomEffect, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
            Intensity = 1.7,
            Size = 35,
            Threshold = 1.1
        }):Play();
        wait(0.5);
        TweenService:Create(BloomEffect, TweenInfo.new(0.25), {
            Intensity = v9.Intensity,
            Size = v9.Size,
            Threshold = v9.Threshold
        }):Play();
        v9:Destroy();
        Debris:AddItem(BloomEffect, 0.6);
    end);
    task.spawn(function() -- Line: 83
        -- upvalues: u1 (ref), u7 (copy), u5 (copy), ParticleHandler (ref), u4 (copy), u3 (copy), TweenService (ref)
        local u10 = u1["D4C: Love Train"][u7.beamname]:Clone();

        if u5 then
            ParticleHandler.Unusualify(u10, {
                HSVData = u5
            });
        end;

        u10:SetPrimaryPartCFrame(CFrame.lookAt(u4.HumanoidRootPart.Position, u3.HumanoidRootPart.Position));
        u10.Bottom.Attachment2.WorldCFrame = u4.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        u10.Bottom.Attachment.WorldCFrame = u4.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
        TweenService:Create(u10.Bottom.Attachment2, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            WorldCFrame = u3.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0)
        }):Play();
        TweenService:Create(u10.Bottom.Beam, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
            Width0 = 0,
            Width1 = 0
        }):Play();

        for i = 1, (u3.HumanoidRootPart.Position - u4.HumanoidRootPart.Position).Magnitude do
            local v11 = u10.LoveTrain:Clone();
            v11.CFrame = u10.Bottom.CFrame * CFrame.new((Vector3.new(0, -2, -i))) * CFrame.Angles(1.5707963267948966, 0, 0);
            v11.Parent = u10;
        end;

        u10.Parent = workspace.Effects;

        for _, descendant in pairs(u10:GetDescendants()) do
            if descendant:IsA("Beam") and descendant.Parent.Name ~= "Bottom" then
                task.spawn(function() -- Line: 111
                    -- upvalues: descendant (copy), u4 (ref), TweenService (ref)
                    local Magnitude = (descendant.Parent.Position - u4.HumanoidRootPart.Position).Magnitude;
                    wait(Magnitude / 200);
                    local Attachment1 = descendant.Attachment1;
                    local v12 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                    local v13 = {};
                    local v14 = -1 * math.random(0.5, 3);
                    v13.Position = Vector3.new(0, 0, v14);
                    TweenService:Create(Attachment1, v12, v13):Play();
                    wait(Magnitude / 150);
                    TweenService:Create(Attachment1, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Position = Vector3.new(0, 0, 0)
                    }):Play();
                end);
            end;
        end;

        task.spawn(function() -- Line: 123
            -- upvalues: u10 (copy)
            wait(3);
            u10:Destroy();
        end);
    end);
end;