 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local FFlags = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags"));
local BotFrameCodec = require(script.Parent.BotFrameCodec);
local BotNetConfig = require(script.Parent.BotNetConfig);
local u1 = {};
local v2;

if FFlags.ClientBots == true then
    v2 = RunService:IsClient();
else
    v2 = false;
end;

u1.enabled = v2;
u1.Delay = BotNetConfig.RenderDelay;
u1.MaxExtrapolation = BotNetConfig.MaxExtrapolation;
u1.renderAt = 0;
local Flags = BotFrameCodec.Flags;
local u3 = Flags.Locked + Flags.Ragdolled;
local u4 = 1 / BotNetConfig.SendRate;
local u5 = {};
u5.__index = u5;

function u5.Disconnect(p6) -- Line: 45
    if not p6.Connected then
        return;
    end;

    p6.Connected = false;
    local _handlers = p6._signal._handlers;
    local table_find_ret = table.find(_handlers, p6);

    if table_find_ret then
        table.remove(_handlers, table_find_ret);
    end;
end;

local u7 = {};
u7.__index = u7;

local function newSignal() -- Line: 58
    -- upvalues: u7 (copy)
    return setmetatable({
        _handlers = {}
    }, u7);
end;

function u7.Connect(p8, p9) -- Line: 61
    -- upvalues: u5 (copy)
    local v10 = setmetatable({
        Connected = true,
        _signal = p8,
        _fn = p9
    }, u5);
    table.insert(p8._handlers, v10);

    return v10;
end;

function u7.Once(p11, u12) -- Line: 66
    local u13 = nil;
    u13 = p11:Connect(function(...) -- Line: 68
        -- upvalues: u13 (ref), u12 (copy)
        u13:Disconnect();
        u12(...);
    end);

    return u13;
end;

