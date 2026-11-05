  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = Random.new();

local function u4(p2, p3) -- Line: 23
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function UseNumber(p5) -- Line: 27
    -- upvalues: u4 (copy)
    if typeof(p5) == "number" then
        return p5;
    end;

    return typeof(p5) ~= "NumberRange" and 0 or u4(p5.Min, p5.Max);
end;

return function(p6, p7) -- Line: 37
    -- upvalues: EffectsHandler (copy)
    local Cinematic = workspace:FindFirstChild("Map"):FindFirstChild("Fractured Island"):FindFirstChild("Special"):FindFirstChild("Cinematic");
    local v8 = {
        ABILITY_658 = "rbxassetid://84352444880887",
        ABILITY_8008135 = "rbxassetid://129354086212122",
        ABILITY_13579 = "rbxassetid://76845622897640"
    };
    local v9 = ({
        ABILITY_658 = Cinematic:FindFirstChild("PlanetShaper_Start"),
        ABILITY_8008135 = Cinematic:FindFirstChild("Crystallized_Start"),
        ABILITY_13579 = Cinematic:FindFirstChild("NuclearStar_Start")
    })[p7.StartIndex];

    if not v9 then
        return;
    end;

    local v10 = {};

    for _, child in Cinematic:FindFirstChild("Waypoints"):GetChildren() do
        if child:IsA("BasePart") then
            local v11 = tonumber(child.Name);

            if v11 then
                v10[v11] = child;
            end;
        end;
    end;

    table.insert(v10, 1, v9);
    task.spawn(EffectsHandler.CallEffect, "Create Global Audio", {
        Volume = 1.5,
        PlaybackSpeed = 1,
        Sound = v8[p7.StartIndex]
    });
    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
        LifeTime = 8,
        Transparency = 0.2,
        TweenIn = { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
        Size = UDim2.fromScale(1, 1),
        Color = Color3.fromRGB(0, 0, 0)
    });
    EffectsHandler.CallEffect("Camera Cinematic", p6, {
        Duration = 10,
        EasingStyle = "Sine",
        EasingDirection = "InOut",
        EndOnCharacter = true,
        DisableUI = true,
        Waypoints = v10
    });
end;