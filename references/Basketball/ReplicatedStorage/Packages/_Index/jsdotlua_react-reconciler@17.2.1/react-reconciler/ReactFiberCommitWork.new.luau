 
 

local function unimplemented(p1: string) -- Line: 11
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

local _G___DEV__ = _G.__DEV__;
local _G___YOLO__ = _G.__YOLO__;
local u2 = 0;

local function isCallable(p3) -- Line: 27
    if typeof(p3) == "function" then
        return true;
    end;

    if typeof(p3) == "table" then
        local v4 = getmetatable(p3);

        if v4 and rawget(v4, "__call") then
            return true;
        end;

        if p3._isMockFunction then
            return true;
        end;
    end;

    return false;
end;

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local v5 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Error = v5.Error;
local Set = v5.Set;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local v6 = require(script.Parent:WaitForChild("ReactUpdateQueue.new"));
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local ReactHookEffectTags = require(script.Parent:WaitForChild("ReactHookEffectTags"));
local unstable_wrap = require(script.Parent.Parent:WaitForChild("scheduler")).tracing.unstable_wrap;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local enableProfilerCommitHooks = ReactFeatureFlags.enableProfilerCommitHooks;
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback;
local enableDoubleInvokingEffects = ReactFeatureFlags.enableDoubleInvokingEffects;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local FunctionComponent = ReactWorkTags.FunctionComponent;
local ForwardRef = ReactWorkTags.ForwardRef;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local Profiler = ReactWorkTags.Profiler;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local DehydratedFragment = ReactWorkTags.DehydratedFragment;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local ScopeComponent = ReactWorkTags.ScopeComponent;
local Block = ReactWorkTags.Block;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
local ReactErrorUtils = require(script.Parent.Parent:WaitForChild("shared")).ReactErrorUtils;
local invokeGuardedCallback = ReactErrorUtils.invokeGuardedCallback;
local hasCaughtError = ReactErrorUtils.hasCaughtError;
local clearCaughtError = ReactErrorUtils.clearCaughtError;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local NoFlags = ReactFiberFlags.NoFlags;
local ContentReset = ReactFiberFlags.ContentReset;
local Placement = ReactFiberFlags.Placement;
local Snapshot = ReactFiberFlags.Snapshot;
local Update = ReactFiberFlags.Update;
local Callback = ReactFiberFlags.Callback;
local LayoutMask = ReactFiberFlags.LayoutMask;
local PassiveMask = ReactFiberFlags.PassiveMask;
local Ref = ReactFiberFlags.Ref;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local describeError = require(script.Parent.Parent:WaitForChild("shared")).describeError;
local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"));
local current = ReactCurrentFiber.current;
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber;
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber;
local onCommitUnmount = require(script.Parent:WaitForChild("ReactFiberDevToolsHook.new")).onCommitUnmount;
local resolveDefaultProps = require(script.Parent:WaitForChild("ReactFiberLazyComponent.new")).resolveDefaultProps;
local v7 = require(script.Parent:WaitForChild("ReactProfilerTimer.new"));
local startLayoutEffectTimer = v7.startLayoutEffectTimer;
local recordPassiveEffectDuration = v7.recordPassiveEffectDuration;
local recordLayoutEffectDuration = v7.recordLayoutEffectDuration;
local startPassiveEffectTimer = v7.startPassiveEffectTimer;
local getCommitTime = v7.getCommitTime;
local ProfileMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).ProfileMode;
local commitUpdateQueue = v6.commitUpdateQueue;
local getPublicInstance = ReactFiberHostConfig.getPublicInstance;
local supportsMutation = ReactFiberHostConfig.supportsMutation;
local supportsPersistence = ReactFiberHostConfig.supportsPersistence;
local supportsHydration = ReactFiberHostConfig.supportsHydration;
local commitMount = ReactFiberHostConfig.commitMount;
local commitUpdate = ReactFiberHostConfig.commitUpdate;
local resetTextContent = ReactFiberHostConfig.resetTextContent;
local commitTextUpdate = ReactFiberHostConfig.commitTextUpdate;
local appendChild = ReactFiberHostConfig.appendChild;
local appendChildToContainer = ReactFiberHostConfig.appendChildToContainer;
local insertBefore = ReactFiberHostConfig.insertBefore;
local insertInContainerBefore = ReactFiberHostConfig.insertInContainerBefore;
local removeChild = ReactFiberHostConfig.removeChild;
local removeChildFromContainer = ReactFiberHostConfig.removeChildFromContainer;
local hideInstance = ReactFiberHostConfig.hideInstance;
local hideTextInstance = ReactFiberHostConfig.hideTextInstance;
local unhideInstance = ReactFiberHostConfig.unhideInstance;
local unhideTextInstance = ReactFiberHostConfig.unhideTextInstance;
local commitHydratedSuspenseInstance = ReactFiberHostConfig.commitHydratedSuspenseInstance;
local clearContainer = ReactFiberHostConfig.clearContainer;
local u8 = nil;

local function resolveRetryWakeable(p9, p10) -- Line: 190
    -- upvalues: u8 (ref)
    if not u8 then
        u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u8.resolveRetryWakeable(p9, p10);
end;

local function markCommitTimeOfFallback() -- Line: 197
    -- upvalues: u8 (ref)
    if not u8 then
        u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
    end;

    u8.markCommitTimeOfFallback();
end;

local function schedulePassiveEffectCallback() -- Line: 205
    -- upvalues: console (copy)
    console.warn("ReactFiberCommitWork: schedulePassiveEffectCallback causes a dependency cycle\n" .. debug.traceback());
end;

local function captureCommitPhaseError(p11, p12, p13) -- Line: 213
    -- upvalues: console (copy)
    console.warn("ReactFiberCommitWork: captureCommitPhaseError causes a dependency cycle");
    error(p13);
end;

local NoFlags2 = ReactHookEffectTags.NoFlags;
local HasEffect = ReactHookEffectTags.HasEffect;
local Layout = ReactHookEffectTags.Layout;
local Passive = ReactHookEffectTags.Passive;
local u14 = nil;

local function u15() -- Line: 231
    -- upvalues: u14 (ref)
    if not u14 then
        u14 = require(script.Parent:WaitForChild("ReactFiberBeginWork.new")).didWarnAboutReassigningProps;
    end;

    return u14;
end;

local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = nil;
local u21 = nil;
local u22 = nil;
local u23 = nil;

local function callComponentWillUnmountWithTimer(p24, u25) -- Line: 256
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy)
    u25.props = p24.memoizedProps;
    u25.state = p24.memoizedState;

    if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p24.mode, ProfileMode) ~= 0) then
        local v26, v27 = xpcall(function() -- Line: 265
            -- upvalues: startLayoutEffectTimer (ref), u25 (copy)
            startLayoutEffectTimer();
            u25:componentWillUnmount();
        end, describeError);
        recordLayoutEffectDuration(p24);

        if not v26 then
            error(v27);
        end;
    else
        u25:componentWillUnmount();
    end;
