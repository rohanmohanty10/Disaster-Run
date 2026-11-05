  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Action = require(script.Parent.Action);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local InputUtil = require(ReplicatedRoot.Libraries.Utility.InputUtil);
local MoveUtil = require(ReplicatedRoot.Libraries.Utility.MoveUtil);
require(ReplicatedRoot.Libraries.Classes.Trove);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
local Enums = require(ReplicatedRoot.Libraries.Enums);
local TagService = require(ReplicatedRoot.Services.TagService);
local HttpService = game:GetService("HttpService");
local SharedFunctionService = require(ReplicatedRoot.Services.SharedFunctionService);
require(ReplicatedRoot.Libraries.Networking.BridgeNet2).ReferenceBridge("CallReplication");
local u1 = {
    ClassName = "MoveAction"
};
u1.__index = u1;
require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.new(u2, p3) -- Line: 188
    -- upvalues: Core (copy), Action (copy), u1 (copy), TagService (copy), HttpService (copy), Signal (copy), SharedFunctionService (copy), TableUtil (copy)
    local CombatService = require(Core.ReplicatedServices.CombatService);
    local v4 = Action.new(p3 or {});

    for i, v in pairs(u1) do
        v4[i] = v;
    end;

    v4.Character = u2;
    v4.Humanoid = u2.Humanoid;
    v4.RootPart = u2.HumanoidRootPart;
    v4.Player = game.Players:GetPlayerFromCharacter(u2);
    v4.Tags = TagService.GetContainer(v4.Character);
    v4.Id = `{os.clock()}-{HttpService:GenerateGUID()}`;
    v4.Directory = {};
    v4.Flags = {};
    v4.Binds = {};
    v4.State = {};
    v4.Metadata = {};
    v4.Enabled = not v4.Data.Enabled and true or v4.Data.Enabled;
    v4.Priority = v4.Data.Priority or 0;
    v4.OnEnabled = v4.Collector:Construct(Signal);
    v4.OnDisabled = v4.Collector:Construct(Signal);
    v4.OnBind = v4.Collector:Construct(Signal);
    v4.OnUnbind = v4.Collector:Construct(Signal);
    v4.Activated = v4.Collector:Construct(Signal);
    v4.Deactivated = v4.Collector:Construct(Signal);

    if v4.Data.Cooldown and v4.Data.Cooldown.Name == nil then
        v4.Data.Cooldown.Name = v4.Id;
    end;

    if v4.Data.Flags then
        for i, v in pairs(v4.Data.Flags) do
            if typeof(v) == "string" then
                if v == "@Client" and Core.Context == "Client" then
                    v4:SetFlag(i, true);
                elseif v == "@Server" and Core.Context == "Server" then
                    v4:SetFlag(i, true);
                end;
            else
                v4:SetFlag(i, v);
            end;
        end;
    end;

    if v4.Data.Binds and v4.Player == nil then
        for i, v in pairs(v4.Data.Binds) do
            v4:SetBind(i, v);
        end;
    end;

    v4:BindCallback("Init", function(p5) -- Line: 248
        -- upvalues: Core (ref)
        for i, v in pairs(p5.Data) do
            if typeof(v) == "function" and string.sub(i, 1, 4) == "Init" then
                v(p5);
            end;
        end;

        for i, v in pairs(p5.Data) do
            if typeof(v) == "function" and string.sub(i, 1, 4) == "Start" then
                v(p5);
            end;
        end;

        p5:GenerateMetadata();

        if Core.Context == "Server" and p5.Replica ~= nil then
            p5:InitReplica();
        end;
    end);
    v4:BindCallback("Activate", function(u6, u7) -- Line: 272
        -- upvalues: HttpService (ref), SharedFunctionService (ref), Core (ref), TableUtil (ref), CombatService (copy), u2 (copy)
        u7.Move = u6;
        u7.Id = `{os.clock()}-{HttpService:GenerateGUID()}`;
        u7.State = {};
        u7.Replicated = {};
        u7.Result.Runned = false;
        u7.Result.Failed = false;
        u7.Result.Valid = true;
        u7.Result.Active = true;
        u7.Result.TimeLeft = 0;

        function u7.IsActive(p8) -- Line: 287
            return p8.Result.Active;
        end;

        function u7.Deactivate(p9) -- Line: 291
            -- upvalues: u6 (copy)
            p9.Result.Active = false;
            u6.Deactivated:Fire(p9);

            if typeof(u6.Data.Deactivate) == "function" then
                return u6.Data.Deactivate(u6, p9);
            end;
        end;

        function u7.Interrupt(p10) -- Line: 300
            -- upvalues: u6 (copy)
            p10.Result.Interrupted = true;
            p10.Result.Completed = false;

            if typeof(u6.Data.Interrupt) == "function" then
                return u6.Data.Interrupt(u6, p10);
            end;
        end;

        function u7.PlaySequence(p11, p12) -- Line: 309
            p12.Call = p11;
            p12:Play();
        end;

        function u7.AwaitSequences(p13, p14) -- Line: 314
            while p13.Result.Running == true do
                local v15 = 0;
                local v16 = false;

                for _, v in pairs(p14) do
                    if v:IsPlaying() then
                        local v17 = (v:GetLength() - v._Time) / v:GetSpeed() / 60;

                        if v15 >= v17 then
                            v17 = v15;
                        end;

                        v15 = v17;
                        v16 = true;
                    end;
                end;

                p13.Result.TimeLeft = v15;

                if v16 == false then
                    break;
                end;

                task.wait();
            end;
        end;

        function u7.CallFunction(p18, p19, ...) -- Line: 339
            -- upvalues: SharedFunctionService (ref), u6 (copy)
            local v20 = SharedFunctionService.GetFunction(p19, {
                Call = p18,
                Move = u6
            });

            if v20 ~= nil then
                return SharedFunctionService.CallFunction(v20, {
                    Move = u6,
                    Call = p18
                }, ...);
            end;
        end;

        function u7.GetReplicated(p21, p22) -- Line: 352
            return p21.Replicated[p22];
        end;

        function u7.SetReplicated(p23, p24, p25) -- Line: 356
            -- upvalues: Core (ref), u6 (copy)
            p23.Replicated[p24] = p25;

            if Core.Context == "Server" and (u6.Player and (p23.Parameters.RequestId and u6.Replica)) then
                u6.Replica:FireAllClients(p23.Parameters.RequestId, p24, p25);
            end;
        end;

        function u7.SetCooldown(p26, p27) -- Line: 363
            -- upvalues: TableUtil (ref), u6 (copy)
            p26.Result.Cooldown = TableUtil.Reconcile(p27 or {}, {
                Name = u6.Data.Cooldown and u6.Data.Cooldown.Name or u6.Name
            });
        end;

        function u7.ApplyCooldown(p28) -- Line: 369
            -- upvalues: CombatService (ref), u2 (ref), u6 (copy)
            if CombatService.IsNPC(u2) then
                return;
            end;

            if p28.Result.Cooldown and (p28.Result.Cooldown.Enabled ~= false and (typeof(p28.Result.Cooldown.Time) == "number" and p28.Result.Cooldown.Time > 0)) then
                CombatService.SetCooldown(u2, {
                    Name = u6.Id,
                    MoveName = u6.Name
                }, p28.Result.Cooldown);
            end;
        end;

        function u7.SetMeter(p29, p30, p31) -- Line: 381
            -- upvalues: TableUtil (ref), CombatService (ref), u2 (ref)
            p29.Result.Meter = TableUtil.Reconcile(p31 or {}, p30 or {});
            p29.Result.MeterResult = CombatService.ValidateMeter(u2, p30);
        end;

        function u7.ApplyMeter(p32) -- Line: 386
            -- upvalues: CombatService (ref), u2 (ref), Core (ref)
            if CombatService.IsNPC(u2) then
                return;
            end;

            if p32.Result.Meter and (p32.Result.MeterResult.Success and (p32.Result.Meter.Enabled ~= false and Core.Context == "Server")) then
                CombatService.ChangeMeter(u2, p32.Result.MeterResult);
            end;
        end;

        if Core.Context == "Client" and u6.Replica then
            u7.Collector:Connect(u6.Replica.OnClientEvent, function(p33, p34, p35) -- Line: 396
                -- upvalues: u7 (copy)
                if p33 == u7.Id then
                    u7.Replicated[p34] = p35;
                end;
            end);
        end;

        local function Fail() -- Line: 403
            -- upvalues: u7 (copy)
            u7.Result.Running = false;
            u7.Result.Runned = false;
            u7.Result.Completed = false;
            u7.Result.Failed = true;
        end;

        u7:SetCooldown(u6.Data.Cooldown or {});
        u7:SetMeter(u6.Data.Meter or {});

        if u6.Data.Interruptible or {} then
            local CombatService2 = require(Core.ReplicatedServices.CombatService);
            u7.Collector:Construct(CombatService2.GetInterruptSignal, u6.Character):Connect(function(p36, p37) -- Line: 417
                -- upvalues: u6 (copy), u7 (copy)
                if p37.Stop and typeof(u6.Data.Interrupt) == "function" then
                    u7:Interrupt();
                end;
            end);
        end;

        local v38 = u6.Data.Validate or {};

        if v38 then
            local v39 = u6:Validate(v38);
            u7.Result.Validation = v39;

            if v39.Success == false then
                u7.Result.Valid = false;

                return Fail();
            end;
        end;

        local v40 = u6.Data.Active ~= false and (u6.Data.Active or {}) or nil;
        local v41 = v40 == true and {} or v40;

        if typeof(v41) == "table" then
            local u42 = v41.Name or u6.Name;
            CombatService.SetActive(u2, u42, v41);
            u7.Collector:Add(function() -- Line: 441
                -- upvalues: u6 (copy), CombatService (ref), u2 (ref), u42 (copy)
                if not u6:IsRunning() then
                    CombatService.SetActive(u2, u42, nil);
                end;
            end);
        end;

        if u7.Result.Failed == false then
            if u7.Result.Validation then
                if typeof(u6.Data.Stacking) == "function" then
                    u6.Data.Stacking(u6, u7, u7.Result.Validation.Stacked);
                end;

                for i, v in pairs(u7.Result.Validation.Stacked) do
                    if u7 ~= i then
                        if typeof(i.Action.Data.Stacked) == "function" then
                            i.Action.Data.Stacked(i.Action, i, u7, v);
                        end;

                        if v.Info.Interrupt then
                            i:Interrupt();
                        end;
                    end;
                end;
            end;

            u7.Result.Runned = true;

            if u7.Result.Cooldown and u7.Result.Cooldown.Manual ~= true then
                if u7.Result.Cooldown.AfterMove == false then
                    u7:ApplyCooldown();
                else
                    u7.Collector:Add(function() -- Line: 471
                        -- upvalues: u7 (copy)
                        u7:ApplyCooldown();
                    end);
                end;
            end;

            if u7.Result.Meter and u7.Result.Meter.Manual ~= true then
                if u7.Result.Meter.AfterMove == true then
                    u7.Collector:Add(function() -- Line: 481
                        -- upvalues: u7 (copy)
                        u7:ApplyMeter();
                    end);
                else
                    u7:ApplyMeter();
                end;
            end;

            u6.Activated:Fire(u7);

            if typeof(u6.Data.Activate) == "function" then
                return u6.Data.Activate(u6, u7);
            end;
        end;
    end);

    return v4;
