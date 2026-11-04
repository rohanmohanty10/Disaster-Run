 

local u1 = game:GetService("RunService")
local v2 = require(script.TweenFunctions)
local u3 = require(script.Lerps)
local u4 = u1.Heartbeat
local v5 = {}
local u6 = {
    ["Heartbeat"] = true,
    ["Stepped"] = true,
    ["RenderStepped"] = true
}
if not u1:IsClient() then
    u6.RenderStepped = nil
end
local u7 = {
    ["FabricAccelerate"] = {
        ["In"] = v2.InFabricAccelerate,
        ["Out"] = v2.OutFabricAccelerate,
        ["InOut"] = v2.InOutFabricAccelerate,
        ["OutIn"] = v2.OutInFabricAccelerate
    },
    ["UWPAccelerate"] = {
        ["In"] = v2.InUWPAccelerate,
        ["Out"] = v2.OutUWPAccelerate,
        ["InOut"] = v2.InOutUWPAccelerate,
        ["OutIn"] = v2.OutInUWPAccelerate
    },
    ["Circ"] = {
        ["In"] = v2.InCirc,
        ["Out"] = v2.OutCirc,
        ["InOut"] = v2.InOutCirc,
        ["OutIn"] = v2.OutInCirc
    },
    ["RevBack"] = {
        ["In"] = v2.InRevBack,
        ["Out"] = v2.OutRevBack,
        ["InOut"] = v2.InOutRevBack,
        ["OutIn"] = v2.OutInRevBack
    },
    ["Spring"] = {
        ["In"] = v2.InSpring,
        ["Out"] = v2.OutSpring,
        ["InOut"] = v2.InOutSpring,
        ["OutIn"] = v2.OutInSpring
    },
    ["Standard"] = {
        ["In"] = v2.InStandard,
        ["Out"] = v2.OutStandard,
        ["InOut"] = v2.InOutStandard,
        ["OutIn"] = v2.OutInStandard
    },
    ["StandardExpressive"] = {
        ["In"] = v2.InStandardExpressive,
        ["Out"] = v2.OutStandardExpressive,
        ["InOut"] = v2.InOutStandardExpressive,
        ["OutIn"] = v2.OutInStandardExpressive
    },
    ["Linear"] = {
        ["In"] = v2.InLinear,
        ["Out"] = v2.OutLinear,
        ["InOut"] = v2.InOutLinear,
        ["OutIn"] = v2.OutInLinear
    },
    ["ExitProductive"] = {
        ["In"] = v2.InExitProductive,
        ["Out"] = v2.OutExitProductive,
        ["InOut"] = v2.InOutExitProductive,
        ["OutIn"] = v2.OutInExitProductive
    },
    ["Deceleration"] = {
        ["In"] = v2.InDeceleration,
        ["Out"] = v2.OutDeceleration,
        ["InOut"] = v2.InOutDeceleration,
        ["OutIn"] = v2.OutInDeceleration
    },
    ["Smoother"] = {
        ["In"] = v2.InSmoother,
        ["Out"] = v2.OutSmoother,
        ["InOut"] = v2.InOutSmoother,
        ["OutIn"] = v2.OutInSmoother
    },
    ["FabricStandard"] = {
        ["In"] = v2.InFabricStandard,
        ["Out"] = v2.OutFabricStandard,
        ["InOut"] = v2.InOutFabricStandard,
        ["OutIn"] = v2.OutInFabricStandard
    },
    ["RidiculousWiggle"] = {
        ["In"] = v2.InRidiculousWiggle,
        ["Out"] = v2.OutRidiculousWiggle,
        ["InOut"] = v2.InOutRidiculousWiggle,
        ["OutIn"] = v2.OutInRidiculousWiggle
    },
    ["MozillaCurve"] = {
        ["In"] = v2.InMozillaCurve,
        ["Out"] = v2.OutMozillaCurve,
        ["InOut"] = v2.InOutMozillaCurve,
        ["OutIn"] = v2.OutInMozillaCurve
    },
    ["Expo"] = {
        ["In"] = v2.InExpo,
        ["Out"] = v2.OutExpo,
        ["InOut"] = v2.InOutExpo,
        ["OutIn"] = v2.OutInExpo
    },
    ["Sine"] = {
        ["In"] = v2.InSine,
        ["Out"] = v2.OutSine,
        ["InOut"] = v2.InOutSine,
        ["OutIn"] = v2.OutInSine
    },
    ["Cubic"] = {
        ["In"] = v2.InCubic,
        ["Out"] = v2.OutCubic,
        ["InOut"] = v2.InOutCubic,
        ["OutIn"] = v2.OutInCubic
    },
    ["EntranceExpressive"] = {
        ["In"] = v2.InEntranceExpressive,
        ["Out"] = v2.OutEntranceExpressive,
        ["InOut"] = v2.InOutEntranceExpressive,
        ["OutIn"] = v2.OutInEntranceExpressive
    },
    ["Elastic"] = {
        ["In"] = v2.InElastic,
        ["Out"] = v2.OutElastic,
        ["InOut"] = v2.InOutElastic,
        ["OutIn"] = v2.OutInElastic
    },
    ["Quint"] = {
        ["In"] = v2.InQuint,
        ["Out"] = v2.OutQuint,
        ["InOut"] = v2.InOutQuint,
        ["OutIn"] = v2.OutInQuint
    },
    ["EntranceProductive"] = {
        ["In"] = v2.InEntranceProductive,
        ["Out"] = v2.OutEntranceProductive,
        ["InOut"] = v2.InOutEntranceProductive,
        ["OutIn"] = v2.OutInEntranceProductive
    },
    ["Bounce"] = {
        ["In"] = v2.InBounce,
        ["Out"] = v2.OutBounce,
        ["InOut"] = v2.InOutBounce,
        ["OutIn"] = v2.OutInBounce
    },
    ["Smooth"] = {
        ["In"] = v2.InSmooth,
        ["Out"] = v2.OutSmooth,
        ["InOut"] = v2.InOutSmooth,
        ["OutIn"] = v2.OutInSmooth
    },
    ["Back"] = {
        ["In"] = v2.InBack,
        ["Out"] = v2.OutBack,
        ["InOut"] = v2.InOutBack,
        ["OutIn"] = v2.OutInBack
    },
    ["Quart"] = {
        ["In"] = v2.InQuart,
        ["Out"] = v2.OutQuart,
        ["InOut"] = v2.InOutQuart,
        ["OutIn"] = v2.OutInQuart
    },
    ["StandardProductive"] = {
        ["In"] = v2.InStandardProductive,
        ["Out"] = v2.OutStandardProductive,
        ["InOut"] = v2.InOutStandardProductive,
        ["OutIn"] = v2.OutInStandardProductive
    },
    ["Quad"] = {
        ["In"] = v2.InQuad,
        ["Out"] = v2.OutQuad,
        ["InOut"] = v2.InOutQuad,
        ["OutIn"] = v2.OutInQuad
    },
    ["FabricDecelerate"] = {
        ["In"] = v2.InFabricDecelerate,
        ["Out"] = v2.OutFabricDecelerate,
        ["InOut"] = v2.InOutFabricDecelerate,
        ["OutIn"] = v2.OutInFabricDecelerate
    },
    ["Acceleration"] = {
        ["In"] = v2.InAcceleration,
        ["Out"] = v2.OutAcceleration,
        ["InOut"] = v2.InOutAcceleration,
        ["OutIn"] = v2.OutInAcceleration
    },
    ["SoftSpring"] = {
        ["In"] = v2.InSoftSpring,
        ["Out"] = v2.OutSoftSpring,
        ["InOut"] = v2.InOutSoftSpring,
        ["OutIn"] = v2.OutInSoftSpring
    },
    ["ExitExpressive"] = {
        ["In"] = v2.InExitExpressive,
        ["Out"] = v2.OutExitExpressive,
        ["InOut"] = v2.InOutExitExpressive,
        ["OutIn"] = v2.OutInExitExpressive
    },
    ["Sharp"] = {
        ["In"] = v2.InSharp,
        ["Out"] = v2.OutSharp,
        ["InOut"] = v2.InOutSharp,
        ["OutIn"] = v2.OutInSharp
    }
}
local function u11(p8) --[[ Line: 316 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v9 = math.max(p8 or 0.03, 0)
    local v10 = v9
    while v9 > 0 do
        v9 = v9 - u4:Wait()
    end
    return v10 - v9
end
function v5.Create(_, u12, p13) --[[ Line: 327 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u1
        [3] = u7
        [4] = u3
        [5] = u11
    --]]
    if not u12 or typeof(u12) ~= "Instance" then
        return warn("Invalid object to tween:", u12)
    end
    local u14 = type(p13) == "table" and (p13 or {}) or {}
    local u15 = u6[u14.StepType] and u1[u14.StepType] or u1.Stepped
    local u16 = u7[u14.EasingStyle or "Quad"][u14.EasingDirection or "In"]
    local v17 = u14.Time
    local v18 = type(v17) == "number" and (u14.Time or 1) or 1
    local u19 = math.max(v18, 0.001)
    local v20 = u14.Goal
    local v21 = type(v20) == "table" and (u14.Goal or {}) or {}
    local v22 = u14.DelayTime
    local u23
    if type(v22) == "number" and u14.DelayTime > 0.027 then
        u23 = u14.DelayTime
    else
        u23 = false
    end
    local v24 = u14.RepeatCount
    local v25
    if type(v24) == "number" then
        local v26 = u14.RepeatCount
        v25 = math.max(v26, -1) or 0
    else
        v25 = 0
    end
    local u27 = v25 + 1
    local u28 = {}
    for v29, v30 in pairs(v21) do
        u28[v29] = u3[typeof(v30)](u12[v29], v30)
    end
    local u31 = Instance.new("BindableEvent")
    local u32 = Instance.new("BindableEvent")
    local u33 = Instance.new("BindableEvent")
    local u34 = nil
    local u35 = os.clock()
    local u36 = 0
    local u37 = {
        ["Instance"] = u12,
        ["PlaybackState"] = Enum.PlaybackState.Begin,
        ["Completed"] = u31.Event,
        ["Resumed"] = u33.Event,
        ["Stopped"] = u32.Event,
        ["Destroy"] = function() --[[ Name: Destroy, Line 365 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u31
                [3] = u32
                [4] = u33
                [5] = u37
            --]]
            if u34 then
                u34:Disconnect()
                u34 = nil
            end
            u31:Destroy()
            u32:Destroy()
            u33:Destroy()
            u37 = nil
        end
    }
    local u38 = false
    local u39 = 0
    local function u51(p40, u41) --[[ Line: 380 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u27
            [3] = u37
            [4] = u31
            [5] = u38
            [6] = u39
            [7] = u23
            [8] = u11
            [9] = u35
            [10] = u36
            [11] = u15
            [12] = u19
            [13] = u28
            [14] = u12
            [15] = u51
            [16] = u14
            [17] = u16
        --]]
        if u34 then
            u34:Disconnect()
            u34 = nil
        end
        local u42 = p40 or 1
        if u27 == 0 or u27 >= u42 then
            u39 = u42
            if u41 then
                u38 = true
            end
            if u23 then
                u37.PlaybackState = Enum.PlaybackState.Delayed;
                (u23 < 2 and u11 or wait)(u23)
            end
            u35 = os.clock() - u36
            u34 = u15:Connect(function() --[[ Line: 409 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u35
                    [3] = u19
                    [4] = u41
                    [5] = u28
                    [6] = u12
                    [7] = u34
                    [8] = u51
                    [9] = u42
                    [10] = u14
                    [11] = u16
                --]]
                u36 = os.clock() - u35
                if u19 <= u36 then
                    if u41 then
                        for v43, v44 in pairs(u28) do
                            u12[v43] = v44(0)
                        end
                    else
                        for v45, v46 in pairs(u28) do
                            u12[v45] = v46(1)
                        end
                    end
                    u34:Disconnect()
                    u34 = nil
                    if u41 then
                        u36 = 0
                        u51(u42 + 1, false)
                        return
                    elseif u14.Reverses then
                        u36 = 0
                        u51(u42, true)
                    else
                        u36 = 0
                        u51(u42 + 1, false)
                    end
                else
                    local v47 = u16(u41 and 1 - u36 / u19 or u36 / u19)
                    local v48 = math.clamp(v47, 0, 1)
                    for v49, v50 in pairs(u28) do
                        u12[v49] = v50(v48)
                    end
                    return
                end
            end)
            u37.PlaybackState = Enum.PlaybackState.Playing
        else
            u37.PlaybackState = Enum.PlaybackState.Completed
            u31:Fire()
            u38 = false
            u39 = 1
        end
    end
    function u37.Play() --[[ Line: 449 ]]
        --[[
        Upvalues:
            [1] = u36
            [2] = u51
        --]]
        u36 = 0
        u51(1, false)
    end
    function u37.Stop() --[[ Line: 454 ]]
        --[[
        Upvalues:
            [1] = u34
            [2] = u37
            [3] = u32
        --]]
        if u34 then
            u34:Disconnect()
            u34 = nil
            u37.PlaybackState = Enum.PlaybackState.Cancelled
            u32:Fire()
        end
    end
    function u37.Resume() --[[ Line: 463 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u39
            [3] = u38
            [4] = u33
        --]]
        u51(u39, u38)
        u33:Fire()
    end
    return u37
end
return v5