end;

function safelyCallComponentWillUnmount(p28, p29, p30)
    -- upvalues: callComponentWillUnmountWithTimer (copy), describeError (copy), captureCommitPhaseError (ref)
    local v31, v32 = xpcall(callComponentWillUnmountWithTimer, describeError, p28, p29);

    if not v31 then
        captureCommitPhaseError(p28, p30, v32);
    end;
end;

local function safelyDetachRef(p33, p34) -- Line: 297
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local ref = p33.ref;

    if ref ~= nil then
        if typeof(ref) == "function" then
            local v35, v36 = xpcall(ref, describeError);

            if not v35 then
                captureCommitPhaseError(p33, p34, v36);
            end;
        else
            ref.current = nil;
        end;
    end;
end;

local function safelyCallDestroy(p37: any, p38: any, p39: function) -- Line: 313
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local v40, v41 = xpcall(p39, describeError);

    if not v40 then
        captureCommitPhaseError(p37, p38, v41);
    end;
end;

local function commitHookEffectListUnmount(p42, p43, p44) -- Line: 418
    -- upvalues: describeError (copy), captureCommitPhaseError (ref)
    local updateQueue = p43.updateQueue;
    local v45;

    if updateQueue == nil then
        v45 = nil;
    else
        v45 = updateQueue.lastEffect;
    end;

    if v45 ~= nil then
        local next = v45.next;

        repeat
            if bit32.band(next.tag, p42) == p42 then
                local destroy = next.destroy;
                next.destroy = nil;

                if destroy ~= nil then
                    local v46, v47 = xpcall(destroy, describeError);

                    if not v46 then
                        captureCommitPhaseError(p43, p44, v47);
                    end;
                end;
            end;

            next = next.next;
        until next == next;
    end;
end;

local function commitHookEffectListMount(p48, p49) -- Line: 446
    -- upvalues: _G___DEV__ (copy), console (copy)
    local updateQueue = p49.updateQueue;
    local v50;

    if updateQueue == nil then
        v50 = nil;
    else
        v50 = updateQueue.lastEffect;
    end;

    if v50 ~= nil then
        local next = v50.next;

        repeat
            if bit32.band(next.tag, p48) == p48 then
                next.destroy = next.create();

                if _G___DEV__ then
                    local destroy = next.destroy;

                    if destroy ~= nil and typeof(destroy) ~= "function" then
                        local v51 = destroy == nil and " You returned nil. If your effect does not require clean up, return nil (or nothing)." or (typeof(destroy.andThen) == "function" and "\n\nIt looks like you wrote useEffect(Promise.new(function() --[[...]] end) or returned a Promise. Instead, write the async function inside your effect and call it immediately:\n\nuseEffect(function()\n  function fetchData()\n    -- You can await here\n    local response = MyAPI.getData(someId):await()\n    -- ...\n  end\n  fetchData()\nend, {someId}) -- Or {} if effect doesn\'t need props or state\n\nLearn more about data fetching with Hooks: https://reactjs.org/link/hooks-data-fetching" or " You returned: " .. destroy);
                        console.error("An effect function must not return anything besides a function, which is used for clean-up.%s", v51);
                    end;
                end;
            end;

            next = next.next;
        until next == next;
    end;
end;

function commitProfilerPassiveEffect(p52, p53)
    -- upvalues: enableProfilerTimer (copy), enableProfilerCommitHooks (copy), Profiler (copy), getCommitTime (copy), enableSchedulerTracing (copy)
    if enableProfilerTimer and (enableProfilerCommitHooks and p53.tag == Profiler) then
        local passiveEffectDuration = p53.stateNode.passiveEffectDuration;
        local id = p53.memoizedProps.id;
        local onPostCommit = p53.memoizedProps.onPostCommit;
        local v54 = getCommitTime();

        if typeof(onPostCommit) == "function" then
            if enableSchedulerTracing then
                onPostCommit(id, p53.alternate == nil and "mount" or "update", passiveEffectDuration, v54, p52.memoizedInteractions);

                return;
            end;

            onPostCommit(id, p53.alternate == nil and "mount" or "update", passiveEffectDuration, v54);
        end;
    end;
end;

