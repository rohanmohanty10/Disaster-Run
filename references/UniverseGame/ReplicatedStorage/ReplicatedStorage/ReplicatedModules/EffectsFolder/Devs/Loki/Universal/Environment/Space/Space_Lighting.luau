  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LightingManager = require(ReplicatedStorage.ReplicatedModules.Independent.LightingManager);
local _ = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 22
    -- upvalues: LightingManager (copy), EffectsHandler (copy), Lighting (copy), TweenService (copy)
    local v2 = p1 == nil and {} or p1;
    local OriginalLighting = LightingManager.OriginalLighting;
    local v3 = v2 and "{\"Lighting\":{\"ExposureCompensation\":0,\"ColorShift_Bottom\":\"c3:0.000,0.000,0.000\",\"FogColor\":\"c3:0.753,0.753,0.753\",\"FogEnd\":100000,\"EnvironmentDiffuseScale\":1,\"EnvironmentSpecularScale\":1,\"GlobalShadows\":true,\"GeographicLatitude\":0,\"Ambient\":\"c3:0.275,0.275,0.275\",\"OutdoorAmbient\":\"c3:0.275,0.275,0.275\",\"ColorShift_Top\":\"c3:0.000,0.000,0.000\",\"Brightness\":3,\"ShadowSoftness\":0.20000000298023225,\"FogStart\":0},\"Objects\":[{\"Enabled\":true,\"Name\":\"SunRays\",\"ClassName\":\"SunRaysEffect\",\"Spread\":0.10000000149011612,\"Intensity\":0.009999999776482582},{\"Offset\":0.25,\"Density\":0.30000001192092898,\"Name\":\"SpaceAtmosphere\",\"ClassName\":\"Atmosphere\",\"Color\":\"c3:0.780,0.780,0.780\",\"Decay\":\"c3:0.416,0.439,0.490\",\"Glare\":0,\"Haze\":0},{\"Enabled\":true,\"Name\":\"Bloom\",\"ClassName\":\"BloomEffect\",\"Threshold\":2,\"Intensity\":1,\"Size\":24},{\"Enabled\":false,\"FarIntensity\":0.10000000149011612,\"Name\":\"DepthOfField\",\"ClassName\":\"DepthOfFieldEffect\",\"InFocusRadius\":30,\"FocusDistance\":0.05000000074505806,\"NearIntensity\":0.75},{\"StarCount\":3000,\"SkyboxUp\":\"rbxassetid://15753304473\",\"MoonTextureId\":\"rbxasset://sky/moon.jpg\",\"SkyboxFt\":\"rbxassetid://15753305823\",\"SkyboxDn\":\"rbxassetid://15753362674\",\"CelestialBodiesShown\":true,\"ClassName\":\"Sky\",\"Name\":\"SpaceSky\",\"SunTextureId\":\"rbxasset://sky/sun.jpg\",\"SunAngularSize\":0,\"SkyboxLf\":\"rbxassetid://15753310707\",\"SkyboxRt\":\"rbxassetid://15753304774\",\"SkyboxBk\":\"rbxassetid://15753305495\"}]}" or LightingManager.OriginalLighting;
    local v4 = (type(v2) ~= "table" or v2.FireSpaceEnvironment == nil) and true or v2.FireSpaceEnvironment;

    if not v2 then
        EffectsHandler.CallEffect("Space_Environment", false, {});
        LightingManager:Set(v3, nil, {});

        if Lighting:FindFirstChild("DefaultBloom") then
            Lighting:FindFirstChild("DefaultBloom").Enabled = true;
        end;

        if Lighting:FindFirstChild("DefaultSunRays") then
            Lighting:FindFirstChild("DefaultSunRays").Enabled = true;
        end;

        if workspace.Terrain:FindFirstChildOfClass("Clouds") then
            workspace.Terrain:FindFirstChildOfClass("Clouds").Enabled = true;
        end;

        return;
    end;

    if v4 then
        EffectsHandler.CallEffect("Space_Environment", true, {});
    end;

    local v5 = v2.EasingTime or nil;
    local v6 = v2.EasingStyle or "Linear";
    local v7 = v2.EasingDirection or "Out";
    local v8 = {};
    local v9 = 0;
    local v10 = true;

    if Lighting:FindFirstChild("DefaultBloom") then
        Lighting:FindFirstChild("DefaultBloom").Enabled = false;
    end;

    if Lighting:FindFirstChild("DefaultSunRays") then
        Lighting:FindFirstChild("DefaultSunRays").Enabled = false;
    end;

    if workspace.Terrain:FindFirstChildOfClass("Clouds") then
        workspace.Terrain:FindFirstChildOfClass("Clouds").Enabled = false;
    end;

    if v5 and v5 > 0 then
        LightingManager:Set(OriginalLighting, nil, v8);

        while v10 do
            v9 = v9 + task.wait();
            local v11 = TweenService:GetValue(math.clamp(v9 / v5, 0, 1), v6, v7);

            if v11 >= 1 then
                LightingManager:Set(v3, nil, v8);
                v10 = false;
            else
                LightingManager:Transition(OriginalLighting, v3, v11, v8);
            end;
        end;
    else
        LightingManager:Set(v3, nil, v8);
    end;
end;