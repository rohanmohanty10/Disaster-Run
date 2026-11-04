 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
v1:FindFirstChildOfClass("Humanoid");
v1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local v2 = Knit.CreateController({
    Name = script.Name
});

function v2.ResetLighting(p3, p4) -- Line: 22
    p3:SetLighting(p3.Presets.Default, p4);
end;

function v2.Atmosphere(u5, u6, u7) -- Line: 26
    -- upvalues: Lighting (copy), RunService (copy)
    if not u6 then
        return;
    end;

    if u7 == 0 then
        for i, v in u6 do
            Lighting.Atmosphere[i] = v;
        end;

        return;
    end;

    local u8 = nil;
    local u9 = {
        Density = Lighting.Atmosphere.Density,
        Offset = Lighting.Atmosphere.Offset,
        Color = Lighting.Atmosphere.Color,
        Decay = Lighting.Atmosphere.Decay,
        Glare = Lighting.Atmosphere.Glare,
        Haze = Lighting.Atmosphere.Haze
    };
    local u10 = tick();
    local _ = u10 + u7;
    u8 = RunService.RenderStepped:Connect(function() -- Line: 49
        -- upvalues: u10 (copy), u7 (copy), u6 (copy), u9 (copy), Lighting (ref), u5 (copy), u8 (ref)
        local v11 = (tick() - u10) / u7;
        local math_min_ret = math.min(v11, 1);

        for i, v in u6 do
            if typeof(v) == "Color3" then
                local Color3_fromRGB_ret = Color3.fromRGB((u9[i].R + (v.R - u9[i].R) * math_min_ret) * 255, (u9[i].G + (v.G - u9[i].G) * math_min_ret) * 255, (u9[i].B + (v.B - u9[i].B) * math_min_ret) * 255);
                Lighting.Atmosphere[i] = Color3_fromRGB_ret;
            else
                Lighting.Atmosphere[i] = u9[i] + (v - u9[i]) * math_min_ret;
            end;
        end;

        if math_min_ret ~= 1 then
            return;
        end;

        table.remove(u5.LightingTweens, table.find(u5.LightingTweens, u8));
        u8:Disconnect();
    end);
    table.insert(u5.LightingTweens, u8);
end;

function v2.SetLighting(p12, p13, p14) -- Line: 73
    -- upvalues: TweenService (copy), Lighting (copy)
    if typeof(p13) == "string" then
        p13 = p12.Presets[p13] or p13;
    end;

    local v15 = p14 or 0;

    for _, v in p12.LightingTweens do
        if typeof(v) == "Instance" then
            v:Cancel();
        elseif typeof(v) == "RBXScriptConnection" then
            v:Disconnect();
        end;
    end;

    table.clear(p12.LightingTweens);

    if p13.Lighting then
        local v16 = TweenService:Create(Lighting, TweenInfo.new(v15), p13.Lighting);
        v16:Play();
        table.insert(p12.LightingTweens, v16);
    end;

    for _, child in Lighting:GetChildren() do
        if p13[child.Name] then
            if child.Name == "Atmosphere" then
                p12:Atmosphere(p13.Atmosphere, v15);
            else
                local v17 = TweenService:Create(child, TweenInfo.new(v15), p13[child.Name]);
                v17:Play();
                table.insert(p12.LightingTweens, v17);
            end;
        end;
    end;
end;

