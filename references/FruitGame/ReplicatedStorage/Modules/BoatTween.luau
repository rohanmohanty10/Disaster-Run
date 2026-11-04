 

local v1 = {}
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = tick
local u5 = typeof
local u6 = math.clamp
local u7 = table.clear
local u8 = task.spawn
local u9 = task.wait
local u10 = {
    ["Heartbeat"] = true,
    ["Stepped"] = true,
    ["RenderStepped"] = true
}
if not u2:IsClient() then
    u10.RenderStepped = nil
end
local v11 = require(script.TweenFunctions)
local u12 = require(game.ReplicatedStorage.Modules.Trove)
local u13 = require(v3.Modules.Shared.Signals.GoodSignal)
local u14 = {
    ["Linear"] = {
        ["In"] = v11.Linear,
        ["Out"] = v11.Linear,
        ["InOut"] = v11.Linear
    },
    ["Quad"] = {
        ["In"] = v11.InQuad,
        ["Out"] = v11.OutQuad,
        ["InOut"] = v11.InOutQuad
    },
    ["Cubic"] = {
        ["In"] = v11.InCubic,
        ["Out"] = v11.OutCubic,
        ["InOut"] = v11.InOutCubic
    },
    ["Quart"] = {
        ["In"] = v11.InQuart,
        ["Out"] = v11.OutQuart,
        ["InOut"] = v11.InOutQuart
    },
    ["Quint"] = {
        ["In"] = v11.InQuint,
        ["Out"] = v11.OutQuint,
        ["InOut"] = v11.InOutQuint
    },
    ["Sine"] = {
        ["In"] = v11.InSine,
        ["Out"] = v11.OutSine,
        ["InOut"] = v11.InOutSine
    },
    ["Exponential"] = {
        ["In"] = v11.InExponential,
        ["Out"] = v11.OutExponential,
        ["InOut"] = v11.InOutExponential
    },
    ["Expo"] = {
        ["In"] = v11.InExponential,
        ["Out"] = v11.OutExponential,
        ["InOut"] = v11.InOutExponential
    },
    ["Circular"] = {
        ["In"] = v11.InCircular,
        ["Out"] = v11.OutCircular,
        ["InOut"] = v11.InOutCircular
    },
    ["Elastic"] = {
        ["In"] = v11.InElastic,
        ["Out"] = v11.OutElastic,
        ["InOut"] = v11.InOutElastic
    },
    ["Back"] = {
        ["In"] = v11.InBack,
        ["Out"] = v11.OutBack,
        ["InOut"] = v11.InOutBack
    },
    ["Bounce"] = {
        ["In"] = v11.InBounce,
        ["Out"] = v11.OutBounce,
        ["InOut"] = v11.InOutBounce
    },
    ["Smooth"] = {
        ["In"] = v11.InSmooth,
        ["Out"] = v11.OutSmooth,
        ["InOut"] = v11.InOutSmooth
    },
    ["Smoother"] = {
        ["In"] = v11.InSmoother,
        ["Out"] = v11.OutSmoother,
        ["InOut"] = v11.InOutSmoother
    },
    ["RidiculousWiggle"] = {
        ["In"] = v11.InRidiculousWiggle,
        ["Out"] = v11.OutRidiculousWiggle,
        ["InOut"] = v11.InOutRidiculousWiggle
    },
    ["RevBack"] = {
        ["In"] = v11.InRevBack,
        ["Out"] = v11.OutRevBack,
        ["InOut"] = v11.InOutRevBack
    },
    ["Spring"] = {
        ["In"] = v11.InSpring,
        ["Out"] = v11.OutSpring,
        ["InOut"] = v11.InOutSpring
    },
    ["SoftSpring"] = {
        ["In"] = v11.InSoftSpring,
        ["Out"] = v11.OutSoftSpring,
        ["InOut"] = v11.InOutSoftSpring
    },
    ["Sharp"] = {
        ["In"] = v11.InSharp,
        ["Out"] = v11.OutSharp,
        ["InOut"] = v11.InOutSharp
    },
    ["Acceleration"] = {
        ["In"] = v11.InAcceleration,
        ["Out"] = v11.OutAcceleration,
        ["InOut"] = v11.InOutAcceleration
    },
    ["Standard"] = {
        ["In"] = v11.InStandard,
        ["Out"] = v11.OutStandard,
        ["InOut"] = v11.InOutStandard
    },
    ["Deceleration"] = {
        ["In"] = v11.InDeceleration,
        ["Out"] = v11.OutDeceleration,
        ["InOut"] = v11.InOutDeceleration
    },
    ["FabricStandard"] = {
        ["In"] = v11.InFabricStandard,
        ["Out"] = v11.OutFabricStandard,
        ["InOut"] = v11.InOutFabricStandard
    },
    ["FabricAccelerate"] = {
        ["In"] = v11.InFabricAccelerate,
        ["Out"] = v11.OutFabricAccelerate,
        ["InOut"] = v11.InOutFabricAccelerate
    },
    ["FabricDecelerate"] = {
        ["In"] = v11.InFabricDecelerate,
        ["Out"] = v11.OutFabricDecelerate,
        ["InOut"] = v11.InOutFabricDecelerate
    },
    ["UWPAccelerate"] = {
        ["In"] = v11.InUWPAccelerate,
        ["Out"] = v11.OutUWPAccelerate,
        ["InOut"] = v11.InOutUWPAccelerate
    },
    ["StandardProductive"] = {
        ["In"] = v11.InStandardProductive,
        ["Out"] = v11.OutStandardProductive,
        ["InOut"] = v11.InOutStandardProductive
    },
    ["EntranceProductive"] = {
        ["In"] = v11.InEntranceProductive,
        ["Out"] = v11.OutEntranceProductive,
        ["InOut"] = v11.InOutEntranceProductive
    },
    ["ExitProductive"] = {
        ["In"] = v11.InExitProductive,
        ["Out"] = v11.OutExitProductive,
        ["InOut"] = v11.InOutExitProductive
    },
    ["StandardExpressive"] = {
        ["In"] = v11.InStandardExpressive,
        ["Out"] = v11.OutStandardExpressive,
        ["InOut"] = v11.InOutStandardExpressive
    },
    ["EntranceExpressive"] = {
        ["In"] = v11.InEntranceExpressive,
        ["Out"] = v11.OutEntranceExpressive,
        ["InOut"] = v11.InOutEntranceExpressive
    },
    ["ExitExpressive"] = {
        ["In"] = v11.InExitExpressive,
        ["Out"] = v11.OutExitExpressive,
        ["InOut"] = v11.InOutExitExpressive
    },
    ["MozillaCurve"] = {
        ["In"] = v11.InMozillaCurve,
        ["Out"] = v11.OutMozillaCurve,
        ["InOut"] = v11.InOutMozillaCurve
    }
}
local u15 = require(script.Lerps)
function v1.Create(_, u16, p17) --[[ Line: 199 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u10
        [3] = u2
        [4] = u14
        [5] = u6
        [6] = u15
        [7] = u12
        [8] = u13
        [9] = u8
        [10] = u9
        [11] = u4
        [12] = u7
    --]]
    if u16 and u5(u16) == "Instance" then
        local v18 = type(p17) == "table" and (p17 or {}) or {}
        local u19 = u10[v18.StepType] and u2[v18.StepType] or u2.Heartbeat
        local u20 = u14[v18.EasingStyle or "Quad"][v18.EasingDirection or "In"]
        local v21 = v18.Time
        local u22 = u6(type(v21) == "number" and (v18.Time or 1) or 1, 0, 9999999999)
        local u23 = 1 / u22
        local v24 = v18.Goal
        local u25 = type(v24) == "table" and (v18.Goal or {}) or {}
        local v26 = v18.DelayTime
        local u27
        if type(v26) == "number" and v18.DelayTime > 0.027 then
            u27 = v18.DelayTime
        else
            u27 = false
        end
        local v28 = v18.RepeatCount
        local u29 = (type(v28) == "number" and (u6(v18.RepeatCount, -1, 999999999) or 0) or 0) + 1
        local u30 = v18.CustomEventStepFreq
        local u31 = v18.Reverses
        local u32 = {}
        local u33 = {}
        local u34 = 0
        if u25.CustomEventStepFreq then
            u25.CustomEventStepFreq = nil
        end
        for u35, v36 in u25 do
            local v37, v38 = pcall(function() --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u35
                --]]
                return u16[u35]
            end)
            if not v37 or v38 == nil then
                error("Property \'" .. u35 .. "\' does not exist or is not accessible on " .. tostring(u16))
            end
            u34 = u34 + 1
            u32[u34] = u35
            u33[u34] = u15[u5(v36)](v38, v36)
        end
        local u39 = u12.new()
        local u40 = u39:Construct(u13)
        local u41 = u39:Construct(u13)
        local u42 = u39:Construct(u13)
        local u43
        if u30 then
            u43 = u39:Construct(u13)
            u39:Add(u8(function() --[[ Line: 255 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u30
                    [3] = u43
                --]]
                while u9(u30) do
                    u43:Fire()
                end
            end))
        else
            u43 = nil
        end
        local u44 = nil
        local u45 = u4()
        local u46 = 0
        local u47 = {
            ["Instance"] = u16,
            ["PlaybackState"] = Enum.PlaybackState.Begin,
            ["Completed"] = u40,
            ["Resumed"] = u42,
            ["Stopped"] = u41
        }
        local u48 = false
        local u49 = false
        function u47.Destroy(_) --[[ Line: 298 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u39
                [3] = u48
                [4] = u44
                [5] = u41
                [6] = u42
                [7] = u40
                [8] = u7
                [9] = u32
                [10] = u33
                [11] = u25
                [12] = u47
            --]]
            if u49 then
                return
            else
                u49 = true
                if u39 ~= nil then
                    if not u48 then
                        u48 = true
                    end
                    if u44 then
                        u44:Disconnect()
                        u44 = nil
                    end
                    if u41 then
                        u41:DisconnectAll()
                    end
                    if u42 then
                        u42:DisconnectAll()
                    end
                    if u40 then
                        u40:DisconnectAll()
                    end
                    u39:Destroy()
                    u39 = nil
                    u7(u32)
                    u7(u33)
                    u7(u25)
                    u7(u47)
                end
            end
        end
        u39:Connect(u16.Destroying, function() --[[ Line: 336 ]]
            --[[
            Upvalues:
                [1] = u47
            --]]
            u47:Destroy()
        end)
        local u50 = false
        local u51 = 0
        local function u64(p52, u53) --[[ Line: 343 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u48
                [3] = u47
                [4] = u40
                [5] = u49
                [6] = u29
                [7] = u50
                [8] = u51
                [9] = u27
                [10] = u9
                [11] = u45
                [12] = u4
                [13] = u46
                [14] = u43
                [15] = u19
                [16] = u44
                [17] = u22
                [18] = u34
                [19] = u32
                [20] = u33
                [21] = u64
                [22] = u31
                [23] = u23
                [24] = u20
                [25] = u39
            --]]
            if u16 == nil or u16:IsDescendantOf(game) ~= false then
                local u54 = p52 or 1
                if u29 == 0 or u29 >= u54 then
                    u51 = u54
                    if u53 then
                        u50 = true
                    end
                    if u27 then
                        u47.PlaybackState = Enum.PlaybackState.Delayed
                        u9(u27)
                    end
                    u45 = u4() - u46
                    if u43 then
                        u19 = u43
                    end
                    if u49 ~= true then
                        u44 = u19:Connect(function() --[[ Line: 379 ]]
                            --[[
                            Upvalues:
                                [1] = u46
                                [2] = u4
                                [3] = u45
                                [4] = u22
                                [5] = u53
                                [6] = u34
                                [7] = u16
                                [8] = u32
                                [9] = u33
                                [10] = u44
                                [11] = u64
                                [12] = u54
                                [13] = u31
                                [14] = u23
                                [15] = u20
                            --]]
                            u46 = u4() - u45
                            if u22 <= u46 then
                                if u53 then
                                    for v55 = 1, u34 do
                                        u16[u32[v55]] = u33[v55](0)
                                    end
                                else
                                    for v56 = 1, u34 do
                                        u16[u32[v56]] = u33[v56](1)
                                    end
                                end
                                u44:Disconnect()
                                u44 = nil
                                u46 = 0
                                if u53 then
                                    u64(u54 + 1, false)
                                    return
                                elseif u31 then
                                    u64(u54, true)
                                else
                                    u64(u54 + 1, false)
                                end
                            else
                                local v57 = u46 * u23
                                if u53 then
                                    local v58 = u20(1 - v57)
                                    local v59 = v58 > 1 and 1 or (v58 < 0 and 0 or v58)
                                    for v60 = 1, u34 do
                                        u16[u32[v60]] = u33[v60](v59)
                                    end
                                else
                                    local v61 = u20(v57)
                                    local v62 = v61 > 1 and 1 or (v61 < 0 and 0 or v61)
                                    for v63 = 1, u34 do
                                        u16[u32[v63]] = u33[v63](v62)
                                    end
                                end
                            end
                        end)
                        u47.PlaybackState = Enum.PlaybackState.Playing
                        u39:Add(u44)
                    end
                else
                    if not u48 then
                        u48 = true
                        if u47 then
                            u47.PlaybackState = Enum.PlaybackState.Completed
                        end
                        if u40 then
                            u40:Fire()
                        end
                        if not u49 and (u47 and u47.Destroy) then
                            u47:Destroy()
                        end
                    end
                    u50 = false
                    u51 = 1
                    return
                end
            else
                if not u48 then
                    u48 = true
                    if u47 then
                        u47.PlaybackState = Enum.PlaybackState.Completed
                    end
                    if u40 then
                        u40:Fire()
                    end
                    if not u49 and (u47 and u47.Destroy) then
                        u47:Destroy()
                    end
                end
                return
            end
        end
        function u47.Play(_) --[[ Line: 441 ]]
            --[[
            Upvalues:
                [1] = u46
                [2] = u64
            --]]
            u46 = 0
            u64(1, false)
        end
        function u47.Stop(_) --[[ Line: 446 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u47
                [3] = u41
            --]]
            if u44 then
                u44:Disconnect()
                u44 = nil
                u47.PlaybackState = Enum.PlaybackState.Cancelled
                u41:Fire()
            end
        end
        function u47.Resume(_) --[[ Line: 455 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u51
                [3] = u50
                [4] = u42
            --]]
            u64(u51, u50)
            u42:Fire()
        end
        return u47
    end
    error("Invalid object to tween:", u16)
end
return v1