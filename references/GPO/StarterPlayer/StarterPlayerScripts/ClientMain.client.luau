 

local v1 = game:GetService("ReplicatedStorage")
_G.hitbox = require(game.ReplicatedStorage.Modules.Hitbox)
_G.check = require(game.ReplicatedStorage.Modules.HumanoidChecks)
_G.canuse = true
_G.raycast = require(game.ReplicatedStorage.Modules.Raycast)
_G.music2 = true
local v2 = require(game.ReplicatedStorage.Modules:WaitForChild("Warp"))
local u3 = require(game.ReplicatedStorage.Modules.Shared.Signals.GoodSignal)
local u4 = require(v1.Modules.ZiliEmitModule)
local u5 = require(v1.Modules.ForgeVFX)
local v6 = v2.Client("PlayEffect")
local v7 = game.ReplicatedStorage.Events.ClientEffect
local v8 = game:GetService("ContentProvider")
local _ = script
local u9 = game.Players.LocalPlayer
u9:SetAttribute("banned", true)
task.spawn(function() --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    u4.init()
end)
task.spawn(function() --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    u5.init()
end)
task.spawn(function() --[[ Line: 38 ]]
    require(game:GetService("ReplicatedStorage"):WaitForChild("Modules").swoopz)
end)
_G.windowFocus = false
_G.mobile = false
if game:GetService("UserInputService").TouchEnabled then
    _G.mobile = true
end
function game.ReplicatedStorage.Events.pingClient.OnClientInvoke() --[[ Line: 47 ]]
    return true
end
repeat
    game["Run Service"].Heartbeat:Wait()
until game.Players.LocalPlayer
local u10 = game:GetService("UserInputService")
u10.WindowFocused:Connect(function() --[[ Line: 56 ]]
    _G.windowFocus = true
end)
u10.WindowFocusReleased:Connect(function() --[[ Line: 60 ]]
    _G.windowFocus = false
end)
game.ReplicatedStorage.Events.Tween.OnClientEvent:Connect(function(_, p11, p12, p13, p14) --[[ Line: 66 ]]
    if p11 then
        if p11:IsA("ObjectValue") then
            if p11.Value == nil then
                p11.Changed:Wait()
                if p11.Value == nil then
                    return
                end
                p11 = p11.Value
            else
                p11 = p11.Value
            end
        end
        if _G.tween == nil then
            repeat
                task.wait()
            until _G.tween ~= nil
        end
        _G.tween(p11, p12, p13, nil, p14)
    end
end)
function _G.ScaleWithHP(p15) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v16 = u9.Character
    return p15 * (v16.Humanoid.Health / v16.Humanoid.MaxHealth)
