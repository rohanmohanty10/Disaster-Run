 

 

local TypeRegistry = require(script.Parent.TypeRegistry);
local EventsPayload = require(script.Parent.EventsPayload);
local HitFilter = require(script.Parent.HitFilter);
local Log = require(script.Parent.Log);
local u1 = {
    DEFAULT_CHAIN_DEPTH_LIMIT = 4
};
local _ = TypeRegistry.CONFIG_NAME;
local u2 = {};
u1._frameCount = 0;
u1._burstDropped = 0;
u1._burstReportPending = false;
local u3 = false;
local u4 = 0;
local u5 = 0;
local u6 = {};
local u7 = {};
u1._unsupportedOriginWarned = u6;
u1._nilOriginWarned = u7;
local u8 = 0;

local function nextChainId() -- Line: 52
    -- upvalues: u8 (ref)
    u8 = u8 + 1;

    return u8;
end;

function u1.newChainCtx() -- Line: 57
    -- upvalues: u8 (ref)
    local v9 = {
        Depth = 0
    };
    u8 = u8 + 1;
    v9.ChainId = u8;

    return v9;
end;

function u1.withEmitIndex(p10, p11) -- Line: 62
    if not p10 then
        return {
            EmitIndex = p11
        };
    end;

    local v12 = {
        EmitIndex = p11
    };

    for i, v in pairs(p10) do
        if i ~= "EmitIndex" then
            v12[i] = v;
        end;
    end;

    return v12;
end;

function u1.withEmitIndexAndCount(p13, p14, p15) -- Line: 72
    if not p13 then
        return {
            EmitIndex = p14,
            EmitCount = p15
        };
    end;

    local v16 = {
        EmitIndex = p14,
        EmitCount = p15
    };

    for i, v in pairs(p13) do
        if i ~= "EmitIndex" and i ~= "EmitCount" then
            v16[i] = v;
        end;
    end;

    return v16;
end;

function u1.withEvenOffset(p17, p18, p19, p20, p21, p22, p23) -- Line: 86
    local v24 = {
        EmitIndex = p18,
        EmitCount = p19
    };

    if p17 then
        for i, v in pairs(p17) do
            if i ~= "EmitIndex" and (i ~= "EmitCount" and (i ~= "EvenOffsetIdx_Pos" and (i ~= "EvenOffsetN_Pos" and (i ~= "EvenOffsetIdx_Rot" and i ~= "EvenOffsetN_Rot")))) then
                v24[i] = v;
            end;
        end;
    end;

    if p21 and p21 > 0 then
        v24.EvenOffsetIdx_Pos = p20;
        v24.EvenOffsetN_Pos = p21;
    end;

    if p23 and p23 > 0 then
        v24.EvenOffsetIdx_Rot = p22;
        v24.EvenOffsetN_Rot = p23;
    end;

    return v24;
end;

function u1.descendCtx(p25) -- Line: 110
    if p25 then
        return (p25.EventOriginCF ~= nil or (p25.IgnoreLink ~= nil or (p25.UseFullOrigin ~= nil or p25.EventOriginResolver ~= nil))) and {
            ChainCtx = p25.ChainCtx,
            EmitIndex = p25.EmitIndex,
            EmitCount = p25.EmitCount
        } or p25;
    end;

    return nil;
end;

local success = pcall(function() -- Line: 127
    return Instance.new("ModuleScript").Source;
end);

function u1._compile(p26) -- Line: 129
    -- upvalues: success (copy)
    if not success then
        local success2, result = pcall(require, p26);

        if not success2 then
            return nil, result;
        end;

        if type(result) == "function" then
            return result, nil, nil;
        end;

        return nil, "module must return function(payload)";
    end;

    local v27 = p26:Clone();
    v27.Name = "_CompiledEventModule";
    v27.Archivable = false;
    v27.Parent = p26.Parent;
    local success2, result = pcall(require, v27);

    if not success2 then
        v27:Destroy();

        return nil, result;
    end;

    if type(result) == "function" then
        return result, nil, v27;
    end;

    v27:Destroy();

    return nil, "module must return function(payload)";