local function recursivelyCommitLayoutEffects(u55: any, p56: any, p57: function, p58: function) -- Line: 530
    -- upvalues: captureCommitPhaseError (ref), schedulePassiveEffectCallback (ref), Profiler (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), u23 (ref), LayoutMask (copy), NoFlags (copy), _G___DEV__ (copy), current (copy), setCurrentFiber (copy), invokeGuardedCallback (copy), recursivelyCommitLayoutEffects (copy), hasCaughtError (copy), clearCaughtError (copy), resetCurrentFiber (copy), describeError (copy), Update (copy), Callback (copy), ReactCurrentFiber (copy), u2 (ref), _G___YOLO__ (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), recordLayoutEffectDuration (copy), PassiveMask (copy), ClassComponent (copy), u21 (ref), HostRoot (copy), u19 (ref), HostComponent (copy), u20 (ref), SuspenseComponent (copy), FundamentalComponent (copy), HostPortal (copy), HostText (copy), IncompleteClassComponent (copy), LegacyHiddenComponent (copy), OffscreenComponent (copy), ScopeComponent (copy), SuspenseListComponent (copy), invariant (copy), Ref (copy)
    if p57 ~= nil then
        captureCommitPhaseError = p57;
    end;

    if p58 ~= nil then
        schedulePassiveEffectCallback = p58;
    end;

    local flags = u55.flags;
    local tag = u55.tag;

    if tag == Profiler then
        local v59;

        if enableProfilerTimer and enableProfilerCommitHooks then
            v59 = u23;
            u23 = u55;
        else
            v59 = nil;
        end;

        local child = u55.child;

        while child ~= nil do
            if bit32.band(u55.subtreeFlags, LayoutMask) ~= NoFlags then
                if _G___DEV__ then
                    local v60 = current;
                    setCurrentFiber(child);
                    invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);

                    if hasCaughtError() then
                        captureCommitPhaseError(child, u55, (clearCaughtError()));
                    end;

                    if v60 == nil then
                        resetCurrentFiber();
                    else
                        setCurrentFiber(v60);
                    end;
                else
                    local v61, v62 = xpcall(recursivelyCommitLayoutEffects, describeError, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);

                    if not v61 then
                        captureCommitPhaseError(child, u55, v62);
                    end;
                end;
            end;

            child = child.sibling;
        end;

        local bit32_bor_ret = bit32.bor(Update, Callback);

        if bit32.band(flags, bit32_bor_ret) ~= NoFlags and enableProfilerTimer then
            if _G___DEV__ then
                local v63 = current;
                setCurrentFiber(u55);
                invokeGuardedCallback(nil, commitLayoutEffectsForProfiler, nil, u55, p56);

                if hasCaughtError() then
                    local v64 = clearCaughtError();
                    captureCommitPhaseError(u55, u55.return_, v64);
                end;

                if v63 == nil then
                    resetCurrentFiber();
                else
                    setCurrentFiber(v63);
                end;
            else
                local v65, v66 = xpcall(commitLayoutEffectsForProfiler, describeError, u55, p56);

                if not v65 then
                    captureCommitPhaseError(u55, u55.return_, v66);
                end;
            end;
        end;

        if enableProfilerTimer and enableProfilerCommitHooks then
            if v59 ~= nil then
                local stateNode = v59.stateNode;
                stateNode.effectDuration = stateNode.effectDuration + u55.stateNode.effectDuration;
            end;

            u23 = v59;
        end;
    else
        local child = u55.child;

        while child ~= nil do
            if bit32.band(u55.subtreeFlags, LayoutMask) ~= NoFlags then
                if _G___DEV__ then
                    local current2 = ReactCurrentFiber.current;
                    setCurrentFiber(child);

                    if u2 < 20 then
                        u2 = u2 + 1;
                        invokeGuardedCallback(nil, recursivelyCommitLayoutEffects, nil, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        u2 = u2 - 1;

                        if hasCaughtError() then
                            captureCommitPhaseError(child, u55, (clearCaughtError()));
                        end;
                    else
                        recursivelyCommitLayoutEffects(child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                    end;

                    if current2 == nil then
                        resetCurrentFiber();
                    else
                        setCurrentFiber(current2);
                    end;
                else
                    local v67 = nil;
                    local v68;

                    if _G___YOLO__ or u2 >= 20 then
                        recursivelyCommitLayoutEffects(child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        v68 = true;
                    else
                        u2 = u2 + 1;
                        v68, v67 = xpcall(recursivelyCommitLayoutEffects, describeError, child, p56, captureCommitPhaseError, schedulePassiveEffectCallback);
                        u2 = u2 - 1;
                    end;

                    if not v68 then
                        captureCommitPhaseError(child, u55, v67);
                    end;
                end;
            end;

            child = child.sibling;
        end;

        local bit32_bor_ret = bit32.bor(Update, Callback);

        if bit32.band(flags, bit32_bor_ret) ~= NoFlags then
            if tag == FunctionComponent or (tag == ForwardRef or (tag == SimpleMemoComponent or tag == Block)) then
                if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(u55.mode, ProfileMode) ~= 0) then
                    local v69, v70 = xpcall(function() -- Line: 751
                        -- upvalues: startLayoutEffectTimer (ref), commitHookEffectListMount (ref), Layout (ref), HasEffect (ref), u55 (copy)
                        startLayoutEffectTimer();
                        commitHookEffectListMount(bit32.bor(Layout, HasEffect), u55);
                    end, describeError);
                    recordLayoutEffectDuration(u55);

                    if not v69 then
                        error(v70);
                    end;
                else
                    commitHookEffectListMount(bit32.bor(Layout, HasEffect), u55);
                end;

                if bit32.band(u55.subtreeFlags, PassiveMask) ~= NoFlags then
                    schedulePassiveEffectCallback();
                end;
            elseif tag == ClassComponent then
                u21(u55);
            elseif tag == HostRoot then
                u19(u55);
            elseif tag == HostComponent then
                u20(u55);
            elseif tag == SuspenseComponent then
                commitSuspenseHydrationCallbacks(p56, u55);
            elseif tag ~= FundamentalComponent and (tag ~= HostPortal and (tag ~= HostText and (tag ~= IncompleteClassComponent and (tag ~= LegacyHiddenComponent and (tag ~= OffscreenComponent and (tag ~= ScopeComponent and tag ~= SuspenseListComponent)))))) then
                invariant(
                    false,
                    "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
                );
            end;
        end;

        if bit32.band(flags, Ref) ~= 0 then
            commitAttachRef(u55);
        end;
    end;
end;

function commitLayoutEffectsForProfiler(p71, p72)
    -- upvalues: enableProfilerTimer (copy), getCommitTime (copy), Update (copy), Callback (copy), NoFlags (copy), enableSchedulerTracing (copy), enableProfilerCommitHooks (copy)
    if enableProfilerTimer then
        local flags = p71.flags;
        local alternate = p71.alternate;
        local onCommit = p71.memoizedProps.onCommit;
        local onRender = p71.memoizedProps.onRender;
        local effectDuration = p71.stateNode.effectDuration;
        local v73 = getCommitTime();

        if bit32.band(flags, Update) ~= NoFlags then
            local v74;

            if typeof(onRender) == "function" then
                v74 = true;
            elseif typeof(onRender) == "table" then
                local v75 = getmetatable(onRender);
                v74 = v75 and rawget(v75, "__call") and true or (onRender._isMockFunction and true or false);
            else
                v74 = false;
            end;

            if v74 then
                if enableSchedulerTracing then
                    onRender(p71.memoizedProps.id, alternate == nil and "mount" or "update", p71.actualDuration, p71.treeBaseDuration, p71.actualStartTime, v73, p72.memoizedInteractions);
                else
                    onRender(p71.memoizedProps.id, alternate == nil and "mount" or "update", p71.actualDuration, p71.treeBaseDuration, p71.actualStartTime, v73);
                end;
            end;
        end;

        if enableProfilerCommitHooks and bit32.band(flags, Callback) ~= NoFlags then
            local v76;

            if typeof(onCommit) == "function" then
                v76 = true;
            elseif typeof(onCommit) == "table" then
                local v77 = getmetatable(onCommit);
                v76 = v77 and rawget(v77, "__call") and true or (onCommit._isMockFunction and true or false);
            else
                v76 = false;
            end;

            if v76 then
                if enableSchedulerTracing then
                    onCommit(p71.memoizedProps.id, alternate == nil and "mount" or "update", effectDuration, v73, p72.memoizedInteractions);

                    return;
                end;

                onCommit(p71.memoizedProps.id, alternate == nil and "mount" or "update", effectDuration, v73);
            end;
        end;
    end;
end;

u21 = function(p78) -- Line: 882, Name: commitLayoutEffectsForClassComponent
    -- upvalues: Update (copy), _G___DEV__ (copy), u15 (copy), console (copy), getComponentName (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), recordLayoutEffectDuration (copy), resolveDefaultProps (copy), commitUpdateQueue (copy)
    local stateNode = p78.stateNode;
    local alternate = p78.alternate;

    if bit32.band(p78.flags, Update) ~= 0 then
        if alternate == nil then
            if _G___DEV__ and (p78.type == p78.elementType and not u15) then
                if stateNode.props ~= p78.memoizedProps then
                    console.error("Expected %s props to match memoized props before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;

                if stateNode.state ~= p78.memoizedState then
                    console.error("Expected %s state to match memoized state before componentDidMount. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;
            end;

            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p78.mode, ProfileMode) ~= 0) then
                local v79, v80 = xpcall(function() -- Line: 914
                    -- upvalues: startLayoutEffectTimer (ref), stateNode (copy)
                    startLayoutEffectTimer();
                    stateNode:componentDidMount();
                end, describeError);
                recordLayoutEffectDuration(p78);

                if not v79 then
                    error(v80);
                end;
            else
                stateNode:componentDidMount();
            end;
        else
            local u81 = p78.elementType == p78.type and alternate.memoizedProps or resolveDefaultProps(p78.type, alternate.memoizedProps);
            local memoizedState = alternate.memoizedState;

            if _G___DEV__ and (p78.type == p78.elementType and not u15) then
                if stateNode.props ~= p78.memoizedProps then
                    console.error("Expected %s props to match memoized props before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;

                if stateNode.state ~= p78.memoizedState then
                    console.error("Expected %s state to match memoized state before componentDidUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
                end;
            end;

            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p78.mode, ProfileMode) ~= 0) then
                local v82, v83 = xpcall(function() -- Line: 968
                    -- upvalues: startLayoutEffectTimer (ref), stateNode (copy), u81 (copy), memoizedState (copy)
                    startLayoutEffectTimer();
                    stateNode:componentDidUpdate(u81, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate);
                end, describeError);
                recordLayoutEffectDuration(p78);

                if not v82 then
                    error(v83);
                end;
            else
                stateNode:componentDidUpdate(u81, memoizedState, stateNode.__reactInternalSnapshotBeforeUpdate);
            end;
        end;
    end;

    local updateQueue = p78.updateQueue;

    if updateQueue ~= nil then
        if _G___DEV__ and (p78.type == p78.elementType and not u15) then
            if stateNode.props ~= p78.memoizedProps then
                console.error("Expected %s props to match memoized props before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p78.type) or "instance");
            end;

            if stateNode.state ~= p78.memoizedState then
                console.error("Expected %s state to match memoized state before processing the update queue. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p78.type) or "instance");
            end;
        end;

        commitUpdateQueue(p78, updateQueue, stateNode);
    end;
end;

u19 = function(p84) -- Line: 1031, Name: commitLayoutEffectsForHostRoot
    -- upvalues: HostComponent (copy), getPublicInstance (copy), ClassComponent (copy), commitUpdateQueue (copy)
    local updateQueue = p84.updateQueue;

    if updateQueue ~= nil then
        local v85 = nil;

        if p84.child ~= nil then
            local child = p84.child;

            if child.tag == HostComponent then
                v85 = getPublicInstance(child.stateNode);
            elseif child.tag == ClassComponent then
                v85 = child.stateNode;
            end;
        end;

        commitUpdateQueue(p84, updateQueue, v85);
    end;
end;

u20 = function(p86) -- Line: 1050, Name: commitLayoutEffectsForHostComponent
    -- upvalues: Update (copy), commitMount (copy)
    local stateNode = p86.stateNode;

    if p86.alternate == nil and bit32.band(p86.flags, Update) ~= 0 then
        commitMount(stateNode, p86.type, p86.memoizedProps, p86);
    end;
end;

local function hideOrUnhideAllChildren(p87, p88) -- Line: 1065
    -- upvalues: supportsMutation (copy), HostComponent (copy), hideInstance (copy), unhideInstance (copy), HostText (copy), hideTextInstance (copy), unhideTextInstance (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy)
    if not supportsMutation then
        return;
    end;

    local v89 = p87;

    while true do
        local p87;
        local v90 = 0;

        while true do
            if v90 == 0 then
                v90 = -1;

                if p87.tag == HostComponent then
                    v90 = 1;
                    continue;
                end;

                v90 = 3;
                continue;
            elseif v90 == 1 then
                v90 = -1;
                local stateNode = p87.stateNode;

                if p88 then
                    hideInstance(stateNode);
                else
                    unhideInstance(p87.stateNode, p87.memoizedProps);
                end;

                v90 = 2;
                continue;
            elseif v90 == 2 then
                v90 = -1;

                if p87 == v89 then
                    return;
                end;

                while p87.sibling == nil do
                    if p87.return_ == nil or p87.return_ == v89 then
                        return;
                    end;

                    p87 = p87.return_;
                end;

                p87.sibling.return_ = p87.return_;
                p87 = p87.sibling;
                v90 = 0;
                continue;
            elseif v90 == 3 then
                v90 = -1;

                if p87.tag == HostText then
                    local stateNode = p87.stateNode;

                    if p88 then
                        hideTextInstance(stateNode);
                    else
                        unhideTextInstance(stateNode, p87.memoizedProps);
                    end;

                    v90 = 2;
                    continue;
                end;

                if not (p87.tag ~= OffscreenComponent and p87.tag ~= LegacyHiddenComponent or (p87.memoizedState == nil or p87 == v89)) or p87.child == nil then
                    v90 = 2;
                    continue;
                end;

                p87.child.return_ = p87;
                p87 = p87.child;
                break;
            else
                break;
            end;
        end;
    end;
end;

function commitAttachRef(p91)
    -- upvalues: HostComponent (copy), getPublicInstance (copy), _G___DEV__ (copy), console (copy), getComponentName (copy)
    local ref = p91.ref;

    if ref ~= nil then
        local stateNode = p91.stateNode;

        if p91.tag == HostComponent then
            stateNode = getPublicInstance(stateNode);
        end;

        if typeof(ref) == "function" then
            ref(stateNode);

            return;
        end;

        if _G___DEV__ and typeof(ref) ~= "table" then
            console.error("Unexpected ref object provided for %s. Use either a ref-setter function or React.createRef().", getComponentName(p91.type) or "instance");

            return;
        end;

        ref.current = stateNode;
    end;
end;

function commitDetachRef(p92)
    local ref = p92.ref;

    if ref ~= nil then
        if typeof(ref) == "function" then
            ref(nil);

            return;
        end;

        ref.current = nil;
    end;
end;

local function commitUnmount(p93, p94, p95, p96) -- Line: 1168
    -- upvalues: onCommitUnmount (copy), FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), Layout (copy), NoFlags2 (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), describeError (copy), captureCommitPhaseError (ref), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), HostPortal (copy), supportsMutation (copy), u22 (ref), supportsPersistence (copy), unimplemented (copy)
    onCommitUnmount(p94);

    if p94.tag ~= FunctionComponent and (p94.tag ~= ForwardRef and (p94.tag ~= MemoComponent and (p94.tag ~= SimpleMemoComponent and p94.tag ~= Block))) then
        if p94.tag == ClassComponent then
            local ref = p94.ref;

            if ref ~= nil then
                if typeof(ref) == "function" then
                    local v97, v98 = xpcall(ref, describeError);

                    if not v97 then
                        captureCommitPhaseError(p94, p95, v98);
                    end;
                else
                    ref.current = nil;
                end;
            end;

            local stateNode = p94.stateNode;

            if typeof(stateNode.componentWillUnmount) == "function" then
                safelyCallComponentWillUnmount(p94, stateNode, p95);
            end;

            return;
        end;

        if p94.tag == HostComponent then
            local ref = p94.ref;

            if ref ~= nil then
                if typeof(ref) == "function" then
                    local v99, v100 = xpcall(ref, describeError);

                    if not v99 then
                        captureCommitPhaseError(p94, p95, v100);

                        return;
                    end;
                else
                    ref.current = nil;
                end;
            end;

            return;
        end;

        if p94.tag ~= HostPortal then
            return;
        end;

        if supportsMutation then
            u22(p93, p94, p95, p96);

            return;
        end;

        if supportsPersistence then
            unimplemented("emptyPortalContainer");
        end;

        return;
    end;

    local updateQueue = p94.updateQueue;

    if updateQueue ~= nil then
        local lastEffect = updateQueue.lastEffect;

        if lastEffect ~= nil then
            local next = lastEffect.next;

            repeat
                if next.destroy ~= nil and bit32.band(next.tag, Layout) ~= NoFlags2 then
                    if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p94.mode, ProfileMode) ~= 0) then
                        startLayoutEffectTimer();
                        local v101, v102 = xpcall(next.destroy, describeError);

                        if not v101 then
                            captureCommitPhaseError(p94, p95, v102);
                        end;

                        recordLayoutEffectDuration(p94);
                    else
                        local v103, v104 = xpcall(next.destroy, describeError);

                        if not v103 then
                            captureCommitPhaseError(p94, p95, v104);
                        end;
                    end;
                end;

                next = next.next;
            until next == next;
        end;
    end;