function u7.Wait(p14) -- Line: 74
    local coroutine_running_ret = coroutine.running();
    p14:Once(function(...) -- Line: 76
        -- upvalues: coroutine_running_ret (copy)
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u7._fire(p15, ...) -- Line: 81
    local _handlers = p15._handlers;

    if #_handlers == 0 then
        return;
    end;

    for _, v in table.clone(_handlers) do
        if v.Connected then
            task.spawn(v._fn, ...);
        end;
    end;
end;

u1.Added = setmetatable({
    _handlers = {}
}, u7);
u1.Removed = setmetatable({
    _handlers = {}
}, u7);
u1.CharacterChanged = setmetatable({
    _handlers = {}
}, u7);
local u16 = {};
u16.__index = u16;

function u16.GetAttribute(p17, p18) -- Line: 98
    return p17.record:GetAttribute(p18);
end;

function u16.GetAttributeChangedSignal(p19, p20) -- Line: 101
    return p19.record:GetAttributeChangedSignal(p20);
end;

function u16.pose(p21) -- Line: 104
    if p21._posed then
        return p21._position, p21._look, p21._velocity, p21._at;
    end;

    return nil;
end;

function u16.isActive(p22) -- Line: 112
    -- upvalues: u3 (copy)
    local record = p22.record;

    if not p22._posed or (p22._removed or (record:GetAttribute("Hidden") or (record:GetAttribute("FadeOutAt") or (record:GetAttribute("RunState") ~= "Active" or bit32.band(p22._flags, u3) ~= 0)))) then
        return false;
    end;

    local _body = p22._body;

    if _body then
        if _body:GetAttribute("MovementLocked") or _body:GetAttribute("Ragdolled") then
            return false;
        end;

        local Attribute = _body:GetAttribute("Health");

        if type(Attribute) == "number" and Attribute <= 0 then
            return false;
        end;
    end;

    return true;
end;

local u23 = false;
local u24 = nil;
local u25 = {};
local u26 = {};
local u27 = {};
local u28 = {};
local u29 = {};
local u30 = {};
local u31 = {};
local u32 = 0;
local u33 = {};
local table_freeze_ret = table.freeze({});
local u34 = nil;
local u35 = {};
local u36 = 0;

local function takeRing(p37) -- Line: 150
    -- upvalues: u30 (copy), u32 (ref), u31 (copy)
    local v38 = u30[p37];

    if v38 then
        return v38;
    end;

    if u32 >= 1024 then
        return nil;
    end;

    local v39 = table.remove(u31) or table.create(112, 0);
    v39.n = 0;
    v39.head = 0;
    v39.heard = os.clock();
    u30[p37] = v39;
    u32 = u32 + 1;

    return v39;
end;

local function dropRing(p40) -- Line: 166
    -- upvalues: u30 (copy), u32 (ref), u31 (copy)
    local v41 = u30[p40];

    if not v41 then
        return;
    end;

    u30[p40] = nil;
    u32 = u32 - 1;

    if #u31 < 32 then
        table.insert(u31, v41);
    end;
end;

local function push(p42, p43, p44, p45, p46, p47, p48, p49) -- Line: 177
    local v50 = p42.head % 16 + 1;
    local v51 = (v50 - 1) * 7;
    p42[v51 + 1] = p43;
    p42[v51 + 2] = p44;
    p42[v51 + 3] = p45;
    p42[v51 + 4] = p46;
    p42[v51 + 5] = p47;
    p42[v51 + 6] = p48;
    p42[v51 + 7] = p49;
    p42.head = v50;

    if p42.n < 16 then
        p42.n = p42.n + 1;
    end;
end;

local function store(p52, p53, p54, p55, p56, p57, p58, p59) -- Line: 187
    -- upvalues: u4 (copy)
    if p52.n > 0 then
        local v60 = (p52.head - 1) * 7;
        local v61 = p52[v60 + 1];

        if p53 <= v61 then
            return;
        end;

        if p53 - v61 > u4 * 1.5 and (p52[v60 + 6] <= 0.3 and (p54 ~= p52[v60 + 2] or (p55 ~= p52[v60 + 3] or (p56 ~= p52[v60 + 4] or p57 ~= p52[v60 + 5])))) then
            local v62 = p52[v60 + 2];
            local v63 = p52[v60 + 3];
            local v64 = p52[v60 + 4];
            local v65 = p52[v60 + 5];
            local v66 = p52[v60 + 6];
            local v67 = p52[v60 + 7];
            local v68 = p52.head % 16 + 1;
            local v69 = (v68 - 1) * 7;
            p52[v69 + 1] = p53 - u4;
            p52[v69 + 2] = v62;
            p52[v69 + 3] = v63;
            p52[v69 + 4] = v64;
            p52[v69 + 5] = v65;
            p52[v69 + 6] = v66;
            p52[v69 + 7] = v67;
            p52.head = v68;

            if p52.n < 16 then
                p52.n = p52.n + 1;
            end;
        end;
    end;

    local v70 = p52.head % 16 + 1;
    local v71 = (v70 - 1) * 7;
    p52[v71 + 1] = p53;
    p52[v71 + 2] = p54;
    p52[v71 + 3] = p55;
    p52[v71 + 4] = p56;
    p52[v71 + 5] = p57;
    p52[v71 + 6] = p58;
    p52[v71 + 7] = p59;
    p52.head = v70;

    if p52.n < 16 then
        p52.n = p52.n + 1;
    end;
end;

local table_create_ret = table.create(1785, 0);
local u72 = 0;

local function visit(p73, p74, p75, p76, p77, p78, p79) -- Line: 210
    -- upvalues: u72 (ref), table_create_ret (copy)
    local v80 = u72 * 7;
    table_create_ret[v80 + 1] = p73;
    table_create_ret[v80 + 2] = p74;
    table_create_ret[v80 + 3] = p75;
    table_create_ret[v80 + 4] = p76;
    table_create_ret[v80 + 5] = p77;
    table_create_ret[v80 + 6] = p78;
    table_create_ret[v80 + 7] = p79;
    u72 = u72 + 1;
end;

local function receive(p81) -- Line: 216
    -- upvalues: u72 (ref), BotFrameCodec (copy), visit (copy), takeRing (copy), table_create_ret (copy), store (copy)
    u72 = 0;
    local v82 = BotFrameCodec.read(p81, visit);

    if type(v82) ~= "number" or v82 ~= v82 then
        return;
    end;

    local os_clock_ret = os.clock();

    for i = 0, u72 - 1 do
        local v83 = i * 7;
        local v84 = takeRing(table_create_ret[v83 + 1]);
        local v85;

        if v84 then
            v84.heard = os_clock_ret;
            store(v84, v82, table_create_ret[v83 + 2], table_create_ret[v83 + 3], table_create_ret[v83 + 4], table_create_ret[v83 + 5], table_create_ret[v83 + 6], table_create_ret[v83 + 7]);
            v85 = i;
        else
            v85 = i;
        end;
    end;
end;

local function show(p86, p87, p88, p89, p90, p91, p92, p93, p94, p95, p96) -- Line: 233
    p86._position = Vector3.new(p87, p88, p89);
    p86._yaw = p90;
    local v97 = -math.sin(p90);
    local v98 = -math.cos(p90);
    p86._look = Vector3.new(v97, 0, v98);
    p86._velocity = Vector3.new(p93, p94, p95);
    p86._speed = p91;
    p86._flags = p92;
    p86._at = p96;
    p86._posed = true;
end;

local function jump(p99, p100, p101) -- Line: 244
    local v102 = p99[p101 + 2] - p99[p100 + 2];
    local v103 = p99[p101 + 3] - p99[p100 + 3];
    local v104 = p99[p101 + 4] - p99[p100 + 4];
    local v105;

    if v102 * v102 + v103 * v103 + v104 * v104 > 576 then
        v105 = true;
    elseif p99[p101 + 1] - p99[p100 + 1] > 1 then
        v105 = p99[p100 + 6] > 0.3;
    else
        v105 = false;
    end;

    return v105;
end;

local function flow(p106, p107, p108, p109) -- Line: 250
    local v110 = p106[p108 + 1] - p106[p107 + 1];

    if v110 <= 0.0001 then
        return 0, 0, 0;
    end;

    local v111 = (p106[p108 + 2] - p106[p107 + 2]) / v110;
    local v112 = (p106[p108 + 3] - p106[p107 + 3]) / v110;
    local v113 = (p106[p108 + 4] - p106[p107 + 4]) / v110;
    local math_sqrt_ret = math.sqrt(v111 * v111 + v113 * v113);

    if math_sqrt_ret > 0.5 and p109 < 63.5 then
        local v114 = p109 / math_sqrt_ret;
        v111 = v111 * v114;
        v113 = v113 * v114;
    end;

    return v111, v112, v113;
end;

local function sample(p115, p116) -- Line: 266
    -- upvalues: u3 (copy), jump (copy), u1 (copy), flow (copy)
    local _ring = p115._ring;
    local v117 = _ring and (_ring.n or 0) or 0;

    if v117 == 0 then
        return;
    end;

    local head = _ring.head;
    local v118 = (head - 1) * 7;
    local v119 = _ring[v118 + 1];

    if v119 > p116 then
        for i = 2, v117 do
            head = head == 1 and 16 or head - 1;
            local v120 = (head - 1) * 7;
            local v121 = _ring[v120 + 1];

            if v121 <= p116 then
                if jump(_ring, v120, v118) then
                    local v122 = _ring[v120 + 5];
                    local v123 = _ring[v120 + 6];
                    local v124 = _ring[v120 + 7];
                    p115._position = Vector3.new(_ring[v120 + 2], _ring[v120 + 3], _ring[v120 + 4]);
                    p115._yaw = v122;
                    local v125 = -math.sin(v122);
                    local v126 = -math.cos(v122);
                    p115._look = Vector3.new(v125, 0, v126);
                    p115._velocity = Vector3.new(0, 0, 0);
                    p115._speed = v123;
                    p115._flags = v124;
                    p115._at = v121;
                    p115._posed = true;

                    return;
                end;

                local v127 = (p116 - v121) / (v119 - v121);
                local v128 = _ring[v120 + 5];
                local v129 = (_ring[v118 + 5] - v128 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
                local v130 = _ring[v120 + 6] + (_ring[v118 + 6] - _ring[v120 + 6]) * v127;
                local v131, v132, v133 = flow(_ring, v120, v118, v130);
                local v134 = v128 + v129 * v127;
                local v135 = _ring[v120 + 7];
                p115._position = Vector3.new(_ring[v120 + 2] + (_ring[v118 + 2] - _ring[v120 + 2]) * v127, _ring[v120 + 3] + (_ring[v118 + 3] - _ring[v120 + 3]) * v127, _ring[v120 + 4] + (_ring[v118 + 4] - _ring[v120 + 4]) * v127);
                p115._yaw = v134;
                local v136 = -math.sin(v134);
                local v137 = -math.cos(v134);
                p115._look = Vector3.new(v136, 0, v137);
                p115._velocity = Vector3.new(v131, v132, v133);
                p115._speed = v130;
                p115._flags = v135;
                p115._at = p116;
                p115._posed = true;

                return;
            end;

            v119 = v121;
            v118 = v120;
            local _ = i;
        end;

        local v138 = _ring[v118 + 5];
        local v139 = _ring[v118 + 6];
        local v140 = _ring[v118 + 7];
        p115._position = Vector3.new(_ring[v118 + 2], _ring[v118 + 3], _ring[v118 + 4]);
        p115._yaw = v138;
        local v141 = -math.sin(v138);
        local v142 = -math.cos(v138);
        p115._look = Vector3.new(v141, 0, v142);
        p115._velocity = Vector3.new(0, 0, 0);
        p115._speed = v139;
        p115._flags = v140;
        p115._at = v119;
        p115._posed = true;

        return;
    end;

    local v143 = _ring[v118 + 6];
    local v144 = _ring[v118 + 7];

    if v117 > 1 and (v143 > 0.3 and bit32.band(v144, u3) == 0) then
        local v145 = ((head == 1 and 16 or head - 1) - 1) * 7;

        if not jump(_ring, v145, v118) then
            local math_min_ret = math.min(p116 - v119, u1.MaxExtrapolation);
            local v146, v147, v148 = flow(_ring, v145, v118, v143);
            local v149 = _ring[v118 + 5];
            p115._position = Vector3.new(_ring[v118 + 2] + v146 * math_min_ret, _ring[v118 + 3] + v147 * math_min_ret, _ring[v118 + 4] + v148 * math_min_ret);
            p115._yaw = v149;
            local v150 = -math.sin(v149);
            local v151 = -math.cos(v149);
            p115._look = Vector3.new(v150, 0, v151);
            p115._velocity = Vector3.new(v146, v147, v148);
            p115._speed = v143;
            p115._flags = v144;
            p115._at = v119 + math_min_ret;
            p115._posed = true;

            return;
        end;
    end;

    local v152 = _ring[v118 + 5];

    if v143 > 0.3 then
        p116 = v119 or p116;
    end;

    p115._position = Vector3.new(_ring[v118 + 2], _ring[v118 + 3], _ring[v118 + 4]);
    p115._yaw = v152;
    local v153 = -math.sin(v152);
    local v154 = -math.cos(v152);
    p115._look = Vector3.new(v153, 0, v154);
    p115._velocity = Vector3.new(0, 0, 0);
    p115._speed = v143;
    p115._flags = v144;
    p115._at = p116;
    p115._posed = true;
end;

local function step(p155) -- Line: 338
    -- upvalues: u1 (copy), table_freeze_ret (ref), sample (copy), u36 (ref), u30 (copy), u28 (copy), u32 (ref), u31 (copy)
    u1.renderAt = p155;

    for _, v in table_freeze_ret do
        sample(v, p155);
    end;

    local os_clock_ret = os.clock();

    if u36 <= os_clock_ret then
        u36 = os_clock_ret + 5;

        for i, v in u30 do
            if not u28[i] and os_clock_ret - v.heard > 5 then
                local v156 = u30[i];

                if v156 then
                    u30[i] = nil;
                    u32 = u32 - 1;

                    if #u31 < 32 then
                        table.insert(u31, v156);
                    end;
                end;
            end;
        end;
    end;
end;

local function attach(p157, p158) -- Line: 355
    -- upvalues: u28 (copy), u30 (copy), u32 (ref), u31 (copy), takeRing (copy)
    if type(p158) ~= "number" then
        p158 = nil;
    end;

    if p157.NetId == p158 and (p158 == nil or p157._ring ~= nil) then
        return;
    end;

    local NetId = p157.NetId;

    if NetId ~= nil and u28[NetId] == p157 then
        u28[NetId] = nil;
        local v159 = u30[NetId];

        if v159 then
            u30[NetId] = nil;
            u32 = u32 - 1;

            if #u31 < 32 then
                table.insert(u31, v159);
            end;
        end;
    end;

    p157.NetId = p158;
    p157._ring = nil;

    if p158 and not p157._removed then
        local v160 = u28[p158];

        if v160 and v160 ~= p157 then
            v160._ring = nil;
        end;

        u28[p158] = p157;
        p157._ring = takeRing(p158);
    end;
end;

local function updateCharacter(p161) -- Line: 378
    -- upvalues: u1 (copy)
    local _ref = p161._ref;

    if _ref then
        if _ref.Parent == p161.record then
            _ref = _ref.Value;
        else
            _ref = false;
        end;
    end;

    local v162 = _ref or p161._rig;

    if p161.Character == v162 then
        return;
    end;

    p161.Character = v162;
    u1.CharacterChanged:_fire(p161, v162);
end;

local function bindRef(u163, p164) -- Line: 388
    -- upvalues: u1 (copy)
    if u163._refChanged then
        u163._refChanged:Disconnect();
        u163._refChanged = nil;
    end;

    u163._ref = p164;

    if p164 then
        u163._refChanged = p164:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 395
            -- upvalues: u163 (copy), u1 (ref)
            local v165 = u163;
            local _ref = v165._ref;

            if _ref then
                if _ref.Parent == v165.record then
                    _ref = _ref.Value;
                else
                    _ref = false;
                end;
            end;

            local v166 = _ref or v165._rig;

            if v165.Character == v166 then
                return;
            end;

            v165.Character = v166;
            u1.CharacterChanged:_fire(v165, v166);
        end);
    end;

    local _ref = u163._ref;

    if _ref then
        if _ref.Parent == u163.record then
            _ref = _ref.Value;
        else
            _ref = false;
        end;
    end;

    local v167 = _ref or u163._rig;

    if u163.Character == v167 then
        return;
    end;

    u163.Character = v167;
    u1.CharacterChanged:_fire(u163, v167);
end;

local function describe(p168) -- Line: 401
    local record = p168.record;
    local Attribute = record:GetAttribute("DisplayName");
    p168.DisplayName = type(Attribute) == "string" and Attribute and Attribute or record.Name;
    local Attribute2 = record:GetAttribute("CloneOwnerUserId");
    p168.OwnerUserId = Attribute2;
    p168.Kind = record:GetAttribute("BotKind") or (Attribute2 and "Clone" or "Bot");
    p168.AvatarUserId = record:GetAttribute("AvatarUserId");
end;

local function publish() -- Line: 410
    -- upvalues: table_freeze_ret (ref), u33 (copy)
    table_freeze_ret = table.freeze(table.clone(u33));
end;

local function add(u169) -- Line: 413
    -- upvalues: u25 (copy), u29 (copy), u24 (ref), add (copy), u16 (copy), describe (copy), u26 (copy), attach (copy), bindRef (copy), u1 (copy), u33 (copy), table_freeze_ret (ref)
    if u25[u169] or u29[u169] then
        return;
    end;

    local Attribute = u169:GetAttribute("UserId");

    if type(Attribute) ~= "number" then
        u29[u169] = u169:GetAttributeChangedSignal("UserId"):Connect(function() -- Line: 419
            -- upvalues: u169 (copy), u29 (ref), u24 (ref), add (ref)
            if type(u169:GetAttribute("UserId")) ~= "number" then
                return;
            end;

            local v170 = u29[u169];
            u29[u169] = nil;

            if v170 then
                v170:Disconnect();
            end;

            if u169.Parent == u24 then
                add(u169);
            end;
        end);

        return;
    end;

    local u171 = setmetatable({
        IsBot = true,
        Character = nil,
        _flags = 0,
        _speed = 0,
        _posed = false,
        UserId = Attribute,
        Name = u169.Name,
        record = u169,
        _connections = {}
    }, u16);
    describe(u171);
    u25[u169] = u171;
    u26[Attribute] = u171;
    local Body = u169:FindFirstChild("Body");

    if not (Body and (Body:IsA("Folder") and Body)) then
        Body = nil;
    end;

    u171._body = Body;
    table.insert(u171._connections, u169.AttributeChanged:Connect(function(p172) -- Line: 452
        -- upvalues: attach (ref), u171 (copy), u169 (copy), describe (ref)
        if p172 == "NetId" then
            attach(u171, u169:GetAttribute("NetId"));

            return;
        end;

        if p172 == "DisplayName" or (p172 == "BotKind" or (p172 == "CloneOwnerUserId" or p172 == "AvatarUserId")) then
            describe(u171);
        end;
    end));
    table.insert(u171._connections, u169.ChildAdded:Connect(function(p173) -- Line: 462
        -- upvalues: u171 (copy), bindRef (ref)
        if p173.Name == "Body" and p173:IsA("Folder") then
            u171._body = p173;

            return;
        end;

        if p173.Name == "Character" and p173:IsA("ObjectValue") then
            bindRef(u171, p173);
        end;
    end));
    table.insert(u171._connections, u169.ChildRemoved:Connect(function(p174) -- Line: 472
        -- upvalues: u171 (copy), u169 (copy), bindRef (ref)
        if p174 ~= u171._body then
            if p174 == u171._ref then
                local Character = u169:FindFirstChild("Character");

                if not (Character and (Character:IsA("ObjectValue") and Character)) then
                    Character = nil;
                end;

                bindRef(u171, Character);
            end;

            return;
        end;

        local Body2 = u169:FindFirstChild("Body");

        if not (Body2 and (Body2:IsA("Folder") and Body2)) then
            Body2 = nil;
        end;

        u171._body = Body2;
    end));
    local Character = u169:FindFirstChild("Character");

    if Character and Character:IsA("ObjectValue") then
        u171._ref = Character;
        u171._refChanged = Character:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 485
            -- upvalues: u171 (copy), u1 (ref)
            local v175 = u171;
            local _ref = v175._ref;

            if _ref then
                if _ref.Parent == v175.record then
                    _ref = _ref.Value;
                else
                    _ref = false;
                end;
            end;

            local v176 = _ref or v175._rig;

            if v175.Character == v176 then
                return;
            end;

            v175.Character = v176;
            u1.CharacterChanged:_fire(v175, v176);
        end);
        u171.Character = Character.Value;
    end;

    attach(u171, u169:GetAttribute("NetId"));
    table.insert(u33, u171);
    table_freeze_ret = table.freeze(table.clone(u33));
    u1.Added:_fire(u171);
