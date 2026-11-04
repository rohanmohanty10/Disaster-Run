 
 

local function unimplemented(p1: string) -- Line: 11
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    print("UNIMPLEMENTED ERROR: " .. tostring(p1));
    error("FIXME (roblox): " .. p1 .. " is unimplemented", 2);
end;

require(script.Parent:WaitForChild("ReactInternalTypes"));
local ReactFiberLane = require(script.Parent:WaitForChild("ReactFiberLane"));
local OffscreenLane = ReactFiberLane.OffscreenLane;
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
require(script.Parent:WaitForChild("ReactFiberOffscreenComponent"));
local resetWorkInProgressVersions = require(script.Parent:WaitForChild("ReactMutableSource.new")).resetWorkInProgressVersions;
local ReactWorkTags = require(script.Parent:WaitForChild("ReactWorkTags"));
local IndeterminateComponent = ReactWorkTags.IndeterminateComponent;
local FunctionComponent = ReactWorkTags.FunctionComponent;
local ClassComponent = ReactWorkTags.ClassComponent;
local HostRoot = ReactWorkTags.HostRoot;
local HostComponent = ReactWorkTags.HostComponent;
local HostText = ReactWorkTags.HostText;
local HostPortal = ReactWorkTags.HostPortal;
local ContextProvider = ReactWorkTags.ContextProvider;
local ContextConsumer = ReactWorkTags.ContextConsumer;
local ForwardRef = ReactWorkTags.ForwardRef;
local Fragment = ReactWorkTags.Fragment;
local Mode = ReactWorkTags.Mode;
local Profiler = ReactWorkTags.Profiler;
local SuspenseComponent = ReactWorkTags.SuspenseComponent;
local SuspenseListComponent = ReactWorkTags.SuspenseListComponent;
local MemoComponent = ReactWorkTags.MemoComponent;
local SimpleMemoComponent = ReactWorkTags.SimpleMemoComponent;
local LazyComponent = ReactWorkTags.LazyComponent;
local IncompleteClassComponent = ReactWorkTags.IncompleteClassComponent;
local FundamentalComponent = ReactWorkTags.FundamentalComponent;
local ScopeComponent = ReactWorkTags.ScopeComponent;
local Block = ReactWorkTags.Block;
local OffscreenComponent = ReactWorkTags.OffscreenComponent;
local LegacyHiddenComponent = ReactWorkTags.LegacyHiddenComponent;
require(script.Parent:WaitForChild("ReactFiberSuspenseComponent.new"));
local ReactTypeOfMode = require(script.Parent:WaitForChild("ReactTypeOfMode"));
local NoMode = ReactTypeOfMode.NoMode;
local ConcurrentMode = ReactTypeOfMode.ConcurrentMode;
local BlockingMode = ReactTypeOfMode.BlockingMode;
local ProfileMode = ReactTypeOfMode.ProfileMode;
local ReactFiberFlags = require(script.Parent:WaitForChild("ReactFiberFlags"));
local Ref = ReactFiberFlags.Ref;
local Update = ReactFiberFlags.Update;
local Callback = ReactFiberFlags.Callback;
local Passive = ReactFiberFlags.Passive;
local Deletion = ReactFiberFlags.Deletion;
local NoFlags = ReactFiberFlags.NoFlags;
local DidCapture = ReactFiberFlags.DidCapture;
local Snapshot = ReactFiberFlags.Snapshot;
local MutationMask = ReactFiberFlags.MutationMask;
local LayoutMask = ReactFiberFlags.LayoutMask;
local PassiveMask = ReactFiberFlags.PassiveMask;
local StaticMask = ReactFiberFlags.StaticMask;
local PerformedWork = ReactFiberFlags.PerformedWork;
local invariant = require(script.Parent.Parent:WaitForChild("shared")).invariant;
local createInstance = ReactFiberHostConfig.createInstance;
local createTextInstance = ReactFiberHostConfig.createTextInstance;
local appendInitialChild = ReactFiberHostConfig.appendInitialChild;
local finalizeInitialChildren = ReactFiberHostConfig.finalizeInitialChildren;
local prepareUpdate = ReactFiberHostConfig.prepareUpdate;
local supportsMutation = ReactFiberHostConfig.supportsMutation;
local supportsPersistence = ReactFiberHostConfig.supportsPersistence;
local createContainerChildSet = ReactFiberHostConfig.createContainerChildSet;
local finalizeContainerChildren = ReactFiberHostConfig.finalizeContainerChildren;
local preparePortalMount = ReactFiberHostConfig.preparePortalMount;
local v2 = require(script.Parent:WaitForChild("ReactFiberHostContext.new"));
local getRootHostContainer = v2.getRootHostContainer;
local popHostContext = v2.popHostContext;
local getHostContext = v2.getHostContext;
local popHostContainer = v2.popHostContainer;
local v3 = require(script.Parent:WaitForChild("ReactFiberSuspenseContext.new"));
local popSuspenseContext = v3.popSuspenseContext;
local suspenseStackCursor = v3.suspenseStackCursor;
local InvisibleParentSuspenseContext = v3.InvisibleParentSuspenseContext;
local hasSuspenseContext = v3.hasSuspenseContext;
local v4 = require(script.Parent:WaitForChild("ReactFiberContext.new"));
local isContextProvider = v4.isContextProvider;
local popContext = v4.popContext;
local popTopLevelContextObject = v4.popTopLevelContextObject;
local popProvider = require(script.Parent:WaitForChild("ReactFiberNewContext.new")).popProvider;
local v5 = require(script.Parent:WaitForChild("ReactFiberHydrationContext.new"));
local prepareToHydrateHostSuspenseInstance = v5.prepareToHydrateHostSuspenseInstance;
local popHydrationState = v5.popHydrationState;
local resetHydrationState = v5.resetHydrationState;
local prepareToHydrateHostInstance = v5.prepareToHydrateHostInstance;
local prepareToHydrateHostTextInstance = v5.prepareToHydrateHostTextInstance;
local ReactFeatureFlags = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags;
local enableSchedulerTracing = ReactFeatureFlags.enableSchedulerTracing;
local enableSuspenseCallback = ReactFeatureFlags.enableSuspenseCallback;
local enableSuspenseServerRenderer = ReactFeatureFlags.enableSuspenseServerRenderer;
local enableFundamentalAPI = ReactFeatureFlags.enableFundamentalAPI;
local enableProfilerTimer = ReactFeatureFlags.enableProfilerTimer;
local u6 = require(script.Parent:WaitForChild("ReactFiberWorkLoop.new"));
local popRenderLanes = u6.popRenderLanes;
local markSpawnedWork = u6.markSpawnedWork;
local renderDidSuspend = u6.renderDidSuspend;
local renderDidSuspendDelayIfPossible = u6.renderDidSuspendDelayIfPossible;
local NoLanes = ReactFiberLane.NoLanes;
local includesSomeLane = ReactFiberLane.includesSomeLane;
local mergeLanes = ReactFiberLane.mergeLanes;
local transferActualDuration = require(script.Parent:WaitForChild("ReactProfilerTimer.new")).transferActualDuration;

