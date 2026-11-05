  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = { 137197678732259, 122682756948865, 96310867892433, 124069238406635 };

if not workspace:SetAttribute("_KanjisLoaded") then
    workspace:SetAttribute("_KanjisLoaded", true);
    task.spawn(function() -- Line: 19
        -- upvalues: u1 (copy)
        local u2 = {};

        for _, v in u1 do
            local Decal = Instance.new("Decal");
            Decal.Texture = "rbxassetid://" .. v;
            table.insert(u2, Decal);
        end;

        game:GetService("ContentProvider"):PreloadAsync(u2, function(p3) -- Line: 26
            -- upvalues: u2 (copy)
            for _, v in u2 do
                if v.Texture == p3 then
                    v:Destroy();
                end;
            end;
        end);
    end);
end;

return function(u4) -- Line: 36
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), u1 (copy), TweenService (copy), EffectsHandler (copy)
    if not u4 then
        return;
    end;

    local u5 = AssetHandler.CloneAsset("UIs/SGSKanjisUI", {
        AbilityName = "Uber Oni"
    });
    u5.Parent = LocalPlayer.PlayerGui;
    local ImageLabel = u5.ImageLabel;
    local After = ImageLabel.After;
    ImageLabel.ImageTransparency = 1;
    ImageLabel.Image = "rbxassetid://" .. u1[u4.Kanjis or 1];
    ImageLabel.Size = u4.Size or ImageLabel.Size;
    ImageLabel.Position = u4.Position or ImageLabel.Position;
    After.Image = ImageLabel.Image;
    local u6 = TweenService:Create(ImageLabel, TweenInfo.new(u4.Time / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        ImageTransparency = 0,
        Size = ImageLabel.Size
    });
    local u7 = TweenService:Create(After, TweenInfo.new(u4.Time / 4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        ImageColor3 = Color3.new(),
        Size = UDim2.fromScale(0.4, 0.9)
    });
    ImageLabel.Size = UDim2.fromScale(ImageLabel.Size.X.Scale + 0.1, ImageLabel.Size.Y.Scale + 0.1);
    u6:Play();
    u6.Completed:Once(function() -- Line: 63
        -- upvalues: EffectsHandler (ref), u4 (copy), ImageLabel (copy), After (copy), u7 (copy), u6 (copy), u5 (copy)
        EffectsHandler.Wait(u4.LifeTime or u4.Time);
        ImageLabel.ImageTransparency = 1;
        After.Visible = true;
        u7:Play();
        u7.Completed:Once(function() -- Line: 68
            -- upvalues: u6 (ref), u7 (ref), u5 (ref)
            u6:Destroy();
            u7:Destroy();
            u5:Destroy();
        end);
    end);
end;