  

 

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Signal = require(script.Parent.Signal);
local Symbol = require(script.Parent.Symbol);
local Trove = require(script.Parent.Trove);
local Promise = require(script.Parent.Promise);
local u1 = RunService:IsServer();
local u2 = { workspace, game:GetService("Players") };
local u3 = Symbol("Ancestors");
local u4 = Symbol("InstancesToComponents");
local u5 = Symbol("LockConstruct");
local u6 = Symbol("Components");
local u7 = Symbol("Trove");
local u8 = Symbol("Extensions");
local u9 = Symbol("ActiveExtensions");
local u10 = Symbol("Started");
local u11 = 0;

local function NextRenderName() -- Line: 195
    -- upvalues: u11 (ref)
    u11 = u11 + 1;

    return "ComponentRender" .. tostring(u11);
end;

local function InvokeExtensionFn(p12, p13) -- Line: 201
    -- upvalues: u9 (copy)
    for _, v in ipairs(p12[u9]) do
        local v14 = v[p13];

        if type(v14) == "function" then
            v14(p12);
        end;
    end;
end;

local function ShouldConstruct(p15) -- Line: 211
    -- upvalues: u9 (copy)
    for _, v in ipairs(p15[u9]) do
        local ShouldConstruct = v.ShouldConstruct;

        if type(ShouldConstruct) == "function" and not ShouldConstruct(p15) then
            return false;
        end;
    end;

    return true;
end;