local function markUpdate(p7) -- Line: 185
    -- upvalues: Update (copy)
    p7.flags = bit32.bor(p7.flags, Update);
end;

local function markRef(p8) -- Line: 191
    -- upvalues: Ref (copy)
    p8.flags = bit32.bor(p8.flags, Ref);
end;

local function hadNoMutationsEffects(p9, p10) -- Line: 197
    -- upvalues: MutationMask (copy), NoFlags (copy)
    local v11;

    if p9 == nil then
        v11 = false;
    else
        v11 = p9.child == p10.child;
    end;

    if v11 then
        return true;
    end;

    local child = p10.child;

    while child ~= nil do
        if bit32.band(child.flags, MutationMask) ~= NoFlags then
            return false;
        end;

        if bit32.band(child.subtreeFlags, MutationMask) ~= NoFlags then
            return false;
        end;

        child = child.sibling;
    end;

    return true;
end;

local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15;

if supportsMutation then
    u13 = function(p16, p17, p18, p19, p20) -- Line: 264, Name: updateHostComponent
        -- upvalues: getHostContext (copy), prepareUpdate (copy), Update (copy)
        local memoizedProps = p16.memoizedProps;

        if memoizedProps == p19 then
            return;
        end;

        local v21 = prepareUpdate(p17.stateNode, p18, memoizedProps, p19, p20, (getHostContext()));
        p17.updateQueue = v21;

        if v21 then
            p17.flags = bit32.bor(p17.flags, Update);
        end;
    end;

    u12 = function(p22: any, p23: any, p24: boolean, p25: boolean) -- Line: 223
        -- upvalues: HostComponent (copy), HostText (copy), appendInitialChild (copy), enableFundamentalAPI (copy), FundamentalComponent (copy), HostPortal (copy)
        local child = p23.child;

        while true do
            local child;
            local v26 = 0;

            while true do
                if v26 == 0 then
                    v26 = -1;

                    while true do
                        if child == nil then
                            return;
                        end;

                        if child.tag == HostComponent or child.tag == HostText then
                            break;
                        end;

                        if enableFundamentalAPI and child.tag == FundamentalComponent then
                            appendInitialChild(p22, child.stateNode.instance);
                            v26 = 1;
                            break;
                        end;

                        if child.tag == HostPortal or child.child == nil then
                            v26 = 1;
                            break;
                        end;

                        child.child.return_ = child;
                        child = child.child;
                    end;

                    if v26 ~= -1 then
                        continue;
                    end;

                    appendInitialChild(p22, child.stateNode);
                    v26 = 1;
                    continue;
                elseif v26 == 1 then
                    v26 = -1;

                    if child == p23 then
                        return;
                    end;

                    while child.sibling == nil do
                        if child.return_ == nil or child.return_ == p23 then
                            return;
                        end;

                        child = child.return_;
                    end;

                    child.sibling.return_ = child.return_;
                    child = child.sibling;
                    break;
                else
                    break;
                end;
            end;
        end;
    end;

    u14 = function(p27: any, p28: any, p29: string, p30: string) -- Line: 305, Name: updateHostText
        -- upvalues: Update (copy)
        if p29 ~= p30 then
            p28.flags = bit32.bor(p28.flags, Update);
        end;
    end;

    u15 = function(p31, p32) -- Line: 261
    end;