end;

local function commitNestedUnmounts(p105, p106, p107, p108) -- Line: 1275
    -- upvalues: commitUnmount (ref), supportsMutation (copy), HostPortal (copy)
    local v109 = p106;

    while true do
        while true do
            commitUnmount(p105, p106, p107, p108);

            if p106.child ~= nil and (not supportsMutation or p106.tag ~= HostPortal) then
                break;
            end;

            if p106 == v109 then
                return;
            end;

            while p106.sibling == nil do
                if p106.return_ == nil or p106.return_ == v109 then
                    return;
                end;

                p106 = p106.return_;
            end;

            p106.sibling.return_ = p106.return_;
            p106 = p106.sibling;
        end;

        p106.child.return_ = p106;
        p106 = p106.child;
    end;
end;

local function detachFiberMutation(p110) -- Line: 1315
    local alternate = p110.alternate;

    if alternate ~= nil then
        alternate.return_ = nil;
        p110.alternate = nil;
    end;

    p110.return_ = nil;
end;

local function getHostParentFiber(p111) -- Line: 1382
    -- upvalues: u16 (ref), Error (copy)
    local return_ = p111.return_;

    while return_ ~= nil do
        if u16(return_) then
            return return_;
        end;

        return_ = return_.return_;
    end;

    error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."));