end;

function u1._isCacheValid(p28, p29) -- Line: 151
    if not (p28 and (p29 and p29:IsA("ModuleScript"))) then
        return false;
    end;

    if p29.Name ~= "Module" then
        return false;
    end;

    local expectedEventCfg = p28.expectedEventCfg;

    if not (expectedEventCfg and expectedEventCfg.Parent) then
        return false;
    end;

    if expectedEventCfg.Name ~= p28.expectedEventName then
        return false;
    end;

    if expectedEventCfg.Parent and expectedEventCfg.Parent.Name == "Events" then
        return p29.Parent == expectedEventCfg;
    end;

    return false;
end;

function u1._invalidate(p30) -- Line: 162
    -- upvalues: u2 (copy)
    local u31 = u2[p30];

    if not u31 then
        return;
    end;

    if u31.sourceConn then
        u31.sourceConn:Disconnect();
        u31.sourceConn = nil;
    end;

    if u31.ancestryConn then
        u31.ancestryConn:Disconnect();
        u31.ancestryConn = nil;
    end;

    if u31.nameConn then
        u31.nameConn:Disconnect();
        u31.nameConn = nil;
    end;

    if u31.compiledClone then
        pcall(function() -- Line: 169
            -- upvalues: u31 (copy)
            u31.compiledClone:Destroy();
        end);
        u31.compiledClone = nil;
    end;

    u2[p30] = nil;
end;

function u1.compile(u32) -- Line: 176
    -- upvalues: u2 (copy), u1 (copy), success (copy)
    if not (u32 and u32:IsA("ModuleScript")) then
        return nil;
    end;

    local v33 = u2[u32];

    if v33 and (not v33.dirty and u1._isCacheValid(v33, u32)) then
        return v33.fn;
    end;

    if v33 then
        u1._invalidate(u32);
    end;

    local v34, v35, v36 = u1._compile(u32);

    if not v34 then
        u1.reportScriptError(u32, v35);

        return nil;
    end;

    local Parent = u32.Parent;

    if not (Parent and Parent:IsA("Configuration")) then
        v36:Destroy();

        return nil;
    end;

    local v37 = {
        dirty = false,
        fn = v34,
        expectedEventCfg = Parent,
        expectedEventName = Parent.Name,
        compiledClone = v36
    };

    if success then
        v37.sourceConn = u32:GetPropertyChangedSignal("Source"):Connect(function() -- Line: 207
            -- upvalues: u2 (ref), u32 (copy)
            if u2[u32] then
                u2[u32].dirty = true;
            end;
        end);
    end;

    v37.ancestryConn = u32.AncestryChanged:Connect(function() -- Line: 212
        -- upvalues: u1 (ref), u2 (ref), u32 (copy)
        if not u1._isCacheValid(u2[u32], u32) then
            u1._invalidate(u32);
        end;
    end);
    v37.nameConn = u32:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 219
        -- upvalues: u32 (copy)
        if u32.Name ~= "Module" then
            pcall(function() -- Line: 221
                -- upvalues: u32 (ref)
                u32.Name = "Module";
            end);
        end;
    end);
    u2[u32] = v37;

    return v34;
end;

function u1.cleanup() -- Line: 228
    -- upvalues: u2 (copy), u1 (copy), u5 (ref), u4 (ref), u3 (ref), u6 (copy), u7 (copy)
    local v38 = {};

    for i in pairs(u2) do
        table.insert(v38, i);
    end;

    for _, v in ipairs(v38) do
        u1._invalidate(v);
    end;

    u5 = u5 + 1;
    u1._frameCount = 0;
    u1._burstDropped = 0;
    u1._burstReportPending = false;
    u4 = 0;
    u3 = false;
    table.clear(u6);
    table.clear(u7);
end;

