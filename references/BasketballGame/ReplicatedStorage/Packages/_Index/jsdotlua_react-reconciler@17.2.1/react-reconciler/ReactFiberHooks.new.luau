 
 

local function unimplemented(p1: string) -- Line: 12
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. p1);
    error("FIXME (roblox): " .. p1 .. " is unimplemented");
end;

local _G___DEV__ = _G.__DEV__;
local v2 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Array = v2.Array;
local Error = v2.Error;
local Object = v2.Object;
local createRef = require(script.Parent.Parent:WaitForChild("react")).createRef;
local createBinding = require(script.Parent.Parent:WaitForChild("react")).createBinding;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"));
local ReactSharedInternals = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableDebugTracing = ReactFeatureFlags.enableDebugTracing;
local enableSchedulingProfiler = ReactFeatureFlags.enableSchedulingProfiler;
local enableNewReconciler = ReactFeatureFlags.enableNewReconciler;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local DebugTracingMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).DebugTracingMode;
local NoLane = ReactFiberLane.NoLane;
local NoLanes = ReactFiberLane.NoLanes;
local isSubsetOfLanes = ReactFiberLane.isSubsetOfLanes;
local mergeLanes = ReactFiberLane.mergeLanes;
local removeLanes = ReactFiberLane.removeLanes;
local markRootEntangled = ReactFiberLane.markRootEntangled;
local markRootMutableRead = ReactFiberLane.markRootMutableRead;
local readContext = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).readContext;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Update = ReactFiberFlags.Update;
local Passive = ReactFiberFlags.Passive;
local PassiveStatic = ReactFiberFlags.PassiveStatic;
local MountLayoutDev = ReactFiberFlags.MountLayoutDev;
local MountPassiveDev = ReactFiberFlags.MountPassiveDev;
local HasEffect = ReactHookEffectTags.HasEffect;
local Layout = ReactHookEffectTags.Layout;
local Passive2 = ReactHookEffectTags.Passive;
local v3 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local warnIfNotCurrentlyActingUpdatesInDEV = v3.warnIfNotCurrentlyActingUpdatesInDEV;
local scheduleUpdateOnFiber = v3.scheduleUpdateOnFiber;
local warnIfNotScopedWithMatchingAct = v3.warnIfNotScopedWithMatchingAct;
local requestEventTime = v3.requestEventTime;
local requestUpdateLane = v3.requestUpdateLane;
local markSkippedUpdateLanes = v3.markSkippedUpdateLanes;
local getWorkInProgressRoot = v3.getWorkInProgressRoot;
local warnIfNotCurrentlyActingEffectsInDEV = v3.warnIfNotCurrentlyActingEffectsInDEV;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;

local function is(p4, p5) -- Line: 114
    local v6;

    if p4 == p5 and (p4 ~= 0 or 1 / p4 == 1 / p5) then
        v6 = true;
    elseif p4 == p4 then
        v6 = false;
    else
        v6 = p5 ~= p5;
    end;

    return v6;
end;

local markWorkInProgressReceivedUpdate = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).markWorkInProgressReceivedUpdate;
local getIsHydrating = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new")).getIsHydrating;
local makeClientId = require(script.Parent:WaitForChild("ReactFiberHostConfig")).makeClientId;
local v7 = require(script.Parent:WaitForChild("ReactMutableSource.new"));
local warnAboutMultipleRenderersDEV = v7.warnAboutMultipleRenderersDEV;
local getWorkInProgressVersion = v7.getWorkInProgressVersion;
local setWorkInProgressVersion = v7.setWorkInProgressVersion;
local markSourceAsDirty = v7.markSourceAsDirty;
local logStateUpdateScheduled = require(script.Parent:WaitForChild("DebugTracing")).logStateUpdateScheduled;
local markStateUpdateScheduled = require(script.Parent:WaitForChild("SchedulingProfiler")).markStateUpdateScheduled;
local ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher;
local u8 = _G___DEV__ and {} or nil;
local u9 = {};
local u10 = NoLanes;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = false;
local u15 = false;
local u16 = nil;
local u17 = nil;
local u18 = 0;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;
local u24 = nil;
local u25 = nil;

local function getHighestIndex(p26: table) -- Line: 256
    local v27 = 0;

    for i, _ in p26 do
        if v27 < i then
            v27 = i;
        end;
    end;

    return v27;
end;

local function isArrayOrSparseArray(p28) -- Line: 266
    if type(p28) ~= "table" then
        return false;
    end;

    for i, _ in p28 do
        if type(i) ~= "number" then
            return false;
        end;
    end;

    return true;
end;

local function mountHookTypesDev() -- Line: 278
    -- upvalues: _G___DEV__ (copy), u16 (ref), u17 (ref)
    if _G___DEV__ then
        local v29 = u16;

        if u17 == nil then
            u17 = { v29 };

            return;
        end;

        table.insert(u17, v29);
    end;
end;

function updateHookTypesDev()
    -- upvalues: _G___DEV__ (copy), u16 (ref), u17 (ref), u18 (ref)
    if _G___DEV__ then
        local v30 = u16;

        if u17 ~= nil then
            u18 = u18 + 1;

            if u17[u18] ~= v30 then
                warnOnHookMismatchInDev(v30);
            end;
        end;
    end;
end;

local function checkDepsAreArrayDev(p31) -- Line: 305
    -- upvalues: _G___DEV__ (copy), console (copy), u16 (ref)
    if _G___DEV__ and p31 ~= nil then
        local v32;

        if type(p31) == "table" then
            v32 = true;

            for i, _ in p31 do
                if type(i) ~= "number" then
                    v32 = false;
                    break;
                end;
            end;
        else
            v32 = false;
        end;

        if not v32 then
            console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p31)));
        end;
    end;
end;

function warnOnHookMismatchInDev(p33)
    -- upvalues: _G___DEV__ (copy), getComponentName (copy), u11 (ref), u8 (ref), u17 (ref), u18 (ref), console (copy)
    if _G___DEV__ then
        local v34 = getComponentName(u11.type) or "Component";

        if not u8[v34] then
            u8[v34] = true;

            if u17 ~= nil then
                local v35 = "";

                for i = 1, u18 do
                    local v36 = u17[i];
                    local v37;

                    if i == u18 then
                        v37 = p33;
                    else
                        v37 = v36;
                    end;

                    local v38 = tostring(i) .. ". " .. (v36 or "undefined");
                    local _ = i;

                    while string.len(v38) < 30 do
                        v38 = v38 .. " ";
                    end;

                    v35 = v35 .. v38 .. v37 .. "\n";
                end;

                console.error("React has detected a change in the order of Hooks called by %s. This will lead to bugs and errors if not fixed. For more information, read the Rules of Hooks: https://reactjs.org/link/rules-of-hooks\n\n   Previous render            Next render\n   ------------------------------------------------------\n%s   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n", v34, v35);
            end;
        end;
    end;
end;

local function throwInvalidHookError() -- Line: 372
    -- upvalues: Error (copy)
    error(Error.new("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem."));
end;

local function areHookInputsEqual(p39: table, p40: table) -- Line: 387
    -- upvalues: _G___DEV__ (copy), console (copy), u16 (ref)
    if p40 == nil then
        if _G___DEV__ then
            console.error("%s received a final argument during this render, but not during the previous render. Even though the final argument is optional, its type cannot change between renders.", u16);
        end;

        return false;
    end;

    local v41 = 0;

    for i, _ in p39 do
        if v41 < i then
            v41 = i;
        end;
    end;

    local v42 = 0;

    for i, _ in p40 do
        if v42 < i then
            v42 = i;
        end;
    end;

    if v41 ~= v42 then
        return false;
    end;

    for i = 1, math.min(v42, v41) do
        local v43 = p39[i];
        local v44 = p40[i];
        local v45;

        if v43 == v44 and (v43 ~= 0 or 1 / v43 == 1 / v44) then
            v45 = true;
        elseif v43 == v43 then
            v45 = false;
        else
            v45 = v44 ~= v44;
        end;

        if not v45 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

function u9.bailoutHooks(p46, p47, p48) -- Line: 451
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), MountLayoutDev (copy), Update (copy), removeLanes (copy)
    p47.updateQueue = p46.updateQueue;

    if _G___DEV__ and enableDoubleInvokingEffects then
        local flags = p47.flags;
        local bit32_bor_ret = bit32.bor(MountPassiveDev, Passive, MountLayoutDev, Update);
        local bit32_bnot_ret = bit32.bnot(bit32_bor_ret);
        p47.flags = bit32.band(flags, bit32_bnot_ret);
    else
        local flags = p47.flags;
        local bit32_bor_ret = bit32.bor(Passive, Update);
        local bit32_bnot_ret = bit32.bnot(bit32_bor_ret);
        p47.flags = bit32.band(flags, bit32_bnot_ret);
    end;

    p46.lanes = removeLanes(p46.lanes, p48);