end;

u16 = function(p112) -- Line: 1400, Name: isHostParent
    -- upvalues: HostComponent (copy), HostRoot (copy), HostPortal (copy)
    return (p112.tag == HostComponent or p112.tag == HostRoot) and true or p112.tag == HostPortal;
end;

local function getHostSibling(p113) -- Line: 1404
    -- upvalues: u16 (ref), HostComponent (copy), HostText (copy), DehydratedFragment (copy), Placement (copy), HostPortal (copy)
    while true do
        local v114 = false;

        while p113.sibling == nil do
            if p113.return_ == nil or u16(p113.return_) then
                return nil;
            end;

            p113 = p113.return_;
        end;

        p113.sibling.return_ = p113.return_;
        p113 = p113.sibling;

        while p113.tag ~= HostComponent and (p113.tag ~= HostText and p113.tag ~= DehydratedFragment) do
            if bit32.band(p113.flags, Placement) ~= 0 or (p113.child == nil or p113.tag == HostPortal) then
                v114 = true;
                break;
            end;

            p113.child.return_ = p113;
            p113 = p113.child;
        end;

        if not v114 and bit32.band(p113.flags, Placement) == 0 then
            return p113.stateNode;
        end;
    end;
end;

local function commitPlacement(p115) -- Line: 1458
    -- upvalues: supportsMutation (copy), getHostParentFiber (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), invariant (copy), ContentReset (copy), resetTextContent (copy), getHostSibling (ref), u18 (ref), u17 (ref)
    if not supportsMutation then
        return;
    end;

    local v116 = getHostParentFiber(p115);
    local v117 = nil;
    local v118 = nil;
    local stateNode = v116.stateNode;

    if v116.tag == HostComponent then
        v117 = stateNode;
        v118 = false;
    elseif v116.tag == HostRoot then
        v117 = stateNode.containerInfo;
        v118 = true;
    elseif v116.tag == HostPortal then
        v117 = stateNode.containerInfo;
        v118 = true;
    else
        invariant(
            false,
            "Invalid host parent fiber. This error is likely caused by a bug in React. Please file an issue."
        );
    end;

    if bit32.band(v116.flags, ContentReset) ~= 0 then
        resetTextContent(v117);
        local flags = v116.flags;
        local bit32_bnot_ret = bit32.bnot(ContentReset);
        v116.flags = bit32.band(flags, bit32_bnot_ret);
    end;

    local v119 = getHostSibling(p115);

    if v118 then
        u18(p115, v119, v117);

        return;
    end;

    u17(p115, v119, v117);
end;

u18 = function(p120, p121, p122) -- Line: 1509, Name: insertOrAppendPlacementNodeIntoContainer
    -- upvalues: HostComponent (copy), HostText (copy), insertInContainerBefore (copy), appendChildToContainer (copy), HostPortal (copy), u18 (ref)
    local tag = p120.tag;

    if tag == HostComponent and true or tag == HostText then
        local stateNode = p120.stateNode;

        if p121 then
            insertInContainerBefore(p122, stateNode, p121);

            return;
        end;

        appendChildToContainer(p122, stateNode);

        return;
    end;

    if tag == HostPortal then
        return;
    end;

    local child = p120.child;

    if child ~= nil then
        u18(child, p121, p122);
        local sibling = child.sibling;

        while sibling ~= nil do
            u18(sibling, p121, p122);
            sibling = sibling.sibling;
        end;
    end;