end;

local function remove(p177) -- Line: 495
    -- upvalues: u29 (copy), u25 (copy), u26 (copy), attach (copy), u33 (copy), table_freeze_ret (ref), u1 (copy), u27 (copy)
    local v178 = u29[p177];

    if v178 then
        u29[p177] = nil;
        v178:Disconnect();
    end;

    local v179 = u25[p177];

    if not v179 then
        return;
    end;

    u25[p177] = nil;

    if u26[v179.UserId] == v179 then
        u26[v179.UserId] = nil;
    end;

    for _, v in v179._connections do
        v:Disconnect();
    end;

    table.clear(v179._connections);

    if v179._refChanged then
        v179._refChanged:Disconnect();
        v179._refChanged = nil;
    end;

    v179._removed = true;
    attach(v179, nil);
    local table_find_ret = table.find(u33, v179);

    if table_find_ret then
        table.remove(u33, table_find_ret);
    end;

    table_freeze_ret = table.freeze(table.clone(u33));
    u1.Removed:_fire(v179);

    if v179._rig and u27[v179._rig] == v179 then
        u27[v179._rig] = nil;
    end;
end;

function u1._setRig(p180, p181) -- Line: 532
    -- upvalues: u27 (copy), u1 (copy)
    local _rig = p180._rig;

    if _rig == p181 then
        return;
    end;

    if _rig and u27[_rig] == p180 then
        u27[_rig] = nil;
    end;

    p180._rig = p181;

    if p181 and not p180._removed then
        u27[p181] = p180;
    end;

    local _ref = p180._ref;

    if _ref then
        if _ref.Parent == p180.record then
            _ref = _ref.Value;
        else
            _ref = false;
        end;
    end;

    local v182 = _ref or p180._rig;

    if p180.Character == v182 then
        return;
    end;

    p180.Character = v182;
    u1.CharacterChanged:_fire(p180, v182);
