 

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
local u7 = {}
for _ = 1, 64 do
    local v8 = script.Actor:Clone()
    v8.Parent = script.AllActors
    local v9 = require
    local v10 = v8.Tween
    table.insert(u7, v9(v10))
end
function v1.Create(_, u11, p12) --[[ Line: 277 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u5
        [4] = u6
        [5] = u7
    --]]
    if u11 and typeof(u11) == "Instance" then
        local u13 = type(p12) == "table" and (p12 or {}) or {}
        local u14 = u3[u13.StepType] and u2[u13.StepType] or u2.Heartbeat
        local u15 = u5[u13.EasingStyle or "Quad"][u13.EasingDirection or "In"]
        local v16 = u13.Time
        local v17 = type(v16) == "number" and (u13.Time or 1) or 1
        local u18 = math.clamp(v17, 0, 9999999999)
        local v19 = u13.Goal
        local v20 = type(v19) == "table" and (u13.Goal or {}) or {}
        local v21 = u13.DelayTime
        local u22
        if type(v21) == "number" and u13.DelayTime > 0.027 then
            u22 = u13.DelayTime
        else
            u22 = false
        end
        local v23 = u13.RepeatCount
        local v24
        if type(v23) == "number" then
            local v25 = u13.RepeatCount
            v24 = math.clamp(v25, -1, 999999999) or 0
        else
            v24 = 0
        end
        local u26 = v24 + 1
        local u27 = {}
        for v28, v29 in v20 do
            u27[v28] = u6[typeof(v29)](u11[v28], v29)
        end
        local u30 = Instance.new("BindableEvent", script)
        u30.Name = "btCompleted"
        local u31 = Instance.new("BindableEvent", script)
        u31.Name = "btStopped"
        local u32 = Instance.new("BindableEvent", script)
        u32.Name = "btResume"
        local u33 = nil
        local u34 = nil
        local u35 = tick()
        local u36 = 0
        local u37 = {
            ["Instance"] = u11,
            ["PlaybackState"] = Enum.PlaybackState.Begin,
            ["Completed"] = u30.Event,
            ["Resumed"] = u32.Event,
            ["Stopped"] = u31.Event,
            ["Destroy"] = function(_) --[[ Name: Destroy, Line 321 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u34
                    [3] = u30
                    [4] = u31
                    [5] = u32
                    [6] = u37
                    [7] = u11
                --]]
                if u33 then
                    u33:Disconnect()
                    u33 = nil
                end
                if u34 then
                    u34:Disconnect()
                    u34 = nil
                end
                u30:Destroy()
                u31:Destroy()
                u32:Destroy()
                u30 = nil
                u31 = nil
                u32 = nil
                table.clear(u37)
                u11 = nil
            end
        }
        u34 = u11.Destroying:Connect(function() --[[ Line: 340 ]]
            --[[
            Upvalues:
                [1] = u37
            --]]
            u37.PlaybackState = Enum.PlaybackState.Completed
            u37:Destroy()
        end)
        local u38 = false
        local u39 = 0
        local function u48(p40, u41) --[[ Line: 352 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u37
                [3] = u30
                [4] = u26
                [5] = u38
                [6] = u39
                [7] = u22
                [8] = u35
                [9] = u36
                [10] = u33
                [11] = u14
                [12] = u18
                [13] = u27
                [14] = u48
                [15] = u13
                [16] = u7
                [17] = u15
            --]]
            if u11 == nil or u11:IsDescendantOf(game) ~= false then
                local u42 = p40 or 1
                if u26 == 0 or u26 >= u42 then
                    u39 = u42
                    if u41 then
                        u38 = true
                    end
                    if u22 then
                        u37.PlaybackState = Enum.PlaybackState.Delayed
                        task.wait(u22)
                    end
                    u35 = tick() - u36
                    local v43 = game:GetService("HttpService"):GenerateGUID()
                    local _ = "BoatTween" .. u11:GetFullName() .. v43
                    tick()
                    u33 = u14:Connect(function() --[[ Line: 383 ]]
                        --[[
                        Upvalues:
                            [1] = u36
                            [2] = u35
                            [3] = u18
                            [4] = u41
                            [5] = u27
                            [6] = u11
                            [7] = u33
                            [8] = u48
                            [9] = u42
                            [10] = u13
                            [11] = u7
                            [12] = u15
                        --]]
                        u36 = tick() - u35
                        if u18 <= u36 then
                            if u41 then
                                for v44, v45 in u27 do
                                    u11[v44] = v45(0)
                                end
                            else
                                for v46, v47 in u27 do
                                    u11[v46] = v47(1)
                                end
                            end
                            u33:Disconnect()
                            u33 = nil
                            if u41 then
                                u36 = 0
                                u48(u42 + 1, false)
                                return
                            elseif u13.Reverses then
                                u36 = 0
                                u48(u42, true)
                            else
                                u36 = 0
                                u48(u42 + 1, false)
                            end
                        elseif u41 then
                            u7[math.random(1, 64)](u11, u27, u15, 1 - u36 / u18)
                        else
                            u7[math.random(1, 64)](u11, u27, u15, u36 / u18)
                        end
                    end)
                    u37.PlaybackState = Enum.PlaybackState.Playing
                else
                    u37.PlaybackState = Enum.PlaybackState.Completed
                    u30:Fire()
                    u38 = false
                    u39 = 1
                end
            else
                u37.PlaybackState = Enum.PlaybackState.Completed
                u30:Fire()
                return
            end
        end
        function u37.Play(_) --[[ Line: 421 ]]
            --[[
            Upvalues:
                [1] = u36
                [2] = u48
            --]]
            u36 = 0
            u48(1, false)
        end
        function u37.Stop(_) --[[ Line: 426 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u37
                [3] = u31
            --]]
            if u33 then
                u33:Disconnect()
                u33 = nil
                u37.PlaybackState = Enum.PlaybackState.Cancelled
                u31:Fire()
            end
        end
        function u37.Resume(_) --[[ Line: 435 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u39
                [3] = u38
                [4] = u32
            --]]
            u48(u39, u38)
            u32:Fire()
        end
        return u37
    end
    error("Invalid object to tween:", u11)
end
return v1