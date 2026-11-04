 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);

local function is_weather() -- Line: 30
    -- upvalues: Players (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if not (setting and (setting:FindFirstChild("weather") and not setting.weather.Value)) then
        return true;
    end;
end;

function v1.rain_weather(p2) -- Line: 41
    -- upvalues: Players (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), TweenService (copy), Lighting (copy), RunService (copy), workspace_CurrentCamera (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("weather") and not setting.weather.Value) then
        return;
    end;

    local v3 = {};

    for _, child in ipairs(ReplicatedStorage.Resources.weather.rain:GetChildren()) do
        if not child:IsA("Part") then
            if child:IsA("Sound") then
                local v4 = soundUtil:play(ReplicatedStorage.Resources.weather.rain.atmosphereSoundEffect, SoundService);
                v4.Volume = 0;
                TweenService:Create(v4, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Volume = 0.5
                }):Play();
                table.insert(v3, v4);
            else
                local v5;
                local v6 = 0;

                while true do
                    if v6 == 0 then
                        v6 = -1;
                        v5 = child:Clone();
                        v5.Name = `RAIN - {v5.Name}`;
                        v5.Parent = v5:IsA("Model") and workspace.Terrain or Lighting;

                        if v5:IsA("Model") then
                            v6 = 1;
                            continue;
                        end;

                        if v5:IsA("BloomEffect") then
                            local Threshold = v5.Threshold;
                            v5.Threshold = 10;
                            TweenService:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Threshold = Threshold
                            }):Play();
                            v6 = 2;
                            continue;
                        end;

                        if v5:IsA("ColorCorrectionEffect") then
                            local Brightness = v5.Brightness;
                            local Contrast = v5.Contrast;
                            local Saturation = v5.Saturation;
                            local TintColor = v5.TintColor;
                            v5.Brightness = 0;
                            v5.Contrast = 0;
                            v5.Saturation = 0;
                            v5.TintColor = Color3.fromRGB(255, 255, 255);
                            TweenService:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Brightness = Brightness,
                                Contrast = Contrast,
                                Saturation = Saturation,
                                TintColor = TintColor
                            }):Play();
                            v6 = 2;
                            continue;
                        end;

                        if v5:IsA("DepthOfFieldEffect") then
                            local FarIntensity = v5.FarIntensity;
                            v5.FarIntensity = 0;
                            TweenService:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                FarIntensity = FarIntensity
                            }):Play();
                            v6 = 2;
                            continue;
                        end;

                        if v5:IsA("Atmosphere") then
                            local Density = v5.Density;
                            local Offset = v5.Offset;
                            local Color = v5.Color;
                            local Decay = v5.Decay;
                            local Glare = v5.Glare;
                            local Haze = v5.Haze;
                            v5.Density = Lighting.Atmosphere.Density;
                            v5.Offset = Lighting.Atmosphere.Offset;
                            v5.Color = Lighting.Atmosphere.Color;
                            v5.Decay = Lighting.Atmosphere.Decay;
                            v5.Glare = Lighting.Atmosphere.Glare;
                            v5.Haze = Lighting.Atmosphere.Haze;
                            TweenService:Create(v5, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Density = Density,
                                Offset = Offset,
                                Color = Color,
                                Decay = Decay,
                                Glare = Glare,
                                Haze = Haze
                            }):Play();
                            v6 = 2;
                            continue;
                        end;

                        if not v5:IsA("BlurEffect") then
                            v6 = 2;
                            continue;
                        end;

                        v5:Destroy();
                        v6 = 3;
                        continue;
                    elseif v6 == 1 then
                        v6 = -1;

                        for _, descendant in ipairs(v5:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0;
                                    TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                        TimeScale = 1
                                    }):Play();
                                end;

                                descendant.Enabled = true;
                            end;
                        end;

                        v6 = 2;
                        continue;
                    elseif v6 == 2 then
                        v6 = -1;
                        table.insert(v3, v5);
                        v6 = 3;
                        continue;
                    elseif v6 == 3 then
                        v6 = -1;
                        break;
                    else
                        break;
                    end;
                end;
            end;
        end;
    end;

    local u7 = ReplicatedStorage.Resources.weather.rain["RAIN ( cam )"]:Clone();
    u7.Parent = workspace.Terrain;
    local u8 = nil;
    u8 = RunService.PreRender:connect(function() -- Line: 155
        -- upvalues: u7 (copy), u8 (ref), workspace_CurrentCamera (ref)
        if not u7:IsDescendantOf(game) then
            u8:Disconnect();
        end;

        u7.Position = workspace_CurrentCamera.CFrame.Position;
    end);
    table.insert(v3, u7);

    while p2 > 0 do
        p2 = p2 - task.wait(1);
        local setting2 = Players.LocalPlayer:FindFirstChild("setting");

        if setting2 and (setting2:FindFirstChild("weather") and not setting2.weather.Value) then
            break;
        end;
    end;

    for _, v in v3 do
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") then
            v:Destroy();
        else
            local v9;

            if v:IsA("ColorCorrectionEffect") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                v9 = v;
            elseif v:IsA("DepthOfFieldEffect") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    FarIntensity = 0
                }):Play();
                v9 = v;
            elseif v:IsA("Atmosphere") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Density = Lighting.Atmosphere.Density,
                    Offset = Lighting.Atmosphere.Offset,
                    Color = Lighting.Atmosphere.Color,
                    Decay = Lighting.Atmosphere.Decay,
                    Glare = Lighting.Atmosphere.Glare,
                    Haze = Lighting.Atmosphere.Haze
                }):Play();
                v9 = v;
            elseif v:IsA("Model") then
                v9 = v;

                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            elseif v:IsA("Part") then
                v9 = v;

                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            elseif v:IsA("Sound") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Volume = 0
                }):Play();
                v9 = v;
            else
                v9 = v;
            end;

            task.delay(3, v9.Destroy, v9);
        end;
    end;