end;

local u49 = false;

function u9.resetHooksAfterThrow() -- Line: 476
    -- upvalues: ReactCurrentDispatcher (copy), u9 (copy), u14 (ref), u11 (ref), u10 (ref), NoLanes (copy), u12 (ref), u13 (ref), _G___DEV__ (copy), u17 (ref), u18 (ref), u16 (ref), u49 (ref), u15 (ref)
    ReactCurrentDispatcher.current = u9.ContextOnlyDispatcher;

    if u14 then
        local memoizedState = u11.memoizedState;

        while memoizedState ~= nil do
            local queue = memoizedState.queue;

            if queue ~= nil then
                queue.pending = nil;
            end;

            memoizedState = memoizedState.next;
        end;

        u14 = false;
    end;

    u10 = NoLanes;
    u11 = nil;
    u12 = nil;
    u13 = nil;

    if _G___DEV__ then
        u17 = nil;
        u18 = 0;
        u16 = nil;
        u49 = false;
    end;

    u15 = false;
end;

local function mountWorkInProgressHook() -- Line: 521
    -- upvalues: u13 (ref), u11 (ref)
    local v50 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v50;
        u13 = v50;
    else
        u13.next = v50;
        u13 = v50;
    end;

    return u13;
end;

local function updateWorkInProgressHook() -- Line: 544
    -- upvalues: u12 (ref), u11 (ref), u13 (ref), Error (copy)
    local v51;

    if u12 == nil then
        local alternate = u11.alternate;

        if alternate == nil then
            v51 = nil;
        else
            v51 = alternate.memoizedState;
        end;
    else
        v51 = u12.next;
    end;

    local v52;

    if u13 == nil then
        v52 = u11.memoizedState;
    else
        v52 = u13.next;
    end;

    if v52 == nil then
        if v51 == nil then
            error(Error.new("Rendered more hooks than during the previous render."));
        end;

        u12 = v51;
        local v53 = {
            next = nil,
            memoizedState = u12.memoizedState,
            baseState = u12.baseState,
            baseQueue = u12.baseQueue,
            queue = u12.queue
        };

        if u13 == nil then
            u13 = v53;
            u11.memoizedState = v53;
        else
            u13.next = v53;
            u13 = v53;
        end;
    else
        u13 = v52;
        local _ = u13.next;
        u12 = v51;
    end;

    return u13;
end;

function basicStateReducer(p54, p55)
    if type(p55) == "function" then
        return p55(p54);
    end;

    return p55;
end;

function mountReducer(p56: function, p57: any, p58: function?)
    -- upvalues: u13 (ref), u11 (ref)
    local v59 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v59;
        u13 = v59;
    else
        u13.next = v59;
        u13 = v59;
    end;

    local v60 = u13;

    if p58 ~= nil then
        p57 = p58(p57);
    end;

    v60.baseState = p57;
    v60.memoizedState = v60.baseState;
    local u61 = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = p56,
        lastRenderedState = p57
    };
    v60.queue = u61;
    local u62 = u11;

    local function v64(p63, ...) -- Line: 655
        -- upvalues: u62 (copy), u61 (copy)
        dispatchAction(u62, u61, p63, ...);
    end;

    u61.dispatch = v64;

    return v60.memoizedState, v64;
end;

function updateReducer(p65: function, p66: any, p67: function?)
    -- upvalues: updateWorkInProgressHook (copy), u12 (ref), u10 (ref), u11 (ref), mergeLanes (copy), markSkippedUpdateLanes (copy), NoLane (copy), markWorkInProgressReceivedUpdate (copy)
    local v68 = updateWorkInProgressHook();
    local queue = v68.queue;
    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.");
    queue.lastRenderedReducer = p65;
    local v69 = u12;
    local baseQueue = v69.baseQueue;
    local pending = queue.pending;

    if pending == nil then
        pending = baseQueue;
    else
        if baseQueue ~= nil then
            local next = baseQueue.next;
            baseQueue.next = pending.next;
            pending.next = next;
        end;

        v69.baseQueue = pending;
        queue.pending = nil;
    end;

    if pending ~= nil then
        local next = pending.next;
        local baseState = v69.baseState;
        local v70 = nil;
        local v71 = nil;
        local v72 = nil;

        repeat
            if true then
                local lane = next.lane;

                if bit32.band(u10, lane) == lane then
                    if v70 ~= nil then
                        v70.next = {
                            next = nil,
                            lane = NoLane,
                            action = next.action,
                            eagerReducer = next.eagerReducer,
                            eagerState = next.eagerState
                        };
                        v70 = v70.next;
                    end;

                    if next.eagerReducer == p65 then
                        baseState = next.eagerState;
                    else
                        baseState = p65(baseState, next.action);
                    end;
                else
                    local v73 = {
                        next = nil,
                        lane = lane,
                        action = next.action,
                        eagerReducer = next.eagerReducer,
                        eagerState = next.eagerState
                    };

                    if v70 == nil then
                        v71 = v73;
                        v70 = v71;
                        v72 = baseState;
                        local v74 = v71;
                        v71 = v70;
                        v74 = v70;
                        v70 = v71;
                    else
                        v70.next = v73;
                        v70 = v70.next;
                    end;

                    u11.lanes = mergeLanes(u11.lanes, lane);
                    markSkippedUpdateLanes(lane);
                end;
            end;

            next = next.next;
        until next == nil or next == next;

        if v70 == nil then
            v72 = baseState;
        else
            v70.next = v71;
        end;

        local memoizedState = v68.memoizedState;
        local v75;

        if baseState == memoizedState and (baseState ~= 0 or 1 / baseState == 1 / memoizedState) then
            v75 = true;
        elseif baseState == baseState then
            v75 = false;
        else
            v75 = memoizedState ~= memoizedState;
        end;

        if not v75 then
            markWorkInProgressReceivedUpdate();
        end;

        v68.memoizedState = baseState;
        v68.baseState = v72;
        v68.baseQueue = v70;
        queue.lastRenderedState = baseState;
    end;

    return v68.memoizedState, queue.dispatch;
end;

function rerenderReducer(p76: function, p77: any, p78: function?)
    -- upvalues: updateWorkInProgressHook (copy), markWorkInProgressReceivedUpdate (copy)
    local v79 = updateWorkInProgressHook();
    local queue = v79.queue;
    assert(queue ~= nil, "Should have a queue. This is likely a bug in React. Please file an issue.");
    queue.lastRenderedReducer = p76;
    local dispatch = queue.dispatch;
    local pending = queue.pending;
    local memoizedState = v79.memoizedState;

    if pending ~= nil then
        queue.pending = nil;
        local next = pending.next;

        repeat
            memoizedState = p76(memoizedState, next.action);
            next = next.next;
        until next == next;

        local memoizedState2 = v79.memoizedState;
        local v80;

        if memoizedState == memoizedState2 and (memoizedState ~= 0 or 1 / memoizedState == 1 / memoizedState2) then
            v80 = true;
        elseif memoizedState == memoizedState then
            v80 = false;
        else
            v80 = memoizedState2 ~= memoizedState2;
        end;

        if not v80 then
            markWorkInProgressReceivedUpdate();
        end;

        v79.memoizedState = memoizedState;

        if v79.baseQueue == nil then
            v79.baseState = memoizedState;
        end;

        queue.lastRenderedState = memoizedState;
    end;

    return memoizedState, dispatch;
end;

function readFromUnsubcribedMutableSource(p81, p82, p83)
    -- upvalues: _G___DEV__ (copy), warnAboutMultipleRenderersDEV (copy), getWorkInProgressVersion (copy), isSubsetOfLanes (copy), u10 (ref), setWorkInProgressVersion (copy), console (copy), markSourceAsDirty (copy), Error (copy)
    if _G___DEV__ then
        warnAboutMultipleRenderersDEV(p82);
    end;

    local v84 = p82._getVersion(p82._source);
    local v85 = getWorkInProgressVersion(p82);
    local v86;

    if v85 == nil then
        v86 = isSubsetOfLanes(u10, p81.mutableReadLanes);

        if v86 then
            setWorkInProgressVersion(p82, v84);
        end;
    else
        v86 = v85 == v84;
    end;

    if v86 then
        local v87 = p83(p82._source);

        if _G___DEV__ and type(v87) == "function" then
            console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.");
        end;

        return v87;
    end;

    markSourceAsDirty(p82);
    error(Error.new("Cannot read from mutable source during the current render without tearing. This is a bug in React. Please file an issue."));
end;

