  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = {};
local Lighting = game.Lighting;
local TweenService = game:GetService("TweenService");
local u16 = {
    Default = function(p2, p3) -- Line: 11
        local v4 = script:FindFirstChild(p2);

        if v4 and v4:IsA("Folder") then
            for _, child in v4:GetChildren() do
                local v5 = p3:Clone(child);
                v5:SetAttribute("AmbienceObject", true);
                v5.Parent = game.Lighting;
            end;
        end;
    end,

    ["Hueco Mundo"] = function(p6, p7) -- Line: 23
        -- upvalues: Lighting (copy)
        local ClockTime = Lighting.ClockTime;
        Lighting.ClockTime = 0;
        local v8 = script:FindFirstChild(p6);
        p7:Add(function() -- Line: 29
            -- upvalues: Lighting (ref), ClockTime (copy)
            Lighting.ClockTime = ClockTime;
        end);

        if v8 and v8:IsA("Folder") then
            for _, child in v8:GetChildren() do
                local v9 = p7:Clone(child);
                v9:SetAttribute("AmbienceObject", true);
                v9.Parent = game.Lighting;
            end;
        end;
    end,

    ["Devil\'s Palm"] = function(p10, p11) -- Line: 42
        -- upvalues: Lighting (copy), TweenService (copy)
        local v12 = p11:Construct(Instance, "BlurEffect");
        v12.Name = "DPBlur";
        v12.Parent = Lighting;
        TweenService:Create(v12, TweenInfo.new(1), {
            Size = 9
        }):Play();
        local v13 = p11:Construct(Instance, "ColorCorrectionEffect");
        v13.Name = "DPColorCorrection";
        v13.Parent = Lighting;
        TweenService:Create(v13, TweenInfo.new(1), {
            Saturation = -0.5,
            TintColor = Color3.fromRGB(240, 196, 134)
        }):Play();
        local v14 = p11:Construct(Instance, "Atmosphere");
        v14.Name = "DPAtmosphere";
        v14.Density = 0.3;
        v14.Haze = 0.1;
        v14.Color = Color3.fromRGB(150, 150, 150);
        v14.Decay = Color3.fromRGB(100, 100, 100);
        v14.Parent = Lighting;
        TweenService:Create(v14, TweenInfo.new(1), {
            Density = 0.7,
            Haze = 10,
            Decay = Color3.fromRGB(190, 190, 190),
            Color = Color3.fromRGB(175, 175, 175)
        }):Play();
        local v15 = p11:Construct(Instance, "Sound");
        v15.Parent = workspace;
        v15.Name = "AreaMusic";
        v15.Looped = true;
        v15.SoundId = "rbxassetid://9062045120";
        v15.Volume = 1;
        v15:Play();
    end
};

return function(p17, p18) -- Line: 85
    -- upvalues: u1 (copy), Trove (copy), u16 (copy)
    if u1[p17] then
        u1[p17]:Destroy();
        u1[p17] = nil;

        for _, child in game.Lighting:GetChildren() do
            if not child:GetAttribute("AmbienceObject") then
                child.Parent = nil;
                task.delay(0.5, function() -- Line: 94
                    -- upvalues: child (copy)
                    child.Parent = game.Lighting;
                end);
            end;
        end;

        return;
    end;

    local v19 = Trove.new();
    u1[p17] = v19;
    (u16[p17] or u16.Default)(p17, v19);
end;