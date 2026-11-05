 

 

local l__RunService__1 = game:GetService("RunService");
local l__TweenFunctions__2 = require(script.TweenFunctions);
local l__Lerps__3 = require(script.Lerps);
local l__Heartbeat__4 = l__RunService__1.Heartbeat;
local v1 = {};
local u2 = {
    Heartbeat = true,
    Stepped = true,
    RenderStepped = true
};
if not l__RunService__1:IsClient() then
    u2.RenderStepped = nil;
end;
local u3 = {
    FabricAccelerate = {
        In = l__TweenFunctions__2.InFabricAccelerate,
        Out = l__TweenFunctions__2.OutFabricAccelerate,
        InOut = l__TweenFunctions__2.InOutFabricAccelerate,
        OutIn = l__TweenFunctions__2.OutInFabricAccelerate
    },
    UWPAccelerate = {
        In = l__TweenFunctions__2.InUWPAccelerate,
        Out = l__TweenFunctions__2.OutUWPAccelerate,
        InOut = l__TweenFunctions__2.InOutUWPAccelerate,
        OutIn = l__TweenFunctions__2.OutInUWPAccelerate
    },
    Circ = {
        In = l__TweenFunctions__2.InCirc,
        Out = l__TweenFunctions__2.OutCirc,
        InOut = l__TweenFunctions__2.InOutCirc,
        OutIn = l__TweenFunctions__2.OutInCirc
    },
    RevBack = {
        In = l__TweenFunctions__2.InRevBack,
        Out = l__TweenFunctions__2.OutRevBack,
        InOut = l__TweenFunctions__2.InOutRevBack,
        OutIn = l__TweenFunctions__2.OutInRevBack
    },
    Spring = {
        In = l__TweenFunctions__2.InSpring,
        Out = l__TweenFunctions__2.OutSpring,
        InOut = l__TweenFunctions__2.InOutSpring,
        OutIn = l__TweenFunctions__2.OutInSpring
    },
    Standard = {
        In = l__TweenFunctions__2.InStandard,
        Out = l__TweenFunctions__2.OutStandard,
        InOut = l__TweenFunctions__2.InOutStandard,
        OutIn = l__TweenFunctions__2.OutInStandard
    },
    StandardExpressive = {
        In = l__TweenFunctions__2.InStandardExpressive,
        Out = l__TweenFunctions__2.OutStandardExpressive,
        InOut = l__TweenFunctions__2.InOutStandardExpressive,
        OutIn = l__TweenFunctions__2.OutInStandardExpressive
    },
    Linear = {
        In = l__TweenFunctions__2.InLinear,
        Out = l__TweenFunctions__2.OutLinear,
        InOut = l__TweenFunctions__2.InOutLinear,
        OutIn = l__TweenFunctions__2.OutInLinear
    },
    ExitProductive = {
        In = l__TweenFunctions__2.InExitProductive,
        Out = l__TweenFunctions__2.OutExitProductive,
        InOut = l__TweenFunctions__2.InOutExitProductive,
        OutIn = l__TweenFunctions__2.OutInExitProductive
    },
    Deceleration = {
        In = l__TweenFunctions__2.InDeceleration,
        Out = l__TweenFunctions__2.OutDeceleration,
        InOut = l__TweenFunctions__2.InOutDeceleration,
        OutIn = l__TweenFunctions__2.OutInDeceleration
    },
    Smoother = {
        In = l__TweenFunctions__2.InSmoother,
        Out = l__TweenFunctions__2.OutSmoother,
        InOut = l__TweenFunctions__2.InOutSmoother,
        OutIn = l__TweenFunctions__2.OutInSmoother
    },
    FabricStandard = {
        In = l__TweenFunctions__2.InFabricStandard,
        Out = l__TweenFunctions__2.OutFabricStandard,
        InOut = l__TweenFunctions__2.InOutFabricStandard,
        OutIn = l__TweenFunctions__2.OutInFabricStandard
    },
    RidiculousWiggle = {
        In = l__TweenFunctions__2.InRidiculousWiggle,
        Out = l__TweenFunctions__2.OutRidiculousWiggle,
        InOut = l__TweenFunctions__2.InOutRidiculousWiggle,
        OutIn = l__TweenFunctions__2.OutInRidiculousWiggle
    },
    MozillaCurve = {
        In = l__TweenFunctions__2.InMozillaCurve,
        Out = l__TweenFunctions__2.OutMozillaCurve,
        InOut = l__TweenFunctions__2.InOutMozillaCurve,
        OutIn = l__TweenFunctions__2.OutInMozillaCurve
    },
    Expo = {
        In = l__TweenFunctions__2.InExpo,
        Out = l__TweenFunctions__2.OutExpo,
        InOut = l__TweenFunctions__2.InOutExpo,
        OutIn = l__TweenFunctions__2.OutInExpo
    },
    Sine = {
        In = l__TweenFunctions__2.InSine,
        Out = l__TweenFunctions__2.OutSine,
        InOut = l__TweenFunctions__2.InOutSine,
        OutIn = l__TweenFunctions__2.OutInSine
    },
    Cubic = {
        In = l__TweenFunctions__2.InCubic,
        Out = l__TweenFunctions__2.OutCubic,
        InOut = l__TweenFunctions__2.InOutCubic,
        OutIn = l__TweenFunctions__2.OutInCubic
    },
    EntranceExpressive = {
        In = l__TweenFunctions__2.InEntranceExpressive,
        Out = l__TweenFunctions__2.OutEntranceExpressive,
        InOut = l__TweenFunctions__2.InOutEntranceExpressive,
        OutIn = l__TweenFunctions__2.OutInEntranceExpressive
    },
    Elastic = {
        In = l__TweenFunctions__2.InElastic,
        Out = l__TweenFunctions__2.OutElastic,
        InOut = l__TweenFunctions__2.InOutElastic,
        OutIn = l__TweenFunctions__2.OutInElastic
    },
    Quint = {
        In = l__TweenFunctions__2.InQuint,
        Out = l__TweenFunctions__2.OutQuint,
        InOut = l__TweenFunctions__2.InOutQuint,
        OutIn = l__TweenFunctions__2.OutInQuint
    },
    EntranceProductive = {
        In = l__TweenFunctions__2.InEntranceProductive,
        Out = l__TweenFunctions__2.OutEntranceProductive,
        InOut = l__TweenFunctions__2.InOutEntranceProductive,
        OutIn = l__TweenFunctions__2.OutInEntranceProductive
    },
    Bounce = {
        In = l__TweenFunctions__2.InBounce,
        Out = l__TweenFunctions__2.OutBounce,
        InOut = l__TweenFunctions__2.InOutBounce,
        OutIn = l__TweenFunctions__2.OutInBounce
    },
    Smooth = {
        In = l__TweenFunctions__2.InSmooth,
        Out = l__TweenFunctions__2.OutSmooth,
        InOut = l__TweenFunctions__2.InOutSmooth,
        OutIn = l__TweenFunctions__2.OutInSmooth
    },
    Back = {
        In = l__TweenFunctions__2.InBack,
        Out = l__TweenFunctions__2.OutBack,
        InOut = l__TweenFunctions__2.InOutBack,
        OutIn = l__TweenFunctions__2.OutInBack
    },
    Quart = {
        In = l__TweenFunctions__2.InQuart,
        Out = l__TweenFunctions__2.OutQuart,
        InOut = l__TweenFunctions__2.InOutQuart,
        OutIn = l__TweenFunctions__2.OutInQuart
    },
    StandardProductive = {
        In = l__TweenFunctions__2.InStandardProductive,
        Out = l__TweenFunctions__2.OutStandardProductive,
        InOut = l__TweenFunctions__2.InOutStandardProductive,
        OutIn = l__TweenFunctions__2.OutInStandardProductive
    },
    Quad = {
        In = l__TweenFunctions__2.InQuad,
        Out = l__TweenFunctions__2.OutQuad,
        InOut = l__TweenFunctions__2.InOutQuad,
        OutIn = l__TweenFunctions__2.OutInQuad
    },
    FabricDecelerate = {
        In = l__TweenFunctions__2.InFabricDecelerate,
        Out = l__TweenFunctions__2.OutFabricDecelerate,
        InOut = l__TweenFunctions__2.InOutFabricDecelerate,
        OutIn = l__TweenFunctions__2.OutInFabricDecelerate
    },
    Acceleration = {
        In = l__TweenFunctions__2.InAcceleration,
        Out = l__TweenFunctions__2.OutAcceleration,
        InOut = l__TweenFunctions__2.InOutAcceleration,
        OutIn = l__TweenFunctions__2.OutInAcceleration
    },
    SoftSpring = {
        In = l__TweenFunctions__2.InSoftSpring,
        Out = l__TweenFunctions__2.OutSoftSpring,
        InOut = l__TweenFunctions__2.InOutSoftSpring,
        OutIn = l__TweenFunctions__2.OutInSoftSpring
    },
    ExitExpressive = {
        In = l__TweenFunctions__2.InExitExpressive,
        Out = l__TweenFunctions__2.OutExitExpressive,
        InOut = l__TweenFunctions__2.InOutExitExpressive,
        OutIn = l__TweenFunctions__2.OutInExitExpressive
    },
    Sharp = {
        In = l__TweenFunctions__2.InSharp,
        Out = l__TweenFunctions__2.OutSharp,
        InOut = l__TweenFunctions__2.InOutSharp,
        OutIn = l__TweenFunctions__2.OutInSharp
    }
};
local function u7(p4) --[[ Line: 316 ]]
    -- upvalues: l__Heartbeat__4 (copy)
    local v5 = math.max(p4 or 0.03, 0);
    local v6 = v5;
    while v5 > 0 do
        v5 = v5 - l__Heartbeat__4:Wait();
    end;
    return v6 - v5;