function useMutableSource(p88: table, u89: any, u90: any, u91: any)
    -- upvalues: getWorkInProgressRoot (copy), invariant (copy), ReactCurrentDispatcher (copy), u13 (ref), u11 (ref), _G___DEV__ (copy), console (copy), requestUpdateLane (copy), markRootMutableRead (copy), markRootEntangled (copy)
    local u92 = getWorkInProgressRoot();
    invariant(u92 ~= nil, "Expected a work-in-progress root. This is a bug in React. Please file an issue.");
    local _getVersion = u89._getVersion;
    local u93 = _getVersion(u89._source);
    local current = ReactCurrentDispatcher.current;
    assert(current ~= nil, "dispatcher was nil, this is a bug in React");
    local v94, u95 = current.useState(function() -- Line: 979
        -- upvalues: u92 (copy), u89 (copy), u90 (copy)
        return readFromUnsubcribedMutableSource(u92, u89, u90);
    end);
    local u96 = v94;
    local v97 = u13;
    local memoizedState = p88.memoizedState;

    if memoizedState.refs == nil then
        error((tostring(debug.traceback())));
    end;

    local refs = memoizedState.refs;
    local getSnapshot = refs.getSnapshot;
    local source = memoizedState.source;
    local subscribe = memoizedState.subscribe;
    local u98 = u11;
    p88.memoizedState = {
        refs = refs,
        source = u89,
        subscribe = u91
    };
    current.useEffect(function() -- Line: 1008
        -- upvalues: refs (copy), u90 (copy), u95 (ref), _getVersion (copy), u89 (copy), u93 (copy), _G___DEV__ (ref), console (ref), u96 (ref), requestUpdateLane (ref), u98 (copy), markRootMutableRead (ref), u92 (copy), markRootEntangled (ref)
        refs.getSnapshot = u90;
        refs.setSnapshot = u95;
        local v99 = _getVersion(u89._source);
        local v100 = u93;
        local v101;

        if v100 == v99 and (v100 ~= 0 or 1 / v100 == 1 / v99) then
            v101 = true;
        elseif v100 == v100 then
            v101 = false;
        else
            v101 = v99 ~= v99;
        end;

        if not v101 then
            local v102 = u90(u89._source);

            if _G___DEV__ and type(v102) == "function" then
                console.error("Mutable source should not return a function as the snapshot value. Functions may close over mutable values and cause tearing.");
            end;

            local v103 = u96;
            local v104;

            if v103 == v102 and (v103 ~= 0 or 1 / v103 == 1 / v102) then
                v104 = true;
            elseif v103 == v103 then
                v104 = false;
            else
                v104 = v102 ~= v102;
            end;

            if not v104 then
                u95(v102);
                markRootMutableRead(u92, (requestUpdateLane(u98)));
            end;

            markRootEntangled(u92, u92.mutableReadLanes);
        end;
    end, { u90, u89, u91 });
    current.useEffect(function() -- Line: 1046
        -- upvalues: refs (copy), u89 (copy), requestUpdateLane (ref), u98 (copy), markRootMutableRead (ref), u92 (copy), u91 (copy), _G___DEV__ (ref), console (ref)
        local v105 = u91(u89._source, function() -- Line: 1047
            -- upvalues: refs (ref), u89 (ref), requestUpdateLane (ref), u98 (ref), markRootMutableRead (ref), u92 (ref)
            local getSnapshot2 = refs.getSnapshot;
            local setSnapshot = refs.setSnapshot;
            local success, result = pcall(function() -- Line: 1052
                -- upvalues: setSnapshot (copy), getSnapshot2 (copy), u89 (ref), requestUpdateLane (ref), u98 (ref), markRootMutableRead (ref), u92 (ref)
                setSnapshot(getSnapshot2(u89._source));
                markRootMutableRead(u92, (requestUpdateLane(u98)));
            end);

            if not success then
                setSnapshot(function() -- Line: 1066
                    -- upvalues: result (copy)
                    error(result);
                end);
            end;
        end);

        if _G___DEV__ and type(v105) ~= "function" then
            console.error("Mutable source subscribe function must return an unsubscribe function.");
        end;

        return v105;
    end, { u89, u91 });
    local v106;

    if getSnapshot == u90 and (getSnapshot ~= 0 or 1 / getSnapshot == 1 / u90) then
        v106 = true;
    elseif getSnapshot == getSnapshot then
        v106 = false;
    else
        v106 = u90 ~= u90;
    end;

    local u107, u108;

    if v106 then
        local v109;

        if source == u89 and (source ~= 0 or 1 / source == 1 / u89) then
            v109 = true;
        elseif source == source then
            v109 = false;
        else
            v109 = u89 ~= u89;
        end;

        if v109 then
            local v110;

            if subscribe == u91 and (subscribe ~= 0 or 1 / subscribe == 1 / u91) then
                v110 = true;
            elseif subscribe == subscribe then
                v110 = false;
            else
                v110 = u91 ~= u91;
            end;

            if not v110 then
                u107 = {
                    pending = nil,
                    dispatch = nil,
                    lastRenderedReducer = basicStateReducer,
                    lastRenderedState = u96
                };
                u108 = u11;

                u95 = function(...) -- Line: 1115
                    -- upvalues: u108 (copy), u107 (copy)
                    dispatchAction(u108, u107, ...);
                end;

                u107.dispatch = u95;
                v97.queue = u107;
                v97.baseQueue = nil;
                u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
                v97.baseState = u96;
                v97.memoizedState = v97.baseState;
            end;
        else
            u107 = {
                pending = nil,
                dispatch = nil,
                lastRenderedReducer = basicStateReducer,
                lastRenderedState = u96
            };
            u108 = u11;

            u95 = function(...) -- Line: 1115
                -- upvalues: u108 (copy), u107 (copy)
                dispatchAction(u108, u107, ...);
            end;

            u107.dispatch = u95;
            v97.queue = u107;
            v97.baseQueue = nil;
            u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
            v97.baseState = u96;
            v97.memoizedState = v97.baseState;
        end;
    else
        u107 = {
            pending = nil,
            dispatch = nil,
            lastRenderedReducer = basicStateReducer,
            lastRenderedState = u96
        };
        u108 = u11;

        u95 = function(...) -- Line: 1115
            -- upvalues: u108 (copy), u107 (copy)
            dispatchAction(u108, u107, ...);
        end;

        u107.dispatch = u95;
        v97.queue = u107;
        v97.baseQueue = nil;
        u96 = readFromUnsubcribedMutableSource(u92, u89, u90);
        v97.baseState = u96;
        v97.memoizedState = v97.baseState;
    end;

    return u96;
end;

function mountMutableSource(p111, p112, p113)
    -- upvalues: u13 (ref), u11 (ref)
    local v114 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v114;
        u13 = v114;
    else
        u13.next = v114;
        u13 = v114;
    end;

    local v115 = u13;
    v115.memoizedState = {
        refs = {
            setSnapshot = nil,
            getSnapshot = p112
        },
        source = p111,
        subscribe = p113
    };

    return useMutableSource(v115, p111, p112, p113);
end;

function updateMutableSource(p116, p117, p118)
    -- upvalues: updateWorkInProgressHook (copy)
    local v119 = updateWorkInProgressHook();

    return useMutableSource(v119, p116, p117, p118);
end;

function mountState(p120)
    -- upvalues: u13 (ref), u11 (ref)
    local v121 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v121;
        u13 = v121;
    else
        u13.next = v121;
        u13 = v121;
    end;

    local v122 = u13;

    if type(p120) == "function" then
        p120 = p120();
    end;

    v122.baseState = p120;
    v122.memoizedState = v122.baseState;
    local u123 = {
        pending = nil,
        dispatch = nil,
        lastRenderedReducer = nil,
        lastRenderedState = p120,
        lastRenderedReducer = basicStateReducer
    };
    v122.queue = u123;
    local u124 = u11;

    local function v126(p125, ...) -- Line: 1189
        -- upvalues: u124 (copy), u123 (copy)
        dispatchAction(u124, u123, p125, ...);
    end;

    u123.dispatch = v126;

    return v122.memoizedState, v126;
end;

function updateState(p127)
    return updateReducer(basicStateReducer, p127);
end;

function rerenderState(p128)
    return rerenderReducer(basicStateReducer, p128);
end;

local function pushEffect(p129, p130, p131, p132) -- Line: 1206
    -- upvalues: u11 (ref)
    local v133 = {
        next = nil,
        tag = p129,
        create = p130,
        destroy = p131,
        deps = p132
    };
    local updateQueue = u11.updateQueue;

    if updateQueue == nil then
        local v134 = {
            lastEffect = nil
        };
        u11.updateQueue = v134;
        v133.next = v133;
        v134.lastEffect = v133;

        return v133;
    end;

    local lastEffect = updateQueue.lastEffect;

    if lastEffect == nil then
        updateQueue.lastEffect = v133;
        v133.next = v133;

        return v133;
    end;

    local next = lastEffect.next;
    lastEffect.next = v133;
    v133.next = next;
    updateQueue.lastEffect = v133;

    return v133;
end;

