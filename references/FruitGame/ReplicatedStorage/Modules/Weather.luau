 

local v1 = {}
require(game.ReplicatedStorage.Modules.Rain)
_G.getEffect("StormLightning")
local function u6(p2, p3) --[[ Line: 6 ]]
    if not p3:IsA("Atmosphere") then
        local v4
        if p3:IsA("BlurEffect") then
            v4 = {
                ["Size"] = p3.Size
            }
        elseif p3:IsA("DepthOfFieldEffect") then
            v4 = {
                ["FarIntensity"] = p3.FarIntensity,
                ["FocusDistance"] = p3.FocusDistance,
                ["InFocusRadius"] = p3.InFocusRadius,
                ["NearIntensity"] = p3.NearIntensity
            }
        else
            v4 = {
                ["Brightness"] = p3.Brightness,
                ["Contrast"] = p3.Contrast,
                ["Saturation"] = p3.Saturation,
                ["TintColor"] = p3.TintColor
            }
        end
        local v5 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(p2, v5, v4):Play()
    end
end
local function u10(p7) --[[ Line: 32 ]]
    local v8 = p7:GetChildren()
    for v9 = 1, #v8 do
        if v8[v9]:IsA("ParticleEmitter") then
            v8[v9].Enabled = false
        end
    end
end
local function u17(p11) --[[ Line: 41 ]]
    if p11 ~= nil then
        local v12 = p11:GetChildren()
        local v13 = {}
        for v14 = 1, #v12 do
            local v15 = v12[v14]
            if game.Lighting[v15.Name] then
                v13[v15.Name] = v15.Value
            end
        end
        local v16 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(game.Lighting, v16, v13):Play()
    end
end
function v1.set(_, u18, p19) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
        [3] = u17
    --]]
    if script:FindFirstChild(u18) ~= nil then
        local v20 = script:GetChildren()
        for v21 = 1, #v20 do
            if v20[v21].Name ~= u18 and (v20[v21]:FindFirstChild("sfx") and v20[v21].sfx.IsPlaying == true) then
                v20[v21].sfx:Stop()
            end
        end
        local v22 = script[u18]:GetChildren()
        for v23 = 1, #v22 do
            if game.Lighting:FindFirstChild(v22[v23].Name) then
                u6(game.Lighting:FindFirstChild(v22[v23].Name), v22[v23])
            end
        end
        if script[u18]:FindFirstChild("WeatherFollow") ~= nil then
            script[u18]:FindFirstChild("WeatherFollow"):Clone().Parent = workspace.Effects
        end
        if script[u18]:FindFirstChild("WeatherFollow") == nil and workspace.Effects:FindFirstChild("WeatherFollow") then
            local v24 = workspace.Effects:FindFirstChild("WeatherFollow")
            _G.destroy(v24, 5)
            u10(v24)
            v24.Name = "weatherfollowdisabled"
        end
        if script[u18]:FindFirstChild("sfx") and script[u18].sfx.IsPlaying == false then
            script[u18].sfx.SoundGroup = game.SoundService.Music
            script[u18].sfx:Play()
        end
        if script[u18]:FindFirstChild("LightingProps") then
            u17(script[u18]:FindFirstChild("LightingProps"))
        end
        if script[u18]:FindFirstChild("Clouds") then
            _G.tween(workspace.Terrain.Clouds, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Density"] = script[u18].Clouds.Density,
                ["Cover"] = script[u18].Clouds.Cover
            })
        end
        if script[u18]:FindFirstChild("Atmosphere") then
            _G.tween(game.Lighting.Atmosphere, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = script[u18].Atmosphere.Color,
                ["Decay"] = script[u18].Atmosphere.Decay,
                ["Glare"] = script[u18].Atmosphere.Glare,
                ["Offset"] = script[u18].Atmosphere.Offset,
                ["Density"] = script[u18].Atmosphere.Density,
                ["Haze"] = script[u18].Atmosphere.Haze
            })
        end
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        p19:FindFirstChild("Mesh")
        if u18 == "Cupid2026" then
            game.Lighting.DepthOfFieldF.Enabled = true
        end
        task.spawn(function() --[[ Line: 127 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            local v25 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting.DepthOfFieldF, v25, {
                ["FocusDistance"] = 200
            })
            local v26 = {
                ["FocusDistance"] = script[u18].DepthOfFieldF.FocusDistance
            }
            local v27 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting.DepthOfFieldF, v27, v26)
            local v28 = {
                ["FogStart"] = script[u18].LightingProps.FogStart.Value + 50
            }
            local v29 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting, v29, v28)
            local v30 = {
                ["FogStart"] = script[u18].LightingProps.FogStart.Value
            }
            local v31 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting, v31, v30)
            local v32 = script[u18].ColorCorrectionF.Brightness
            if v32 < -0.001 then
                v32 = v32 + 0.2
            end
            if script[u18].ColorCorrectionF.Brightness < v32 then
                v32 = script[u18].ColorCorrectionF.Brightness
            end
            local v33 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, v33, {
                ["Brightness"] = v32
            })
            local v34 = {
                ["Brightness"] = script[u18].ColorCorrectionF.Brightness
            }
            local v35 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, v35, v34):Play()
            tick()
        end)
        _G.currentweather = u18
        _G.weatherfolder = script[u18]
    end
end
return v1