end;

u17 = function(p123, p124, p125) -- Line: 1541, Name: insertOrAppendPlacementNode
    -- upvalues: HostComponent (copy), HostText (copy), insertBefore (copy), appendChild (copy), HostPortal (copy), u17 (ref)
    local tag = p123.tag;

    if tag == HostComponent and true or tag == HostText then
        local stateNode = p123.stateNode;

        if p124 then
            insertBefore(p125, stateNode, p124);

            return;
        end;

        appendChild(p125, stateNode);

        return;
    end;

    if tag == HostPortal then
        return;
    end;

    local child = p123.child;

    if child ~= nil then
        u17(child, p124, p125);
        local sibling = child.sibling;

        while sibling ~= nil do
            u17(sibling, p124, p125);
            sibling = sibling.sibling;
        end;
    end;
end;

u22 = function(p126, p127, p128, p129) -- Line: 1569, Name: unmountHostComponents
    -- upvalues: Error (copy), HostComponent (copy), HostRoot (copy), HostPortal (copy), HostText (copy), commitNestedUnmounts (ref), removeChildFromContainer (copy), removeChild (copy), commitUnmount (ref)
    local v130, v131, v132, v133;
    local p127, v130, v131, v132, v133;
    local v134 = 0;

    while true do
        if v134 == 0 then
            v134 = -1;
            v130 = p127;
            v131 = false;
            v132 = nil;
            v133 = nil;
            v134 = 1;
            continue;
        elseif v134 == 1 then
            v134 = -1;

            if v131 then
                v134 = 2;
                continue;
            end;

            v134 = 6;
            continue;
        elseif v134 == 2 then
            v134 = -1;

            if p127.tag == HostComponent or p127.tag == HostText then
                v134 = 3;
                continue;
            end;

            if p127.tag == HostPortal then
                if p127.child == nil then
                    v134 = 4;
                    continue;
                end;

                v133 = p127.stateNode.containerInfo;
                p127.child.return_ = p127;
                p127 = p127.child;
                v132 = true;
            else
                commitUnmount(p126, p127, p128, p129);

                if p127.child == nil then
                    v134 = 4;
                    continue;
                end;

                p127.child.return_ = p127;
                p127 = p127.child;
            end;

            v134 = 5;
            continue;
        elseif v134 == 3 then
            v134 = -1;
            commitNestedUnmounts(p126, p127, p128, p129);

            if v132 then
                removeChildFromContainer(v133, p127.stateNode);
            else
                removeChild(v133, p127.stateNode);
            end;

            v134 = 4;
            continue;
        elseif v134 == 4 then
            v134 = -1;

            if p127 == v130 then
                return;
            end;

            while p127.sibling == nil do
                if p127.return_ == nil or p127.return_ == v130 then
                    return;
                end;

                p127 = p127.return_;

                if p127.tag == HostPortal then
                    v131 = false;
                end;
            end;

            p127.sibling.return_ = p127.return_;
            p127 = p127.sibling;
            v134 = 5;
            continue;
        elseif v134 == 5 then
            v134 = -1;
            v134 = 1;
            continue;
        elseif v134 == 6 then
            v134 = -1;
            local return_ = p127.return_;

            while true do
                if return_ == nil then
                    error(Error.new("Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue."));
                end;

                v133 = return_.stateNode;

                if return_.tag == HostComponent then
                    v132 = false;
                    break;
                end;

                if return_.tag == HostRoot then
                    v133 = v133.containerInfo;
                    v132 = true;
                    break;
                end;

                if return_.tag == HostPortal then
                    v133 = v133.containerInfo;
                    v132 = true;
                    break;
                end;

                return_ = return_.return_;
            end;

            v131 = true;
            v134 = 2;
            continue;
        else
            break;
        end;
    end;
end;

local function commitDeletion(p135, p136, p137, p138) -- Line: 1747
    -- upvalues: u22 (ref)
    u22(p135, p136, p137, p138);
    local alternate = p136.alternate;
    local alternate2 = p136.alternate;

    if alternate2 ~= nil then
        alternate2.return_ = nil;
        p136.alternate = nil;
    end;

    p136.return_ = nil;

    if alternate ~= nil then
        local alternate3 = alternate.alternate;

        if alternate3 ~= nil then
            alternate3.return_ = nil;
            alternate.alternate = nil;
        end;

        alternate.return_ = nil;
    end;
end;

function commitSuspenseComponent(p139)
    -- upvalues: u8 (ref), supportsMutation (copy), hideOrUnhideAllChildren (copy), enableSuspenseCallback (copy), _G___DEV__ (copy), console (copy)
    local memoizedState = p139.memoizedState;

    if memoizedState ~= nil then
        if not u8 then
            u8 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
        end;

        u8.markCommitTimeOfFallback();

        if supportsMutation then
            hideOrUnhideAllChildren(p139.child, true);
        end;
    end;

    if enableSuspenseCallback and memoizedState ~= nil then
        local suspenseCallback = p139.memoizedProps.suspenseCallback;

        if typeof(suspenseCallback) == "function" then
            local updateQueue = p139.updateQueue;

            if updateQueue ~= nil then
                suspenseCallback(table.clone(updateQueue));
            end;
        elseif _G___DEV__ and suspenseCallback ~= nil then
            console.error("Unexpected type for suspenseCallback: %s", (tostring(suspenseCallback)));
        end;
    end;
end;

function commitSuspenseHydrationCallbacks(p140, p141)
    -- upvalues: supportsHydration (copy), commitHydratedSuspenseInstance (copy), enableSuspenseCallback (copy)
    if not supportsHydration then
        return;
    end;

    if p141.memoizedState == nil then
        local alternate = p141.alternate;

        if alternate ~= nil then
            local memoizedState = alternate.memoizedState;

            if memoizedState ~= nil then
                local dehydrated = memoizedState.dehydrated;

                if dehydrated ~= nil then
                    commitHydratedSuspenseInstance(dehydrated);

                    if enableSuspenseCallback then
                        local hydrationCallbacks = p140.hydrationCallbacks;
                        local v142 = hydrationCallbacks ~= nil and hydrationCallbacks.onHydrated;

                        if v142 then
                            v142(dehydrated);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