end;

function u1._watch(p183, p184) -- Line: 547
    -- upvalues: u24 (ref), u35 (copy), add (copy), remove (copy), receive (copy)
    u24 = p183;
    table.insert(u35, p183.ChildAdded:Connect(add));
    table.insert(u35, p183.ChildRemoved:Connect(remove));

    for _, child in p183:GetChildren() do
        add(child);
    end;

    if p184 then
        table.insert(u35, p184.OnClientEvent:Connect(receive));
    end;
end;

u1._receive = receive;
u1._step = step;

function u1._stop() -- Line: 561
    -- upvalues: u23 (ref), RunService (copy), u35 (copy), u29 (copy), remove (copy), u33 (copy), u30 (copy), u32 (ref), u31 (copy), u27 (copy), u24 (ref), u34 (ref)
    if u23 then
        pcall(RunService.UnbindFromRenderStep, RunService, "ClientBotPoses");
    end;

    u23 = false;

    for _, v in u35 do
        v:Disconnect();
    end;

    table.clear(u35);

    for i in u29 do
        remove(i);
    end;

    for _, v in table.clone(u33) do
        remove(v.record);
    end;

    for i in u30 do
        local v185 = u30[i];

        if v185 then
            u30[i] = nil;
            u32 = u32 - 1;

            if #u31 < 32 then
                table.insert(u31, v185);
            end;
        end;
    end;

    table.clear(u31);
    table.clear(u27);
    u24 = nil;
    u34 = nil;