end;

function v1.snow_weather(p10) -- Line: 235
    -- upvalues: Players (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), TweenService (copy), Lighting (copy), RunService (copy), workspace_CurrentCamera (copy)
    local setting = Players.LocalPlayer:FindFirstChild("setting");

    if setting and (setting:FindFirstChild("weather") and not setting.weather.Value) then
        return;
    end;

    local v11 = {};

    for _, child in ipairs(ReplicatedStorage.Resources.weather.snow:GetChildren()) do
        if not child:IsA("Part") then
            if child:IsA("Sound") then
                local v12 = soundUtil:play(ReplicatedStorage.Resources.weather.snow.atmosphereSoundEffect, SoundService);
                v12.Volume = 0;
                TweenService:Create(v12, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Volume = 0.5
                }):Play();
                table.insert(v11, v12);
            else
                local v13;
                local v14 = 0;

                while true do
                    if v14 == 0 then
                        v14 = -1;
                        v13 = child:Clone();
                        v13.Name = `RAIN - {v13.Name}`;
                        v13.Parent = v13:IsA("Model") and workspace.Terrain or Lighting;

                        if v13:IsA("Model") then
                            v14 = 1;
                            continue;
                        end;

                        if v13:IsA("BloomEffect") then
                            local Threshold = v13.Threshold;
                            v13.Threshold = 10;
                            TweenService:Create(v13, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Threshold = Threshold
                            }):Play();
                            v14 = 2;
                            continue;
                        end;

                        if v13:IsA("ColorCorrectionEffect") then
                            local Brightness = v13.Brightness;
                            local Contrast = v13.Contrast;
                            local Saturation = v13.Saturation;
                            local TintColor = v13.TintColor;
                            v13.Brightness = 0;
                            v13.Contrast = 0;
                            v13.Saturation = 0;
                            v13.TintColor = Color3.fromRGB(255, 255, 255);
                            TweenService:Create(v13, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Brightness = Brightness,
                                Contrast = Contrast,
                                Saturation = Saturation,
                                TintColor = TintColor
                            }):Play();
                            v14 = 2;
                            continue;
                        end;

                        if v13:IsA("DepthOfFieldEffect") then
                            local FarIntensity = v13.FarIntensity;
                            v13.FarIntensity = 0;
                            TweenService:Create(v13, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                FarIntensity = FarIntensity
                            }):Play();
                            v14 = 2;
                            continue;
                        end;

                        if v13:IsA("Atmosphere") then
                            local Density = v13.Density;
                            local Offset = v13.Offset;
                            local Color = v13.Color;
                            local Decay = v13.Decay;
                            local Glare = v13.Glare;
                            local Haze = v13.Haze;
                            v13.Density = Lighting.Atmosphere.Density;
                            v13.Offset = Lighting.Atmosphere.Offset;
                            v13.Color = Lighting.Atmosphere.Color;
                            v13.Decay = Lighting.Atmosphere.Decay;
                            v13.Glare = Lighting.Atmosphere.Glare;
                            v13.Haze = Lighting.Atmosphere.Haze;
                            TweenService:Create(v13, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                Density = Density,
                                Offset = Offset,
                                Color = Color,
                                Decay = Decay,
                                Glare = Glare,
                                Haze = Haze
                            }):Play();
                            v14 = 2;
                            continue;
                        end;

                        if not v13:IsA("BlurEffect") then
                            v14 = 2;
                            continue;
                        end;

                        v13:Destroy();
                        v14 = 3;
                        continue;
                    elseif v14 == 1 then
                        v14 = -1;

                        for _, descendant in ipairs(v13:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                                if descendant:IsA("ParticleEmitter") then
                                    descendant.TimeScale = 0;
                                    TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                                        TimeScale = 1
                                    }):Play();
                                end;

                                descendant.Enabled = true;
                            end;
                        end;

                        v14 = 2;
                        continue;
                    elseif v14 == 2 then
                        v14 = -1;
                        table.insert(v11, v13);
                        v14 = 3;
                        continue;
                    elseif v14 == 3 then
                        v14 = -1;
                        break;
                    else
                        break;
                    end;
                end;
            end;
        end;
    end;

    local u15 = ReplicatedStorage.Resources.weather.snow["RAIN ( cam )"]:Clone();
    u15.Parent = workspace.Terrain;
    local u16 = nil;
    u16 = RunService.PreRender:connect(function() -- Line: 351
        -- upvalues: u15 (copy), u16 (ref), workspace_CurrentCamera (ref)
        if not u15:IsDescendantOf(game) then
            u16:Disconnect();
        end;

        u15.Position = workspace_CurrentCamera.CFrame.Position;
    end);
    table.insert(v11, u15);

    while p10 > 0 do
        p10 = p10 - task.wait(1);
        local setting2 = Players.LocalPlayer:FindFirstChild("setting");

        if setting2 and (setting2:FindFirstChild("weather") and not setting2.weather.Value) then
            break;
        end;
    end;

    for _, v in v11 do
        if v:IsA("BloomEffect") or v:IsA("BlurEffect") then
            v:Destroy();
        else
            local v17;

            if v:IsA("ColorCorrectionEffect") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                v17 = v;
            elseif v:IsA("DepthOfFieldEffect") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    FarIntensity = 0
                }):Play();
                v17 = v;
            elseif v:IsA("Atmosphere") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Density = Lighting.Atmosphere.Density,
                    Offset = Lighting.Atmosphere.Offset,
                    Color = Lighting.Atmosphere.Color,
                    Decay = Lighting.Atmosphere.Decay,
                    Glare = Lighting.Atmosphere.Glare,
                    Haze = Lighting.Atmosphere.Haze
                }):Play();
                v17 = v;
            elseif v:IsA("Model") then
                v17 = v;

                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            elseif v:IsA("Part") then
                v17 = v;

                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            elseif v:IsA("Sound") then
                TweenService:Create(v, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                    Volume = 0
                }):Play();
                v17 = v;
            else
                v17 = v;
            end;

            task.delay(3, v17.Destroy, v17);
        end;
    end;
end;

return v1;