function attachSuspenseRetryListeners(u143)
    -- upvalues: Set (copy), resolveRetryWakeable (copy), enableSchedulerTracing (copy), unstable_wrap (copy)
    local updateQueue = u143.updateQueue;

    if updateQueue ~= nil then
        u143.updateQueue = nil;
        local stateNode = u143.stateNode;

        if stateNode == nil then
            u143.stateNode = Set.new();
            stateNode = u143.stateNode;
        end;

        for i, _ in updateQueue do
            local function u144() -- Line: 2075
                -- upvalues: resolveRetryWakeable (ref), u143 (copy), i (copy)
                return resolveRetryWakeable(u143, i);
            end;

            if not stateNode:has(i) then
                if enableSchedulerTracing and i.__reactDoNotTraceInteractions ~= true then
                    u144 = unstable_wrap(u144);
                end;

                stateNode:add(i);
                i:andThen(function() -- Line: 2086
                    -- upvalues: u144 (ref)
                    return u144();
                end, function() -- Line: 2088
                    -- upvalues: u144 (ref)
                    return u144();
                end);
            end;
        end;
    end;
end;

function isSuspenseBoundaryBeingHidden(p145, p146)
    if p145 ~= nil then
        local memoizedState = p145.memoizedState;

        if memoizedState == nil or memoizedState.dehydrated ~= nil then
            local memoizedState2 = p146.memoizedState;
            local v147;

            if memoizedState2 == nil then
                v147 = false;
            else
                v147 = memoizedState2.dehydrated == nil;
            end;

            return v147;
        end;
    end;

    return false;
end;

function commitResetTextContent(p148)
    -- upvalues: supportsMutation (copy), resetTextContent (copy)
    if not supportsMutation then
        return;
    end;

    resetTextContent(p148.stateNode);
end;

function invokeLayoutEffectMountInDEV(p149)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        if p149.tag == FunctionComponent or (p149.tag == ForwardRef or (p149.tag == SimpleMemoComponent or p149.tag == Block)) then
            invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Layout, HasEffect), p149);

            if hasCaughtError() then
                local v150 = clearCaughtError();
                captureCommitPhaseError(p149, p149.return_, v150);
            end;
        end;
    elseif p149.tag == ClassComponent then
        local stateNode = p149.stateNode;
        invokeGuardedCallback(nil, stateNode.componentDidMount, stateNode);

        if hasCaughtError() then
            local v151 = clearCaughtError();
            captureCommitPhaseError(p149, p149.return_, v151);
        end;
    end;
end;

function invokePassiveEffectMountInDEV(p152)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListMount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref)
    if not (_G___DEV__ and (enableDoubleInvokingEffects and (p152.tag == FunctionComponent or (p152.tag == ForwardRef or (p152.tag == SimpleMemoComponent or p152.tag == Block))))) then
        return;
    end;

    invokeGuardedCallback(nil, commitHookEffectListMount, nil, bit32.bor(Passive, HasEffect), p152);

    if hasCaughtError() then
        local v153 = clearCaughtError();
        captureCommitPhaseError(p152, p152.return_, v153);
    end;
end;

function invokeLayoutEffectUnmountInDEV(p154)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref), ClassComponent (copy)
    if _G___DEV__ and enableDoubleInvokingEffects then
        if p154.tag == FunctionComponent or (p154.tag == ForwardRef or (p154.tag == SimpleMemoComponent or p154.tag == Block)) then
            invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Layout, HasEffect), p154, p154.return_);

            if hasCaughtError() then
                local v155 = clearCaughtError();
                captureCommitPhaseError(p154, p154.return_, v155);
            end;
        end;
    elseif p154.tag == ClassComponent then
        local stateNode = p154.stateNode;

        if typeof(stateNode.componentWillUnmount) == "function" then
            safelyCallComponentWillUnmount(p154, stateNode, p154.return_);
        end;
    end;
end;

function invokePassiveEffectUnmountInDEV(p156)
    -- upvalues: _G___DEV__ (copy), enableDoubleInvokingEffects (copy), FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), invokeGuardedCallback (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), hasCaughtError (copy), clearCaughtError (copy), captureCommitPhaseError (ref)
    if not (_G___DEV__ and (enableDoubleInvokingEffects and (p156.tag == FunctionComponent or (p156.tag == ForwardRef or (p156.tag == SimpleMemoComponent or p156.tag == Block))))) then
        return;
    end;

    invokeGuardedCallback(nil, commitHookEffectListUnmount, nil, bit32.bor(Passive, HasEffect), p156, p156.return_);

    if hasCaughtError() then
        local v157 = clearCaughtError();
        captureCommitPhaseError(p156, p156.return_, v157);
    end;
end;