end;

function u1._counts() -- Line: 584
    -- upvalues: u25 (copy), u27 (copy), u28 (copy), u32 (ref), u29 (copy), u35 (copy), u1 (copy)
    local v186 = 0;
    local v187 = 0;
    local v188 = 0;

    for _ in u25 do
        v186 = v186 + 1;
    end;

    for _ in u27 do
        v187 = v187 + 1;
    end;

    for _ in u28 do
        v188 = v188 + 1;
    end;

    return {
        records = v186,
        models = v187,
        nets = v188,
        rings = u32,
        waiting = next(u29) ~= nil,
        watchers = #u35,
        added = #u1.Added._handlers,
        removed = #u1.Removed._handlers,
        changed = #u1.CharacterChanged._handlers
    };
end;

function u1.start() -- Line: 608
    -- upvalues: u23 (ref), u1 (copy), RunService (copy), step (copy), u24 (ref)
    if u23 or not u1.enabled then
        return;
    end;

    u23 = true;
    RunService:BindToRenderStep("ClientBotPoses", Enum.RenderPriority.Input.Value + 10, function() -- Line: 613
        -- upvalues: step (ref), u1 (ref)
        step(workspace:GetServerTimeNow() - u1.Delay);
    end);
    task.spawn(function() -- Line: 616
        -- upvalues: u23 (ref), u24 (ref), u1 (ref)
        local script_Parent = script.Parent;
        local Actors = script_Parent:WaitForChild("Actors");
        local BotFrames = script_Parent:WaitForChild("BotFrames");

        if u23 and not u24 then
            u1._watch(Actors, BotFrames);
        end;
    end);