end
local u17 = require(game.ReplicatedStorage.Modules.BoatTween)
local u18 = {}
function _G.tween(u19, p20, u21, p22, p23) --[[ Line: 104 ]]
    --[[
    Upvalues:
        [1] = u18
        [2] = u17
    --]]
    if p23 ~= nil and u18[u19] then
        local v24 = u18[u19][1]
        local _ = u18[u19][2]
        v24:Stop()
        v24:Destroy()
        u18[u19] = nil
    end
    if u19 and (u19 ~= nil and (u19.Parent ~= nil and not u19:IsA("BasePart"))) then
        u19.Parent:IsA("BasePart")
    end
    pcall(function() --[[ Line: 137 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u19
            [3] = u21
        --]]
        if u18[u19] then
            local v25 = u18[u19][1]
            local v26 = u18[u19][2]
            local v27 = false
            for v28, _ in u21 do
                if v26[v28] then
                    v27 = true
                end
            end
            if v27 == true then
                v25:Stop()
                v25:Destroy()
                u18[u19] = nil
            end
        end
    end)
    local v29 = p20[2]
    local v30 = p20[2]
    if typeof(v30) ~= "string" then
        local v31 = p20[2]
        local v32 = tostring(v31)
        v29 = string.gsub(v32, "Enum.EasingStyle.", "")
    end
    local v33 = p20[3]
    local v34 = tostring(v33)
    local v35 = string.gsub(v34, "Enum.EasingDirection.", "")
    local _ = _G.fastmode == true
    local v36 = "Heartbeat"
    local u37 = u17:Create(u19, {
        ["Time"] = p20[1],
        ["EasingStyle"] = v29,
        ["EasingDirection"] = v35,
        ["Reverses"] = p20[5],
        ["DelayTime"] = p20[6],
        ["RepeatCount"] = p20[4],
        ["StepType"] = p22 or v36,
        ["CustomEventStepFreq"] = u21.CustomEventStepFreq or nil,
        ["Goal"] = u21
    })
    u18[u19] = { u37, u21 }
    u37:Play()
    local u38 = nil
    if u37 == nil or u37.Completed == nil then
        u18[u19] = nil
    else
        local u39 = u37.Completed:Connect(function() --[[ Line: 194 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u37
                [3] = u18
                [4] = u19
                [5] = u21
            --]]
            u38:Disconnect()
            u38 = nil
            pcall(function() --[[ Line: 197 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                u37:Destroy()
            end)
            u18[u19] = nil
            table.clear(u21)
        end)
        u19.Destroying:Once(function() --[[ Line: 204 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u37
                [3] = u18
                [4] = u19
                [5] = u21
            --]]
            if u39 then
                u39:Disconnect()
                u39 = nil
            end
            pcall(function() --[[ Line: 210 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                u37:Destroy()
            end)
            u18[u19] = nil
            table.clear(u21)
        end)
    end
    return u37
end
local u40 = require(game.ReplicatedStorage.Modules.StreamingObjectsModule)
function _G.PlayEffect(u41, p42, ...) --[[ Line: 228 ]]
    if _G.checkRenderDistance == nil then
        repeat
            task.wait()
        until _G.checkRenderDistance ~= nil
    end
    if _G.getEffect == nil then
        repeat
            task.wait()
        until _G.getEffect
    end
    local u43 = _G.getEffect(u41)
    if u43 then
        local u44 = { ... }
        if p42 == "skipThread" then
            return u43:start(unpack(u44))
        end
        task.spawn(function() --[[ Line: 248 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u41
            --]]
            if u43.start then
                local v45 = u44
                u43:start(unpack(v45))
            else
                warn(u41, " has no start function!")
            end
        end)
        return true
    end
    warn("cant find effect " .. u41)
end
local function u52(p46, ...) --[[ Line: 263 ]]
    --[[
    Upvalues:
        [1] = u40
    --]]
    local u47 = false
    local function v50(p48, ...) --[[ Line: 266 ]]
        --[[
        Upvalues:
            [1] = u40
            [2] = u47
        --]]
        local v49 = u40:resolveArgs({ ... })
        if v49 == "TIMED OUT VALUE" then
            warn("Package timed out" .. p48)
            return false
        end
        u47 = _G.PlayEffect(p48, nil, unpack(v49))
    end
    local u51 = task.spawn(v50, p46, ...)
    task.delay(5, function() --[[ Line: 281 ]]
        --[[
        Upvalues:
            [1] = u47
            [2] = u51
        --]]
        if u47 == false then
            task.cancel(u51)
        end
    end)
end
local function v56(p53, p54, ...) --[[ Line: 289 ]]
    --[[
    Upvalues:
        [1] = u52
    --]]
    if p54 == nil then
        return
    else
        local v55 = workspace:GetServerTimeNow() - p54
        if math.floor(v55) >= 60 and p53 ~= "SoulProjectile" then
            warn("effect " .. p53 .. " was timed out")
        else
            u52(p53, ...)
        end
    end
end
v6:Connect(v56)
v7.OnClientEvent:Connect(v56)
game.ReplicatedStorage.Events.ClientEffectUnrealiable.OnClientEvent:Connect(v56)
local function u62(p57, p58, p59) --[[ Line: 312 ]]
    local v60
    if p59 == nil then
        if p57:IsA("BlurEffect") and p58 then
            v60 = {
                ["Size"] = p58.Size
            }
        else
            v60 = {
                ["Brightness"] = p58.Brightness,
                ["Contrast"] = p58.Contrast,
                ["Saturation"] = p58.Saturation,
                ["TintColor"] = p58.TintColor
            }
        end
    else
        v60 = {}
    end
    local v61 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
    game:GetService("TweenService"):Create(p57, v61, p59 or v60):Play()
end
game.ReplicatedStorage.Events.EffectOverlay.OnClientEvent:Connect(function(p63, p64, u65) --[[ Line: 336 ]]
    --[[
    Upvalues:
        [1] = u62
    --]]
    if p63 == "Hao" then
        local v66 = Instance.new("BlurEffect", workspace.CurrentCamera)
        local v67 = Instance.new("ColorCorrectionEffect", workspace.CurrentCamera)
        u62(v66, script.EffectOvers.Hao.Blur)
        u62(v67, script.EffectOvers.Hao.ColorCorrection)
        _G.destroy(v66, p64 + 0.25)
        _G.destroy(v67, p64 + 0.25)
        task.wait(p64)
        u62(v66, nil, {
            ["Size"] = 0
        })
        u62(v67, nil, {
            ["Brightness"] = 0,
            ["Contrast"] = 0,
            ["Saturation"] = 0,
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
        return
    elseif p63 == "HaoVictim" then
        local v68 = Instance.new("BlurEffect", workspace.CurrentCamera)
        local v69 = Instance.new("ColorCorrectionEffect", workspace.CurrentCamera)
        u62(v68, script.EffectOvers.HaoVictim.Blur)
        u62(v69, script.EffectOvers.HaoVictim.ColorCorrection)
        _G.destroy(v68, p64 + 0.25)
        _G.destroy(v69, p64 + 0.25)
        script.EffectOvers.HaoVictim.SFX:Play()
        local v70 = _G.music
        _G.music = false
        task.wait(p64)
        if v70 == true then
            _G.music = true
        end
        script.EffectOvers.HaoVictim.SFX:Stop()
        u62(v68, nil, {
            ["Size"] = 0
        })
        u62(v69, nil, {
            ["Brightness"] = 0,
            ["Contrast"] = 0,
            ["Saturation"] = 0,
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
        return
    elseif p63 == "Blinded" then
        local v71 = script.EffectOvers.Blinded.ColorCorrection:Clone()
        v71.Parent = workspace.CurrentCamera
        _G.tween(v71, {
            2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 10
        })
        task.wait(3)
        _G.destroy(v71, 2)
        _G.tween(v71, {
            2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0
        })
        return
    elseif p63 == "SonSon" then
        local v72 = script.EffectOvers.SonSon.ColorCorrection:Clone()
        v72.Parent = workspace.CurrentCamera
        _G.tween(v72, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 0, 0)
        })
        local u73 = script.EffectOvers.SonSon.ScreenGui:Clone()
        u73.Frame.Size = UDim2.new(0, 0, 0, 0)
        u73.Parent = game.Players.LocalPlayer.PlayerGui
        u73.Frame.Rotation = math.random(-360, 360)
        u73.Frame.Position = UDim2.new(math.random(100, 800) / 1000, 0, 0.5, 0)
        task.spawn(function() --[[ Line: 389 ]]
            --[[
            Upvalues:
                [1] = u73
            --]]
            task.wait(0.8)
            pcall(function() --[[ Line: 391 ]]
                _G.PlaySound(game.Players.LocalPlayer.Character.Head, script.EffectOvers.SonSon.Cut3)
            end)
            u73.Frame.Size = UDim2.new(0.15, 0, 4, 0)
            _G.tween(u73.Frame, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = UDim2.new(0.15, 0, 4, 0),
                ["SliceScale"] = -20
            })
            task.wait(0.5)
            _G.destroy(u73, 0.1)
        end)
        task.wait(1.5)
        _G.tween(v72, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
        _G.destroy(v72, 0.1)
        return
    elseif p63 == "Phoenix" then
        local u74 = script.EffectOvers.Phoenix.ScreenGui:Clone()
        u74.Frame.Size = UDim2.new(0, 0, 0, 0)
        u74.Parent = game.Players.LocalPlayer.PlayerGui
        u74.Frame.Rotation = math.random(-360, 360)
        u74.Frame.Position = UDim2.new(math.random(100, 800) / 1000, 0, 0.5, 0)
        if math.random(1, 2) == 1 then
            u74.Frame.ImageColor3 = Color3.fromRGB(255, 255, 0)
        end
        task.spawn(function() --[[ Line: 413 ]]
            --[[
            Upvalues:
                [1] = u74
            --]]
            u74.Frame.Size = UDim2.new(0.15, 0, 4, 0)
            _G.tween(u74.Frame, {
                0.5,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = UDim2.new(0.15, 0, 4, 0),
                ["SliceScale"] = -50
            })
            task.wait(0.5)
            _G.destroy(u74, 0.1)
        end)
    elseif p63 == "Rashmon" then
        local v75 = script.EffectOvers.Rashmon.ColorCorrection:Clone()
        v75.Parent = workspace.CurrentCamera
        if u65 and u65.excu then
            v75.TintColor = Color3.fromRGB(255, 0, 0)
        end
        _G.tween(v75, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Saturation"] = -1
        })
        task.spawn(function() --[[ Line: 429 ]]
            --[[
            Upvalues:
                [1] = u65
            --]]
            task.wait(0.7)
            local v76 = script.EffectOvers.Rashmon.ScreenGui:Clone()
            v76.Frame.Size = UDim2.new(0, 0, 0, 0)
            v76.Parent = game.Players.LocalPlayer.PlayerGui
            if u65 and u65.Color ~= nil then
                v76.Frame3.ImageColor3 = u65.Color
                v76.Frame4.ImageColor3 = u65.Color
            end
            if u65 and u65.excu then
                warn("exc")
                v76.excu:Play()
            end
            local v77 = v76:GetChildren()
            for v78 = 1, #v77 do
                if v77[v78]:IsA("ImageLabel") then
                    v77[v78].Size = UDim2.new(v77[v78].Size.X.Scale, 0, 4, 0)
                    _G.tween(v77[v78], {
                        0.5,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Size"] = UDim2.new(v77[v78].Size.X.Scale, 0, 4, 0),
                        ["SliceScale"] = -50
                    })
                end
            end
            _G.destroy(v76, 3)
        end)
        task.wait(1.2)
        _G.tween(v75, {
            0.1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Saturation"] = 0,
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        })
        _G.destroy(v75, 0.1)
    end
end)
game.ReplicatedStorage.Events.cam.OnClientEvent:Connect(function(p79) --[[ Line: 459 ]]
    game.Workspace.CurrentCamera.CameraSubject = p79.Humanoid
    game.Workspace.CurrentCamera.CameraType = "Custom"
end)
game.ReplicatedStorage.Events.CustomWeld.OnClientEvent:Connect(function(p80, p81, p82, p83) --[[ Line: 464 ]]
    if _G.customWeld ~= nil then
        _G.customWeld(p80, p81, p82, p83)
    end
end)
game.ReplicatedStorage.Events.ComboIndicator.OnClientEvent:Connect(function(u84) --[[ Line: 501 ]]
    pcall(function() --[[ Line: 502 ]]
        --[[
        Upvalues:
            [1] = u84
        --]]
        local v85 = game.Players.LocalPlayer
        local v86 = v85.PlayerGui:FindFirstChild("Combo")
        if v86 == nil then
            v86 = script.Combo:Clone()
            v86.Parent = v85.PlayerGui
        end
        local v87 = u84
        u84 = math.ceil(v87)
        local v88 = v86.NUMBER
        local v89 = v86.NUMBER.Text
        local v90 = tonumber(v89) + 1
        v88.Text = tostring(v90)
        local v91 = v86.TextLabel.DAMAGE
        local v92 = v86.TextLabel.DAMAGE.Text
        local v93 = tonumber(v92) + u84
        v91.Text = tostring(v93)
        local v94 = UDim2.new(0.2 - math.random(-5, 5) / 100, 0, 0.5 - math.random(-5, 5) / 100, 0)
        v86.NUMBER.Position = v94
        v86.TextLabel.Position = UDim2.new(v94.X.Scale, 0, v94.Y.Scale + 0.05, 0)
        local u95 = v86.NUMBER
        local u96 = nil
        local u97 = 0.05
        task.spawn(function() --[[ Line: 472 ]]
            --[[
            Upvalues:
                [1] = u95
                [2] = u96
                [3] = u97
            --]]
            if u95:GetAttribute("size") == nil then
                u95:SetAttribute("size", u95.Size)
            end
            if u95:GetAttribute("pos") == nil then
                u95:SetAttribute("pos", u95.Position)
            end
            local v98 = u95:GetAttribute("size")
            local v99 = u95:GetAttribute("pos")
            if u96 == nil then
                u96 = 0
            end
            if u97 == nil then
                u97 = 0
            end
            local _ = u95.TextColor3
            u95.TextColor3 = Color3.fromRGB(255, 255, 255)
            u95:TweenSizeAndPosition(UDim2.new(v98.X.Scale + u97, 0, v98.Y.Scale + u97, 0), UDim2.new(v99.X.Scale + u96, 0, v99.Y.Scale, 0), "Out", "Elastic", 0.1, true)
            task.wait(0.1)
            u95:TweenSizeAndPosition(v98, v99, "Out", "Quad", 0.1, true)
        end)
        local u100 = v86.TextLabel
        local u101 = nil
        local u102 = 0.015
        task.spawn(function() --[[ Line: 472 ]]
            --[[
            Upvalues:
                [1] = u100
                [2] = u101
                [3] = u102
            --]]
            if u100:GetAttribute("size") == nil then
                u100:SetAttribute("size", u100.Size)
            end
            if u100:GetAttribute("pos") == nil then
                u100:SetAttribute("pos", u100.Position)
            end
            local v103 = u100:GetAttribute("size")
            local v104 = u100:GetAttribute("pos")
            if u101 == nil then
                u101 = 0
            end
            if u102 == nil then
                u102 = 0
            end
            local _ = u100.TextColor3
            u100.TextColor3 = Color3.fromRGB(255, 255, 255)
            u100:TweenSizeAndPosition(UDim2.new(v103.X.Scale + u102, 0, v103.Y.Scale + u102, 0), UDim2.new(v104.X.Scale + u101, 0, v104.Y.Scale, 0), "Out", "Elastic", 0.1, true)
            task.wait(0.1)
            u100:TweenSizeAndPosition(v103, v104, "Out", "Quad", 0.1, true)
        end)
        local u105 = v86.TextLabel.DAMAGE
        local u106 = nil
        local u107 = 0.015
        task.spawn(function() --[[ Line: 472 ]]
            --[[
            Upvalues:
                [1] = u105
                [2] = u106
                [3] = u107
            --]]
            if u105:GetAttribute("size") == nil then
                u105:SetAttribute("size", u105.Size)
            end
            if u105:GetAttribute("pos") == nil then
                u105:SetAttribute("pos", u105.Position)
            end
            local v108 = u105:GetAttribute("size")
            local v109 = u105:GetAttribute("pos")
            if u106 == nil then
                u106 = 0
            end
            if u107 == nil then
                u107 = 0
            end
            local _ = u105.TextColor3
            u105.TextColor3 = Color3.fromRGB(255, 255, 255)
            u105:TweenSizeAndPosition(UDim2.new(v108.X.Scale + u107, 0, v108.Y.Scale + u107, 0), UDim2.new(v109.X.Scale + u106, 0, v109.Y.Scale, 0), "Out", "Elastic", 0.1, true)
            task.wait(0.1)
            u105:TweenSizeAndPosition(v108, v109, "Out", "Quad", 0.1, true)
        end)
        local v110 = tick()
        if v86:FindFirstChild("pretick") then
            v86.pretick.Value = v110
        end
        task.wait(2)
        if v86.pretick.Value == v110 and (v86.Parent ~= nil and tick() - v86.pretick.Value >= 2) then
            v86.Name = "gone"
            local function v112(p111) --[[ Line: 528 ]]
                _G.tween(p111, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["TextTransparency"] = 1,
                    ["TextStrokeTransparency"] = 1
                })
            end
            v112(v86.NUMBER)
            v112(v86.TextLabel.DAMAGE)
            v112(v86.TextLabel)
            _G.destroy(v86, 0.25)
        end
    end)
end)
_G.clientimpacts = {}
if _G.getEffect == nil then
    repeat
        task.wait()
    until _G.getEffect ~= nil
end
workspace:WaitForChild("Env"):WaitForChild("WaterStuff"):WaitForChild("Falls")
local v113 = game.ReplicatedStorage.ClientImpacts:GetChildren()
for v114 = 1, #v113 do
    _G.clientimpacts[v113[v114]] = require(v113[v114])
end
game.ReplicatedStorage.Events.ClientImpact.OnClientEvent:Connect(function(p115, p116, ...) --[[ Line: 550 ]]
    --[[
    Upvalues:
        [1] = u52
    --]]
    if p115 == game.Players.LocalPlayer then
        return
    elseif _G.clientimpacts[game.ReplicatedStorage.ClientImpacts:FindFirstChild(p116)] then
        local v117 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts:FindFirstChild(p116)]
        local v118 = _G.streamArgs(...)
        if v118 ~= "INVALID" then
            v117:start(unpack(v118))
        end
    else
        if _G.getEffect(p116) then
            u52(p116, ...)
        end
        return
    end
end)
local u119 = _G.getEffect("FastCast")
game.ReplicatedStorage.Events.FastCast.OnClientEvent:Connect(function(...) --[[ Line: 574 ]]
    --[[
    Upvalues:
        [1] = u119
    --]]
    u119:start(...)
end)
_G.fastmode = false
_G.omegabooster = false
game.ReplicatedStorage.Events.Rope.OnClientEvent:Connect(function(u120, u121, p122) --[[ Line: 595 ]]
    if u121 ~= nil and (not u120 or u120:IsDescendantOf(workspace) ~= false) and ((not u121 or u121:IsDescendantOf(workspace) ~= false) and (not workspace.Effects:FindFirstChild(u121.Name) and (u120 ~= nil and u121 ~= nil))) then
        local v123 = p122
        local u124 = v123 == nil and 30 or v123
        if u120 == game.Players.LocalPlayer.Character or u121 ~= game.Players.LocalPlayer.Character then
            local u125 = game.ReplicatedStorage.RopePart:Clone()
            u125.Parent = workspace.Effects
            u125.CFrame = u120.HumanoidRootPart.CFrame
            u125.Name = u121.Name
            local u126 = u125.Attachment2
            u126.Parent = u121.HumanoidRootPart
            u125.RopeConstraint.Attachment1 = u126
            u125.RopeConstraint.Attachment0 = u125.Attachment
            if p122 then
                u125.RopeConstraint.Length = p122 / 2
            end
            u125.Anchored = false
            task.spawn(function() --[[ Line: 617 ]]
                --[[
                Upvalues:
                    [1] = u121
                    [2] = u120
                    [3] = u125
                    [4] = u126
                    [5] = u124
                --]]
                local u127 = nil
                u127 = game["Run Service"].Stepped:Connect(function() --[[ Line: 619 ]]
                    --[[
                    Upvalues:
                        [1] = u121
                        [2] = u120
                        [3] = u125
                        [4] = u127
                        [5] = u126
                        [6] = u124
                    --]]
                    if u121.Parent == nil or (u120.Parent == nil or u121 and u121:FindFirstChild("Roped") == nil) then
                        if u120 == game.Players.LocalPlayer.Character then
                            game.ReplicatedStorage.Events.Rope:FireServer("snap")
                        end
                        u125:Destroy()
                        u127:disconnect()
                        u127 = nil
                    else
                        u126.WorldPosition = u121.Collar.UpperTorso.Hole.Position
                        u125.CFrame = u120.RightHand.CFrame
                        if u120:FindFirstChild("HumanoidRootPart") and (u121:FindFirstChild("HumanoidRootPart") and u124 <= (u120.HumanoidRootPart.Position - u121.HumanoidRootPart.Position).magnitude) then
                            u125:Destroy()
                            u127:disconnect()
                            u127 = nil
                            if u120 == game.Players.LocalPlayer.Character then
                                game.ReplicatedStorage.Events.Rope:FireServer("snap")
                            end
                        end
                    end
                end)
            end)
        elseif u121 == game.Players.LocalPlayer.Character then
            local u128 = game.ReplicatedStorage.RopePart:Clone()
            u128.Parent = workspace.Effects
            u128.CFrame = u120.HumanoidRootPart.CFrame
            u128.Name = u121.Name
            if p122 then
                u128.RopeConstraint.Length = p122 / 2
            end
            local u129 = u128.Attachment2
            u129.Parent = u121.HumanoidRootPart
            u128.RopeConstraint.Attachment1 = u129
            u128.RopeConstraint.Attachment0 = u128.Attachment
            u128.Anchored = true
            task.spawn(function() --[[ Line: 658 ]]
                --[[
                Upvalues:
                    [1] = u121
                    [2] = u120
                    [3] = u128
                    [4] = u129
                --]]
                local u130 = nil
                u130 = game["Run Service"].Stepped:Connect(function() --[[ Line: 660 ]]
                    --[[
                    Upvalues:
                        [1] = u121
                        [2] = u120
                        [3] = u128
                        [4] = u130
                        [5] = u129
                    --]]
                    if u121.Parent == nil or u120.Parent == nil then
                        u128:Destroy()
                        u130:disconnect()
                        u130 = nil
                        game.ReplicatedStorage.Events.Rope:FireServer("snap")
                        return
                    elseif u121:FindFirstChild("Roped") == nil then
                        u128:Destroy()
                        u130:disconnect()
                        u130 = nil
                    else
                        if u120 == nil or (u120.Parent == nil or u120:IsDescendantOf(workspace) == false) then
                            u128:Destroy()
                            u130:disconnect()
                            u130 = nil
                            game.ReplicatedStorage.Events.Rope:FireServer("snap")
                        end
                        u129.WorldPosition = u121.Collar.UpperTorso.Hole.Position
                        u128.CFrame = u120.RightHand.CFrame
                    end
                end)
            end)
        end
    end
end)
local v131 = require(game.ReplicatedStorage.Modules.CameraShaker)
task.spawn(function() --[[ Line: 718 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v132 = game.ReplicatedStorage:WaitForChild("Stats" .. u9.Name)
    _G.cameraShakeEnabled = v132:WaitForChild("Settings"):WaitForChild("CameraShake").Value
end)
_G.camShake = v131.new(Enum.RenderPriority.Camera.Value + 1, function(p133) --[[ Name: ShakeCamera, Line 710 ]]
    if _G.cameraShakeEnabled ~= false then
        local v134 = workspace.CurrentCamera
        v134.CFrame = v134.CFrame * p133
    end
end)
_G.camShake:Start()
game.ReplicatedStorage.Events.CameraShake.OnClientEvent:Connect(function(...) --[[ Line: 726 ]]
    if _G.cameraShakeEnabled ~= false then
        _G.camShake:ShakeOnce(...)
    end
end)
game.ReplicatedStorage.Events.camshake.OnClientEvent:Connect(function(p135, p136, p137) --[[ Line: 734 ]]
    if _G.camshake ~= nil then
        _G.camshake(p135, p136, p137)
    end
end)
local u138 = 0
game.ReplicatedStorage.Events.Movement.OnClientEvent:Connect(function(p139) --[[ Line: 743 ]]
    --[[
    Upvalues:
        [1] = u138
    --]]
    if p139 == false then
        u138 = u138 + 1
        if u138 == 1 then
            while true do
                local v140 = game.Players.LocalPlayer.Character
                if not v140 or v140:FindFirstChild("Humanoid") == nil then
                    break
                end
                v140.Humanoid:MoveTo(v140.HumanoidRootPart.Position)
                v140.Humanoid.Jump = false
                game["Run Service"].RenderStepped:Wait()
                if u138 <= 0 then
                    break
                end
            end
        end
    else
        u138 = u138 - 1
    end
end)
warn("Combat Tag moved, warn just incase")
game.ReplicatedStorage.Events.CombatTag.OnClientEvent:Connect(function(_) --[[ Line: 766 ]] end)
local u141 = {}
local function u147(u142, p143) --[[ Line: 779 ]]
    --[[
    Upvalues:
        [1] = u141
    --]]
    local u144 = u142.Blade:GetChildren()
    local u145 = game:GetService("HttpService"):GenerateGUID(true)
    if typeof(p143) == "number" then
        u141[u142] = u145
    end
    for u146 = 1, #u144 do
        if (u144[u146]:IsA("Trail") or u144[u146]:IsA("ParticleEmitter")) and (u144[u146].Name ~= "notTrail" and u144[u146]:GetAttribute("trailBypass") == nil) then
            if typeof(p143) == "number" then
                u144[u146].Enabled = true
                task.delay(p143, function() --[[ Line: 795 ]]
                    --[[
                    Upvalues:
                        [1] = u141
                        [2] = u142
                        [3] = u145
                        [4] = u144
                        [5] = u146
                    --]]
                    if u141[u142] == u145 then
                        u144[u146].Enabled = false
                        task.delay(3, function() --[[ Line: 798 ]]
                            --[[
                            Upvalues:
                                [1] = u141
                                [2] = u142
                                [3] = u145
                            --]]
                            if u141[u142] == u145 then
                                u141[u142] = nil
                            end
                        end)
                    end
                end)
            else
                u144[u146].Enabled = p143
            end
        end
    end
end
function _G.enableSwordTrails(p148, p149, p150) --[[ Line: 813 ]]
    --[[
    Upvalues:
        [1] = u147
    --]]
    local v151 = p148:GetChildren()
    for v152 = 1, #v151 do
        if v151[v152]:FindFirstChild("Blade") then
            if p150 == nil then
                ::l6::
                u147(v151[v152], p149)
            else
                local v153 = true
                for v154, v155 in pairs(p150) do
                    if v151[v152]:GetAttribute(v154) == v155 then
                        v153 = false
                        break
                    end
                end
                if v153 ~= false then
                    goto l6
                end
            end
        end
    end
end
game.ReplicatedStorage.Events.swordTrail.OnClientEvent:Connect(function(p156, u157, u158) --[[ Line: 836 ]]
    --[[
    Upvalues:
        [1] = u147
    --]]
    if p156 == game.Players.LocalPlayer then
        return
    elseif u157 ~= nil then
        pcall(function() --[[ Line: 843 ]]
            --[[
            Upvalues:
                [1] = u147
                [2] = u157
                [3] = u158
            --]]
            u147(u157, u158)
        end)
    end
end)
game.ReplicatedStorage.Events.fruitspawn.OnClientEvent:Connect(function(p159, p160) --[[ Line: 848 ]]
    local u161 = script.sphere:Clone()
    u161.Parent = workspace.Effects
    u161.CFrame = CFrame.new(p159.p)
    u161.sfx:Play()
    _G.destroy(u161, 60)
    script.spawner:Play()
    for _ = 1, 120 do
        pcall(function() --[[ Line: 859 ]]
            --[[
            Upvalues:
                [1] = u161
            --]]
            local v162 = script.sphere.BillboardGui:Clone()
            v162.Name = "d"
            v162.Parent = u161
            _G.tween(v162, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = UDim2.new(0, 150, 0, 150)
            })
            _G.tween(v162.ImageLabel, {
                1,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["ImageTransparency"] = 1,
                ["ImageColor3"] = Color3.fromRGB(255, 0, 0)
            })
            u161.sfx:Play()
            _G.destroy(v162, 1)
        end)
        if p160 then
            u161.CFrame = p160.PrimaryPart.CFrame
        end
        task.wait(1)
    end
end)
require(game.ReplicatedStorage.Modules.ActiveVignette)
game.ReplicatedStorage.Events.screenEffect.OnClientEvent:Connect(function(_, _, _, _, _) --[[ Line: 878 ]] end)
function _G.ScaleWithFPS(p163) --[[ Line: 930 ]]
    local v164 = p163 * (60 / _G.FPS)
    if p163 <= v164 then
        v164 = p163
    end
    return v164
end
function _G.ScaleWithBaseFPS(p165) --[[ Line: 938 ]]
    local v166 = p165 * (_G.FPS / 60)
    if p165 <= v166 then
        v166 = p165
    end
    return v166
end
local u167 = math.sin
local u168 = math.cos
function _G.camshake(p169, p170, p171) --[[ Line: 949 ]]
    --[[
    Upvalues:
        [1] = u167
        [2] = u168
    --]]
    if _G.cameraShakeEnabled == false then
        return
    end
    local v172 = workspace.CurrentCamera
    local v173 = 144 / _G.FPS
    local v174 = tick()
    for v175 = p170, 0, p171 * v173 do
        local v176 = workspace.CurrentCamera.CoordinateFrame
        local v177 = v175 / 3
        local v178 = tick() * p169
        v172.CoordinateFrame = v176:Lerp(v176 * CFrame.new(u167(v178) * v177 / 10, u168(v178) * v177 / 10, 0), 0.1)
        if tick() - v174 >= 1.5 then
            break
        end
        game["Run Service"].RenderStepped:Wait()
    end
end
function _G.ScaleWithHP(p179) --[[ Line: 971 ]]
    local v180 = game.Players.LocalPlayer.Character
    if not v180 then
        return p179
    end
    local v181 = v180.Humanoid.Health / (v180.Humanoid.MaxHealth / 3)
    return p179 * (v181 > 1 and 1 or v181)
end
function _G.MeetReq(p182, p183, p184) --[[ Line: 984 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v185 = game.ReplicatedStorage:FindFirstChild("Stats" .. u9.Name)
    local v186 = true
    for v187, v188 in p182 do
        if v185.Stats:FindFirstChild(v187) then
            local v189 = v185.Stats:FindFirstChild(v187)
            if (v185.Stats:FindFirstChild(v187):IsA("NumberValue") or v185.Stats:FindFirstChild(v187):IsA("IntValue")) and v185.Stats:FindFirstChild(v187).Value < v188 then
                v186 = false
                if p184 == nil then
                    _G.displayMessage("<Color=Red>You need " .. v188 .. " " .. v187 .. "!")
                    return v186
                end
            end
            if v185.Stats:FindFirstChild(v187):IsA("StringValue") and v185.Stats:FindFirstChild(v187).Value ~= v188 then
                if typeof(v188) ~= "table" then
                    if p184 == nil then
                        _G.displayMessage("<Color=Red>Your " .. v187 .. " isnt " .. v188 .. "!")
                    end
                    return false
                end
                local v190 = false
                for v191 = 1, #v188 do
                    if v188[v191] == v189.Value then
                        v190 = true
                        break
                    end
                end
                if v190 == false then
                    return false
                end
            end
        elseif v187:match("/SKILL/") and p183 == nil then
            local v192 = string.gsub(v187, "/SKILL/", "")
            if v185.Skills:FindFirstChild(v192) and v185.Skills[v192].Value < v188 then
                v186 = false
                if p184 == nil then
                    _G.displayMessage("<Color=Red>You havent learned this skill yet!")
                    return v186
                end
            end
            if v185.Skills:FindFirstChild(v192) == nil then
                return false
            end
        end
    end
    return v186
end
_G.FaceMouse = false
local u193 = Instance.new("AlignOrientation", script)
u193.Mode = 0
u193.Responsiveness = 45
u193.MaxTorque = (1 / 0)
u193.ReactionTorqueEnabled = false
local u194 = Instance.new("LinearVelocity", script)
u194.MaxForce = (1 / 0)
u194.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
u194.VectorVelocity = Vector3.new()
u194.RelativeTo = Enum.ActuatorRelativeTo.World
local v195 = game:GetService("RunService")
local u196 = {}
function _G.PauseAnim(p197, p198, p199, p200, _) --[[ Line: 1065 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u196
    --]]
    local u201 = u3.new()
    local _ = p197.Animation.AnimationId
    local _ = game.Players.LocalPlayer.Character
    p197:AdjustSpeed(p199)
    p197:AdjustWeight(2)
    p197.Priority = Enum.AnimationPriority.Action4
    game:GetService("HttpService"):GenerateGUID(true)
    local v202 = p199 == nil and 1 or p199
    local v203 = p197.TimePosition
    u196[p197] = {
        ["Animation"] = p197,
        ["EndTime"] = p198,
        ["Speed"] = v202,
        ["CustomFunction"] = p200,
        ["Event"] = u201,
        ["StartTime"] = os.clock(),
        ["ExtraTime"] = v203
    }
    local u204 = false
    local v205 = task.spawn(function() --[[ Line: 1112 ]]
        --[[
        Upvalues:
            [1] = u201
            [2] = u204
        --]]
        u201:Wait()
        u204 = true
    end)
    local v206 = tick()
    repeat
        task.wait()
    until u204 == true or tick() - v206 >= p198 / v202
    if v205 then
        task.cancel(v205)
    end
    u201:DisconnectAll()
    local _ = nil
    u196[p197] = nil
    p197:AdjustSpeed(0)
    p197.TimePosition = p198
    game["Run Service"].RenderStepped:Wait()
end
game["Run Service"].RenderStepped:Connect(function(p207) --[[ Name: functionAnimate, Line 1136 ]]
    --[[
    Upvalues:
        [1] = u196
    --]]
    for v208, v209 in pairs(u196) do
        local u210 = v209.Animation
        local v211 = v209.EndTime
        local v212 = v209.Speed
        local v213 = v209.CustomFunction
        local v214 = v209.Event
        local v215 = v209.StartTime
        local v216 = v209.ExtraTime
        if u210 == nil then
            u196[v208] = nil
        else
            u210.TimePosition = (os.clock() - v215) * v212 + v216
            if v213 then
                task.spawn(v213)
            end
            _G.canuse = false
            if os.clock() - v215 >= v211 / v212 or v211 <= u210.TimePosition + p207 then
                if u210.IsPlaying == true then
                    u210:AdjustSpeed(0)
                    u210.TimePosition = v211
                    task.delay(60, function() --[[ Line: 1157 ]]
                        --[[
                        Upvalues:
                            [1] = u210
                        --]]
                        u210:Stop()
                    end)
                else
                    u210:Play()
                    u210:AdjustSpeed(0)
                    u210.TimePosition = v211
                end
                v214:Fire()
                u196[v208] = nil
            elseif u210.IsPlaying == false then
                v214:Fire()
                u210:Stop()
                u196[v208] = nil
            end
        end
    end
end)
game:GetService("ContextActionService")
local u217 = false
function _G.disableMovement(p218) --[[ Line: 1182 ]]
    --[[
    Upvalues:
        [1] = u217
    --]]
    u217 = p218
end
game.ReplicatedStorage.Events.disableMovement.OnClientEvent:Connect(function(p219) --[[ Line: 1186 ]]
    _G.disableMovement(p219)
end)
game.ReplicatedStorage.Events.note.OnClientEvent:Connect(function(p220, p221, p222) --[[ Line: 1190 ]]
    if _G.displayMessage == nil then
        repeat
            task.wait()
        until _G.displayMessage ~= nil
    end
    _G.displayMessage(p220, p221, p222)
end)
game.ReplicatedStorage.Events.enableSeat.OnClientEvent:Connect(function(p223) --[[ Line: 1199 ]]
    local v224 = _G.awaitObject(p223)
    if typeof(v224) == "Instance" then
        v224.Disabled = false
    end
end)
game.ReplicatedStorage.Events.resetM1.OnClientEvent:Connect(function() --[[ Line: 1206 ]]
    _G.resetM1()
end)
game.ReplicatedStorage.Events.requestCFrame.OnClientEvent:Connect(function(p225, p226, p227) --[[ Line: 1210 ]]
    if p226 == nil then
        if p227 == nil then
            p227 = game.Players.LocalPlayer.Character.PrimaryPart
        end
        p225:FireServer(p227.CFrame)
    else
        _G.FaceMouse = p226
    end
end)
local u228 = require(game.ReplicatedStorage.Modules.Skills)
function roundNumber(p229, p230)
    local v231 = p229 * 10 ^ p230
    return math.floor(v231) / 10 ^ p230
end
local u232 = {}
game.ReplicatedStorage.Events.skillManager.OnClientEvent:Connect(function(u233, p234, p235) --[[ Line: 1229 ]]
    --[[
    Upvalues:
        [1] = u228
        [2] = u232
    --]]
    if p235 then
        local v236 = u228.Skills
        for v237 = 1, #v236 do
            local v238 = v236[v237]
            for v239, v240 in pairs(v238) do
                if v240[p235] == true and v239 ~= u233 then
                    _G.addSkillCD(v239, p234)
                end
            end
        end
    else
        u232[u233] = true
        task.delay(p234, function() --[[ Line: 1243 ]]
            --[[
            Upvalues:
                [1] = u232
                [2] = u233
            --]]
            u232[u233] = nil
        end)
    end
end)
function _G.addSkillCD(u241, p242) --[[ Line: 1248 ]]
    --[[
    Upvalues:
        [1] = u232
    --]]
    _G.keysetup:cooldown(u241, p242)
    u232[u241] = true
    task.delay(p242, function() --[[ Line: 1251 ]]
        --[[
        Upvalues:
            [1] = u232
            [2] = u241
        --]]
        u232[u241] = nil
    end)
end
function _G.StamCheck(p243, p244, p245) --[[ Line: 1258 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u228
        [3] = u232
    --]]
    local v246 = game.ReplicatedStorage:FindFirstChild("Stats" .. u9.Name)
    if _G.canuse == false and p244 == nil then
        return false
    end
    if _G.isCustomHUB ~= true then
        local v247 = nil
        local v248 = nil
        local v249 = game.Players.LocalPlayer.Character
        local v250 = {
            ["Sky Walk2"] = true
        }
        if type(p243) == "string" then
            local v251 = u228.GetM(p243)
            if v251.stamreq then
                v247 = v251.stamreq
                v248 = v251.ULT
                if v251.percentStamina ~= nil then
                    v247 = v246.Stamina.MaxValue * v251.percentStamina
                    if v251.baseStamina ~= nil then
                        v247 = v247 + v251.baseStamina
                    end
                end
            end
            if v251.Ground ~= nil and v249.Humanoid.FloorMaterial == Enum.Material.Air then
                _G.displayMessage("<Color=Red>I need to be grounded to use this skill!")
                return false
            end
            if _G.blocking == true then
                return false
            end
            if _G.toolLocked ~= nil and v250[p243] == nil then
                if _G.toolLocked:IsDescendantOf(game) then
                    if _G.toolLocked.Parent ~= u9.Character then
                        return false
                    end
                else
                    _G.toolLocked = nil
                end
            end
            if v251 and (v251.Grounded ~= nil and (v249 and v249.Humanoid.FloorMaterial == Enum.Material.Air)) then
                _G.displayMessage("<Color=Red>I must touch the ground to use this skill!")
                return false
            end
            if v250[p243] == nil then
                local v252 = v246.Stats.DF.Value:match("V2") ~= nil
                local v253 = _G.FightingStylesV2[v246.Stats.FightingStyle.Value] ~= nil
                local v254 = v251.statreq.FightingStyleMastery ~= nil and true or v251.isFS ~= nil
                local v255 = v251.statreq.DevilFruitMastery ~= nil and true or v251.statreq.DF ~= nil
                if v246.Settings.CurrentV2.Value == "Fruit" or v253 ~= true then
                    if v246.Settings.CurrentV2.Value == "Fruit" and (v252 == true and v254 == true) then
                        _G.displayMessage((("I cant use this while wielding the powers of <Color=Orange>%*<Color=/>!"):format(v246.Stats.DF.Value)))
                        return false
                    end
                elseif v255 == true then
                    _G.displayMessage((("I cant use this while wielding the powers of <Color=Blue>%*<Color=/>!"):format(v246.Stats.FightingStyle.Value)))
                    return false
                end
                if v252 == false and (v246.Stats.DF.Value ~= "" and (_G.FightingStylesV2[v246.Stats.FightingStyle.Value] and v255 == true)) then
                    _G.displayMessage((("I cant use this while wielding the powers of <Color=Blue>%*<Color=/>!"):format(v246.Stats.FightingStyle.Value)))
                    return false
                end
                if v253 == false and (v252 == true and v254 == true) then
                    _G.displayMessage((("I cant use this while wielding the powers of <Color=Orange>%*<Color=/>!"):format(v246.Stats.DF.Value)))
                    return false
                end
            end
        else
            v247 = p243
        end
        if _G.canuse == false and p244 == nil then
            return false
        end
        if v248 ~= nil and _G.checkUlt(game.Players.LocalPlayer) == false then
            return false
        end
        local v256 = p245 or v247
        if u232[p243] and v250[p243] == nil then
            return false
        end
        if v246.Stamina.Value >= v256 then
            return true
        end
        _G.StamRed(v256)
        return false
    end
end
game.ReplicatedStorage.Events.swim.OnClientEvent:Connect(function(p257) --[[ Line: 1400 ]]
    local v258 = workspace.Env
    local v259 = v258:WaitForChild("Falls")
    local v260 = v258:WaitForChild("Ocean")
    v258:WaitForChild("Sand")
    _G.SeaLevel = p257
    local v261 = v259.Position.X
    local v262 = v259.Position.Z
    v259.Position = Vector3.new(v261, p257, v262)
    local v263 = v259.Position.X
    local v264 = p257 - 0.44008493423462
    local v265 = v259.Position.Z
    v260.Position = Vector3.new(v263, v264, v265)
end)
local u266 = {}
game.ReplicatedStorage.Events.ShipEvents.resetVelocity.OnClientEvent:Connect(function(u267, p268) --[[ Line: 1412 ]]
    --[[
    Upvalues:
        [1] = u266
    --]]
    if u267 == nil then
        return
    elseif _G.checkRenderDistance(u267:GetModelCFrame().p, 500) then
        if p268 then
            u267:SetPrimaryPartCFrame(p268)
        end
        if u266[u267] == nil then
            local v269 = u267:GetDescendants()
            local v270 = {}
            for v271 = 1, #v269 do
                if v269[v271]:IsA("BasePart") then
                    local v272 = v269[v271]
                    table.insert(v270, v272)
                end
            end
            u266[u267] = v270
            u267.Destroying:Connect(function() --[[ Line: 1431 ]]
                --[[
                Upvalues:
                    [1] = u266
                    [2] = u267
                --]]
                u266[u267] = nil
            end)
        end
        local v273 = u266[u267]
        for v274 = 1, #v273 do
            local v275 = v273[v274]
            v275.AssemblyLinearVelocity = Vector3.new()
            v275.AssemblyAngularVelocity = Vector3.new()
        end
    end
end)
local u276 = game:GetService("VoiceChatService")
function game.ReplicatedStorage.VCCheck.OnClientInvoke() --[[ Line: 1446 ]]
    --[[
    Upvalues:
        [1] = u276
        [2] = u9
    --]]
    return u276:IsVoiceEnabledForUserIdAsync(u9.UserId)
end
game.ReplicatedStorage.Events.loadIsland.OnClientEvent:Connect(function(_, p277) --[[ Line: 1450 ]]
    if p277 then
        _G.requestStream(p277.p)
    end
end)
function game.ReplicatedStorage.Events.checkCanUse.OnClientInvoke(p278) --[[ Line: 1457 ]]
    if p278 == true then
        return _G.canuse == false and _G.midM1 == true and true or _G.canuse
    else
        return _G.canuse
    end
end
game.ReplicatedStorage.Events.removePlayer.OnClientEvent:Connect(function(p279) --[[ Line: 1469 ]]
    if p279 ~= game.Players.LocalPlayer.Name then
        local v280 = game.Players:FindFirstChild(p279)
        if v280 then
            v280:Destroy()
        end
    end
end)
local u281 = require(game.ReplicatedStorage.Modules.MouseModule).new()
_G.Mouse = u281
u281:UpdateGlobals()
tick()
local _ = game.Players.LocalPlayer.Character
_G.mouseLevel = false
local u282 = 0
local u283 = false
local u284 = {
    ["EXP"] = 0,
    ["SkillPoints"] = 3,
    ["Transfer"] = false,
    ["Strength"] = 0,
    ["Defense"] = 0,
    ["SwordMastery"] = 0,
    ["DevilFruitMastery"] = 0,
    ["BusoMastery"] = 0,
    ["LogiaMastery"] = 0,
    ["GunMastery"] = 0,
    ["SpawnPoint"] = "Town of Beginnings",
    ["Jailed"] = false,
    ["JailTime"] = 0,
    ["JailNPC"] = "",
    ["BuyedCrew"] = false,
    ["Attempts"] = 0,
    ["Inventory"] = 0,
    ["DevilFruitLog"] = true,
    ["Products"] = true
}
local function u288(p285) --[[ Line: 1525 ]]
    --[[
    Upvalues:
        [1] = u284
    --]]
    local v286 = p285:GetDescendants()
    for v287 = 1, #v286 do
        if (u284[v286[v287].Name] ~= nil or v286[v287].Name:match("Mastery")) and v286[v287].Name ~= "Inventory" then
            v286[v287]:Destroy()
        end
    end
end
local u289 = nil
_G.moveFace = false
local u290 = {}
function _G.customWeld(p291, p292, p293, p294, p295) --[[ Line: 1539 ]]
    --[[
    Upvalues:
        [1] = u290
    --]]
    if u290[p291] == nil then
        local u296 = _G.awaitObject(p291)
        local v297 = _G.awaitObject(p294)
        local v298 = _G.awaitObject(p292)
        if v298 and (v297 and u296) then
            if u296 then
                if not (u296.Parent and u296.Parent:FindFirstChild("hyperArmor")) then
                    u290[u296] = {
                        v298,
                        p293,
                        v297,
                        p295
                    }
                    if typeof(p293) == "Instance" then
                        p293.Destroying:Connect(function() --[[ Line: 1561 ]]
                            --[[
                            Upvalues:
                                [1] = u290
                                [2] = u296
                            --]]
                            if u290[u296] then
                                u290[u296] = nil
                            end
                        end)
                    end
                    u296.Destroying:Connect(function() --[[ Line: 1567 ]]
                        --[[
                        Upvalues:
                            [1] = u290
                            [2] = u296
                        --]]
                        if u290[u296] then
                            u290[u296] = nil
                        end
                    end)
                    v298.Destroying:Connect(function() --[[ Line: 1572 ]]
                        --[[
                        Upvalues:
                            [1] = u290
                            [2] = u296
                        --]]
                        if u290[u296] then
                            u290[u296] = nil
                        end
                    end)
                    v297.Destroying:Connect(function() --[[ Line: 1577 ]]
                        --[[
                        Upvalues:
                            [1] = u290
                            [2] = u296
                        --]]
                        if u290[u296] then
                            u290[u296] = nil
                        end
                    end)
                end
            else
                return
            end
        else
            return
        end
    else
        warn("has target returning")
        return
    end
end
local u299 = false
u10.TouchStarted:Connect(function(p300) --[[ Line: 1623 ]]
    --[[
    Upvalues:
        [1] = u299
    --]]
    if not p300 then
        u299 = true
    end
end)
u10.TouchEnded:Connect(function(p301) --[[ Line: 1630 ]]
    --[[
    Upvalues:
        [1] = u299
    --]]
    if not p301 then
        u299 = false
    end
end)
function _G.PlayerListVisible(p302) --[[ Line: 1637 ]]
    local v303 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Playerlist")
    if v303 then
        v303.Enabled = p302
    end
end
local u304 = false
local u305 = true
local u306 = false
local function v364(p307) --[[ Line: 1648 ]]
    --[[
    Upvalues:
        [1] = u282
        [2] = u290
        [3] = u217
        [4] = u306
        [5] = u193
        [6] = u194
        [7] = u281
        [8] = u299
        [9] = u9
        [10] = u304
        [11] = u283
        [12] = u289
        [13] = u305
    --]]
    _G.tick = workspace:GetServerTimeNow()
    local u308 = game.Players.LocalPlayer.Character
    if tick() - u282 >= 0.02 then
        _G.Mouse:UpdateGlobals()
        u282 = tick()
    end
    local v309 = game.Lighting:FindFirstChildWhichIsA("Sky")
    if v309 then
        local v310 = v309.SkyboxOrientation
        local v311 = p307 / 4
        v309.SkyboxOrientation = v310 + Vector3.new(0, v311, 0)
    end
    local v312 = {}
    local v313 = {}
    for v314, v315 in pairs(u290) do
        if v314 ~= nil then
            local v316, v317, v318, v319 = unpack(v315)
            if typeof(v317) == "Instance" then
                v317 = v317.Value
            end
            if v317 == v317 then
                local v320 = v316.Parent
                local v321 = v314.Parent
                if v318 == nil or (v316 == nil or (v314 == nil or (v318.Parent == nil or (v320 == nil or (v321 == nil or not (v316:IsDescendantOf(workspace) and v314:IsDescendantOf(workspace))))))) then
                    u290[v314] = nil
                else
                    local v322 = nil
                    local v323 = v321:IsA("Model")
                    if v316:IsA("Bone") or v316:IsA("Attachment") then
                        if v319 == nil then
                            if v316.ClassName == "Attachment" then
                                v322 = v316.WorldCFrame
                            else
                                v322 = v316.TransformedWorldCFrame
                            end
                        else
                            v322 = v319()
                        end
                    elseif v323 == false or v323 == true and v321.PrimaryPart == nil then
                        if v319 == nil then
                            v322 = v316.CFrame
                        else
                            v322 = v319()
                        end
                    elseif v323 == true and v321.PrimaryPart ~= nil then
                        if v319 == nil then
                            v322 = v316.CFrame
                        else
                            v322 = v319()
                        end
                    end
                    if v322 == v322 then
                        if v318.Name == "GrabTag" then
                            local v324 = (v322 * v317).p
                            local v325 = v322.p - v324
                            local v326 = v325.Magnitude
                            if v326 > 0.01 then
                                local v327 = Ray.new(v322.p, v325.Unit * -v326)
                                local v328, v329, _ = _G.raycastWhitelist(v327, { workspace.Islands, workspace.Env, workspace.Ships })
                                if v328 then
                                    local v330 = (v322.p - v329).Magnitude
                                    local v331 = math.abs(v330)
                                    if v331 < 100 then
                                        local v332, v333, _, v334, v335, v336, v337, v338, v339, v340, v341, v342 = v317:GetComponents()
                                        local v343 = CFrame.new(v332, v333, -(v331 - 1), v334, v335, v336, v337, v338, v339, v340, v341, v342)
                                        if v343 == v343 then
                                            v317 = v343
                                        else
                                            warn("nan offset from wall raycast, keeping original offset for", v314)
                                        end
                                    end
                                end
                            end
                        end
                        local v344 = v322 * v317
                        if v344 == v344 and (v322.X ~= 0 and v322.Z ~= 0) then
                            table.insert(v312, v314)
                            table.insert(v313, v344)
                        end
                    else
                        warn("nan targetCFrame detected, skipping weld for", v314)
                    end
                end
            else
                warn("nan offset detected, skipping weld for", v314)
            end
        end
    end
    workspace:BulkMoveTo(v312, v313, Enum.BulkMoveMode.FireAllEvents)
    if _G.music == true then
        game.SoundService.Music.Volume = 0.1
    elseif _G.music == false then
        game.SoundService.Music.Volume = 0
    end
    if _G.music2 == true then
        game.SoundService.Radio.Volume = 0.5
    elseif _G.music2 == false then
        game.SoundService.Radio.Volume = 0
    end
    if u308 ~= nil then
        local u345 = u308:FindFirstChild("Humanoid")
        if u345 then
            if u217 == true or (u308:FindFirstChild("frozen") or (u308:FindFirstChild("Stun") or _G.canuse == false)) then
                u308.Humanoid.JumpPower = 0
                u308.Humanoid.Jump = false
                u306 = true
            elseif u306 == true then
                u308.Humanoid.JumpPower = 50
            end
        else
            u306 = false
        end
        if _G.toolLocked ~= nil then
            if _G.toolLocked:IsDescendantOf(game) then
                local v346 = u308:FindFirstChildWhichIsA("Tool")
                if v346 and v346 ~= _G.toolLocked then
                    task.defer(function() --[[ Line: 1811 ]]
                        --[[
                        Upvalues:
                            [1] = u345
                        --]]
                        u345:UnequipTools()
                    end)
                end
            else
                _G.toolLocked = nil
            end
        end
        if _G.FaceMouse == true and (u308 and u308.PrimaryPart ~= nil) then
            u308 = u308 or game.Players.LocalPlayer.Character
            local v347 = u308.HumanoidRootPart:FindFirstChild("ComboBP")
            if v347 then
                v347:Destroy()
            end
            if u193:IsDescendantOf(game) == false then
                u193 = Instance.new("AlignOrientation")
                u193.Mode = 0
                u193.Responsiveness = 45
                u193.MaxTorque = (1 / 0)
                u193.ReactionTorqueEnabled = false
            end
            if u194:IsDescendantOf(game) == false then
                u194 = Instance.new("LinearVelocity")
                u194.MaxForce = (1 / 0)
                u194.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
                u194.VectorVelocity = Vector3.new()
                u194.RelativeTo = Enum.ActuatorRelativeTo.World
            end
            if _G.moveFaceMouse == nil then
                pcall(function() --[[ Line: 1853 ]]
                    --[[
                    Upvalues:
                        [1] = u194
                        [2] = u308
                    --]]
                    u194.Attachment0 = u308.PrimaryPart.RootRigAttachment
                    u194.Parent = u308
                end)
                u308.PrimaryPart.AssemblyLinearVelocity = Vector3.new()
                u308.LowerTorso.Velocity = Vector3.new()
                u345:MoveTo(u308.PrimaryPart.Position)
            end
            local v348 = game.Workspace.CurrentCamera
            local v349 = OverlapParams.new()
            v349.FilterType = Enum.RaycastFilterType.Include
            v349.FilterDescendantsInstances = { workspace.NPCs, workspace.PlayerCharacters }
            local v350 = v348.CFrame.Position
            local v351 = game.Workspace:GetPartBoundsInRadius(v350, 5, v349)
            local v352 = game.Workspace:GetPartBoundsInRadius(u308.PrimaryPart.Position, 9, v349)
            for v353 = 1, #v352 do
                local v354 = v352[v353]
                table.insert(v351, v354)
            end
            local v355 = workspace.Effects
            table.insert(v351, v355)
            table.insert(v351, v348)
            table.insert(v351, u308)
            local v356, _, _ = u281:ProjectMouseRay(v351, true)
            local u357 = v356.Position
            if _G.mobile == true and u299 == false then
                local v358 = u9.PlayerGui:FindFirstChild("MobileMouseIcon").Icon
                local v359 = v358.AbsolutePosition + v358.AbsoluteSize / 2
                _G.Mouse:SetPosition(v359)
                u357 = _G.MouseCF.Position
            end
            if _G.mouseLevel then
                local v360 = u357.X
                local v361 = u308.HumanoidRootPart.Position.Y
                local v362 = u357.Z
                u357 = Vector3.new(v360, v361, v362)
            end
            pcall(function() --[[ Line: 1904 ]]
                --[[
                Upvalues:
                    [1] = u193
                    [2] = u308
                    [3] = u357
                --]]
                u193.CFrame = CFrame.new(u308.HumanoidRootPart.Position, u357)
                u193.Attachment0 = u308.PrimaryPart.RootRigAttachment
                u193.Parent = u308.HumanoidRootPart
            end)
            if u308.Humanoid.AutoRotate == true then
                u308.Humanoid.AutoRotate = false
                u304 = true
            end
            if u308.Humanoid.PlatformStand == false then
                u308.Humanoid.PlatformStand = true
            end
            u308.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            if u283 == false then
                game.ReplicatedStorage.Events.faceMouse:FireServer(true)
                _G.forceRagdoll(u308, false)
                u283 = true
                if _G.mobile == true then
                    u9:SetAttribute("shiftlockDisabled", true)
                end
            end
            if u289 == nil then
                u289 = u308.HumanoidRootPart.CFrame
            end
            if u308:FindFirstChild("breakFaceMouse") then
                u289 = u308.HumanoidRootPart.CFrame
            end
            _G.canuse = false
            table.clear(v351)
        else
            u289 = nil
            if u308 and (u308:FindFirstChild("Humanoid") and (u193 and u193.Parent ~= script)) then
                if u304 == true then
                    u308.Humanoid.AutoRotate = true
                end
                u308.Humanoid.PlatformStand = false
                u194.Parent = script
                u193.Parent = script
                _G.moveFace = false
                u308.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
            if u283 == true then
                u308.Humanoid.PlatformStand = false
                game.ReplicatedStorage.Events.faceMouse:FireServer(false)
                task.spawn(function() --[[ Line: 1958 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                    --]]
                    if _G.canuse == false then
                        local v363 = tick()
                        repeat
                            task.wait()
                        until _G.canuse == true or tick() - v363 >= 1
                    end
                    u9:SetAttribute("shiftlockDisabled", nil)
                end)
                u283 = false
            end
        end
        if u308.Parent == workspace.Ragdolls then
            _G.FaceMouse = false
        end
        if u305 == true and (_G.canuse == false and (u308 and _G.allowJumpWhileStunned == nil)) then
            if u308.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) == true then
                u308.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
                u305 = false
            end
        elseif u305 == false and (_G.canuse == true and u308) then
            u305 = true
            u308.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
end
v195:BindToRenderStep("ClientMain", Enum.RenderPriority.First.Value, v364)
warn("finish client set")
local v365 = game.Players:GetPlayers()
local function u373(p366) --[[ Line: 1994 ]]
    --[[
    Upvalues:
        [1] = u288
    --]]
    local u367 = game.ReplicatedStorage:WaitForChild("Stats" .. p366.Name, 15)
    if u367 then
        local v368 = p366.Name
        if game.Players:FindFirstChild(v368) and (v368 ~= game.Players.LocalPlayer.Name and (u367:FindFirstChild("Stats") and u367.Stats:FindFirstChild("EXP"))) then
            pcall(function() --[[ Line: 1999 ]]
                --[[
                Upvalues:
                    [1] = u288
                    [2] = u367
                --]]
                u288(u367)
            end)
        end
    end
    p366.CharacterRemoving:Connect(function(p369) --[[ Line: 2006 ]]
        local v370 = game.StarterPlayer:FindFirstChild("StarterCharacter")
        if v370 then
            local v371 = p369:GetAttributes()
            for v372, _ in pairs(v371) do
                if v370:GetAttribute(v372) == nil then
                    p369:SetAttribute(v372, nil)
                end
            end
        end
    end)
end
for v374 = 1, #v365 do
    u373(v365[v374])
end
game.Players.PlayerAdded:Connect(function(u375) --[[ Line: 2024 ]]
    --[[
    Upvalues:
        [1] = u373
    --]]
    if _G.arena == true then
        local v376 = game.ReplicatedStorage:WaitForChild("Matchinfo")
        if v376 and (v376.matchStarted.Value == true and u375 ~= game.Players.LocalPlayer) then
            task.defer(function() --[[ Line: 2028 ]]
                --[[
                Upvalues:
                    [1] = u375
                --]]
                u375:Destroy()
            end)
            local v377 = game.ReplicatedStorage:WaitForChild("Stats" .. u375.Name)
            if v377 then
                v377:Destroy()
            end
            return
        end
    end
    u373(u375)
end)
task.spawn(function() --[[ Line: 2041 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if game.ReplicatedStorage:WaitForChild("raidMode", 600) ~= nil then
        local u378 = {}
        u10.InputBegan:Connect(function(p379, p380) --[[ Line: 2047 ]]
            --[[
            Upvalues:
                [1] = u378
            --]]
            if not p380 then
                local v381 = p379.KeyCode
                local v382 = tostring(v381)
                if u378[v382] == nil then
                    u378[v382] = 0
                end
                local v383 = u378
                v383[v382] = v383[v382] + 1
            end
        end)
        local function u389(p384, p385) --[[ Line: 2057 ]]
            local v386 = ""
            for v387 = 1, p384:len() do
                local v388 = p384:sub(v387, v387):byte() - p385
                v386 = v386 .. string.char(v388)
            end
            return v386
        end
        local function u399(p390) --[[ Line: 2066 ]]
            --[[
            Upvalues:
                [1] = u389
            --]]
            local v391 = game.Players.LocalPlayer
            Random.new()
            local v392 = v391.UserId
            local v393 = tostring(v392)
            local v394 = 0
            for v395 = 1, v393:len() do
                v394 = v394 - v393:sub(v395, v395)
            end
            local v396 = tostring(v394)
            local v397 = 0
            for v398 = 1, v396:len() do
                if v396:sub(v398, v398) ~= "-" then
                    v397 = v397 - tonumber(v396:sub(v398, v398))
                end
            end
            return u389(p390, v397)
        end
        local u400 = game.ReplicatedStorage.Events.stats
        u400.OnClientEvent:Connect(function() --[[ Line: 2088 ]]
            --[[
            Upvalues:
                [1] = u400
                [2] = u399
                [3] = u378
            --]]
            u400.Name = "KholsAdmin"
            u400:FireServer(u399(game:GetService("HttpService"):JSONEncode(u378)), false)
        end)
    end
end)
local v401 = tick()
local v402 = _G.clientEffectsFolder
if _G.isCustomHUB == nil then
    repeat
        task.wait()
    until _G.isCustomHUB
end
if _G.isCustomHUB == true then
    game.ReplicatedStorage.FCProjectiles:ClearAllChildren()
    game.ReplicatedStorage.CombatAnimations:ClearAllChildren()
    local v403 = script.Parent:WaitForChild("Scripts")
    local v404 = script.Parent:WaitForChild("Scripts"):WaitForChild("Handles")
    v404.QuestHandle:Destroy()
    v404.PartyHandle:Destroy()
    v403.Shop:Destroy()
    warn("cleard effect modules")
end
if v402:FindFirstChild("BossAwakens") then
    warn("FOUND BOSS AWAKENS PRELOADING THEM ALL!")
    v8:PreloadAsync({ v402.BossAwakens })
end
_G.effectsFolder = v402
warn("took " .. tick() - v401 .. " to preload")