return {
    safelyCallDestroy = safelyCallDestroy,

    commitBeforeMutationLifeCycles = function(p158, p159) -- Line: 325, Name: commitBeforeMutationLifeCycles
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), ClassComponent (copy), Snapshot (copy), _G___DEV__ (copy), u15 (copy), console (copy), getComponentName (copy), resolveDefaultProps (copy), HostRoot (copy), supportsMutation (copy), clearContainer (copy), HostComponent (copy), HostText (copy), HostPortal (copy), IncompleteClassComponent (copy), invariant (copy)
        if p159.tag == FunctionComponent or (p159.tag == ForwardRef or (p159.tag == SimpleMemoComponent or p159.tag == Block)) then
            return;
        end;

        if p159.tag == ClassComponent then
            if bit32.band(p159.flags, Snapshot) ~= 0 and p158 ~= nil then
                local memoizedProps = p158.memoizedProps;
                local memoizedState = p158.memoizedState;
                local stateNode = p159.stateNode;

                if _G___DEV__ and (p159.type == p159.elementType and not u15) then
                    if stateNode.props ~= p159.memoizedProps then
                        console.error("Expected %s props to match memoized props before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.props`. Please file an issue.", getComponentName(p159.type) or "instance");
                    end;

                    if stateNode.state ~= p159.memoizedState then
                        console.error("Expected %s state to match memoized state before getSnapshotBeforeUpdate. This might either be because of a bug in React, or because a component reassigns its own `this.state`. Please file an issue.", getComponentName(p159.type) or "instance");
                    end;
                end;

                stateNode.__reactInternalSnapshotBeforeUpdate = stateNode:getSnapshotBeforeUpdate(p159.elementType == p159.type and memoizedProps and memoizedProps or resolveDefaultProps(p159.type, memoizedProps), memoizedState);
            end;

            return;
        end;

        if p159.tag == HostRoot then
            if supportsMutation and bit32.band(p159.flags, Snapshot) ~= 0 then
                clearContainer(p159.stateNode.containerInfo);
            end;

            return;
        end;

        if p159.tag == HostComponent or (p159.tag == HostText or (p159.tag == HostPortal or p159.tag == IncompleteClassComponent)) then
            return;
        end;

        invariant(
            false,
            "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
        );
    end,

    commitResetTextContent = commitResetTextContent,
    commitPlacement = commitPlacement,
    commitDeletion = commitDeletion,

    commitWork = function(p160, u161) -- Line: 1779, Name: commitWork
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), MemoComponent (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startLayoutEffectTimer (copy), commitHookEffectListUnmount (copy), Layout (copy), HasEffect (copy), describeError (copy), recordLayoutEffectDuration (copy), ClassComponent (copy), HostComponent (copy), commitUpdate (copy), HostText (copy), invariant (copy), commitTextUpdate (copy), HostRoot (copy), supportsHydration (copy), unimplemented (copy), Profiler (copy), SuspenseComponent (copy), SuspenseListComponent (copy), IncompleteClassComponent (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), hideOrUnhideAllChildren (copy)
        if u161.tag == FunctionComponent or (u161.tag == ForwardRef or (u161.tag == MemoComponent or (u161.tag == SimpleMemoComponent or u161.tag == Block))) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(u161.mode, ProfileMode) ~= 0) then
                local v162, v163 = xpcall(function() -- Line: 1868
                    -- upvalues: startLayoutEffectTimer (ref), commitHookEffectListUnmount (ref), Layout (ref), HasEffect (ref), u161 (copy)
                    startLayoutEffectTimer();
                    commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), u161, u161.return_);
                end, describeError);
                recordLayoutEffectDuration(u161);

                if not v162 then
                    error(v163);

                    return;
                end;
            else
                commitHookEffectListUnmount(bit32.bor(Layout, HasEffect), u161, u161.return_);
            end;

            return;
        end;

        if u161.tag == ClassComponent then
            return;
        end;

        if u161.tag == HostComponent then
            local stateNode = u161.stateNode;

            if stateNode ~= nil then
                local memoizedProps = u161.memoizedProps;
                local v164;

                if p160 then
                    v164 = p160.memoizedProps;
                else
                    v164 = memoizedProps;
                end;

                local type = u161.type;
                local updateQueue = u161.updateQueue;
                u161.updateQueue = nil;

                if updateQueue ~= nil then
                    commitUpdate(stateNode, updateQueue, type, v164, memoizedProps, u161);
                end;
            end;

            return;
        end;

        if u161.tag == HostText then
            invariant(u161.stateNode ~= nil, "This should have a text node initialized. This error is likely caused by a bug in React. Please file an issue.");
            local memoizedProps = u161.memoizedProps;
            local v165;

            if p160 == nil then
                v165 = nil;
            else
                local _ = p160.memoizedProps;
                v165 = memoizedProps;
            end;

            commitTextUpdate(u161.stateNode, v165, memoizedProps);

            return;
        end;

        if u161.tag == HostRoot then
            if supportsHydration then
                local stateNode = u161.stateNode;

                if stateNode.hydrate then
                    stateNode.hydrate = false;
                    unimplemented("commitWork: HostRoot: commitHydratedContainer");
                end;
            end;

            return;
        end;

        if u161.tag == Profiler then
            return;
        end;

        if u161.tag == SuspenseComponent then
            commitSuspenseComponent(u161);
            attachSuspenseRetryListeners(u161);

            return;
        end;

        if u161.tag == SuspenseListComponent then
            unimplemented("commitWork: SuspenseListComponent");
        else
            if u161.tag == IncompleteClassComponent then
                return;
            end;

            if u161.tag == OffscreenComponent or u161.tag == LegacyHiddenComponent then
                hideOrUnhideAllChildren(u161, u161.memoizedState ~= nil);

                return;
            end;
        end;

        invariant(
            false,
            "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue."
        );
    end,

    commitAttachRef = commitAttachRef,
    commitDetachRef = commitDetachRef,

    commitPassiveUnmount = function(p166) -- Line: 2118, Name: commitPassiveUnmount
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy)
        if p166.tag == FunctionComponent or (p166.tag == ForwardRef or (p166.tag == SimpleMemoComponent or p166.tag == Block)) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p166.mode, ProfileMode) ~= 0) then
                startPassiveEffectTimer();
                commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p166, p166.return_);
                recordPassiveEffectDuration(p166);

                return;
            end;

            commitHookEffectListUnmount(bit32.bor(Passive, HasEffect), p166, p166.return_);
        end;
    end,

    commitPassiveUnmountInsideDeletedTree = function(p167, p168) -- Line: 2147, Name: commitPassiveUnmountInsideDeletedTree
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListUnmount (copy), Passive (copy), recordPassiveEffectDuration (copy)
        if p167.tag == FunctionComponent or (p167.tag == ForwardRef or (p167.tag == SimpleMemoComponent or p167.tag == Block)) then
            if enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p167.mode, ProfileMode) ~= 0) then
                startPassiveEffectTimer();
                commitHookEffectListUnmount(Passive, p167, p168);
                recordPassiveEffectDuration(p167);

                return;
            end;

            commitHookEffectListUnmount(Passive, p167, p168);
        end;
    end,

    commitPassiveMount = function(p169, p170) -- Line: 2171, Name: commitPassiveMount
        -- upvalues: FunctionComponent (copy), ForwardRef (copy), SimpleMemoComponent (copy), Block (copy), enableProfilerTimer (copy), enableProfilerCommitHooks (copy), ProfileMode (copy), startPassiveEffectTimer (copy), commitHookEffectListMount (copy), describeError (copy), Passive (copy), HasEffect (copy), recordPassiveEffectDuration (copy), Profiler (copy)
        if p170.tag == FunctionComponent or (p170.tag == ForwardRef or (p170.tag == SimpleMemoComponent or p170.tag == Block)) then
            if not (enableProfilerTimer and (enableProfilerCommitHooks and bit32.band(p170.mode, ProfileMode) ~= 0)) then
                commitHookEffectListMount(bit32.bor(Passive, HasEffect), p170);

                return;
            end;

            startPassiveEffectTimer();
            local bit32_bor_ret = bit32.bor(Passive, HasEffect);
            local v171, v172 = xpcall(commitHookEffectListMount, describeError, bit32_bor_ret, p170);
            recordPassiveEffectDuration(p170);

            if not v171 then
                error(v172);
            end;
        elseif p170.tag == Profiler then
            commitProfilerPassiveEffect(p169, p170);
        end;
    end,

    invokeLayoutEffectMountInDEV = invokeLayoutEffectMountInDEV,
    invokeLayoutEffectUnmountInDEV = invokeLayoutEffectUnmountInDEV,
    invokePassiveEffectMountInDEV = invokePassiveEffectMountInDEV,
    invokePassiveEffectUnmountInDEV = invokePassiveEffectUnmountInDEV,
    isSuspenseBoundaryBeingHidden = isSuspenseBoundaryBeingHidden,
    recursivelyCommitLayoutEffects = recursivelyCommitLayoutEffects
};