end;

function u1.IsEnabled(p43) -- Line: 499
    return p43.Enabled;
end;

function u1.Enable(p44) -- Line: 503
    -- upvalues: Core (copy)
    if Core.Context == "Server" and p44.Replica ~= nil then
        p44.Replica:Set({ "Enabled" }, true);
    end;

    p44.Enabled = true;
    p44.OnEnabled:Fire();
end;

function u1.Disable(p45) -- Line: 511
    -- upvalues: Core (copy)
    if Core.Context == "Server" and p45.Replica ~= nil then
        p45.Replica:Set({ "Enabled" }, false);
    end;

    p45.Enabled = false;
    p45.OnDisabled:Fire();
end;

function u1.GetPriority(p46) -- Line: 519
    return p46.Priority;
end;

function u1.SetPriority(p47, p48) -- Line: 523
    -- upvalues: Core (copy)
    if Core.Context == "Server" and p47.Replica ~= nil then
        p47.Replica:Set({ "Priority" }, p48);
    end;

    p47.Priority = p48;
end;

function u1.GetCalls(p49) -- Line: 530
    return p49._Calls;
end;

function u1.CallFunction(p50, p51, ...) -- Line: 534
    -- upvalues: SharedFunctionService (copy)
    local v52 = SharedFunctionService.GetFunction(p51, {
        Move = p50
    });

    if v52 ~= nil then
        return SharedFunctionService.CallFunction(v52, {
            Move = p50
        }, ...);
    end;
