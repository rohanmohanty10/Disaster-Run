  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local LightingManager = require(ReplicatedStorage.ReplicatedModules.Independent.LightingManager);
local _ = Players.LocalPlayer;
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 21
    -- upvalues: LightingManager (copy), EffectsHandler (copy), Lighting (copy), TweenService (copy)
    local v2 = p1 == nil and {} or p1;
    local OriginalLighting = LightingManager.OriginalLighting;
    local v3 = v2 and "{\"Lighting\":{\"ExposureCompensation\":0,\"ColorShift_Bottom\":\"c3:0.000,0.000,0.000\",\"FogColor\":\"c3:0.753,0.753,0.753\",\"FogEnd\":100000,\"EnvironmentDiffuseScale\":1,\"EnvironmentSpecularScale\":1,\"GlobalShadows\":true,\"GeographicLatitude\":0,\"Ambient\":\"c3:0.275,0.275,0.275\",\"OutdoorAmbient\":\"c3:0.275,0.275,0.275\",\"ColorShift_Top\":\"c3:0.000,0.000,0.000\",\"Brightness\":3,\"ShadowSoftness\":0.20000000298023225,\"FogStart\":0},\"Objects\":[{\"StarCount\":3000,\"SkyboxUp\":\"rbxassetid://6412503613\",\"MoonTextureId\":\"rbxassetid://6444320592\",\"SkyboxFt\":\"rbxassetid://6444884337\",\"SkyboxDn\":\"rbxassetid://6444884785\",\"CelestialBodiesShown\":true,\"ClassName\":\"Sky\",\"Name\":\"Sky\",\"SunTextureId\":\"rbxassetid://6196665106\",\"SunAngularSize\":11,\"SkyboxLf\":\"rbxassetid://6444884337\",\"SkyboxRt\":\"rbxassetid://6444884337\",\"SkyboxBk\":\"rbxassetid://6444884337\"},{\"Enabled\":true,\"Name\":\"SunRays\",\"ClassName\":\"SunRaysEffect\",\"Spread\":0.10000000149011612,\"Intensity\":0.009999999776482582},{\"Offset\":0.25,\"Density\":0.30000001192092898,\"Name\":\"Atmosphere\",\"ClassName\":\"Atmosphere\",\"Color\":\"c3:0.780,0.780,0.780\",\"Decay\":\"c3:0.416,0.439,0.490\",\"Glare\":0,\"Haze\":0},{\"Enabled\":true,\"Name\":\"Bloom\",\"ClassName\":\"BloomEffect\",\"Threshold\":2,\"Intensity\":1,\"Size\":24},{\"Enabled\":false,\"FarIntensity\":0.10000000149011612,\"Name\":\"DepthOfField\",\"ClassName\":\"DepthOfFieldEffect\",\"InFocusRadius\":30,\"FocusDistance\":0.05000000074505806,\"NearIntensity\":0.75}]}" or LightingManager.OriginalLighting;

    if not v2 then
        EffectsHandler.CallEffect("Lab_Environment", false, {});
        LightingManager:Set(v3, nil, {});

        if Lighting:FindFirstChild("DefaultBloom") then
            Lighting:FindFirstChild("DefaultBloom").Enabled = true;
        end;

        return;
    end;

    EffectsHandler.CallEffect("Lab_Environment", true, {});
    local v4 = v2.EasingTime or nil;
    local v5 = v2.EasingStyle or "Linear";
    local v6 = v2.EasingDirection or "Out";
    local v7 = {};
    local v8 = 0;
    local v9 = true;

    if v4 and v4 > 0 then
        LightingManager:Set(OriginalLighting, nil, v7);

        if Lighting:FindFirstChild("DefaultBloom") then
            Lighting:FindFirstChild("DefaultBloom").Enabled = false;
        end;

        while v9 do
            v8 = v8 + task.wait();
            local v10 = TweenService:GetValue(math.clamp(v8 / v4, 0, 1), v5, v6);

            if v10 >= 1 then
                LightingManager:Set(v3, nil, v7);
                v9 = false;
            else
                LightingManager:Transition(OriginalLighting, v3, v10, v7);
            end;
        end;
    else
        LightingManager:Set(v3, nil, v7);
    end;
end;