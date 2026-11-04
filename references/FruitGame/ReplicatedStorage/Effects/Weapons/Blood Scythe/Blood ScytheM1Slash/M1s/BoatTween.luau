 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = {
    ["Heartbeat"] = true,
    ["Stepped"] = true,
    ["RenderStepped"] = true
}
if not u2:IsClient() then
    u3.RenderStepped = nil
end
local v4 = require(script.TweenFunctions)
local u5 = {
    ["Linear"] = {
        ["In"] = v4.Linear,
        ["Out"] = v4.Linear,
        ["InOut"] = v4.Linear
    },
    ["Quad"] = {
        ["In"] = v4.InQuad,
        ["Out"] = v4.OutQuad,
        ["InOut"] = v4.InOutQuad
    },
    ["Cubic"] = {
        ["In"] = v4.InCubic,
        ["Out"] = v4.OutCubic,
        ["InOut"] = v4.InOutCubic
    },
    ["Quart"] = {
        ["In"] = v4.InQuart,
        ["Out"] = v4.OutQuart,
        ["InOut"] = v4.InOutQuart
    },
    ["Quint"] = {
        ["In"] = v4.InQuint,
        ["Out"] = v4.OutQuint,
        ["InOut"] = v4.InOutQuint
    },
    ["Sine"] = {
        ["In"] = v4.InSine,
        ["Out"] = v4.OutSine,
        ["InOut"] = v4.InOutSine
    },
    ["Exponential"] = {
        ["In"] = v4.InExponential,
        ["Out"] = v4.OutExponential,
        ["InOut"] = v4.InOutExponential
    },
    ["Circular"] = {
        ["In"] = v4.InCircular,
        ["Out"] = v4.OutCircular,
        ["InOut"] = v4.InOutCircular
    },
    ["Elastic"] = {
        ["In"] = v4.InElastic,
        ["Out"] = v4.OutElastic,
        ["InOut"] = v4.InOutElastic
    },
    ["Back"] = {
        ["In"] = v4.InBack,
        ["Out"] = v4.OutBack,
        ["InOut"] = v4.InOutBack
    },
    ["Bounce"] = {
        ["In"] = v4.InBounce,
        ["Out"] = v4.OutBounce,
        ["InOut"] = v4.InOutBounce
    },
    ["Smooth"] = {
        ["In"] = v4.InSmooth,
        ["Out"] = v4.OutSmooth,
        ["InOut"] = v4.InOutSmooth
    },
    ["Smoother"] = {
        ["In"] = v4.InSmoother,
        ["Out"] = v4.OutSmoother,
        ["InOut"] = v4.InOutSmoother
    },
    ["RidiculousWiggle"] = {
        ["In"] = v4.InRidiculousWiggle,
        ["Out"] = v4.OutRidiculousWiggle,
        ["InOut"] = v4.InOutRidiculousWiggle
    },
    ["RevBack"] = {
        ["In"] = v4.InRevBack,
        ["Out"] = v4.OutRevBack,
        ["InOut"] = v4.InOutRevBack
    },
    ["Spring"] = {
        ["In"] = v4.InSpring,
        ["Out"] = v4.OutSpring,
        ["InOut"] = v4.InOutSpring
    },
    ["SoftSpring"] = {
        ["In"] = v4.InSoftSpring,
        ["Out"] = v4.OutSoftSpring,
        ["InOut"] = v4.InOutSoftSpring
    },
    ["Sharp"] = {
        ["In"] = v4.InSharp,
        ["Out"] = v4.OutSharp,
        ["InOut"] = v4.InOutSharp
    },
    ["Acceleration"] = {
        ["In"] = v4.InAcceleration,
        ["Out"] = v4.OutAcceleration,
        ["InOut"] = v4.InOutAcceleration
    },
    ["Standard"] = {
        ["In"] = v4.InStandard,
        ["Out"] = v4.OutStandard,
        ["InOut"] = v4.InOutStandard
    },
    ["Deceleration"] = {
        ["In"] = v4.InDeceleration,
        ["Out"] = v4.OutDeceleration,
        ["InOut"] = v4.InOutDeceleration
    },
    ["FabricStandard"] = {
        ["In"] = v4.InFabricStandard,
        ["Out"] = v4.OutFabricStandard,
        ["InOut"] = v4.InOutFabricStandard
    },
    ["FabricAccelerate"] = {
        ["In"] = v4.InFabricAccelerate,
        ["Out"] = v4.OutFabricAccelerate,
        ["InOut"] = v4.InOutFabricAccelerate
    },
    ["FabricDecelerate"] = {
        ["In"] = v4.InFabricDecelerate,
        ["Out"] = v4.OutFabricDecelerate,
        ["InOut"] = v4.InOutFabricDecelerate
    },
    ["UWPAccelerate"] = {
        ["In"] = v4.InUWPAccelerate,
        ["Out"] = v4.OutUWPAccelerate,
        ["InOut"] = v4.InOutUWPAccelerate
    },
    ["StandardProductive"] = {
        ["In"] = v4.InStandardProductive,
        ["Out"] = v4.OutStandardProductive,
        ["InOut"] = v4.InOutStandardProductive
    },
    ["EntranceProductive"] = {
        ["In"] = v4.InEntranceProductive,
        ["Out"] = v4.OutEntranceProductive,
        ["InOut"] = v4.InOutEntranceProductive
    },
    ["ExitProductive"] = {
        ["In"] = v4.InExitProductive,
        ["Out"] = v4.OutExitProductive,
        ["InOut"] = v4.InOutExitProductive
    },
    ["StandardExpressive"] = {
        ["In"] = v4.InStandardExpressive,
        ["Out"] = v4.OutStandardExpressive,
        ["InOut"] = v4.InOutStandardExpressive
    },
    ["EntranceExpressive"] = {
        ["In"] = v4.InEntranceExpressive,
        ["Out"] = v4.OutEntranceExpressive,
        ["InOut"] = v4.InOutEntranceExpressive
    },
    ["ExitExpressive"] = {
        ["In"] = v4.InExitExpressive,
        ["Out"] = v4.OutExitExpressive,
        ["InOut"] = v4.InOutExitExpressive
    },
    ["MozillaCurve"] = {
        ["In"] = v4.InMozillaCurve,
        ["Out"] = v4.OutMozillaCurve,
        ["InOut"] = v4.InOutMozillaCurve
    }
}
local u6 = require(script.Lerps)
function v1.Create(_, u7, p8) --[[ Line: 270 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
        [4] = u6
    --]]
    if u7 and typeof(u7) == "Instance" then
        local u9 = type(p8) == "table" and (p8 or {}) or {}
        local u10 = u3[u9.StepType] and u2[u9.StepType] or u2.Stepped
        local u11 = u5[u9.EasingStyle or "Quad"][u9.EasingDirection or "In"]
        local v12 = u9.Time
        local v13 = type(v12) == "number" and (u9.Time or 1) or 1
        local u14 = math.clamp(v13, 0, 9999999999)
        local v15 = u9.Goal
        local v16 = type(v15) == "table" and (u9.Goal or {}) or {}
        local v17 = u9.DelayTime
        local u18
        if type(v17) == "number" and u9.DelayTime > 0.027 then
            u18 = u9.DelayTime
        else
            u18 = false
        end
        local v19 = u9.RepeatCount
        local v20
        if type(v19) == "number" then
            local v21 = u9.RepeatCount
            v20 = math.clamp(v21, -1, 999999999) or 0
        else
            v20 = 0
        end
        local u22 = v20 + 1
        local u23 = {}
        for v24, v25 in pairs(v16) do
            u23[v24] = u6[typeof(v25)](u7[v24], v25)
        end
        local u26 = Instance.new("BindableEvent")
        local u27 = Instance.new("BindableEvent")
        local u28 = Instance.new("BindableEvent")
        local u29 = nil
        local u30 = tick()
        local u31 = 0
        local u33 = {
            ["Instance"] = u7,
            ["PlaybackState"] = Enum.PlaybackState.Begin,
            ["Completed"] = u26.Event,
            ["Resumed"] = u28.Event,
            ["Stopped"] = u27.Event,
            ["Destroy"] = function(_) --[[ Name: Destroy, Line 311 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u26
                    [3] = u27
                    [4] = u28
                    [5] = u33
                    [6] = u7
                --]]
                if u29 then
                    u29:Disconnect()
                    u29 = nil
                end
                u26:Destroy()
                u27:Destroy()
                u28:Destroy()
                for v32, _ in pairs(u33) do
                    u33[v32] = nil
                end
                table.clear(u33)
                u7 = nil
            end
        }
        local u34 = false
        local u35 = 0
        local function u55(p36, u37) --[[ Line: 331 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u22
                [3] = u33
                [4] = u26
                [5] = u34
                [6] = u35
                [7] = u18
                [8] = u30
                [9] = u31
                [10] = u10
                [11] = u14
                [12] = u23
                [13] = u7
                [14] = u55
                [15] = u9
                [16] = u11
            --]]
            if u29 then
                u29:Disconnect()
                u29 = nil
            end
            local u38 = p36 or 1
            if u22 == 0 or u22 >= u38 then
                u35 = u38
                if u37 then
                    u34 = true
                end
                if u18 then
                    u33.PlaybackState = Enum.PlaybackState.Delayed
                    _G.fw(u18)
                end
                u30 = tick() - u31
                u29 = u10:Connect(function() --[[ Line: 358 ]]
                    --[[
                    Upvalues:
                        [1] = u31
                        [2] = u30
                        [3] = u14
                        [4] = u37
                        [5] = u23
                        [6] = u7
                        [7] = u29
                        [8] = u55
                        [9] = u38
                        [10] = u9
                        [11] = u11
                        [12] = u33
                        [13] = u26
                    --]]
                    u31 = tick() - u30
                    if u14 <= u31 then
                        if u37 then
                            for v39, v40 in pairs(u23) do
                                u7[v39] = v40(0)
                            end
                        else
                            for v41, v42 in pairs(u23) do
                                u7[v41] = v42(1)
                            end
                        end
                        u29:Disconnect()
                        u29 = nil
                        if u37 then
                            u31 = 0
                            u55(u38 + 1, false)
                        elseif u9.Reverses then
                            u31 = 0
                            u55(u38, true)
                        else
                            u31 = 0
                            u55(u38 + 1, false)
                        end
                    elseif u37 then
                        for u43, u44 in pairs(u23) do
                            if pcall(function() --[[ Line: 398 ]]
                                --[[
                                Upvalues:
                                    [1] = u7
                                    [2] = u43
                                    [3] = u44
                                    [4] = u11
                                    [5] = u31
                                    [6] = u14
                                --]]
                                local v45 = u7
                                local v46 = u43
                                local v47 = u44
                                local v48 = u11(1 - u31 / u14)
                                v45[v46] = v47((math.clamp(v48, 0, 1)))
                            end) == false then
                                break
                            end
                        end
                    else
                        for u49, u50 in pairs(u23) do
                            if pcall(function() --[[ Line: 407 ]]
                                --[[
                                Upvalues:
                                    [1] = u7
                                    [2] = u49
                                    [3] = u50
                                    [4] = u11
                                    [5] = u31
                                    [6] = u14
                                --]]
                                local v51 = u7
                                local v52 = u49
                                local v53 = u50
                                local v54 = u11(u31 / u14)
                                v51[v52] = v53((math.clamp(v54, 0, 1)))
                            end) == false then
                                break
                            end
                        end
                    end
                    if u7 and u7:IsDescendantOf(game) == false then
                        u33.PlaybackState = Enum.PlaybackState.Completed
                        u26:Fire()
                    end
                end)
                u33.PlaybackState = Enum.PlaybackState.Playing
            else
                u33.PlaybackState = Enum.PlaybackState.Completed
                u26:Fire()
                u34 = false
                u35 = 1
            end
        end
        function u33.Play(_) --[[ Line: 426 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u55
            --]]
            u31 = 0
            u55(1, false)
        end
        function u33.Stop(_) --[[ Line: 431 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u33
                [3] = u27
            --]]
            if u29 then
                u29:Disconnect()
                u29 = nil
                u33.PlaybackState = Enum.PlaybackState.Cancelled
                u27:Fire()
            end
        end
        function u33.Resume(_) --[[ Line: 440 ]]
            --[[
            Upvalues:
                [1] = u55
                [2] = u35
                [3] = u34
                [4] = u28
            --]]
            u55(u35, u34)
            u28:Fire()
        end
        return u33
    end
    error("Invalid object to tween:", u7)
end
return v1