function mountBinding(p135)
    -- upvalues: u13 (ref), u11 (ref), createBinding (copy)
    local v136 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v136;
        u13 = v136;
    else
        u13.next = v136;
        u13 = v136;
    end;

    local v137, v138 = createBinding(p135);
    u13.memoizedState = { v137, v138 };

    return v137, v138;
end;

function updateBinding(p139)
    -- upvalues: updateWorkInProgressHook (copy)
    local memoizedState = updateWorkInProgressHook().memoizedState;

    return unpack(memoizedState);
end;

function mountRef(p140)
    -- upvalues: u13 (ref), u11 (ref), createRef (copy)
    local v141 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v141;
        u13 = v141;
    else
        u13.next = v141;
        u13 = v141;
    end;

    local v142 = createRef();
    v142.current = p140;
    u13.memoizedState = v142;

    return v142;
end;

function updateRef(p143)
    -- upvalues: updateWorkInProgressHook (copy)
    return updateWorkInProgressHook().memoizedState;
end;

local function mountEffectImpl(p144, p145, p146, p147) -- Line: 1273
    -- upvalues: u13 (ref), u11 (ref), pushEffect (copy), HasEffect (copy)
    local v148 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v148;
        u13 = v148;
    else
        u13.next = v148;
        u13 = v148;
    end;

    u11.flags = bit32.bor(u11.flags, p144);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, p145), p146, nil, p147);
end;

function updateEffectImpl(p149: any, p150: any, p151: any, p152: table?)
    -- upvalues: updateWorkInProgressHook (copy), u12 (ref), areHookInputsEqual (copy), pushEffect (copy), u11 (ref), HasEffect (copy)
    local v153 = updateWorkInProgressHook();
    local v154;

    if u12 == nil then
        v154 = nil;
    else
        local memoizedState = u12.memoizedState;
        v154 = memoizedState.destroy;

        if p152 ~= nil and areHookInputsEqual(p152, memoizedState.deps) then
            v153.memoizedState = pushEffect(p150, p151, v154, p152);

            return;
        end;
    end;

    u11.flags = bit32.bor(u11.flags, p149);
    v153.memoizedState = pushEffect(bit32.bor(HasEffect, p150), p151, v154, p152);
end;

local function mountEffect(p155: function, p156: table?) -- Line: 1311
    -- upvalues: _G___DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), u11 (ref), enableDoubleInvokingEffects (copy), MountPassiveDev (copy), Passive (copy), PassiveStatic (copy), Passive2 (copy), u13 (ref), pushEffect (copy), HasEffect (copy)
    if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(u11);
    end;

    if _G___DEV__ and enableDoubleInvokingEffects then
        local bit32_bor_ret = bit32.bor(MountPassiveDev, Passive, PassiveStatic);
        local v157 = {
            memoizedState = nil,
            baseState = nil,
            baseQueue = nil,
            queue = nil,
            next = nil
        };

        if u13 == nil then
            u11.memoizedState = v157;
            u13 = v157;
        else
            u13.next = v157;
            u13 = v157;
        end;

        u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
        u13.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p155, nil, p156);

        return;
    end;

    local bit32_bor_ret = bit32.bor(Passive, PassiveStatic);
    local v158 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v158;
        u13 = v158;
    else
        u13.next = v158;
        u13 = v158;
    end;

    u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, Passive2), p155, nil, p156);
end;

local function updateEffect(p159: function, p160: table?) -- Line: 1341
    -- upvalues: _G___DEV__ (copy), warnIfNotCurrentlyActingEffectsInDEV (copy), u11 (ref), Passive (copy), Passive2 (copy)
    if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
        warnIfNotCurrentlyActingEffectsInDEV(u11);
    end;

    updateEffectImpl(Passive, Passive2, p159, p160);
end;

local function mountLayoutEffect(p161: function, p162: table?) -- Line: 1356
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), MountLayoutDev (copy), Update (copy), Layout (copy), u13 (ref), u11 (ref), pushEffect (copy), HasEffect (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        local bit32_bor_ret = bit32.bor(MountLayoutDev, Update);
        local v163 = {
            memoizedState = nil,
            baseState = nil,
            baseQueue = nil,
            queue = nil,
            next = nil
        };

        if u13 == nil then
            u11.memoizedState = v163;
            u13 = v163;
        else
            u13.next = v163;
            u13 = v163;
        end;

        u11.flags = bit32.bor(u11.flags, bit32_bor_ret);
        u13.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p161, nil, p162);

        return;
    end;

    local v164 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v164;
        u13 = v164;
    else
        u13.next = v164;
        u13 = v164;
    end;

    u11.flags = bit32.bor(u11.flags, Update);
    u13.memoizedState = pushEffect(bit32.bor(HasEffect, Layout), p161, nil, p162);
end;

local function updateLayoutEffect(p165: function, p166: table?) -- Line: 1373
    -- upvalues: Update (copy), Layout (copy)
    updateEffectImpl(Update, Layout, p165, p166);
end;

function imperativeHandleEffect(p167: function, u168: any)
    -- upvalues: _G___DEV__ (copy), Object (copy), console (copy), Array (copy)
    if u168 ~= nil and type(u168) == "function" then
        u168((p167()));

        return function() -- Line: 1390
            -- upvalues: u168 (copy)
            return u168(nil);
        end;
    end;

    if u168 == nil then
        return nil;
    end;

    if _G___DEV__ then
        local v169;

        if getmetatable(u168) == nil then
            v169 = false;
        else
            v169 = #Object.keys(u168) == 0;
        end;

        if not v169 then
            console.error("Expected useImperativeHandle() first argument to either be a ref callback or React.createRef() object. Instead received: %s.", "an object with keys {" .. Array.join(Object.keys(u168), ", ") .. "}");
        end;
    end;

    u168.current = p167();

    return function() -- Line: 1415
        -- upvalues: u168 (copy)
        u168.current = nil;
    end;
end;

function mountImperativeHandle(u170: any, u171: function, p172: table?)
    -- upvalues: _G___DEV__ (copy), console (copy), Array (copy), enableDoubleInvokingEffects (copy), mountEffectImpl (copy), MountLayoutDev (copy), Update (copy), Layout (copy)
    if _G___DEV__ and type(u171) ~= "function" then
        console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", u171 == nil and "nil" or type(u171));
    end;

    local v173;

    if p172 == nil then
        v173 = nil;
    else
        v173 = Array.concat(p172, { u170 });
    end;

    if _G___DEV__ and enableDoubleInvokingEffects then
        return mountEffectImpl(bit32.bor(MountLayoutDev, Update), Layout, function() -- Line: 1447
            -- upvalues: u171 (copy), u170 (copy)
            return imperativeHandleEffect(u171, u170);
        end, v173);
    end;

    return mountEffectImpl(Update, Layout, function() -- Line: 1453
        -- upvalues: u171 (copy), u170 (copy)
        return imperativeHandleEffect(u171, u170);
    end, v173);
end;

function updateImperativeHandle(u174: any, u175: function, p176: table?)
    -- upvalues: _G___DEV__ (copy), console (copy), Update (copy), Layout (copy)
    if _G___DEV__ and type(u175) ~= "function" then
        local v177 = not u175 and "nil" or type(u175);
        console.error("Expected useImperativeHandle() second argument to be a function that creates a handle. Instead received: %s.", v177);
    end;

    local v178;

    if p176 == nil then
        v178 = nil;
    else
        v178 = table.clone(p176);
        table.insert(v178, u174);
    end;

    return updateEffectImpl(Update, Layout, function() -- Line: 1486
        -- upvalues: u175 (copy), u174 (copy)
        return imperativeHandleEffect(u175, u174);
    end, v178);
end;

function mountDebugValue(p179: any, p180: function?)
end;

local l_mountDebugValue = mountDebugValue;

function mountCallback(p181: any, p182: table?)
    -- upvalues: u13 (ref), u11 (ref)
    local v183 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v183;
        u13 = v183;
    else
        u13.next = v183;
        u13 = v183;
    end;

    u13.memoizedState = { p181, p182 };

    return p181;
end;

function updateCallback(p184: any, p185: table?)
    -- upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy)
    local v186 = updateWorkInProgressHook();
    local memoizedState = v186.memoizedState;

    if memoizedState ~= nil and (p185 ~= nil and areHookInputsEqual(p185, memoizedState[2])) then
        return memoizedState[1];
    end;

    v186.memoizedState = { p184, p185 };

    return p184;
end;

function mountMemo(p187: function, p188: table?)
    -- upvalues: u13 (ref), u11 (ref)
    local v189 = {
        memoizedState = nil,
        baseState = nil,
        baseQueue = nil,
        queue = nil,
        next = nil
    };

    if u13 == nil then
        u11.memoizedState = v189;
        u13 = v189;
    else
        u13.next = v189;
        u13 = v189;
    end;

    local v190 = { p187() };
    u13.memoizedState = { v190, p188 };

    return unpack(v190);