end;

function u1.Validate(p53, p54) -- Line: 546
    -- upvalues: Core (copy), TableUtil (copy)
    local CombatService = require(Core.ReplicatedServices.CombatService);
    local v55 = p54 or {};
    local v56 = TableUtil.Reconcile(v55.Conditions or {}, p53.Data.Conditions or {});
    local v57 = p53:GetFullStack();
    local v58 = {
        Success = true,
        Buffer = true,
        Conditions = {},
        Stacked = v57.Calls
    };
    local v59 = Core.Context .. "Actionable";
    local v60 = TableUtil.Reconcile(p53.Data.Checks or {}, {
        Enabled = p53.Enabled == true,
        Character = p53.Character ~= nil,
        Actionable = not p53.Data.Actionable and true or CombatService.IsActionable(p53.Character, p53.Data.Actionable),
        [v59] = not p53.Data[v59] and true or CombatService.IsActionable(p53.Character, p53.Data[v59]),
        Active = true,
        Cooldown = (not p53.Data.Cooldown or (p53.Data.Cooldown.Check == false or CombatService.IsNPC(p53.Character))) and true or CombatService.FindCooldown(p53.Character, p53.Data.Cooldown.Name) == nil,
        QueuedCooldown = true,
        Meter = (not p53.Data.Meter or (p53.Data.Meter.Check == false or CombatService.IsNPC(p53.Character))) and true or CombatService.ValidateMeter(p53.Character, p53.Data.Meter).Success,
        QueuedMeter = true,
        Stackable = v57.Success,
        Mastery = true
    });

    if not CombatService.IsNPC(p53.Character) then
        local v61 = p53.Data.Info and p53.Data.Info.MasteryRequirement;

        if v61 then
            local v62 = p53.Character:GetAttribute("MasteryRank");

            if not v62 or v62 < v61 then
                v60.Mastery = false;
                v58.Buffer = false;
            end;
        end;

        if not p53.Character:GetAttribute("URF") then
            for _, v in pairs(p53:GetCalls()) do
                if v.Result and v.Result.Runned then
                    if v60.QueuedCooldown and (v.Result.Cooldown and (v.Result.Cooldown.Enabled ~= false and (v.Result.Cooldown.Time and (v.Result.Cooldown.Time > 0 and v.Result.Cooldown.OnReset ~= false)))) then
                        v60.QueuedCooldown = false;
                    end;

                    if v60.QueuedMeter and (v.Result.Meter and (v.Result.MeterResult and (v.Result.Meter.Enabled ~= false and (v.Result.MeterResult.Success and v.Result.MeterResult.Difference < 0)))) then
                        v60.QueuedMeter = false;
                    end;
                end;
            end;
        end;
    end;

    for i, v in pairs(v60) do
        if v56[i] ~= false then
            if typeof(v) == "function" then
                local v = v(p53, v55, v58, i);
            end;

            v58.Conditions[i] = v;

            if v == false then
                v58.Success = false;
            end;
        end;
    end;

    return v58;