end;

function u1.list() -- Line: 625
    -- upvalues: u23 (ref), u1 (copy), table_freeze_ret (ref)
    if not u23 then
        u1.start();
    end;

    return table_freeze_ret;
end;

function u1.get(p189) -- Line: 631
    -- upvalues: u23 (ref), u1 (copy), u26 (copy)
    if not u23 then
        u1.start();
    end;

    return u26[p189];
end;

function u1.resolve(p190) -- Line: 637
    -- upvalues: u23 (ref), u1 (copy), u26 (copy), Players (copy)
    if type(p190) ~= "number" then
        return nil;
    end;

    if not u23 then
        u1.start();
    end;

    return u26[p190] or Players:GetPlayerByUserId(p190);
end;

function u1.ofModel(p191) -- Line: 646
    -- upvalues: u23 (ref), u1 (copy), u27 (copy)
    if not u23 then
        u1.start();
    end;

    local v192 = typeof(p191) == "Instance" and p191 and p191 or nil;

    if not v192 then
        return nil;
    end;

    local v193 = u27[v192];

    if v193 then
        return v193;
    end;

    local Parent = v192.Parent;

    if not Parent then
        return nil;
    end;

    local v194 = u27[Parent];

    if v194 then
        return v194;
    end;

    local Parent2 = Parent.Parent;

    if not Parent2 then
        return nil;
    end;

    local v195 = u27[Parent2];

    if v195 then
        return v195;
    end;

    local Parent3 = Parent2.Parent;

    if not Parent3 then
        return nil;
    end;

    local v196 = u27[Parent3];

    if v196 then
        return v196;
    end;

    local Parent4 = Parent3.Parent;

    if not Parent4 then
        return nil;
    end;

    local v197 = u27[Parent4];

    if v197 then
        return v197;
    end;

    local Parent5 = Parent4.Parent;

    if not Parent5 then
        return nil;
    end;

    local v198 = u27[Parent5];

    if v198 then
        return v198;
    end;

    local _ = Parent5.Parent;

    return nil;
end;

function u1.model(p199) -- Line: 663
    -- upvalues: u23 (ref), u1 (copy), u25 (copy)
    if not u23 then
        u1.start();
    end;

    local v200 = u25[p199];

    if v200 then
        v200 = v200._rig;
    end;

    return v200;
end;

function u1.setFocus(p201) -- Line: 670
    -- upvalues: u34 (ref)
    u34 = typeof(p201) == "Vector3" and p201 and p201 or nil;
end;

function u1.focus() -- Line: 674
    -- upvalues: u34 (ref), Players (copy)
    if u34 then
        return u34;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        LocalPlayer = LocalPlayer.Character;
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:FindFirstChild("HumanoidRootPart");
    end;

    if LocalPlayer then
        return LocalPlayer.Position;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    return workspace_CurrentCamera and workspace_CurrentCamera.Focus.Position or Vector3.new(0, 0, 0);
end;

return u1;