end;

function updateMemo(p191: function, p192: table?)
    -- upvalues: updateWorkInProgressHook (copy), areHookInputsEqual (copy)
    local v193 = updateWorkInProgressHook();
    local memoizedState = v193.memoizedState;

    if memoizedState ~= nil and (p192 ~= nil and areHookInputsEqual(p192, memoizedState[2])) then
        return unpack(memoizedState[1]);
    end;

    local v194 = { p191() };
    v193.memoizedState = { v194, p192 };

    return unpack(v194);
end;

function u9.getIsUpdatingOpaqueValueInRenderPhaseInDEV() -- Line: 1688
    -- upvalues: _G___DEV__ (copy)
    if _G___DEV__ then
        return false;
    end;

    return nil;
end;

function mountOpaqueIdentifier()
    -- upvalues: _G___DEV__ (copy), console (copy), makeClientId (copy), getIsHydrating (copy)
    local v195 = nil;

    if _G___DEV__ then
        console.warn("!!! unimplemented: warnOnOpaqueIdentifierAccessInDEV");
    else
        v195 = makeClientId;
    end;

    if not getIsHydrating() then
        local v196 = v195();
        mountState(v196);

        return v196;
    end;

    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: ReactFiberHooks: getIsHydrating() true");
    error("FIXME (roblox): ReactFiberHooks: getIsHydrating() true is unimplemented");

    return nil;
end;

function updateOpaqueIdentifier()
    local v197, _ = updateState(nil);

    return v197;
end;

function rerenderOpaqueIdentifier()
    local v198, _ = rerenderState(nil);

    return v198;
end;

function dispatchAction(p199: any, p200: table, p201: any, ...)
    -- upvalues: _G___DEV__ (copy), console (copy), requestEventTime (copy), requestUpdateLane (copy), u11 (ref), u14 (ref), u15 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), u24 (ref), warnIfNotScopedWithMatchingAct (copy), warnIfNotCurrentlyActingUpdatesInDEV (copy), scheduleUpdateOnFiber (copy), enableDebugTracing (copy), DebugTracingMode (copy), getComponentName (copy), logStateUpdateScheduled (copy), enableSchedulingProfiler (copy), markStateUpdateScheduled (copy)
    if _G___DEV__ then
        local v202;

        if select("#", ...) == 1 then
            v202 = select(1, ...);
        else
            v202 = nil;
        end;

        if type(v202) == "function" then
            console.error("State updates from the useState() and useReducer() Hooks don\'t support the second callback argument. To execute a side effect after rendering, declare it in the component body with useEffect().");
        end;
    end;

    local v203 = requestEventTime();
    local v204 = requestUpdateLane(p199);
    local v205 = {
        eagerReducer = nil,
        eagerState = nil,
        next = nil,
        lane = v204,
        action = p201
    };
    local pending = p200.pending;

    if pending == nil then
        v205.next = v205;
    else
        v205.next = pending.next;
        pending.next = v205;
    end;

    p200.pending = v205;
    local alternate = p199.alternate;

    if p199 == u11 or alternate ~= nil and alternate == u11 then
        u14 = true;
        u15 = true;
    else
        if p199.lanes == NoLanes and (alternate == nil or alternate.lanes == NoLanes) then
            local lastRenderedReducer = p200.lastRenderedReducer;

            if lastRenderedReducer ~= nil then
                local v206;

                if _G___DEV__ then
                    v206 = ReactCurrentDispatcher.current;
                    ReactCurrentDispatcher.current = u24;
                else
                    v206 = nil;
                end;

                local lastRenderedState = p200.lastRenderedState;
                local success, result = pcall(lastRenderedReducer, lastRenderedState, p201);

                if success then
                    v205.eagerReducer = lastRenderedReducer;
                    v205.eagerState = result;
                end;

                if _G___DEV__ then
                    ReactCurrentDispatcher.current = v206;
                end;

                local v207;

                if result == lastRenderedState and (result ~= 0 or 1 / result == 1 / lastRenderedState) then
                    v207 = true;
                elseif result == result then
                    v207 = false;
                else
                    v207 = lastRenderedState ~= lastRenderedState;
                end;

                if v207 then
                    return;
                end;
            end;
        end;

        if _G___DEV__ and (type(_G.jest) ~= "nil" or _G.__TESTEZ_RUNNING_TEST__) then
            warnIfNotScopedWithMatchingAct(p199);
            warnIfNotCurrentlyActingUpdatesInDEV(p199);
        end;

        scheduleUpdateOnFiber(p199, v204, v203);
    end;

    if _G___DEV__ and (enableDebugTracing and bit32.band(p199.mode, DebugTracingMode) ~= 0) then
        logStateUpdateScheduled(getComponentName(p199.type) or "Unknown", v204, p201);
    end;

    if enableSchedulingProfiler then
        markStateUpdateScheduled(p199, v204);
    end;
end;

local u208 = {
    readContext = readContext,
    useCallback = throwInvalidHookError,
    useContext = throwInvalidHookError,
    useEffect = throwInvalidHookError,
    useImperativeHandle = throwInvalidHookError,
    useLayoutEffect = throwInvalidHookError,
    useMemo = throwInvalidHookError,
    useReducer = throwInvalidHookError,
    useRef = throwInvalidHookError,
    useBinding = throwInvalidHookError,
    useState = throwInvalidHookError,
    useDebugValue = throwInvalidHookError,
    useMutableSource = throwInvalidHookError,
    useOpaqueIdentifier = throwInvalidHookError,
    unstable_isNewReconciler = enableNewReconciler
};
u9.ContextOnlyDispatcher = u208;
local u209 = {
    readContext = readContext,
    useCallback = mountCallback,
    useContext = readContext,
    useEffect = mountEffect,
    useImperativeHandle = mountImperativeHandle,
    useLayoutEffect = mountLayoutEffect,
    useMemo = mountMemo,
    useReducer = mountReducer,
    useRef = mountRef,
    useBinding = mountBinding,
    useState = mountState,
    useDebugValue = mountDebugValue,
    useMutableSource = mountMutableSource,
    useOpaqueIdentifier = mountOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};
local u210 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = updateReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = updateState,
    useDebugValue = l_mountDebugValue,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = updateOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};
local u211 = {
    readContext = readContext,
    useCallback = updateCallback,
    useContext = readContext,
    useEffect = updateEffect,
    useImperativeHandle = updateImperativeHandle,
    useLayoutEffect = updateLayoutEffect,
    useMemo = updateMemo,
    useReducer = rerenderReducer,
    useRef = updateRef,
    useBinding = updateBinding,
    useState = rerenderState,
    useDebugValue = l_mountDebugValue,
    useMutableSource = updateMutableSource,
    useOpaqueIdentifier = rerenderOpaqueIdentifier,
    unstable_isNewReconciler = enableNewReconciler
};