end;

function u1.GetCallStack(u63, u64) -- Line: 622
    -- upvalues: DirectoryUtil (copy), TableUtil (copy), MoveUtil (copy)
    local _ = u63.Data.Stack;
    local Action2 = u64.Action;
    local _ = Action2 and Action2.Ability;
    local Stack = u63.Data.Stack;
    local u65;

    if Action2 then
        u65 = Action2.Data.Stack or nil;
    else
        u65 = nil;
    end;

    if not Stack then
        return {
            Success = true,
            Info = {
                Conditions = {}
            }
        };
    end;

    local _ = Stack.Tags;
    local v66 = Stack.Checks or {};
    local v67 = v66["@All"] or {
        Conditions = {
            ["Replicated/Stackable"] = true
        }
    };

    local function Validate(p68) -- Line: 642
        -- upvalues: Action2 (copy), u65 (copy), u63 (copy), Validate (copy)
        for _, v in pairs(p68.Values) do
            local v69 = false;

            if typeof(v) == "string" then
                if v == Action2.Name then
                    v69 = true;
                elseif string.sub(v, 1, 1) == "$" then
                    v69 = u65 and (u65.Tags and u65.Tags[string.sub(v, 2)] == true) and true or v69;
                else
                    v69 = v == "@Self" and Action2 == u63 and true or (v == "@All" and true or v69);
                end;
            elseif typeof(v) == "table" then
                v69 = Validate(v);
            end;

            if not v69 then
                return false;
            end;
        end;

        return true;
    end;

    local function ValidateConditions(p70) -- Line: 667
        -- upvalues: DirectoryUtil (ref), u64 (copy), TableUtil (ref)
        local v71 = true;

        for i, v in pairs(p70.Conditions or {}) do
            local v72 = DirectoryUtil.Get({
                Path = i,
                Roots = { u64 }
            });

            if typeof(v) == "function" then
                if v(u64, v72) ~= true then
                    v71 = false;
                end;
            elseif v ~= "@Always" and (v ~= v72 or v == "@Never") then
                v71 = false;
            end;
        end;

        return {
            Success = v71,
            Priority = p70.Priority or 0,
            Info = TableUtil.Reconcile(p70, {
                Conditions = {}
            })
        };
    end;

    local v73 = {};

    if not next(v66) then
        v66["@All"] = v67;
    end;

    if next(v66) then
        for i, v in pairs(v66) do
            if Validate((MoveUtil.CalculateStackCheck(i))) then
                local v74 = ValidateConditions((TableUtil.Reconcile(v, v67)));
                table.insert(v73, v74);
            end;
        end;
    end;

    table.sort(v73, function(p75, p76) -- Line: 717
        return p75.Priority < p76.Priority;
    end);
    local v77 = {
        Success = false,
        Info = {
            Conditions = {}
        }
    };

    for _, v in pairs(v73) do
        if v.Success then
            v77.Success = true;
            v77.Info = TableUtil.Reconcile(v77.Info, v.Info);
        end;
    end;

    return v77;