function u1._reportBurst() -- Line: 247
    -- upvalues: u1 (copy), u5 (ref), Log (copy)
    local v39 = u1;
    v39._burstDropped = v39._burstDropped + 1;

    if not u1._burstReportPending then
        u1._burstReportPending = true;
        local u40 = u5;
        task.delay(1, function() -- Line: 252
            -- upvalues: u40 (copy), u5 (ref), u1 (ref), Log (ref)
            if u40 ~= u5 then
                return;
            end;

            if u1._burstDropped > 0 then
                Log.warn(("[Part-Icles Events] dropped %d event fires this second."):format(u1._burstDropped));
            end;

            u1._burstDropped = 0;
            u1._burstReportPending = false;
        end);
    end;
end;

function u1.reserveFrameFire() -- Line: 263
    -- upvalues: u1 (copy)
    if u1._frameCount >= 256 then
        u1._reportBurst();

        return false;
    end;

    local v41 = u1;
    v41._frameCount = v41._frameCount + 1;

    return true;
end;

function u1.tickFrame() -- Line: 273
    -- upvalues: u1 (copy)
    u1._frameCount = 0;
end;

function u1.dropDepth(u42) -- Line: 277
    -- upvalues: u4 (ref), u3 (ref), u5 (ref), Log (copy)
    u4 = u4 + 1;

    if not u3 then
        u3 = true;
        local u43 = u5;
        task.delay(1, function() -- Line: 282
            -- upvalues: u43 (copy), u5 (ref), u4 (ref), Log (ref), u42 (copy), u3 (ref)
            if u43 ~= u5 then
                return;
            end;

            if u4 > 0 then
                Log.warn(("[Part-Icles Events] dropped %d event fire(s) this second (chain depth limit reached%s)."):format(u4, u42 and " on " .. u42 or ""));
            end;

            u4 = 0;
            u3 = false;
        end);
    end;
end;

function u1.reportScriptError(p44, p45) -- Line: 294
    -- upvalues: Log (copy)
    local v46 = p44 and p44:GetFullName() or "<destroyed>";
    Log.warn(("[Part-Icles Events] %s\n  %s"):format(v46, (tostring(p45))));
end;

function u1.getWorldCF(p47) -- Line: 300
    -- upvalues: u1 (copy)
    if p47.Type == "Distortion" then
        if p47._lastOriginPos then
            return CFrame.new(p47._lastOriginPos);
        end;

        return u1.getSourceWorldCF(p47._sourceItem);
    end;

    if p47.Type == "CameraShake" then
        local workspace_CurrentCamera = workspace.CurrentCamera;

        return workspace_CurrentCamera and workspace_CurrentCamera.CFrame or nil;
    end;

    local VisualPart = p47.VisualPart;

    if not (VisualPart and VisualPart.Parent) then
        return nil;
    end;

    if VisualPart:IsA("BasePart") then
        return VisualPart.CFrame;
    end;

    if VisualPart:IsA("Attachment") then
        return VisualPart.WorldCFrame;
    end;

    if VisualPart:IsA("Model") then
        return VisualPart:GetPivot();
    end;

    if VisualPart:IsA("Light") or VisualPart:IsA("Sound") then
        local Parent = VisualPart.Parent;

        if Parent and Parent:IsA("BasePart") then
            return Parent.CFrame;
        end;

        if Parent and Parent:IsA("Attachment") then
            return Parent.WorldCFrame;
        end;

        return nil;
    end;

    if not VisualPart:IsA("Beam") then
        return nil;
    end;

    local Attachment0 = VisualPart.Attachment0;

    if not Attachment0 then
        return nil;
    end;

    local Attachment1 = VisualPart.Attachment1;

    if Attachment1 then
        return CFrame.new((Attachment0.WorldPosition + Attachment1.WorldPosition) * 0.5);
    end;

    return CFrame.new(Attachment0.WorldPosition);
end;

function u1.getWorldPosition(p48) -- Line: 334
    -- upvalues: u1 (copy)
    local WorldCF = u1.getWorldCF(p48);

    return WorldCF and WorldCF.Position or nil;