elseif supportsPersistence then
    local function appendAllChildrenToContainer(p33: any, p34: any, p35: boolean, p36: boolean) -- Line: 413
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"));
        error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2);
    end;

    u12 = function(p37: any, p38: any, p39: boolean, p40: boolean) -- Line: 318
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildren"));
        error("FIXME (roblox): appendAllChildren is unimplemented", 2);
    end;

    u15 = function(p41, p42) -- Line: 507, Name: updateHostContainer
        -- upvalues: hadNoMutationsEffects (copy), createContainerChildSet (copy), Update (copy), finalizeContainerChildren (copy)
        local stateNode = p42.stateNode;

        if hadNoMutationsEffects(p41, p42) then
            return;
        end;

        local containerInfo = stateNode.containerInfo;
        local v43 = createContainerChildSet(containerInfo);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print("UNIMPLEMENTED ERROR: " .. tostring("appendAllChildrenToContainer"));
        error("FIXME (roblox): appendAllChildrenToContainer is unimplemented", 2);
        stateNode.pendingChildren = v43;
        p42.flags = bit32.bor(p42.flags, Update);
        finalizeContainerChildren(containerInfo, v43);
    end;
else
    u15 = function(p44, p45) -- Line: 623
    end;
end;

local function bubbleProperties(p46) -- Line: 716
    -- upvalues: NoLanes (copy), NoFlags (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), mergeLanes (copy), StaticMask (copy)
    local v47;

    if p46.alternate == nil then
        v47 = false;
    else
        v47 = p46.alternate.child == p46.child;
    end;

    local v48 = NoLanes;
    local v49 = NoFlags;

    if v47 then
        if enableProfilerTimer and bit32.band(p46.mode, ProfileMode) ~= NoMode then
            local selfBaseDuration = p46.selfBaseDuration;
            local child = p46.child;

            while child ~= nil do
                v48 = mergeLanes(v48, mergeLanes(child.lanes, child.childLanes));
                local bit32_band_ret = bit32.band(child.subtreeFlags, StaticMask);
                local bit32_bor_ret = bit32.bor(v49, bit32_band_ret);
                local bit32_band_ret2 = bit32.band(child.flags, StaticMask);
                v49 = bit32.bor(bit32_bor_ret, bit32_band_ret2);
                selfBaseDuration = selfBaseDuration + child.treeBaseDuration;
                child = child.sibling;
            end;

            p46.treeBaseDuration = selfBaseDuration;
        else
            local child = p46.child;

            while child ~= nil do
                local bit32_bor_ret = bit32.bor(child.lanes, child.childLanes);
                v48 = bit32.bor(v48, bit32_bor_ret);
                local bit32_band_ret = bit32.band(child.subtreeFlags, StaticMask);
                local bit32_bor_ret2 = bit32.bor(v49, bit32_band_ret);
                local bit32_band_ret2 = bit32.band(child.flags, StaticMask);
                v49 = bit32.bor(bit32_bor_ret2, bit32_band_ret2);
                child.return_ = p46;
                child = child.sibling;
            end;
        end;

        p46.subtreeFlags = bit32.bor(p46.subtreeFlags, v49);
    else
        if enableProfilerTimer and bit32.band(p46.mode, ProfileMode) ~= NoMode then
            local actualDuration = p46.actualDuration;
            local selfBaseDuration = p46.selfBaseDuration;
            local child = p46.child;

            while child ~= nil do
                v48 = mergeLanes(v48, mergeLanes(child.lanes, child.childLanes));
                local bit32_bor_ret = bit32.bor(v49, child.subtreeFlags);
                v49 = bit32.bor(bit32_bor_ret, child.flags);
                actualDuration = actualDuration + child.actualDuration;
                selfBaseDuration = selfBaseDuration + child.treeBaseDuration;
                child = child.sibling;
            end;

            p46.actualDuration = actualDuration;
            p46.treeBaseDuration = selfBaseDuration;
        else
            local child = p46.child;

            while child ~= nil do
                local bit32_bor_ret = bit32.bor(child.lanes, child.childLanes);
                v48 = bit32.bor(v48, bit32_bor_ret);
                local bit32_bor_ret2 = bit32.bor(v49, child.subtreeFlags);
                v49 = bit32.bor(bit32_bor_ret2, child.flags);
                child.return_ = p46;
                child = child.sibling;
            end;
        end;

        p46.subtreeFlags = bit32.bor(p46.subtreeFlags, v49);
    end;

    p46.childLanes = v48;

    return v47;