if _G___DEV__ then
    local function _() -- Line: 2002
        -- upvalues: console (copy)
        console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");
    end;

    local function _() -- Line: 2011
        -- upvalues: console (copy)
        console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
    end;

    u19 = {
        readContext = function(p212, p213) -- Line: 2021, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p212, p213);
        end,

        useCallback = function(p214: any, p215: table?) -- Line: 2024, Name: useCallback
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy)
            u16 = "useCallback";

            if _G___DEV__ then
                local v216 = u16;

                if u17 == nil then
                    u17 = { v216 };
                else
                    table.insert(u17, v216);
                end;
            end;

            if _G___DEV__ and p215 ~= nil then
                local v217;

                if type(p215) == "table" then
                    v217 = true;

                    for i, _ in p215 do
                        if type(i) ~= "number" then
                            v217 = false;
                            break;
                        end;
                    end;
                else
                    v217 = false;
                end;

                if not v217 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p215)));
                end;
            end;

            return mountCallback(p214, p215);
        end,

        useContext = function(p218, p219) -- Line: 2030, Name: useContext
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), readContext (copy)
            u16 = "useContext";

            if _G___DEV__ then
                local v220 = u16;

                if u17 == nil then
                    u17 = { v220 };
                else
                    table.insert(u17, v220);
                end;
            end;

            return readContext(p218, p219);
        end,

        useEffect = function(p221: function, p222: table?) -- Line: 2035, Name: useEffect
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), mountEffect (copy)
            u16 = "useEffect";

            if _G___DEV__ then
                local v223 = u16;

                if u17 == nil then
                    u17 = { v223 };
                else
                    table.insert(u17, v223);
                end;
            end;

            if _G___DEV__ and p222 ~= nil then
                local v224;

                if type(p222) == "table" then
                    v224 = true;

                    for i, _ in p222 do
                        if type(i) ~= "number" then
                            v224 = false;
                            break;
                        end;
                    end;
                else
                    v224 = false;
                end;

                if not v224 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p222)));
                end;
            end;

            return mountEffect(p221, p222);
        end,

        useImperativeHandle = function(p225: any, p226: function, p227: table?) -- Line: 2045, Name: useImperativeHandle
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy)
            u16 = "useImperativeHandle";

            if _G___DEV__ then
                local v228 = u16;

                if u17 == nil then
                    u17 = { v228 };
                else
                    table.insert(u17, v228);
                end;
            end;

            if _G___DEV__ and p227 ~= nil then
                local v229;

                if type(p227) == "table" then
                    v229 = true;

                    for i, _ in p227 do
                        if type(i) ~= "number" then
                            v229 = false;
                            break;
                        end;
                    end;
                else
                    v229 = false;
                end;

                if not v229 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p227)));
                end;
            end;

            return mountImperativeHandle(p225, p226, p227);
        end,

        useLayoutEffect = function(p230: function, p231: table?) -- Line: 2055, Name: useLayoutEffect
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";

            if _G___DEV__ then
                local v232 = u16;

                if u17 == nil then
                    u17 = { v232 };
                else
                    table.insert(u17, v232);
                end;
            end;

            if _G___DEV__ and p231 ~= nil then
                local v233;

                if type(p231) == "table" then
                    v233 = true;

                    for i, _ in p231 do
                        if type(i) ~= "number" then
                            v233 = false;
                            break;
                        end;
                    end;
                else
                    v233 = false;
                end;

                if not v233 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p231)));
                end;
            end;

            return mountLayoutEffect(p230, p231);
        end,

        useMemo = function(p234: function, p235: table?) -- Line: 2066
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), console (copy), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";

            if _G___DEV__ then
                local v236 = u16;

                if u17 == nil then
                    u17 = { v236 };
                else
                    table.insert(u17, v236);
                end;
            end;

            if _G___DEV__ and p235 ~= nil then
                local v237;

                if type(p235) == "table" then
                    v237 = true;

                    for i, _ in p235 do
                        if type(i) ~= "number" then
                            v237 = false;
                            break;
                        end;
                    end;
                else
                    v237 = false;
                end;

                if not v237 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p235)));
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v238 = { pcall(mountMemo, p234, p235) };
            ReactCurrentDispatcher.current = current;

            if not v238[1] then
                error(v238[2]);
            end;

            return unpack(v238, 2);
        end,

        useReducer = function(p239: function, p240: any, p241: function?) -- Line: 2084, Name: useReducer
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";

            if _G___DEV__ then
                local v242 = u16;

                if u17 == nil then
                    u17 = { v242 };
                else
                    table.insert(u17, v242);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v243, v244, v245 = pcall(mountReducer, p239, p240, p241);
            ReactCurrentDispatcher.current = current;

            if not v243 then
                error(v244);
            end;

            return v244, v245;
        end,

        useRef = function(p246) -- Line: 2102, Name: useRef
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useRef";

            if _G___DEV__ then
                local v247 = u16;

                if u17 == nil then
                    u17 = { v247 };
                else
                    table.insert(u17, v247);
                end;
            end;

            return mountRef(p246);
        end,

        useBinding = function(p248) -- Line: 2108, Name: useBinding
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useBinding";

            if _G___DEV__ then
                local v249 = u16;

                if u17 == nil then
                    u17 = { v249 };
                else
                    table.insert(u17, v249);
                end;
            end;

            return mountBinding(p248);
        end,

        useState = function(p250) -- Line: 2113, Name: useState
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";

            if _G___DEV__ then
                local v251 = u16;

                if u17 == nil then
                    u17 = { v251 };
                else
                    table.insert(u17, v251);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v252, v253, v254 = pcall(mountState, p250);
            ReactCurrentDispatcher.current = current;

            if not v252 then
                error(v253);
            end;

            return v253, v254;
        end,

        useDebugValue = function(p255: any, p256: function?) -- Line: 2127, Name: useDebugValue
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useDebugValue";

            if _G___DEV__ then
                local v257 = u16;

                if u17 == nil then
                    u17 = { v257 };
                else
                    table.insert(u17, v257);
                end;
            end;

            return mountDebugValue(p255, p256);
        end,

        useMutableSource = function(p258, p259, p260) -- Line: 2142, Name: useMutableSource
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useMutableSource";

            if _G___DEV__ then
                local v261 = u16;

                if u17 == nil then
                    u17 = { v261 };
                else
                    table.insert(u17, v261);
                end;
            end;

            return mountMutableSource(p258, p259, p260);
        end,

        useOpaqueIdentifier = function() -- Line: 2157, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), _G___DEV__ (copy), u17 (ref)
            u16 = "useOpaqueIdentifier";

            if _G___DEV__ then
                local v262 = u16;

                if u17 == nil then
                    u17 = { v262 };
                else
                    table.insert(u17, v262);
                end;
            end;

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u20 = {
        readContext = function(p263, p264) -- Line: 2167, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p263, p264);
        end,

        useCallback = function(p265: any, p266: table?) -- Line: 2170, Name: useCallback
            -- upvalues: u16 (ref), _G___DEV__ (copy), console (copy)
            u16 = "useCallback";
            updateHookTypesDev();

            if _G___DEV__ and p266 ~= nil then
                local v267;

                if type(p266) == "table" then
                    v267 = true;

                    for i, _ in p266 do
                        if type(i) ~= "number" then
                            v267 = false;
                            break;
                        end;
                    end;
                else
                    v267 = false;
                end;

                if not v267 then
                    console.error("%s received a final argument that is not an array (instead, received `%s`). When specified, the final argument must be an array.", u16, (type(p266)));
                end;
            end;

            return mountCallback(p265, p266);
        end,

        useContext = function(p268, p269) -- Line: 2176, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p268, p269);
        end,

        useEffect = function(p270: function, p271: table?) -- Line: 2181, Name: useEffect
            -- upvalues: u16 (ref), mountEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return mountEffect(p270, p271);
        end,

        useImperativeHandle = function(p272: any, p273: function, p274: table?) -- Line: 2190, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return mountImperativeHandle(p272, p273, p274);
        end,

        useLayoutEffect = function(p275: function, p276: table?) -- Line: 2199, Name: useLayoutEffect
            -- upvalues: u16 (ref), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return mountLayoutEffect(p275, p276);
        end,

        useMemo = function(p277: function, p278: table?) -- Line: 2209
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v279 = { pcall(mountMemo, p277, p278) };
            ReactCurrentDispatcher.current = current;

            if not v279[1] then
                error(v279[2]);
            end;

            return unpack(v279, 2);
        end,

        useReducer = function(p280: function, p281: any, p282: function?) -- Line: 2225, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v283, v284, v285 = pcall(mountReducer, p280, p281, p282);
            ReactCurrentDispatcher.current = current;

            if not v283 then
                error(v284);
            end;

            return v284, v285;
        end,

        useRef = function(p286) -- Line: 2243, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return mountRef(p286);
        end,

        useBinding = function(p287) -- Line: 2249, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return mountBinding(p287);
        end,

        useState = function(p288) -- Line: 2254, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v289, v290, v291 = pcall(mountState, p288);
            ReactCurrentDispatcher.current = current;

            if not v289 then
                error(v290);
            end;

            return v290, v291;
        end,

        useDebugValue = function(p292: any, p293: function?) -- Line: 2268, Name: useDebugValue
            -- upvalues: u16 (ref)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return mountDebugValue(p292, p293);
        end,

        useMutableSource = function(p294, p295, p296) -- Line: 2283, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return mountMutableSource(p294, p295, p296);
        end,

        useOpaqueIdentifier = function() -- Line: 2298, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u21 = {
        readContext = function(p297, p298) -- Line: 2308, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p297, p298);
        end,

        useCallback = function(p299: any, p300: table?) -- Line: 2311, Name: useCallback
            -- upvalues: u16 (ref)
            u16 = "useCallback";
            updateHookTypesDev();

            return updateCallback(p299, p300);
        end,

        useContext = function(p301, p302) -- Line: 2316, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p301, p302);
        end,

        useEffect = function(p303: function, p304: table?) -- Line: 2321, Name: useEffect
            -- upvalues: u16 (ref), updateEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return updateEffect(p303, p304);
        end,

        useImperativeHandle = function(p305: any, p306: function, p307: table?) -- Line: 2330, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return updateImperativeHandle(p305, p306, p307);
        end,

        useLayoutEffect = function(p308: function, p309: table?) -- Line: 2339, Name: useLayoutEffect
            -- upvalues: u16 (ref), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return updateLayoutEffect(p308, p309);
        end,

        useMemo = function(p310: function, p311: table?) -- Line: 2349
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v312 = { pcall(updateMemo, p310, p311) };
            ReactCurrentDispatcher.current = current;

            if not v312[1] then
                error(v312[2]);
            end;

            return unpack(v312, 2);
        end,

        useReducer = function(p313: function, p314: any, p315: function?) -- Line: 2365, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v316, v317, v318 = pcall(updateReducer, p313, p314, p315);
            ReactCurrentDispatcher.current = current;

            if not v316 then
                error(v317);
            end;

            return v317, v318;
        end,

        useRef = function(p319) -- Line: 2383, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return updateRef(p319);
        end,

        useBinding = function(p320) -- Line: 2389, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return updateBinding(p320);
        end,

        useState = function(p321) -- Line: 2394, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v322, v323, v324 = pcall(updateState, p321);
            ReactCurrentDispatcher.current = current;

            if not v322 then
                error(v323);
            end;

            return v323, v324;
        end,

        useDebugValue = function(p325: any, p326: function?) -- Line: 2408, Name: useDebugValue
            -- upvalues: u16 (ref), l_mountDebugValue (copy)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return l_mountDebugValue(p325, p326);
        end,

        useMutableSource = function(p327, p328, p329) -- Line: 2423, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return updateMutableSource(p327, p328, p329);
        end,

        useOpaqueIdentifier = function() -- Line: 2438, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return updateOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u22 = {
        readContext = function(p330, p331) -- Line: 2448, Name: readContext
            -- upvalues: readContext (copy)
            return readContext(p330, p331);
        end,

        useCallback = function(p332: any, p333: table?) -- Line: 2451, Name: useCallback
            -- upvalues: u16 (ref)
            u16 = "useCallback";
            updateHookTypesDev();

            return mountCallback(p332, p333);
        end,

        useContext = function(p334, p335) -- Line: 2456, Name: useContext
            -- upvalues: u16 (ref), readContext (copy)
            u16 = "useContext";
            updateHookTypesDev();

            return readContext(p334, p335);
        end,

        useEffect = function(p336: function, p337: table?) -- Line: 2461, Name: useEffect
            -- upvalues: u16 (ref), updateEffect (copy)
            u16 = "useEffect";
            updateHookTypesDev();

            return updateEffect(p336, p337);
        end,

        useImperativeHandle = function(p338: any, p339: function, p340: table?) -- Line: 2470, Name: useImperativeHandle
            -- upvalues: u16 (ref)
            u16 = "useImperativeHandle";
            updateHookTypesDev();

            return updateImperativeHandle(p338, p339, p340);
        end,

        useLayoutEffect = function(p341: function, p342: table?) -- Line: 2479, Name: useLayoutEffect
            -- upvalues: u16 (ref), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            updateHookTypesDev();

            return updateLayoutEffect(p341, p342);
        end,

        useMemo = function(p343: function, p344: table?) -- Line: 2489
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useMemo";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v345 = { pcall(updateMemo, p343, p344) };
            ReactCurrentDispatcher.current = current;

            if not v345[1] then
                error(v345[2]);
            end;

            return unpack(v345, 2);
        end,

        useReducer = function(p346: function, p347: any, p348: function?) -- Line: 2505, Name: useReducer
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useReducer";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v349, v350, v351 = pcall(rerenderReducer, p346, p347, p348);
            ReactCurrentDispatcher.current = current;

            if not v349 then
                error(v350);
            end;

            return v350, v351;
        end,

        useRef = function(p352) -- Line: 2524, Name: useRef
            -- upvalues: u16 (ref)
            u16 = "useRef";
            updateHookTypesDev();

            return updateRef(p352);
        end,

        useBinding = function(p353) -- Line: 2530, Name: useBinding
            -- upvalues: u16 (ref)
            u16 = "useBinding";
            updateHookTypesDev();

            return updateBinding(p353);
        end,

        useState = function(p354) -- Line: 2535, Name: useState
            -- upvalues: u16 (ref), ReactCurrentDispatcher (copy), u25 (ref)
            u16 = "useState";
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u25;
            local v355, v356, v357 = pcall(rerenderState, p354);
            ReactCurrentDispatcher.current = current;

            if not v355 then
                error(v356);
            end;

            return v356, v357;
        end,

        useDebugValue = function(p358: any, p359: function?) -- Line: 2549, Name: useDebugValue
            -- upvalues: u16 (ref), l_mountDebugValue (copy)
            u16 = "useDebugValue";
            updateHookTypesDev();

            return l_mountDebugValue(p358, p359);
        end,

        useMutableSource = function(p360, p361, p362) -- Line: 2564, Name: useMutableSource
            -- upvalues: u16 (ref)
            u16 = "useMutableSource";
            updateHookTypesDev();

            return updateMutableSource(p360, p361, p362);
        end,

        useOpaqueIdentifier = function() -- Line: 2579, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref)
            u16 = "useOpaqueIdentifier";
            updateHookTypesDev();

            return rerenderOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u23 = {
        readContext = function(p363, p364) -- Line: 2589, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p363, p364);
        end,

        useCallback = function(p365: any, p366: table?) -- Line: 2593, Name: useCallback
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v367 = u16;

                if u17 == nil then
                    u17 = { v367 };
                else
                    table.insert(u17, v367);
                end;
            end;

            return mountCallback(p365, p366);
        end,

        useContext = function(p368, p369) -- Line: 2599, Name: useContext
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v370 = u16;

                if u17 == nil then
                    u17 = { v370 };
                else
                    table.insert(u17, v370);
                end;
            end;

            return readContext(p368, p369);
        end,

        useEffect = function(p371: function, p372: table?) -- Line: 2605, Name: useEffect
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), mountEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v373 = u16;

                if u17 == nil then
                    u17 = { v373 };
                else
                    table.insert(u17, v373);
                end;
            end;

            return mountEffect(p371, p372);
        end,

        useImperativeHandle = function(p374: any, p375: function, p376: table?) -- Line: 2615, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v377 = u16;

                if u17 == nil then
                    u17 = { v377 };
                else
                    table.insert(u17, v377);
                end;
            end;

            return mountImperativeHandle(p374, p375, p376);
        end,

        useLayoutEffect = function(p378: function, p379: table?) -- Line: 2625, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), mountLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v380 = u16;

                if u17 == nil then
                    u17 = { v380 };
                else
                    table.insert(u17, v380);
                end;
            end;

            return mountLayoutEffect(p378, p379);
        end,

        useMemo = function(p381: function, p382: table?) -- Line: 2636
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v383 = u16;

                if u17 == nil then
                    u17 = { v383 };
                else
                    table.insert(u17, v383);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v384 = { pcall(mountMemo, p381, p382) };
            ReactCurrentDispatcher.current = current;

            if not v384[1] then
                error(v384[2]);
            end;

            return unpack(v384, 2);
        end,

        useReducer = function(p385: function, p386: any, p387: function?) -- Line: 2653, Name: useReducer
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v388 = u16;

                if u17 == nil then
                    u17 = { v388 };
                else
                    table.insert(u17, v388);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v389, v390, v391 = pcall(mountReducer, p385, p386, p387);
            ReactCurrentDispatcher.current = current;

            if not v389 then
                error(v390);
            end;

            return v390, v391;
        end,

        useRef = function(p392) -- Line: 2672, Name: useRef
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v393 = u16;

                if u17 == nil then
                    u17 = { v393 };
                else
                    table.insert(u17, v393);
                end;
            end;

            return mountRef(p392);
        end,

        useBinding = function(p394) -- Line: 2679, Name: useBinding
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v395 = u16;

                if u17 == nil then
                    u17 = { v395 };
                else
                    table.insert(u17, v395);
                end;
            end;

            return mountBinding(p394);
        end,

        useState = function(p396) -- Line: 2685, Name: useState
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref), ReactCurrentDispatcher (copy), u23 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v397 = u16;

                if u17 == nil then
                    u17 = { v397 };
                else
                    table.insert(u17, v397);
                end;
            end;

            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u23;
            local v398, v399, v400 = pcall(mountState, p396);
            ReactCurrentDispatcher.current = current;

            if not v398 then
                error(v399);
            end;

            return v399, v400;
        end,

        useDebugValue = function(p401: any, p402: function?) -- Line: 2700, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v403 = u16;

                if u17 == nil then
                    u17 = { v403 };
                else
                    table.insert(u17, v403);
                end;
            end;

            return mountDebugValue(p401, p402);
        end,

        useMutableSource = function(p404, p405, p406) -- Line: 2718, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v407 = u16;

                if u17 == nil then
                    u17 = { v407 };
                else
                    table.insert(u17, v407);
                end;
            end;

            return mountMutableSource(p404, p405, p406);
        end,

        useOpaqueIdentifier = function() -- Line: 2734, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy), _G___DEV__ (copy), u17 (ref)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");

            if _G___DEV__ then
                local v408 = u16;

                if u17 == nil then
                    u17 = { v408 };
                else
                    table.insert(u17, v408);
                end;
            end;

            return mountOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u24 = {
        readContext = function(p409, p410) -- Line: 2745, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p409, p410);
        end,

        useCallback = function(p411: any, p412: table?) -- Line: 2749, Name: useCallback
            -- upvalues: u16 (ref), console (copy)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return mountCallback(p411, p412);
        end,

        useContext = function(p413, p414) -- Line: 2755, Name: useContext
            -- upvalues: u16 (ref), console (copy), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return readContext(p413, p414);
        end,

        useEffect = function(p415: function, p416: table?) -- Line: 2761, Name: useEffect
            -- upvalues: u16 (ref), console (copy), updateEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateEffect(p415, p416);
        end,

        useImperativeHandle = function(p417: any, p418: function, p419: table?) -- Line: 2771, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateImperativeHandle(p417, p418, p419);
        end,

        useLayoutEffect = function(p420: function, p421: table?) -- Line: 2781, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateLayoutEffect(p420, p421);
        end,

        useMemo = function(p422: function, p423: table?) -- Line: 2792
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v424 = { pcall(updateMemo, p422, p423) };
            ReactCurrentDispatcher.current = current;

            if not v424[1] then
                error(v424[2]);
            end;

            return unpack(v424, 2);
        end,

        useReducer = function(p425: function, p426: any, p427: function?) -- Line: 2809, Name: useReducer
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v428, v429, v430 = pcall(updateReducer, p425, p426, p427);
            ReactCurrentDispatcher.current = current;

            if not v428 then
                error(v429);
            end;

            return v429, v430;
        end,

        useRef = function(p431) -- Line: 2829, Name: useRef
            -- upvalues: u16 (ref), console (copy)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateRef(p431);
        end,

        useBinding = function(p432) -- Line: 2836, Name: useBinding
            -- upvalues: u16 (ref), console (copy)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateBinding(p432);
        end,

        useState = function(p433) -- Line: 2842, Name: useState
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v434, v435, v436 = pcall(updateState, p433);
            ReactCurrentDispatcher.current = current;

            if not v434 then
                error(v435);
            end;

            return v435, v436;
        end,

        useDebugValue = function(p437: any, p438: function?) -- Line: 2857, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), l_mountDebugValue (copy)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return l_mountDebugValue(p437, p438);
        end,

        useMutableSource = function(p439, p440, p441) -- Line: 2875, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateMutableSource(p439, p440, p441);
        end,

        useOpaqueIdentifier = function() -- Line: 2891, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
    u25 = {
        readContext = function(p442, p443) -- Line: 2902, Name: readContext
            -- upvalues: console (copy), readContext (copy)
            console.error("Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo().");

            return readContext(p442, p443);
        end,

        useCallback = function(p444: any, p445: table?) -- Line: 2906, Name: useCallback
            -- upvalues: u16 (ref), console (copy)
            u16 = "useCallback";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateCallback(p444, p445);
        end,

        useContext = function(p446, p447) -- Line: 2912, Name: useContext
            -- upvalues: u16 (ref), console (copy), readContext (copy)
            u16 = "useContext";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return readContext(p446, p447);
        end,

        useEffect = function(p448: function, p449: table?) -- Line: 2918, Name: useEffect
            -- upvalues: u16 (ref), console (copy), updateEffect (copy)
            u16 = "useEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateEffect(p448, p449);
        end,

        useImperativeHandle = function(p450: any, p451: function, p452: table?) -- Line: 2928, Name: useImperativeHandle
            -- upvalues: u16 (ref), console (copy)
            u16 = "useImperativeHandle";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateImperativeHandle(p450, p451, p452);
        end,

        useLayoutEffect = function(p453: function, p454: table?) -- Line: 2938, Name: useLayoutEffect
            -- upvalues: u16 (ref), console (copy), updateLayoutEffect (copy)
            u16 = "useLayoutEffect";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateLayoutEffect(p453, p454);
        end,

        useMemo = function(p455: function, p456: table?) -- Line: 2949
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useMemo";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v457 = { pcall(updateMemo, p455, p456) };
            ReactCurrentDispatcher.current = current;

            if not v457[1] then
                error(v457[2]);
            end;

            return unpack(v457, 2);
        end,

        useReducer = function(p458: function, p459: any, p460: function?) -- Line: 2966, Name: useReducer
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useReducer";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v461, v462, v463 = pcall(rerenderReducer, p458, p459, p460);
            ReactCurrentDispatcher.current = current;

            if not v461 then
                error(v462);
            end;

            return v462, v463;
        end,

        useRef = function(p464) -- Line: 2986, Name: useRef
            -- upvalues: u16 (ref), console (copy)
            u16 = "useRef";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateRef(p464);
        end,

        useBinding = function(p465) -- Line: 2993, Name: useBinding
            -- upvalues: u16 (ref), console (copy)
            u16 = "useBinding";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateBinding(p465);
        end,

        useState = function(p466) -- Line: 2999, Name: useState
            -- upvalues: u16 (ref), console (copy), ReactCurrentDispatcher (copy), u24 (ref)
            u16 = "useState";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();
            local current = ReactCurrentDispatcher.current;
            ReactCurrentDispatcher.current = u24;
            local v467, v468, v469 = pcall(rerenderState, p466);
            ReactCurrentDispatcher.current = current;

            if not v467 then
                error(v468);
            end;

            return v468, v469;
        end,

        useDebugValue = function(p470: any, p471: function?) -- Line: 3014, Name: useDebugValue
            -- upvalues: u16 (ref), console (copy), l_mountDebugValue (copy)
            u16 = "useDebugValue";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return l_mountDebugValue(p470, p471);
        end,

        useMutableSource = function(p472, p473, p474) -- Line: 3032, Name: useMutableSource
            -- upvalues: u16 (ref), console (copy)
            u16 = "useMutableSource";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return updateMutableSource(p472, p473, p474);
        end,

        useOpaqueIdentifier = function() -- Line: 3048, Name: useOpaqueIdentifier
            -- upvalues: u16 (ref), console (copy)
            u16 = "useOpaqueIdentifier";
            console.error("Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. You can only call Hooks at the top level of your React function. For more information, see https://reactjs.org/link/rules-of-hooks");
            updateHookTypesDev();

            return rerenderOpaqueIdentifier();
        end,

        unstable_isNewReconciler = enableNewReconciler
    };