end;

function u1.GetMoveStack(p78, p79) -- Line: 746
    local v80 = {
        Success = true,
        Calls = {}
    };

    for _, v in pairs(p79:GetCalls()) do
        if not table.isfrozen(v) and (v.Result.Runned ~= false and v.Result.Running ~= false) then
            local v81 = p78:GetCallStack(v);

            if v81.Success then
                v80.Calls[v] = v81;
            else
                v80.Success = false;
            end;
        end;
    end;

    return v80;
end;

function u1.GetFullStack(p82) -- Line: 772
    -- upvalues: Core (copy)
    local v83 = require(Core.ReplicatedServices.Gameplay.WorldService).GetCharacterEntity(p82.Character);
    local v84 = {
        Success = true,
        Calls = {}
    };

    if v83 and v83.Moves ~= nil then
        for _, v in pairs(v83.Moves) do
            local v85 = p82:GetMoveStack(v);

            for i, v2 in pairs(v85.Calls) do
                if not v84.Calls[i] then
                    v84.Calls[i] = v2;
                end;
            end;

            if v85.Success == false then
                v84.Success = false;
            end;
        end;
    end;

    return v84;
end;

function u1.IsActive(p86) -- Line: 800
    for _, v in pairs(p86:GetCalls()) do
        if v.Result.Active == true then
            return true;
        end;
    end;

    return false;
end;

function u1.Activate(p87, p88) -- Line: 809
    -- upvalues: TableUtil (copy)
    return p87:Fire(TableUtil.Reconcile(p88 or {}, {
        Type = "Activate"
    }));
end;

function u1.Deactivate(p89) -- Line: 815
    for _, v in pairs(p89:GetCalls()) do
        if v.Result.Active == true then
            v:Deactivate();
        end;
    end;
end;

function u1.Interrupt(p90) -- Line: 823
    for _, v in pairs(p90:GetCalls()) do
        if v.Result.Interrupted == false then
            v:Interrupt();
        end;
    end;
end;