end;
function v1.Create(_, u8, p9) --[[ Line: 327 ]]
    -- upvalues: u2 (copy), l__RunService__1 (copy), u3 (copy), l__Lerps__3 (copy), u7 (copy)
    if not u8 or typeof(u8) ~= "Instance" then
        return warn("Invalid object to tween:", u8);
    end;
    local u10 = type(p9) == "table" and (p9 or {}) or {};
    local u11 = u2[u10.StepType] and l__RunService__1[u10.StepType] or l__RunService__1.Stepped;
    local u12 = u3[u10.EasingStyle or "Quad"][u10.EasingDirection or "In"];
    local v13 = type(u10.Time) == "number" and (u10.Time or 1) or 1;
    local u14 = math.max(v13, 0.001);
    local v15 = type(u10.Goal) == "table" and (u10.Goal or {}) or {};
    local u16;
    if type(u10.DelayTime) == "number" and u10.DelayTime > 0.027 then
        u16 = u10.DelayTime;
    else
        u16 = false;
    end;
    local u17 = (type(u10.RepeatCount) == "number" and (math.max(u10.RepeatCount, -1) or 0) or 0) + 1;
    local u18 = {};
    for v19, v20 in pairs(v15) do
        u18[v19] = l__Lerps__3[typeof(v20)](u8[v19], v20);
    end;
    local u21 = Instance.new("BindableEvent");
    local u22 = Instance.new("BindableEvent");
    local u23 = Instance.new("BindableEvent");
    local u24 = nil;
    local u25 = os.clock();
    local u26 = 0;
    local u27 = {
        Instance = u8,
        PlasgckState = Enum.PlasgckState.Begin,
        Completed = u21.Event,
        Resumed = u23.Event,
        Stopped = u22.Event
    };
    function u27.Destroy() --[[ Line: 365 ]]
        -- upvalues: u24 (ref), u21 (copy), u22 (copy), u23 (copy), u27 (ref)
        if u24 then
            u24:Disconnect();
            u24 = nil;
        end;
        u21:Destroy();
        u22:Destroy();
        u23:Destroy();
        u27 = nil;
    end;
    local u28 = false;
    local u29 = 0;
    local function u41(p30, u31) --[[ Line: 380 ]]
        -- upvalues: u24 (ref), u17 (copy), u27 (ref), u21 (copy), u28 (ref), u29 (ref), u16 (copy), u7 (ref), u25 (ref), u26 (ref), u11 (copy), u14 (copy), u18 (copy), u8 (copy), u41 (copy), u10 (ref), u12 (copy)
        if u24 then
            u24:Disconnect();
            u24 = nil;
        end;
        local u32 = p30 or 1;
        if u17 == 0 or u17 >= u32 then
            u29 = u32;
            if u31 then
                u28 = true;
            end;
            if u16 then
                u27.PlasgckState = Enum.PlasgckState.Delayed;
                (u16 < 2 and u7 or wait)(u16);
            end;
            u25 = os.clock() - u26;
            u24 = u11:Connect(function() --[[ Line: 409 ]]
                -- upvalues: u26 (ref), u25 (ref), u14 (ref), u31 (copy), u18 (ref), u8 (ref), u24 (ref), u41 (ref), u32 (ref), u10 (ref), u12 (ref)
                u26 = os.clock() - u25;
                if u14 <= u26 then
                    if u31 then
                        for v33, v34 in pairs(u18) do
                            u8[v33] = v34(0);
                        end;
                    else
                        for v35, v36 in pairs(u18) do
                            u8[v35] = v36(1);
                        end;
                    end;
                    u24:Disconnect();
                    u24 = nil;
                    if u31 then
                        u26 = 0;
                        u41(u32 + 1, false);
                    elseif u10.Reverses then
                        u26 = 0;
                        u41(u32, true);
                    else
                        u26 = 0;
                        u41(u32 + 1, false);
                    end;
                else
                    local v37 = u12(u31 and 1 - u26 / u14 or u26 / u14);
                    local v38 = math.clamp(v37, 0, 1);
                    for v39, v40 in pairs(u18) do
                        u8[v39] = v40(v38);
                    end;
                end;
            end);
            u27.PlasgckState = Enum.PlasgckState.Playing;
        else
            u27.PlasgckState = Enum.PlasgckState.Completed;
            u21:Fire();
            u28 = false;
            u29 = 1;
        end;
    end;
    function u27.Play() --[[ Line: 449 ]]
        -- upvalues: u26 (ref), u41 (copy)
        u26 = 0;
        u41(1, false);
    end;
    function u27.Stop() --[[ Line: 454 ]]
        -- upvalues: u24 (ref), u27 (ref), u22 (copy)
        if u24 then
            u24:Disconnect();
            u24 = nil;
            u27.PlasgckState = Enum.PlasgckState.Cancelled;
            u22:Fire();
        end;
    end;
    function u27.Resume() --[[ Line: 463 ]]
        -- upvalues: u41 (copy), u29 (ref), u28 (ref), u23 (copy)
        u41(u29, u28);
        u23:Fire();
    end;
    return u27;
end;
return v1;