end;

function u9.renderWithHooks(p475: any, p476: any, p477: function, p478: any, p479: any, p480: any) -- Line: 3059
    -- upvalues: u10 (ref), u11 (ref), _G___DEV__ (copy), u17 (ref), u18 (ref), NoLanes (copy), ReactCurrentDispatcher (copy), u21 (ref), u20 (ref), u19 (ref), u209 (copy), u210 (copy), u15 (ref), Error (copy), u12 (ref), u13 (ref), u22 (ref), u211 (copy), u208 (copy), u16 (ref), u14 (ref)
    u10 = p480;
    u11 = p476;

    if _G___DEV__ then
        local v481;

        if p475 == nil then
            v481 = nil;
        else
            v481 = p475._debugHookTypes;
        end;

        u17 = v481;
        u18 = 0;
    end;

    p476.memoizedState = nil;
    p476.updateQueue = nil;
    p476.lanes = NoLanes;

    if _G___DEV__ then
        if p475 == nil or p475.memoizedState == nil then
            if u17 == nil then
                ReactCurrentDispatcher.current = u19;
            else
                ReactCurrentDispatcher.current = u20;
            end;
        else
            ReactCurrentDispatcher.current = u21;
        end;
    else
        ReactCurrentDispatcher.current = (p475 == nil or p475.memoizedState == nil) and u209 or u210;
    end;

    local v482 = p477(p478, p479);

    if u15 then
        local v483 = 0;

        repeat
            u15 = false;

            if v483 >= 25 then
                error(Error.new("Too many re-renders. React limits the number of renders to prevent an infinite loop."));
            end;

            v483 = v483 + 1;
            u12 = nil;
            u13 = nil;
            p476.updateQueue = nil;

            if _G___DEV__ then
                u18 = 0;
            end;

            ReactCurrentDispatcher.current = _G___DEV__ and u22 or u211;
            v482 = p477(p478, p479);
        until not u15;
    end;

    ReactCurrentDispatcher.current = u208;

    if _G___DEV__ then
        p476._debugHookTypes = u17;
    end;

    local v484;

    if u12 == nil then
        v484 = false;
    else
        v484 = u12.next ~= nil;
    end;

    u10 = NoLanes;
    u11 = nil;
    u12 = nil;
    u13 = nil;

    if _G___DEV__ then
        u16 = nil;
        u17 = nil;
        u18 = 0;
    end;

    u14 = false;

    if v484 then
        error(Error.new("Rendered fewer hooks than expected. This may be caused by an accidental early return statement."));
    end;

    return v482;
end;

return u9;