local function GetActiveExtensions(p16, p17) -- Line: 225
    local v18 = table.create(#p17);
    local v19 = true;

    for _, v in ipairs(p17) do
        local ShouldExtend = v.ShouldExtend;

        if type(ShouldExtend) ~= "function" and true or (ShouldExtend(p16) and true or false) then
            table.insert(v18, v);
        else
            v19 = false;
        end;
    end;

    if v19 then
        return p17;
    end;

    return v18;
end;

local u20 = {};
u20.__index = u20;

function u20.new(u21) -- Line: 306
    -- upvalues: u3 (copy), u2 (copy), u4 (copy), u6 (copy), u5 (copy), u7 (copy), Trove (copy), u8 (copy), u10 (copy), Signal (copy), u20 (copy)
    local v22 = {};
    v22.__index = v22;

    function v22.__tostring() -- Line: 309
        -- upvalues: u21 (copy)
        return "Component<" .. u21.Tag .. ">";
    end;

    v22[u3] = u21.Ancestors or u2;
    v22[u4] = {};
    v22[u6] = {};
    v22[u5] = {};
    v22[u7] = Trove.new();
    v22[u8] = u21.Extensions or {};
    v22[u10] = false;
    v22.Tag = u21.Tag;
    v22.Started = v22[u7]:Construct(Signal);
    v22.Stopped = v22[u7]:Construct(Signal);
    setmetatable(v22, u20);
    v22:_setup();

    return v22;
end;

function u20._instantiate(p23, p24) -- Line: 328
    -- upvalues: u9 (copy), GetActiveExtensions (copy), u8 (copy), ShouldConstruct (copy), InvokeExtensionFn (copy)
    local v25 = setmetatable({}, p23);
    v25.Instance = p24;
    v25[u9] = GetActiveExtensions(v25, p23[u8]);

    if not ShouldConstruct(v25) then
        return nil;
    end;

    InvokeExtensionFn(v25, "Constructing");

    if type(v25.Construct) == "function" then
        v25:Construct();
    end;

    InvokeExtensionFn(v25, "Constructed");

    return v25;
end;

function u20._setup(u26) -- Line: 344
    -- upvalues: InvokeExtensionFn (copy), RunService (copy), u1 (copy), u11 (ref), u10 (copy), u5 (copy), u4 (copy), u6 (copy), u3 (copy), u7 (copy), CollectionService (copy)
    local u27 = {};

    local function StartComponent(u28) -- Line: 348
        -- upvalues: InvokeExtensionFn (ref), RunService (ref), u1 (ref), u11 (ref), u10 (ref), u26 (copy)
        InvokeExtensionFn(u28, "Starting");
        u28:Start();
        InvokeExtensionFn(u28, "Started");
        local v29 = typeof(u28.HeartbeatUpdate) == "function";
        local v30 = typeof(u28.SteppedUpdate) == "function";
        local v31 = typeof(u28.RenderSteppedUpdate) == "function";

        if v29 then
            u28._heartbeatUpdate = RunService.Heartbeat:Connect(function(p32) -- Line: 356
                -- upvalues: u28 (copy)
                u28:HeartbeatUpdate(p32);
            end);
        end;

        if v30 then
            u28._steppedUpdate = RunService.Stepped:Connect(function(p33, p34) -- Line: 361
                -- upvalues: u28 (copy)
                u28:SteppedUpdate(p34);
            end);
        end;

        if v31 and not u1 then
            if u28.RenderPriority then
                u11 = u11 + 1;
                u28._renderName = "ComponentRender" .. tostring(u11);
                RunService:BindToRenderStep(u28._renderName, u28.RenderPriority, function(p35) -- Line: 368
                    -- upvalues: u28 (copy)
                    u28:RenderSteppedUpdate(p35);
                end);
            else
                u28._renderSteppedUpdate = RunService.RenderStepped:Connect(function(p36) -- Line: 372
                    -- upvalues: u28 (copy)
                    u28:RenderSteppedUpdate(p36);
                end);
            end;
        end;

        u28[u10] = true;
        u26.Started:Fire(u28);
    end;

    local function StopComponent(p37) -- Line: 381
        -- upvalues: RunService (ref), InvokeExtensionFn (ref), u26 (copy)
        if p37._heartbeatUpdate then
            p37._heartbeatUpdate:Disconnect();
        end;

        if p37._steppedUpdate then
            p37._steppedUpdate:Disconnect();
        end;

        if p37._renderSteppedUpdate then
            p37._renderSteppedUpdate:Disconnect();
        elseif p37._renderName then
            RunService:UnbindFromRenderStep(p37._renderName);
        end;

        InvokeExtensionFn(p37, "Stopping");
        p37:Stop();
        InvokeExtensionFn(p37, "Stopped");
        u26.Stopped:Fire(p37);
    end;

    local function SafeConstruct(p38, p39) -- Line: 399
        -- upvalues: u26 (copy), u5 (ref)
        if u26[u5][p38] ~= p39 then
            return nil;
        end;

        local v40 = u26:_instantiate(p38);

        if u26[u5][p38] == p39 then
            return v40;
        end;

        return nil;
    end;

    local function TryConstructComponent(u41) -- Line: 410
        -- upvalues: u26 (copy), u4 (ref), u5 (ref), u6 (ref), StartComponent (copy)
        if u26[u4][u41] then
            return;
        end;

        local u42 = (u26[u5][u41] or 0) + 1;
        u26[u5][u41] = u42;
        task.defer(function() -- Line: 415
            -- upvalues: u41 (copy), u42 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
            local v43 = u41;
            local v44 = u42;
            local u45;

            if u26[u5][v43] == v44 then
                u45 = u26:_instantiate(v43);

                if u26[u5][v43] ~= v44 then
                    u45 = nil;
                end;
            else
                u45 = nil;
            end;

            if not u45 then
                return;
            end;

            u26[u4][u41] = u45;
            table.insert(u26[u6], u45);
            task.defer(function() -- Line: 422
                -- upvalues: u26 (ref), u4 (ref), u41 (ref), u45 (copy), StartComponent (ref)
                if u26[u4][u41] == u45 then
                    StartComponent(u45);
                end;
            end);
        end);
    end;

    local function TryDeconstructComponent(p46) -- Line: 430
        -- upvalues: u26 (copy), u4 (ref), u5 (ref), u6 (ref), u10 (ref), StopComponent (copy)
        local v47 = u26[u4][p46];

        if not v47 then
            return;
        end;

        u26[u4][p46] = nil;
        u26[u5][p46] = nil;
        local v48 = u26[u6];
        local v49 = table.find(v48, v47);

        if v49 then
            local v50 = #v48;
            v48[v49] = v48[v50];
            v48[v50] = nil;
        end;

        if v47[u10] then
            task.spawn(StopComponent, v47);
        end;
    end;

    local function StartWatchingInstance(u51) -- Line: 447
        -- upvalues: u27 (copy), u26 (copy), u3 (ref), u7 (ref), u4 (ref), u5 (ref), u6 (ref), StartComponent (copy), TryDeconstructComponent (copy)
        if u27[u51] then
            return;
        end;

        local function IsInAncestorList() -- Line: 449
            -- upvalues: u26 (ref), u3 (ref), u51 (copy)
            for _, v in ipairs(u26[u3]) do
                if u51:IsDescendantOf(v) then
                    return true;
                end;
            end;

            return false;
        end;

        u27[u51] = u26[u7]:Connect(u51.AncestryChanged, function(p52, p53) -- Line: 457
            -- upvalues: u26 (ref), u3 (ref), u51 (copy), u4 (ref), u5 (ref), u6 (ref), StartComponent (ref), TryDeconstructComponent (ref)
            if p53 then
                local v54 = false;

                for _, v in ipairs(u26[u3]) do
                    if u51:IsDescendantOf(v) then
                        v54 = true;
                        break;
                    end;
                end;

                if v54 then
                    local u55 = u51;

                    if u26[u4][u55] then
                        return;
                    end;

                    local u56 = (u26[u5][u55] or 0) + 1;
                    u26[u5][u55] = u56;
                    task.defer(function() -- Line: 415
                        -- upvalues: u55 (copy), u56 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
                        local v57 = u55;
                        local v58 = u56;
                        local u59;

                        if u26[u5][v57] == v58 then
                            u59 = u26:_instantiate(v57);

                            if u26[u5][v57] ~= v58 then
                                u59 = nil;
                            end;
                        else
                            u59 = nil;
                        end;

                        if not u59 then
                            return;
                        end;

                        u26[u4][u55] = u59;
                        table.insert(u26[u6], u59);
                        task.defer(function() -- Line: 422
                            -- upvalues: u26 (ref), u4 (ref), u55 (ref), u59 (copy), StartComponent (ref)
                            if u26[u4][u55] == u59 then
                                StartComponent(u59);
                            end;
                        end);
                    end);

                    return;
                end;
            end;

            TryDeconstructComponent(u51);
        end);
        local v60 = false;

        for _, v in ipairs(u26[u3]) do
            if u51:IsDescendantOf(v) then
                v60 = true;
                break;
            end;
        end;

        if v60 then
            if u26[u4][u51] then
                return;
            end;

            local u61 = (u26[u5][u51] or 0) + 1;
            u26[u5][u51] = u61;
            task.defer(function() -- Line: 415
                -- upvalues: u51 (copy), u61 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
                local v62 = u51;
                local v63 = u61;
                local u64;

                if u26[u5][v62] == v63 then
                    u64 = u26:_instantiate(v62);

                    if u26[u5][v62] ~= v63 then
                        u64 = nil;
                    end;
                else
                    u64 = nil;
                end;

                if not u64 then
                    return;
                end;

                u26[u4][u51] = u64;
                table.insert(u26[u6], u64);
                task.defer(function() -- Line: 422
                    -- upvalues: u26 (ref), u4 (ref), u51 (ref), u64 (copy), StartComponent (ref)
                    if u26[u4][u51] == u64 then
                        StartComponent(u64);
                    end;
                end);
            end);
        end;
    end;

    local function InstanceTagged(p65) -- Line: 470
        -- upvalues: StartWatchingInstance (copy)
        StartWatchingInstance(p65);
    end;

    u26[u7]:Connect(CollectionService:GetInstanceAddedSignal(u26.Tag), InstanceTagged);
    u26[u7]:Connect(CollectionService:GetInstanceRemovedSignal(u26.Tag), function(p66) -- Line: 474, Name: InstanceUntagged
        -- upvalues: u27 (copy), TryDeconstructComponent (copy)
        local v67 = u27[p66];

        if v67 then
            v67:Disconnect();
            u27[p66] = nil;
        end;

        TryDeconstructComponent(p66);
    end);
    local v68 = CollectionService:GetTagged(u26.Tag);

    for _, v in ipairs(v68) do
        task.defer(InstanceTagged, v);
    end;
end;

function u20.GetAll(p69) -- Line: 513
    -- upvalues: u6 (copy)
    return p69[u6];
end;

function u20.FromInstance(p70, p71) -- Line: 531
    -- upvalues: u4 (copy)
    return p70[u4][p71];
end;

function u20.WaitForInstance(p72, u73, p74) -- Line: 555
    -- upvalues: Promise (copy)
    local u75 = p72:FromInstance(u73);

    if u75 then
        return Promise.resolve(u75);
    end;

    return Promise.fromEvent(p72.Started, function(p76) -- Line: 560
        -- upvalues: u73 (copy), u75 (ref)
        local v77 = p76.Instance == u73;

        if v77 then
            u75 = p76;
        end;

        return v77;
    end):andThen(function() -- Line: 566
        -- upvalues: u75 (ref)
        return u75;
    end):timeout(type(p74) ~= "number" and 60 or p74);
end;

function u20.Construct(p78) -- Line: 586
end;

function u20.Start(p79) -- Line: 605
end;

function u20.Stop(p80) -- Line: 627
end;

function u20.GetComponent(p81, p82) -- Line: 648
    -- upvalues: u4 (copy)
    return p82[u4][p81.Instance];
end;

function u20.Destroy(p83) -- Line: 735
    -- upvalues: u7 (copy)
    p83[u7]:Destroy();
end;

return u20;