end;

return {
    completeWork = function(p50, p51, p52) -- Line: 855, Name: completeWork
        -- upvalues: IndeterminateComponent (copy), LazyComponent (copy), SimpleMemoComponent (copy), FunctionComponent (copy), ForwardRef (copy), Fragment (copy), Mode (copy), ContextConsumer (copy), MemoComponent (copy), bubbleProperties (copy), ClassComponent (copy), isContextProvider (copy), popContext (copy), HostRoot (copy), popHostContainer (copy), popTopLevelContextObject (copy), resetWorkInProgressVersions (copy), popHydrationState (copy), Update (copy), Snapshot (copy), u15 (ref), HostComponent (copy), popHostContext (copy), getRootHostContainer (copy), u13 (ref), Ref (copy), invariant (copy), getHostContext (copy), prepareToHydrateHostInstance (copy), createInstance (copy), u12 (ref), finalizeInitialChildren (copy), HostText (copy), u14 (ref), prepareToHydrateHostTextInstance (copy), createTextInstance (copy), Profiler (copy), Callback (copy), Passive (copy), PerformedWork (copy), NoFlags (copy), LayoutMask (copy), Deletion (copy), PassiveMask (copy), SuspenseComponent (copy), popSuspenseContext (copy), enableSuspenseServerRenderer (copy), prepareToHydrateHostSuspenseInstance (copy), enableSchedulerTracing (copy), markSpawnedWork (copy), OffscreenLane (copy), enableProfilerTimer (copy), ProfileMode (copy), NoMode (copy), resetHydrationState (copy), DidCapture (copy), transferActualDuration (copy), BlockingMode (copy), hasSuspenseContext (copy), suspenseStackCursor (copy), InvisibleParentSuspenseContext (copy), renderDidSuspend (copy), renderDidSuspendDelayIfPossible (copy), supportsPersistence (copy), supportsMutation (copy), enableSuspenseCallback (copy), HostPortal (copy), preparePortalMount (copy), ContextProvider (copy), popProvider (copy), IncompleteClassComponent (copy), SuspenseListComponent (copy), FundamentalComponent (copy), ScopeComponent (copy), Block (copy), OffscreenComponent (copy), LegacyHiddenComponent (copy), popRenderLanes (copy), includesSomeLane (copy), u6 (copy), ConcurrentMode (copy)
        local pendingProps = p51.pendingProps;

        if p51.tag == IndeterminateComponent or (p51.tag == LazyComponent or (p51.tag == SimpleMemoComponent or (p51.tag == FunctionComponent or (p51.tag == ForwardRef or (p51.tag == Fragment or (p51.tag == Mode or (p51.tag == ContextConsumer or p51.tag == MemoComponent))))))) then
            bubbleProperties(p51);

            return nil;
        end;

        if p51.tag == ClassComponent then
            if isContextProvider(p51.type) then
                popContext(p51);
            end;

            bubbleProperties(p51);

            return nil;
        end;

        if p51.tag == HostRoot then
            popHostContainer(p51);
            popTopLevelContextObject(p51);
            resetWorkInProgressVersions();
            local stateNode = p51.stateNode;

            if stateNode.pendingContext then
                stateNode.context = stateNode.pendingContext;
                stateNode.pendingContext = nil;
            end;

            if p50 == nil or p50.child == nil then
                if popHydrationState(p51) then
                    p51.flags = bit32.bor(p51.flags, Update);
                elseif not stateNode.hydrate then
                    p51.flags = bit32.bor(p51.flags, Snapshot);
                end;
            end;

            u15(p50, p51);
            bubbleProperties(p51);

            return nil;
        end;

        if p51.tag == HostComponent then
            popHostContext(p51);
            local v53 = getRootHostContainer();
            local type = p51.type;

            if p50 == nil or p51.stateNode == nil then
                if not pendingProps then
                    invariant(p51.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.");
                    bubbleProperties(p51);

                    return nil;
                end;

                local v54 = getHostContext();

                if popHydrationState(p51) then
                    if prepareToHydrateHostInstance(p51, v53, v54) then
                        p51.flags = bit32.bor(p51.flags, Update);
                    end;
                else
                    local v55 = createInstance(type, pendingProps, v53, v54, p51);
                    u12(v55, p51, false, false);
                    p51.stateNode = v55;

                    if finalizeInitialChildren(v55, type, pendingProps, v53, v54) then
                        p51.flags = bit32.bor(p51.flags, Update);
                    end;
                end;

                if p51.ref ~= nil then
                    p51.flags = bit32.bor(p51.flags, Ref);
                end;
            else
                u13(p50, p51, type, pendingProps, v53);

                if p50.ref ~= p51.ref then
                    p51.flags = bit32.bor(p51.flags, Ref);
                end;
            end;

            bubbleProperties(p51);

            return nil;
        end;

        if p51.tag == HostText then
            if p50 and p51.stateNode ~= nil then
                u14(p50, p51, p50.memoizedProps, pendingProps);
            else
                if typeof(pendingProps) ~= "string" then
                    invariant(p51.stateNode ~= nil, "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue.");
                end;

                local v56 = getRootHostContainer();
                local v57 = getHostContext();

                if popHydrationState(p51) then
                    if prepareToHydrateHostTextInstance(p51) then
                        p51.flags = bit32.bor(p51.flags, Update);
                    end;
                else
                    p51.stateNode = createTextInstance(pendingProps, v56, v57, p51);
                end;
            end;

            bubbleProperties(p51);

            return nil;
        end;

        if p51.tag ~= Profiler then
            if p51.tag ~= SuspenseComponent then
                if p51.tag == HostPortal then
                    popHostContainer(p51);
                    u15(p50, p51);

                    if p50 == nil then
                        preparePortalMount(p51.stateNode.containerInfo);
                    end;

                    bubbleProperties(p51);

                    return nil;
                end;

                if p51.tag == ContextProvider then
                    popProvider(p51);
                    bubbleProperties(p51);

                    return nil;
                end;

                if p51.tag == IncompleteClassComponent then
                    if isContextProvider(p51.type) then
                        popContext(p51);
                    end;

                    bubbleProperties(p51);

                    return nil;
                end;

                if p51.tag == SuspenseListComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("SuspenseListComponent"));
                    error("FIXME (roblox): SuspenseListComponent is unimplemented", 2);
                elseif p51.tag == FundamentalComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("FundamentalComponent"));
                    error("FIXME (roblox): FundamentalComponent is unimplemented", 2);
                elseif p51.tag == ScopeComponent then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("ScopeComponent"));
                    error("FIXME (roblox): ScopeComponent is unimplemented", 2);
                elseif p51.tag == Block then
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    print("UNIMPLEMENTED ERROR: " .. tostring("Block"));
                    error("FIXME (roblox): Block is unimplemented", 2);
                elseif p51.tag == OffscreenComponent or p51.tag == LegacyHiddenComponent then
                    popRenderLanes(p51);
                    local v58 = p51.memoizedState ~= nil;

                    if p50 ~= nil and (p50.memoizedState ~= nil ~= v58 and pendingProps.mode ~= "unstable-defer-without-hiding") then
                        p51.flags = bit32.bor(p51.flags, Update);
                    end;

                    if not (v58 and (not includesSomeLane(u6.subtreeRenderLanes, OffscreenLane) and bit32.band(p51.mode, ConcurrentMode) ~= NoMode)) then
                        bubbleProperties(p51);
                    end;

                    return nil;
                end;

                invariant(false, "Unknown unit of work tag (%s). This error is likely caused by a bug in React. Please file an issue.", (tostring(p51.tag)));

                return nil;
            end;

            popSuspenseContext(p51);
            local memoizedState = p51.memoizedState;

            if enableSuspenseServerRenderer and (memoizedState ~= nil and memoizedState.dehydrated ~= nil) then
                if p50 == nil then
                    invariant(popHydrationState(p51), "A dehydrated suspense component was completed without a hydrated node. This is probably a bug in React.");
                    prepareToHydrateHostSuspenseInstance(p51);

                    if enableSchedulerTracing then
                        markSpawnedWork(OffscreenLane);
                    end;

                    bubbleProperties(p51);

                    if enableProfilerTimer and bit32.band(p51.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                        local child = p51.child;

                        if child ~= nil then
                            p51.treeBaseDuration = child.treeBaseDuration;
                        end;
                    end;

                    return nil;
                end;

                resetHydrationState();

                if bit32.band(p51.flags, DidCapture) == NoFlags then
                    p51.memoizedState = nil;
                end;

                p51.flags = bit32.bor(p51.flags, Update);
                bubbleProperties(p51);

                if enableProfilerTimer and bit32.band(p51.mode, ProfileMode) ~= NoMode and memoizedState ~= nil then
                    local child = p51.child;

                    if child ~= nil then
                        p51.treeBaseDuration = p51.treeBaseDuration - child.treeBaseDuration;
                    end;
                end;

                return nil;
            end;

            if bit32.band(p51.flags, DidCapture) ~= NoFlags then
                p51.lanes = p52;

                if enableProfilerTimer and bit32.band(p51.mode, ProfileMode) ~= NoMode then
                    transferActualDuration(p51);
                end;

                return p51;
            end;

            local v59 = memoizedState ~= nil;
            local v60 = false;

            if p50 == nil then
                if p51.memoizedProps.fallback ~= nil then
                    popHydrationState(p51);
                end;
            else
                v60 = p50.memoizedState ~= nil;
            end;

            if v59 and (not v60 and bit32.band(p51.mode, BlockingMode) ~= NoMode) then
                local v61;

                if p50 == nil then
                    v61 = p51.memoizedProps.unstable_avoidThisFallback ~= true;
                else
                    v61 = false;
                end;

                if v61 or hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext) then
                    renderDidSuspend();
                else
                    renderDidSuspendDelayIfPossible();
                end;
            end;

            if supportsPersistence and v59 then
                p51.flags = bit32.bor(p51.flags, Update);
            end;

            if supportsMutation and (v59 or v60) then
                p51.flags = bit32.bor(p51.flags, Update);
            end;

            if enableSuspenseCallback and (p51.updateQueue ~= nil and p51.memoizedProps.suspenseCallback ~= nil) then
                p51.flags = bit32.bor(p51.flags, Update);
            end;

            bubbleProperties(p51);

            if enableProfilerTimer and (bit32.band(p51.mode, ProfileMode) ~= NoMode and v59) then
                local child = p51.child;

                if child ~= nil then
                    p51.treeBaseDuration = p51.treeBaseDuration - child.treeBaseDuration;
                end;
            end;

            return nil;
        end;

        if not bubbleProperties(p51) then
            local v62 = Update;
            local v63 = Callback;
            local v64 = Passive;
            local subtreeFlags = p51.subtreeFlags;
            local flags = p51.flags;
            local v65;

            if bit32.band(flags, PerformedWork) == NoFlags and bit32.band(subtreeFlags, PerformedWork) == NoFlags then
                v65 = flags;
            else
                v65 = bit32.bor(flags, v62);
            end;

            local bit32_bor_ret = bit32.bor(LayoutMask, Deletion);

            if bit32.band(flags, bit32_bor_ret) == NoFlags then
                local bit32_bor_ret2 = bit32.bor(LayoutMask, Deletion);

                if bit32.band(subtreeFlags, bit32_bor_ret2) ~= NoFlags then
                    v65 = bit32.bor(v65, v63);
                end;
            else
                v65 = bit32.bor(v65, v63);
            end;

            if bit32.band(flags, PassiveMask) ~= NoFlags or bit32.band(subtreeFlags, PassiveMask) ~= NoFlags then
                v65 = bit32.bor(v65, v64);
            end;

            p51.flags = v65;
        end;

        return nil;
    end
};