function u1.GenerateMetadata(u91) -- Line: 831
    -- upvalues: Core (copy), Enums (copy)
    local _ = u91.Data.Metadata;
    local CombatService = require(Core.ReplicatedServices.CombatService);
    local u92 = {};

    local function Scan(p93) -- Line: 837
        -- upvalues: u91 (copy), Enums (ref), u92 (copy), CombatService (copy), Scan (copy)
        if p93._IsAttack or p93 == u91.Data then
            if p93.AttackPriority then
                local AttackPriority = p93.AttackPriority;

                if typeof(AttackPriority) == "string" then
                    AttackPriority = Enums.Get(AttackPriority, Enums.AttackPriority);
                end;

                if u92.AttackPriority == nil or u92.AttackPriority < AttackPriority then
                    u92.AttackPriority = AttackPriority;
                end;
            end;

            if p93.Armor then
                u92.Armor = true;
            end;

            if p93.Damage then
                u92.IsDamaging = true;
            end;

            if p93.Projectile then
                u92.Projectile = true;
            end;

            if p93.Ragdoll and (typeof(p93.Ragdoll.Time) == "number" and p93.Ragdoll.Time > 0) then
                u92.Ragdoll = true;
            end;

            if p93.Grab then
                u92.Grab = true;
            end;

            if p93.Block and p93.Block.BlockBreak then
                u92.BlockBreak = true;
            end;

            if p93.Meter then
                local v94 = p93.Meter.RequiredMeter or (p93.Meter.RequiredAmount or 0);
                local v95 = p93.Meter.RequiredLevel or 0;
                local v96 = math.max(v94, CombatService.LevelToMeter(v95));
                local v97 = math.max(p93.Meter.RequiredMaxMeter or (p93.Meter.RequiredMaxAmount or v94), CombatService.LevelToMeter(p93.Meter.RequiredMaxLevel or v95));

                if u92.MeterCost == nil or (u92.MeterCost == 0 or v96 > 0 and v96 < u92.MeterCost) then
                    u92.MeterCost = v96;
                end;

                local v98 = math.max(v96, v97);

                if u92.MaxMeterCost == nil or u92.MaxMeterCost < v98 then
                    u92.MaxMeterCost = v98;
                end;
            end;
        end;

        for _, v in pairs(p93) do
            if typeof(v) == "table" then
                Scan(v);
            end;
        end;
    end;

    Scan(u91.Data);

    if u91.Sequences then
        for _, v in pairs(u91.Sequences) do
            if v.Info then
                Scan(v.Info);
            end;
        end;
    end;

    if u91.Data.Attacks then
        local StartAttack = u91.Data.StartAttack;

        if StartAttack then
            local v99 = true;

            local function GetNext(p100) -- Line: 914
                -- upvalues: u91 (copy)
                local v101;

                if p100 == nil then
                    v101 = nil;
                else
                    v101 = u91.Data.Attacks[p100] or nil;
                end;

                if v101 ~= nil and v101.NextAttack ~= nil then
                    return v101.NextAttack;
                end;

                local v102;

                if typeof(p100) == "string" then
                    v102 = string.sub(p100, #p100) or nil;
                else
                    v102 = nil;
                end;

                local v103 = v102 and tonumber(v102) or nil;

                if v103 ~= nil then
                    local v104 = string.sub(p100, 1, #p100 - 1) .. v103 + 1;

                    if u91.Data.Attacks[v104] then
                        return v104;
                    end;
                end;
            end;

            local v105 = 1;

            while true do
                StartAttack = v99 and GetNext(StartAttack);

                if not StartAttack then
                    break;
                end;

                v105 = v105 + 1;
            end;

            u92.UseCount = v105;
        end;
    end;

    if u91.Data.Metadata then
        for i, v in pairs(u91.Data.Metadata) do
            u91.Metadata[i] = v;
        end;
    end;

    for i, v in pairs(u92) do
        if u91.Metadata[i] == nil then
            u91.Metadata[i] = v;
        end;
    end;
end;

function u1.GetFlag(p106, p107) -- Line: 965
    return p106.Flags[p107];
end;

function u1.SetFlag(p108, p109, p110) -- Line: 969
    -- upvalues: Core (copy)
    if p108.Flags[p109] ~= p110 then
        p108.Flags[p109] = p110;

        if Core.Context == "Server" and p108.Replica ~= nil then
            p108.Replica:Set({ "Flags", p109 }, p110);
        end;
    end;
end;

function u1.GetBind(p111, p112) -- Line: 978
    return p111.Binds[p112];
end;

function u1.GetBinds(p113, p114) -- Line: 982
    return p113.Binds;
end;

function u1.SetBind(p115, p116, p117) -- Line: 986
    -- upvalues: TableUtil (copy), InputUtil (copy), Core (copy)
    if typeof(p117) ~= "table" then
        local v118 = p115:GetBind(p116);

        if v118 ~= nil then
            p115:SetFlag(v118.Flag, nil);
            p115.OnUnbind:Fire(v118);
        end;

        p115.Binds[p116] = nil;

        if Core.Context == "Server" and p115.Replica ~= nil then
            p115.Replica:Set({ "Binds", p116 }, nil);
        end;

        return;
    end;

    local v119 = p115:GetBind(p116);
    local v120 = TableUtil.Reconcile(p117, {
        Index = p116,
        Flag = InputUtil.FormatKeybind(p117)
    });

    if v119 ~= nil then
        p115:SetFlag(v119.Flag, nil);
        p115.OnUnbind:Fire(v119);
    end;

    p115:SetFlag(v120.Flag, true);
    p115.Binds[p116] = v120;
    p115.OnBind:Fire(v120);

    if Core.Context ~= "Server" or p115.Replica == nil then
        return;
    end;

    p115.Replica:Set({ "Binds", p116 }, v120);
end;

return u1;