end;

function u1.getSourceWorldCF(p49) -- Line: 339
    if not (p49 and p49.Parent) then
        return nil;
    end;

    if p49:IsA("BasePart") then
        return p49.CFrame;
    end;

    if p49:IsA("Attachment") then
        return p49.WorldCFrame;
    end;

    if p49:IsA("Model") then
        return p49:GetPivot();
    end;

    if p49:IsA("Beam") then
        local Attachment0 = p49.Attachment0;

        if not Attachment0 then
            return nil;
        end;

        local Attachment1 = p49.Attachment1;

        if Attachment1 then
            return CFrame.new((Attachment0.WorldPosition + Attachment1.WorldPosition) * 0.5);
        end;

        return CFrame.new(Attachment0.WorldPosition);
    end;

    if not (p49:IsA("Light") or p49:IsA("Sound")) then
        return nil;
    end;

    local Parent = p49.Parent;

    if Parent and Parent:IsA("BasePart") then
        return Parent.CFrame;
    end;

    if Parent and Parent:IsA("Attachment") then
        return Parent.WorldCFrame;
    end;

    return nil;
end;

function u1.makeHitParams(p50) -- Line: 368
    -- upvalues: HitFilter (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v51 = {};

    if p50.VisualPart then
        table.insert(v51, p50.VisualPart);
    end;

    if p50._sourceItem then
        table.insert(v51, p50._sourceItem);
    end;

    if p50._sourceItem then
        local RenderTemplate = p50._sourceItem:FindFirstChild("RenderTemplate");

        if RenderTemplate then
            table.insert(v51, RenderTemplate);
        end;

        local EmitParent = p50._sourceItem:FindFirstChild("EmitParent");

        if EmitParent and (EmitParent:IsA("ObjectValue") and EmitParent.Value) then
            table.insert(v51, EmitParent.Value);
        end;
    end;

    if p50.VisualPart and (p50.VisualPart:IsA("Attachment") and p50.VisualPart.Parent) then
        table.insert(v51, p50.VisualPart.Parent);
    end;

    if p50._sourceItem then
        local u52, v53 = HitFilter.read(p50._sourceItem);

        if u52 ~= "" then
            pcall(function() -- Line: 394
                -- upvalues: RaycastParams_new_ret (copy), u52 (copy)
                RaycastParams_new_ret.CollisionGroup = u52;
            end);
        end;

        for _, v in ipairs(v53) do
            table.insert(v51, v);
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v51;
    RaycastParams_new_ret.IgnoreWater = true;

    return RaycastParams_new_ret;
end;

function u1.makePayload(p54, p55, p56, p57) -- Line: 404
    -- upvalues: EventsPayload (copy), u1 (copy)
    return EventsPayload.build(p55, p56, p57, u1.getWorldCF(p55));
end;

function u1.resolveEmitModeCF(p58, p59, p60) -- Line: 417
    -- upvalues: u1 (copy)
    if p58 == "AtPosition" then
        if p59 and p59._eventName == "OnEmit" then
            local WorldCF = u1.getWorldCF(p60);

            if WorldCF then
                return WorldCF;
            end;

            if p60.CurrentPosition then
                return CFrame.new(p60.CurrentPosition);
            end;
        end;

        local v61 = p59.HitPosition or (p59.DeathPosition or p59.EmitPosition);

        if v61 and (p59._eventName == "OnHit" and p59.HitNormal) then
            v61 = v61 + p59.HitNormal * 0.1;
        end;

        return v61 and CFrame.new(v61) or nil;
    end;

    if p58 == "AtSource" then
        return u1.getSourceWorldCF(p60._sourceItem);
    end;

    if p58 ~= "AtCFrame" then
        return nil;
    end;

    local v62 = p59 and p59._eventName == "OnEmit" and u1.getWorldCF(p60);

    if v62 then
        return v62;
    end;

    local v63;

    if p59 then
        v63 = p59.WorldCFrame;
    else
        v63 = p59;
    end;

    if v63 and (p59._eventName == "OnHit" and p59.HitNormal) then
        v63 = v63 + p59.HitNormal * 0.1;
    end;

    return v63 or nil;
end;

function u1.fire(u64, u65, p66, p67, p68) -- Line: 448
    -- upvalues: u1 (copy), EventsPayload (copy), Log (copy)
    local u69 = p67 or u1.newChainCtx();
    local u70 = u65.Events and u65.Events[p66];

    if not (u70 and u70.Enabled) then
        return;
    end;

    local v71 = tonumber(u70.ChainDepthLimit) or 4;
    local math_floor_ret = math.floor(v71);
    local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);

    if math_clamp_ret <= u69.Depth then
        u1.dropDepth(p66);

        return;
    end;

    if not (u70.EmitTarget or u70.Module) then
        return;
    end;

    local u72 = p68 or u1.makePayload(u64, u65, p66, nil);
    u72._eventName = u72._eventName or p66;

    if not u1.reserveFrameFire() then
        return;
    end;

    u72.Source = u72.Source or u65._sourceItem;
    u72.Particle = u72.Particle or u65.VisualPart;
    u72.RenderTemplate = u72.RenderTemplate or u72.Particle;

    if u70.Module then
        function u72.Emit(p73, p74) -- Line: 479
            -- upvalues: u1 (ref), u64 (copy), u70 (copy), u72 (ref), u65 (copy), u69 (ref), math_clamp_ret (copy)
            u1.emitTargetInstance(u64, p73, p74 or u70.EmitMode, u72, u65, u69, math_clamp_ret);
        end;

        function u72.Kill() -- Line: 482
            -- upvalues: u64 (copy), u65 (copy)
            if u64._killParticle then
                u64:_killParticle(u65, {
                    fireOnDeath = false
                });
            end;
        end;

        EventsPayload.attachSkipSetters(u72, u65);

        function u72.SetColor(p75) -- Line: 489
            -- upvalues: EventsPayload (ref), u65 (copy)
            EventsPayload.applyColor(u65, p75);
        end;

        function u72.SetTransparency(p76) -- Line: 490
            -- upvalues: EventsPayload (ref), u65 (copy)
            EventsPayload.applyTransparency(u65, p76);
        end;

        function u72.Teleport(p77) -- Line: 491
            -- upvalues: EventsPayload (ref), u65 (copy)
            EventsPayload.applyTeleport(u65, p77);
        end;

        EventsPayload.attachAdvancedSetters(u72, u65);

        function u72.SetSpeedMultiplier(p78) -- Line: 493
            -- upvalues: u65 (copy)
            if type(p78) == "number" then
                u65.SpeedMultiplier = p78;
            end;
        end;

        function u72.SetLifetime(p79) -- Line: 498
            -- upvalues: u65 (copy)
            if type(p79) == "number" then
                u65.LifeTime = math.max(0.001, p79);
            end;
        end;
    end;

    local v80 = #u64.ActiveEmits + (u64._lingerVisualCount or 0) >= (u64.MAX_ACTIVE_PARTICLES or 1000);

    if v80 and (u70.EmitTarget and not u1._capSkipWarned) then
        u1._capSkipWarned = true;
        Log.warn("[Part-Icles Events] active-particle cap reached; event EmitTargets are being skipped");
    end;

    if u70.EmitTarget and not v80 then
        u1.emitTargetInstance(u64, u70.EmitTarget, u70.EmitMode, u72, u65, u69, math_clamp_ret);
    end;

    local u81 = u70.Module and u1.compile(u70.Module);

    if u81 then
        task.spawn(function() -- Line: 517
            -- upvalues: u81 (copy), u72 (ref), u1 (ref), u70 (copy)
            local v82, v83 = xpcall(u81, debug.traceback, u72);

            if not v82 then
                u1.reportScriptError(u70.Module, v83);
            end;
        end);
    end;
end;

require(script.EmitTarget)(u1);
require(script.Hit)(u1);

return u1;