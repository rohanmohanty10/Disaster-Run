 

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
local u5 = require(game.ReplicatedStorage.Modules.Trove)
local u6 = {
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
local u7 = require(script.Lerps)
function v1.Create(_, u8, p9) --[[ Line: 181 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
        [3] = u6
        [4] = u7
        [5] = u5
    --]]
    if u8 and typeof(u8) == "Instance" then
        local u10 = type(p9) == "table" and (p9 or {}) or {}
        local u11 = u3[u10.StepType] and u2[u10.StepType] or u2.Heartbeat
        local u12 = u6[u10.EasingStyle or "Quad"][u10.EasingDirection or "In"]
        local v13 = u10.Time
        local v14 = type(v13) == "number" and (u10.Time or 1) or 1
        local u15 = math.clamp(v14, 0, 9999999999)
        local v16 = u10.Goal
        local u17 = type(v16) == "table" and (u10.Goal or {}) or {}
        local v18 = u10.DelayTime
        local u19
        if type(v18) == "number" and u10.DelayTime > 0.027 then
            u19 = u10.DelayTime
        else
            u19 = false
        end
        local v20 = u10.RepeatCount
        local v21
        if type(v20) == "number" then
            local v22 = u10.RepeatCount
            v21 = math.clamp(v22, -1, 999999999) or 0
        else
            v21 = 0
        end
        local u23 = v21 + 1
        local u24 = u10.CustomEventStepFreq
        local u25 = {}
        if u17.CustomEventStepFreq then
            u17.CustomEventStepFreq = nil
        end
        for v26, v27 in u17 do
            u25[v26] = u7[typeof(v27)](u8[v26], v27)
        end
        local u28 = u5.new()
        local u29 = Instance.new("BindableEvent", script)
        u29.Name = "btCompleted"
        local u30 = Instance.new("BindableEvent", script)
        u30.Name = "btStopped"
        local u31 = Instance.new("BindableEvent", script)
        u31.Name = "btResume"
        local u32
        if u24 then
            u32 = Instance.new("BindableEvent", script)
            u32.Name = "CustomEventStepFreq"
            u28:Add(task.spawn(function() --[[ Line: 228 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u32
                --]]
                while task.wait(u24) do
                    u32:Fire()
                end
            end))
            u28:Add(u32)
        else
            u32 = nil
        end
        local u33 = nil
        local u34 = tick()
        local u35 = 0
        local u36 = {
            ["Instance"] = u8,
            ["PlaybackState"] = Enum.PlaybackState.Begin,
            ["Completed"] = u29.Event,
            ["Resumed"] = u31.Event,
            ["Stopped"] = u30.Event
        }
        local u37 = false
        u28:Add(u29)
        u28:Add(u30)
        u28:Add(u31)
        function u36.Destroy(_) --[[ Line: 278 ]]
            --[[
            Upvalues:
                [1] = u37
                [2] = u36
                [3] = u29
                [4] = u28
                [5] = u25
                [6] = u17
            --]]
            if u37 ~= true then
                u37 = true
                if u36 then
                    u36.PlaybackState = Enum.PlaybackState.Completed
                end
                if u29 then
                    u29:Fire()
                    if u29 then
                        u29:Destroy()
                    end
                    u29 = nil
                end
                if u36 then
                    u36:Destroy()
                end
            end
            if u28 ~= nil then
                u28:Destroy()
                table.clear(u25)
                table.clear(u17)
                table.clear(u36)
                u36 = nil
                u28 = nil
            end
        end
        u28:Connect(u8.Destroying, function() --[[ Line: 292 ]]
            --[[
            Upvalues:
                [1] = u36
            --]]
            u36:Destroy()
        end)
        local u38 = false
        local u39 = 0
        local function u56(p40, u41) --[[ Line: 301 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u37
                [3] = u36
                [4] = u29
                [5] = u23
                [6] = u38
                [7] = u39
                [8] = u19
                [9] = u34
                [10] = u35
                [11] = u32
                [12] = u11
                [13] = u33
                [14] = u15
                [15] = u25
                [16] = u56
                [17] = u10
                [18] = u12
                [19] = u28
            --]]
            if u8 == nil or u8:IsDescendantOf(game) ~= false then
                local u42 = p40 or 1
                if u23 == 0 or u23 >= u42 then
                    u39 = u42
                    if u41 then
                        u38 = true
                    end
                    if u19 then
                        u36.PlaybackState = Enum.PlaybackState.Delayed
                        task.wait(u19)
                    end
                    u34 = tick() - u35
                    local v43 = game:GetService("HttpService"):GenerateGUID()
                    local _ = "BoatTween" .. u8:GetFullName() .. v43
                    tick()
                    if u32 then
                        u11 = u32.Event
                    end
                    u33 = u11:Connect(function() --[[ Line: 336 ]]
                        --[[
                        Upvalues:
                            [1] = u35
                            [2] = u34
                            [3] = u15
                            [4] = u41
                            [5] = u25
                            [6] = u8
                            [7] = u33
                            [8] = u56
                            [9] = u42
                            [10] = u10
                            [11] = u12
                        --]]
                        u35 = tick() - u34
                        local _, _ = pcall(function() --[[ Line: 338 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                                [2] = u15
                                [3] = u41
                                [4] = u25
                                [5] = u8
                                [6] = u33
                                [7] = u56
                                [8] = u42
                                [9] = u10
                                [10] = u12
                            --]]
                            if u15 <= u35 then
                                if u41 then
                                    for v44, v45 in u25 do
                                        u8[v44] = v45(0)
                                    end
                                else
                                    for v46, v47 in u25 do
                                        u8[v46] = v47(1)
                                    end
                                end
                                u33:Disconnect()
                                u33 = nil
                                if u41 then
                                    u35 = 0
                                    u56(u42 + 1, false)
                                    return
                                elseif u10.Reverses then
                                    u35 = 0
                                    u56(u42, true)
                                else
                                    u35 = 0
                                    u56(u42 + 1, false)
                                end
                            elseif u41 then
                                for v48, v49 in u25 do
                                    local v50 = u8
                                    local v51 = u12(1 - u35 / u15)
                                    v50[v48] = v49((math.clamp(v51, 0, 1)))
                                end
                            else
                                for v52, v53 in u25 do
                                    local v54 = u8
                                    local v55 = u12(u35 / u15)
                                    v54[v52] = v53((math.clamp(v55, 0, 1)))
                                end
                            end
                        end)
                    end)
                    u36.PlaybackState = Enum.PlaybackState.Playing
                    u28:Add(u33)
                else
                    if u37 ~= true then
                        u37 = true
                        if u36 then
                            u36.PlaybackState = Enum.PlaybackState.Completed
                        end
                        if u29 then
                            u29:Fire()
                            if u29 then
                                u29:Destroy()
                            end
                            u29 = nil
                        end
                        if u36 then
                            u36:Destroy()
                        end
                    end
                    u38 = false
                    u39 = 1
                end
            else
                if u37 ~= true then
                    u37 = true
                    if u36 then
                        u36.PlaybackState = Enum.PlaybackState.Completed
                    end
                    if u29 then
                        u29:Fire()
                        if u29 then
                            u29:Destroy()
                        end
                        u29 = nil
                    end
                    if u36 then
                        u36:Destroy()
                    end
                end
                return
            end
        end
        function u36.Play(_) --[[ Line: 380 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u56
            --]]
            u35 = 0
            u56(1, false)
        end
        function u36.Stop(_) --[[ Line: 385 ]]
            --[[
            Upvalues:
                [1] = u33
                [2] = u36
                [3] = u30
            --]]
            if u33 then
                u33:Disconnect()
                u33 = nil
                u36.PlaybackState = Enum.PlaybackState.Cancelled
                u30:Fire()
            end
        end
        function u36.Resume(_) --[[ Line: 394 ]]
            --[[
            Upvalues:
                [1] = u56
                [2] = u39
                [3] = u38
                [4] = u31
            --]]
            u56(u39, u38)
            u31:Fire()
        end
        return u36
    end
    error("Invalid object to tween:", u8)
end
return v1