function v2.KnitStart(u18) -- Line: 115
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), LocalPlayer (copy)
    u18.LightingTweens = {};
    u18.Presets = require(script.LobbyPreset);

    local function spawnSkybox(p19, p20) -- Line: 119
        -- upvalues: u18 (copy), Lighting (ref)
        if workspace:FindFirstChild("CrowdVFX") then
            workspace:FindFirstChild("CrowdVFX"):Destroy();
        end;

        u18.Presets = require(p19);

        if game.Lighting:FindFirstChildWhichIsA("Sky") then
            game.Lighting:FindFirstChildWhichIsA("Sky"):Destroy();
        end;

        p20:Clone().Parent = Lighting;
    end;

    ReplicatedStorage.Remotes.Lighting.OnClientEvent:Connect(function(p21, p22) -- Line: 129
        -- upvalues: u18 (copy)
        u18:SetLighting(p21, p22);
    end);

    local function updateLighting() -- Line: 133
        -- upvalues: LocalPlayer (ref), u18 (copy), Lighting (ref), spawnSkybox (copy)
        if workspace:GetAttribute("LowQualityMap") then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor and not LocalPlayer.PlayerGui.Spectate.Enabled then
            u18.Presets = require(script.LobbyPreset);

            if game.Lighting:FindFirstAncestorWhichIsA("Sky") then
                game.Lighting:FindFirstAncestorWhichIsA("Sky"):Destroy();
                script.StylizedSky:Clone().Parent = Lighting;
            end;
        else
            local MapFolder = workspace:WaitForChild("MapFolder", 5);

            if MapFolder:GetAttribute("MapIndex") == 1 then
                spawnSkybox(script.Presets, script.StylizedSky);
            elseif MapFolder:GetAttribute("MapIndex") == 2 then
                spawnSkybox(script.StadiumPresets, script.StylizedSky);
            elseif MapFolder:GetAttribute("MapIndex") == 3 then
                spawnSkybox(script.Presets, script.StylizedSky);
            elseif MapFolder:GetAttribute("MapIndex") == 4 then
                spawnSkybox(script.SunPreset, script.Sunset);
            elseif MapFolder:GetAttribute("MapIndex") == 5 then
                spawnSkybox(script.JapanPreset, script.Anime);
            elseif MapFolder:GetAttribute("MapIndex") == 6 then
                spawnSkybox(script.CyberPreset, script.Cyber);
            elseif MapFolder:GetAttribute("MapIndex") == 7 then
                spawnSkybox(script.GymnasiumPreset, script.Gymnasium);
            elseif MapFolder:GetAttribute("MapIndex") == 8 then
                spawnSkybox(script.GaragePresets, script.Anime);
            elseif MapFolder:GetAttribute("MapIndex") == 9 then
                spawnSkybox(script.TheBlockPresets, script.Anime);
            elseif MapFolder:GetAttribute("MapIndex") == 10 then
                spawnSkybox(script.CruisePresets, script.Anime);
            elseif MapFolder:GetAttribute("MapIndex") == 11 then
                spawnSkybox(script.RooftopPresets, script.Forest);
            elseif MapFolder:GetAttribute("MapIndex") == 12 then
                spawnSkybox(script.SchoolPresets, script.Forest);
            elseif MapFolder:GetAttribute("MapIndex") == 13 then
                spawnSkybox(script.HauntedWoodPreset, script.HauntedWood);
            end;
        end;

        u18:ResetLighting();
    end;

    local InLoadingScreen = game:GetService("ReplicatedFirst"):WaitForChild("InLoadingScreen");

    while InLoadingScreen.Value == true do
        InLoadingScreen.Changed:Wait();
    end;

    LocalPlayer:GetPropertyChangedSignal("Team"):Connect(updateLighting);
    LocalPlayer.PlayerGui.Spectate:GetPropertyChangedSignal("Enabled"):Connect(updateLighting);
    workspace.ChildAdded:Connect(function(p23) -- Line: 200
        -- upvalues: updateLighting (copy)
        if p23.Name == "MapFolder" then
            updateLighting();
        end;
    end);
    updateLighting();
    workspace:GetAttributeChangedSignal("LowQualityMap"):Connect(function() -- Line: 207
        -- upvalues: u18 (copy)
        if workspace:GetAttribute("LowQualityMap") then
            u18.Presets = require(script.Presets);
            u18:ResetLighting();
        end;
    end);
end;

return v2;