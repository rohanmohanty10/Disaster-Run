 
 

local TypeRegistry = require(script.Parent.TypeRegistry);
local EventsCollision = require(script.Parent.EventsCollision);
local EventsPayload = require(script.Parent.EventsPayload);
local EventsSchema = require(script.Parent.EventsSchema);
local Pool = require(script.Parent.Pool);
local u1 = {};
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
local u8 = 0;

local function nextChainId() -- Line: 49
    -- upvalues: u8 (ref)
    u8 = u8 + 1;

    return u8;
end;

function u1.newChainCtx() -- Line: 54
    -- upvalues: u8 (ref)
    local v9 = {
        Depth = 0
    };
    u8 = u8 + 1;
    v9.ChainId = u8;

    return v9;
end;

function u1.withEmitIndex(p10, p11) -- Line: 59
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

function u1.withEmitIndexAndCount(p13, p14, p15) -- Line: 69
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

function u1.descendCtx(p17) -- Line: 80
    if p17 then
        return (p17.EventOriginCF ~= nil or (p17.IgnoreLink ~= nil or (p17.UseFullOrigin ~= nil or p17.EventOriginResolver ~= nil))) and {
            ChainCtx = p17.ChainCtx,
            EmitIndex = p17.EmitIndex,
            EmitCount = p17.EmitCount
        } or p17;
    end;

    return nil;
end;

local success = pcall(function() -- Line: 97
    return Instance.new("ModuleScript").Source;
end);

function u1._compile(p18) -- Line: 99
    -- upvalues: success (copy)
    if not success then
        local success2, result = pcall(require, p18);

        if not success2 then
            return nil, result;
        end;

        if type(result) == "function" then
            return result, nil, nil;
        end;

        return nil, "module must return function(payload)";
    end;

    local v19 = p18:Clone();
    v19.Name = "_CompiledEventModule";
    v19.Archivable = false;
    v19.Parent = p18.Parent;
    local success2, result = pcall(require, v19);

    if not success2 then
        v19:Destroy();

        return nil, result;
    end;

    if type(result) == "function" then
        return result, nil, v19;
    end;

    v19:Destroy();

    return nil, "module must return function(payload)";
end;

function u1._isCacheValid(p20, p21) -- Line: 121
    if not (p20 and (p21 and p21:IsA("ModuleScript"))) then
        return false;
    end;

    if p21.Name ~= "Module" then
        return false;
    end;

    local expectedEventCfg = p20.expectedEventCfg;

    if not (expectedEventCfg and expectedEventCfg.Parent) then
        return false;
    end;

    if expectedEventCfg.Name ~= p20.expectedEventName then
        return false;
    end;

    if expectedEventCfg.Parent and expectedEventCfg.Parent.Name == "Events" then
        return p21.Parent == expectedEventCfg;
    end;

    return false;
end;

function u1._invalidate(p22) -- Line: 132
    -- upvalues: u2 (copy)
    local u23 = u2[p22];

    if not u23 then
        return;
    end;

    if u23.sourceConn then
        u23.sourceConn:Disconnect();
        u23.sourceConn = nil;
    end;

    if u23.ancestryConn then
        u23.ancestryConn:Disconnect();
        u23.ancestryConn = nil;
    end;

    if u23.nameConn then
        u23.nameConn:Disconnect();
        u23.nameConn = nil;
    end;

    if u23.compiledClone then
        pcall(function() -- Line: 139
            -- upvalues: u23 (copy)
            u23.compiledClone:Destroy();
        end);
        u23.compiledClone = nil;
    end;

    u2[p22] = nil;
end;

function u1.compile(u24) -- Line: 146
    -- upvalues: u2 (copy), u1 (copy), success (copy)
    if not (u24 and u24:IsA("ModuleScript")) then
        return nil;
    end;

    local v25 = u2[u24];

    if v25 and (not v25.dirty and u1._isCacheValid(v25, u24)) then
        return v25.fn;
    end;

    if v25 then
        u1._invalidate(u24);
    end;

    local v26, v27, v28 = u1._compile(u24);

    if not v26 then
        u1.reportScriptError(u24, v27);

        return nil;
    end;

    local Parent = u24.Parent;

    if not (Parent and Parent:IsA("Configuration")) then
        v28:Destroy();

        return nil;
    end;

    local v29 = {
        dirty = false,
        fn = v26,
        expectedEventCfg = Parent,
        expectedEventName = Parent.Name,
        compiledClone = v28
    };

    if success then
        v29.sourceConn = u24:GetPropertyChangedSignal("Source"):Connect(function() -- Line: 177
            -- upvalues: u2 (ref), u24 (copy)
            if u2[u24] then
                u2[u24].dirty = true;
            end;
        end);
    end;

    v29.ancestryConn = u24.AncestryChanged:Connect(function() -- Line: 182
        -- upvalues: u1 (ref), u2 (ref), u24 (copy)
        if not u1._isCacheValid(u2[u24], u24) then
            u1._invalidate(u24);
        end;
    end);
    v29.nameConn = u24:GetPropertyChangedSignal("Name"):Connect(function() -- Line: 189
        -- upvalues: u24 (copy)
        if u24.Name ~= "Module" then
            pcall(function() -- Line: 191
                -- upvalues: u24 (ref)
                u24.Name = "Module";
            end);
        end;
    end);
    u2[u24] = v29;

    return v26;
end;

function u1.cleanup() -- Line: 198
    -- upvalues: u2 (copy), u1 (copy), u5 (ref), u4 (ref), u3 (ref), u6 (copy), u7 (copy)
    local v30 = {};

    for i in pairs(u2) do
        table.insert(v30, i);
    end;

    for _, v in ipairs(v30) do
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

function u1._reportBurst() -- Line: 217
    -- upvalues: u1 (copy), u5 (ref)
    local v31 = u1;
    v31._burstDropped = v31._burstDropped + 1;

    if not u1._burstReportPending then
        u1._burstReportPending = true;
        local u32 = u5;
        task.delay(1, function() -- Line: 222
            -- upvalues: u32 (copy), u5 (ref), u1 (ref)
            if u32 ~= u5 then
                return;
            end;

            if u1._burstDropped > 0 then
                warn(("[Part-Icles Events] dropped %d event fires this second."):format(u1._burstDropped));
            end;

            u1._burstDropped = 0;
            u1._burstReportPending = false;
        end);
    end;
end;

function u1.reserveFrameFire() -- Line: 233
    -- upvalues: u1 (copy)
    if u1._frameCount >= 256 then
        u1._reportBurst();

        return false;
    end;

    local v33 = u1;
    v33._frameCount = v33._frameCount + 1;

    return true;
end;

function u1.tickFrame() -- Line: 243
    -- upvalues: u1 (copy)
    u1._frameCount = 0;
end;

function u1.dropDepth(u34) -- Line: 247
    -- upvalues: u4 (ref), u3 (ref), u5 (ref)
    u4 = u4 + 1;

    if not u3 then
        u3 = true;
        local u35 = u5;
        task.delay(1, function() -- Line: 252
            -- upvalues: u35 (copy), u5 (ref), u4 (ref), u34 (copy), u3 (ref)
            if u35 ~= u5 then
                return;
            end;

            if u4 > 0 then
                warn(("[Part-Icles Events] dropped %d event fire(s) this second (chain depth limit reached%s)."):format(u4, u34 and " on " .. u34 or ""));
            end;

            u4 = 0;
            u3 = false;
        end);
    end;
end;

function u1.reportScriptError(p36, p37) -- Line: 264
    local v38 = p36 and p36:GetFullName() or "<destroyed>";
    warn(("[Part-Icles Events] %s\n  %s"):format(v38, (tostring(p37))));
end;

function u1.getWorldCF(p39) -- Line: 270
    local VisualPart = p39.VisualPart;

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

    if VisualPart:IsA("PointLight") then
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

function u1.getWorldPosition(p40) -- Line: 294
    -- upvalues: u1 (copy)
    local WorldCF = u1.getWorldCF(p40);

    return WorldCF and WorldCF.Position or nil;
end;

function u1.getSourceWorldCF(p41) -- Line: 299
    if not (p41 and p41.Parent) then
        return nil;
    end;

    if p41:IsA("BasePart") then
        return p41.CFrame;
    end;

    if p41:IsA("Attachment") then
        return p41.WorldCFrame;
    end;

    if p41:IsA("Model") then
        return p41:GetPivot();
    end;

    if p41:IsA("Beam") then
        local Attachment0 = p41.Attachment0;

        if not Attachment0 then
            return nil;
        end;

        local Attachment1 = p41.Attachment1;

        if Attachment1 then
            return CFrame.new((Attachment0.WorldPosition + Attachment1.WorldPosition) * 0.5);
        end;

        return CFrame.new(Attachment0.WorldPosition);
    end;

    if not p41:IsA("PointLight") then
        return nil;
    end;

    local Parent = p41.Parent;

    if Parent and Parent:IsA("BasePart") then
        return Parent.CFrame;
    end;

    if Parent and Parent:IsA("Attachment") then
        return Parent.WorldCFrame;
    end;

    return nil;
end;

function u1.makeHitParams(p42) -- Line: 328
    -- upvalues: EventsSchema (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v43 = {};

    if p42.VisualPart then
        table.insert(v43, p42.VisualPart);
    end;

    if p42._sourceItem then
        table.insert(v43, p42._sourceItem);
    end;

    if p42._sourceItem then
        local RenderTemplate = p42._sourceItem:FindFirstChild("RenderTemplate");

        if RenderTemplate then
            table.insert(v43, RenderTemplate);
        end;

        local EmitParent = p42._sourceItem:FindFirstChild("EmitParent");

        if EmitParent and (EmitParent:IsA("ObjectValue") and EmitParent.Value) then
            table.insert(v43, EmitParent.Value);
        end;
    end;

    if p42.VisualPart and (p42.VisualPart:IsA("Attachment") and p42.VisualPart.Parent) then
        table.insert(v43, p42.VisualPart.Parent);
    end;

    if p42._sourceItem then
        local v44 = EventsSchema.readEvent(p42._sourceItem, "OnHit");

        if v44 then
            local Attribute = v44:GetAttribute("CollisionGroup");

            if type(Attribute) == "string" and Attribute ~= "" then
                pcall(function() -- Line: 359
                    -- upvalues: RaycastParams_new_ret (copy), Attribute (copy)
                    RaycastParams_new_ret.CollisionGroup = Attribute;
                end);
            end;

            local ExcludeList = v44:FindFirstChild("ExcludeList");

            if ExcludeList then
                for _, child in ipairs(ExcludeList:GetChildren()) do
                    if child:IsA("ObjectValue") and child.Value then
                        table.insert(v43, child.Value);
                    end;
                end;
            end;
        end;
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v43;
    RaycastParams_new_ret.IgnoreWater = true;

    return RaycastParams_new_ret;
end;

function u1.makePayload(p45, p46, p47, p48) -- Line: 377
    -- upvalues: EventsPayload (copy), u1 (copy)
    return EventsPayload.build(p46, p47, p48, u1.getWorldCF(p46));
end;

function u1.resolveEmitModeCF(p49, p50, p51) -- Line: 390
    -- upvalues: u1 (copy)
    if p49 == "AtPosition" then
        if p50 and p50._eventName == "OnEmit" then
            local WorldCF = u1.getWorldCF(p51);

            if WorldCF then
                return WorldCF;
            end;

            if p51.CurrentPosition then
                return CFrame.new(p51.CurrentPosition);
            end;
        end;

        local v52 = p50.HitPosition or (p50.DeathPosition or p50.EmitPosition);

        if v52 and (p50._eventName == "OnHit" and p50.HitNormal) then
            v52 = v52 + p50.HitNormal * 0.1;
        end;

        return v52 and CFrame.new(v52) or nil;
    end;

    if p49 == "AtSource" then
        return u1.getSourceWorldCF(p51._sourceItem);
    end;

    if p49 ~= "AtCFrame" then
        return nil;
    end;

    local v53 = p50 and p50._eventName == "OnEmit" and u1.getWorldCF(p51);

    if v53 then
        return v53;
    end;

    local v54;

    if p50 then
        v54 = p50.WorldCFrame;
    else
        v54 = p50;
    end;

    if v54 and (p50._eventName == "OnHit" and p50.HitNormal) then
        v54 = v54 + p50.HitNormal * 0.1;
    end;

    return v54 or nil;
end;

function u1._supportsOriginOverride(p55) -- Line: 419
    return p55:IsA("BasePart") or (p55:IsA("Attachment") or p55:IsA("Model"));
end;

local function _newHolderPart() -- Line: 425
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.001, 0.001, 0.001);
    Part.Archivable = false;

    return Part;
end;

local function _anchorClone(p56) -- Line: 439
    if p56:IsA("BasePart") then
        p56.Anchored = true;
    end;

    for _, descendant in ipairs(p56:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;
end;

local function _positionClone(p57, p58) -- Line: 448
    if p57:IsA("Model") then
        p57:PivotTo(p58);

        return;
    end;

    if p57:IsA("BasePart") then
        p57.CFrame = p58;

        return;
    end;

    if p57:IsA("Attachment") then
        p57.WorldCFrame = p58;
    end;
end;

local function _getAttachmentHolder(p59) -- Line: 461
    local Folder = p59:GetFolder();
    local _AttachmentHolder = Folder:FindFirstChild("_AttachmentHolder");

    if _AttachmentHolder then
        return _AttachmentHolder;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Massless = true;
    Part.Transparency = 1;
    Part.Size = Vector3.new(0.001, 0.001, 0.001);
    Part.Archivable = false;
    Part.Name = "_AttachmentHolder";
    Part.CFrame = CFrame.new();
    Part.Parent = Folder;

    return Part;
end;

local function _stampAuthoredEnabled(u60) -- Line: 477
    local function visit(u61) -- Line: 478
        if u61:IsA("ParticleEmitter") or u61:IsA("Trail") then
            pcall(function() -- Line: 480
                -- upvalues: u61 (copy)
                u61:SetAttribute("_PartIcleAuthoredEnabled", u61.Enabled);
            end);
        end;
    end;

    if u60:IsA("ParticleEmitter") or u60:IsA("Trail") then
        pcall(function() -- Line: 480
            -- upvalues: u60 (copy)
            u60:SetAttribute("_PartIcleAuthoredEnabled", u60.Enabled);
        end);
    end;

    for _, descendant in ipairs(u60:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            pcall(function() -- Line: 480
                -- upvalues: descendant (copy)
                descendant:SetAttribute("_PartIcleAuthoredEnabled", descendant.Enabled);
            end);
        end;
    end;
end;

local function _restoreAuthoredEnabled(p62) -- Line: 489
    local function v64(u63) -- Line: 490
        if u63:IsA("ParticleEmitter") or u63:IsA("Trail") then
            local Attribute = u63:GetAttribute("_PartIcleAuthoredEnabled");
            pcall(function() -- Line: 493
                -- upvalues: u63 (copy), Attribute (copy)
                u63.Enabled = Attribute == true;
            end);
        end;
    end;

    v64(p62);

    for _, descendant in ipairs(p62:GetDescendants()) do
        v64(descendant);
    end;
end;

local function _killEmittersForRelease(u65) -- Line: 503
    local function _(u66) -- Line: 504
        if u66:IsA("ParticleEmitter") or u66:IsA("Trail") then
            pcall(function() -- Line: 506
                -- upvalues: u66 (copy)
                u66.Enabled = false;
            end);
        end;
    end;

    if u65:IsA("ParticleEmitter") or u65:IsA("Trail") then
        pcall(function() -- Line: 506
            -- upvalues: u65 (copy)
            u65.Enabled = false;
        end);
    end;

    for _, descendant in ipairs(u65:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            pcall(function() -- Line: 506
                -- upvalues: descendant (copy)
                descendant.Enabled = false;
            end);
        end;
    end;
end;

local function _kindFor(p67) -- Line: 516
    return p67:IsA("BasePart") and "Part" or (p67:IsA("Model") and "Model" or (p67:IsA("Folder") and "Model" or (p67:IsA("Attachment") and "Attachment" or (p67:IsA("ParticleEmitter") and "Part" or "Part"))));
end;

local function _computeCloneLifetime(p68) -- Line: 527
    local u69 = 2;

    local function v78(u70) -- Line: 529
        -- upvalues: u69 (ref)
        if not u70:IsA("ParticleEmitter") then
            if u70:IsA("Trail") then
                local v71 = tonumber(u70:GetAttribute("EmitDuration")) or 0;
                local u72 = 2;
                pcall(function() -- Line: 540
                    -- upvalues: u72 (ref), u70 (copy)
                    u72 = math.max(u72, u70.Lifetime);
                end);
                local v73 = v71 + u72 + 0.5;

                if u69 < v73 then
                    u69 = v73;
                end;
            end;

            return;
        end;

        local v74 = tonumber(u70:GetAttribute("EmitDelay")) or 0;
        local v75 = tonumber(u70:GetAttribute("EmitDuration")) or 0;
        local u76 = 2;
        pcall(function() -- Line: 534
            -- upvalues: u76 (ref), u70 (copy)
            u76 = math.max(u76, u70.Lifetime.Max);
        end);
        local v77 = v74 + v75 + u76 + 0.5;

        if u69 < v77 then
            u69 = v77;
        end;
    end;

    v78(p68);

    for _, descendant in ipairs(p68:GetDescendants()) do
        v78(descendant);
    end;

    return u69 > 600 and 600 or u69;
end;

local function _buildEmitClone(u79) -- Line: 564
    -- upvalues: _stampAuthoredEnabled (copy)
    local u80 = nil;

    if u79:IsA("BasePart") then
        u80 = u79:Clone();
        u80.Archivable = false;
    elseif u79:IsA("Model") then
        u80 = u79:Clone();
        u80.Archivable = false;
    elseif u79:IsA("Folder") then
        u80 = Instance.new("Model");
        u80.Archivable = false;
        local v81 = u79:Clone();
        v81.Archivable = false;
        v81.Parent = u80;

        for _, descendant in ipairs(v81:GetDescendants()) do
            if descendant:IsA("BasePart") and not descendant:GetAttribute("_isAnchor") then
                u80.WorldPivot = CFrame.new(descendant.Position);
                break;
            end;
        end;
    elseif u79:IsA("Attachment") then
        u80 = u79:Clone();
    elseif u79:IsA("ParticleEmitter") then
        u80 = Instance.new("Part");
        u80.Anchored = true;
        u80.CanCollide = false;
        u80.CanQuery = false;
        u80.CanTouch = false;
        u80.Massless = true;
        u80.Transparency = 1;
        u80.Size = Vector3.new(0.001, 0.001, 0.001);
        u80.Archivable = false;

        if u79.Parent and u79.Parent:IsA("BasePart") then
            pcall(function() -- Line: 603
                -- upvalues: u80 (copy), u79 (copy)
                u80.Size = u79.Parent.Size;
            end);
        end;

        u79:Clone().Parent = u80;
    end;

    if u80 then
        _stampAuthoredEnabled(u80);
        pcall(function() -- Line: 614
            -- upvalues: u80 (ref)
            u80:SetAttribute("_PartIcleEmit", true);
        end);
    end;

    return u80;
end;

function u1._emitTransformed(p82, p83, u84, u85, u86, p87, p88) -- Line: 623
    -- upvalues: u1 (copy), u6 (copy), u7 (copy)
    local v89 = p87 or u1.newChainCtx();
    local v90 = v89.Depth + 1;

    if (p88 or 4) <= v90 then
        if u85 then
            u85 = u85._eventName;
        end;

        u1.dropDepth(u85);

        return;
    end;

    local v91 = {
        ChainId = v89.ChainId,
        Depth = v90
    };
    local v92 = {
        ChainCtx = v91
    };

    if u84 == "AtTarget" then
        p82:EnableEmit(p83, nil, v92);

        return;
    end;

    if not u1._supportsOriginOverride(p83) then
        local v93 = tostring(u84) .. ":" .. p83.ClassName;

        if not u6[v93] then
            u6[v93] = true;
            warn(("[Part-Icles Events] transformed %s target requires EmitMode=AtTarget"):format(p83.ClassName));
        end;

        return;
    end;

    local u94 = u1.resolveEmitModeCF(u84, u85, u86);

    if u94 then
        if p82.EnableEmitAt then
            p82:EnableEmitAt(p83, u94, {
                IgnoreLink = true,
                ChainCtx = v91,

                OriginResolver = function() -- Line: 663, Name: originResolver
                    -- upvalues: u1 (ref), u84 (copy), u85 (copy), u86 (copy), u94 (copy)
                    return u1.resolveEmitModeCF(u84, u85, u86) or u94;
                end,

                UseFullOrigin = u84 == "AtCFrame"
            });

            return;
        end;

        warn("[Part-Icles Events] EnableEmitAt missing on particle; skipped origin-override emit");

        return;
    end;

    local v95 = tostring(u84);

    if u85 then
        u85 = u85._eventName;
    end;

    local v96 = v95 .. ":" .. tostring(u85);

    if not u7[v96] then
        u7[v96] = true;
        warn(("[Part-Icles Events] EmitMode %q has no resolvable origin (payload position nil)"):format((tostring(u84))));
    end;
end;

function u1.emitTargetInstance(u97, u98, p99, p100, p101, u102, p103) -- Line: 684
    -- upvalues: u1 (copy), _kindFor (copy), Pool (copy), _buildEmitClone (copy), _restoreAuthoredEnabled (copy), _anchorClone (copy), _computeCloneLifetime (copy), _killEmittersForRelease (copy)
    if not (u98 and u98.Parent) then
        return;
    end;

    if p99 == nil or (p99 == "AtTarget" or u98:IsA("Trail")) then
        if u98:GetAttribute("Transformed") then
            u1._emitTransformed(u97, u98, p99, p100, p101, u102, p103);

            return;
        end;

        pcall(function() -- Line: 691
            -- upvalues: u97 (copy), u98 (copy), u102 (copy)
            u97:AbsoluteEmit(u98, false, {
                ChainCtx = u102
            });
        end);

        return;
    end;

    if u98:GetAttribute("Transformed") then
        u1._emitTransformed(u97, u98, p99, p100, p101, u102, p103);

        return;
    end;

    local u104 = u1.resolveEmitModeCF(p99, p100, p101);

    if not u104 then
        pcall(function() -- Line: 703
            -- upvalues: u97 (copy), u98 (copy), u102 (copy)
            u97:AbsoluteEmit(u98, false, {
                ChainCtx = u102
            });
        end);

        return;
    end;

    local u105 = _kindFor(u98);
    local u106 = Pool.acquire(u98, u105);
    local v107;

    if u106 then
        v107 = false;
    else
        u106 = _buildEmitClone(u98);

        if not u106 then
            pcall(function() -- Line: 714
                -- upvalues: u97 (copy), u98 (copy), u102 (copy)
                u97:AbsoluteEmit(u98, false, {
                    ChainCtx = u102
                });
            end);

            return;
        end;

        v107 = true;
    end;

    if not v107 then
        _restoreAuthoredEnabled(u106);
    end;

    if u106:IsA("Attachment") then
        local Folder = u97:GetFolder();
        local _AttachmentHolder = Folder:FindFirstChild("_AttachmentHolder");

        if not _AttachmentHolder then
            _AttachmentHolder = Instance.new("Part");
            _AttachmentHolder.Anchored = true;
            _AttachmentHolder.CanCollide = false;
            _AttachmentHolder.CanQuery = false;
            _AttachmentHolder.CanTouch = false;
            _AttachmentHolder.Massless = true;
            _AttachmentHolder.Transparency = 1;
            _AttachmentHolder.Size = Vector3.new(0.001, 0.001, 0.001);
            _AttachmentHolder.Archivable = false;
            _AttachmentHolder.Name = "_AttachmentHolder";
            _AttachmentHolder.CFrame = CFrame.new();
            _AttachmentHolder.Parent = Folder;
        end;

        u106.Parent = _AttachmentHolder;
        u106.WorldCFrame = u104;
    else
        _anchorClone(u106);
        local v108 = u106;

        if v108:IsA("Model") then
            v108:PivotTo(u104);
        elseif v108:IsA("BasePart") then
            v108.CFrame = u104;
        elseif v108:IsA("Attachment") then
            v108.WorldCFrame = u104;
        end;

        u106.Parent = u97:GetFolder();
        local v109 = u106;

        if v109:IsA("Model") then
            v109:PivotTo(u104);
        elseif v109:IsA("BasePart") then
            v109.CFrame = u104;
        elseif v109:IsA("Attachment") then
            v109.WorldCFrame = u104;
        end;
    end;

    local u110 = {
        SkipClone = true,
        ChainCtx = u102,
        UseFullOrigin = p99 == "AtCFrame",
        IgnoreLink = p99 == "AtPosition" and true or p99 == "AtCFrame"
    };
    pcall(function() -- Line: 753
        -- upvalues: u97 (copy), u106 (ref), u104 (copy), u110 (copy)
        u97:AbsoluteEmitAt(u106, u104, u110);
    end);
    local v111 = _computeCloneLifetime(u106);
    task.delay(v111, function() -- Line: 758
        -- upvalues: u106 (ref), _killEmittersForRelease (ref), Pool (ref), u98 (copy), u105 (copy)
        if not u106.Parent then
            return;
        end;

        _killEmittersForRelease(u106);
        Pool.release(u106, u98, u105, nil);
    end);
end;

function u1.fire(u112, u113, p114, p115, p116) -- Line: 767
    -- upvalues: u1 (copy), EventsPayload (copy)
    local u117 = p115 or u1.newChainCtx();
    local u118 = u113.Events and u113.Events[p114];

    if not (u118 and u118.Enabled) then
        return;
    end;

    local v119 = tonumber(u118.ChainDepthLimit) or 4;
    local math_floor_ret = math.floor(v119);
    local math_clamp_ret = math.clamp(math_floor_ret, 1, 32);

    if math_clamp_ret <= u117.Depth then
        u1.dropDepth(p114);

        return;
    end;

    if not (u118.EmitTarget or u118.Module) then
        return;
    end;

    local u120 = p116 or u1.makePayload(u112, u113, p114, nil);
    u120._eventName = u120._eventName or p114;

    if not u1.reserveFrameFire() then
        return;
    end;

    u120.Source = u120.Source or u113._sourceItem;
    u120.Particle = u120.Particle or u113.VisualPart;
    u120.RenderTemplate = u120.RenderTemplate or u120.Particle;

    if u118.Module then
        function u120.Emit(p121, p122) -- Line: 798
            -- upvalues: u1 (ref), u112 (copy), u118 (copy), u120 (ref), u113 (copy), u117 (ref), math_clamp_ret (copy)
            u1.emitTargetInstance(u112, p121, p122 or u118.EmitMode, u120, u113, u117, math_clamp_ret);
        end;

        function u120.Kill() -- Line: 801
            -- upvalues: u112 (copy), u113 (copy)
            if u112._killParticle then
                u112:_killParticle(u113, {
                    fireOnDeath = false
                });
            end;
        end;

        EventsPayload.attachSkipSetters(u120, u113);

        function u120.SetColor(p123) -- Line: 808
            -- upvalues: EventsPayload (ref), u113 (copy)
            EventsPayload.applyColor(u113, p123);
        end;

        function u120.SetTransparency(p124) -- Line: 809
            -- upvalues: EventsPayload (ref), u113 (copy)
            EventsPayload.applyTransparency(u113, p124);
        end;

        function u120.Teleport(p125) -- Line: 810
            -- upvalues: EventsPayload (ref), u113 (copy)
            EventsPayload.applyTeleport(u113, p125);
        end;

        EventsPayload.attachAdvancedSetters(u120, u113);

        function u120.SetSpeedMultiplier(p126) -- Line: 812
            -- upvalues: u113 (copy)
            if type(p126) == "number" then
                u113.SpeedMultiplier = p126;
            end;
        end;

        function u120.SetLifetime(p127) -- Line: 817
            -- upvalues: u113 (copy)
            if type(p127) == "number" then
                u113.LifeTime = math.max(0.001, p127);
            end;
        end;
    end;

    if u118.EmitTarget and #u112.ActiveEmits + (u112._lingerVisualCount or 0) < (u112.MAX_ACTIVE_PARTICLES or 1000) then
        u1.emitTargetInstance(u112, u118.EmitTarget, u118.EmitMode, u120, u113, u117, math_clamp_ret);
    end;

    local u128 = u118.Module and u1.compile(u118.Module);

    if u128 then
        task.spawn(function() -- Line: 832
            -- upvalues: u128 (copy), u120 (ref), u1 (ref), u118 (copy)
            local v129, v130 = xpcall(u128, debug.traceback, u120);

            if not v129 then
                u1.reportScriptError(u118.Module, v130);
            end;
        end);
    end;
end;

function u1.afterUpdate(p131, p132, p133, p134) -- Line: 847
    -- upvalues: u1 (copy), EventsCollision (copy)
    if not (p132.Events and p132.Events.OnHit) then
        return;
    end;

    if p132._lastEffectiveDt and p132._lastEffectiveDt < 0 then
        p132.LastHitCheckPos = u1.getWorldPosition(p132);
        p132.LastHitCheckTime = p134;

        return;
    end;

    local WorldPosition = u1.getWorldPosition(p132);

    if not WorldPosition then
        return;
    end;

    if not p132.LastHitCheckPos then
        p132.LastHitCheckPos = WorldPosition;
        p132.LastHitCheckTime = p134;

        return;
    end;

    local v135 = p132.Events.OnHit.HitCheckInterval or 0;

    if v135 > 0 and p134 - (p132.LastHitCheckTime or 0) < v135 then
        return;
    end;

    local LastHitCheckPos = p132.LastHitCheckPos;
    local v136 = p134 - (p132.LastHitCheckTime or p134);
    local v137 = v136 <= 0 and 0.016666666666666666 or v136;
    local v138 = WorldPosition - LastHitCheckPos;

    if v138.Magnitude > 0.05 then
        local v139 = workspace:Raycast(LastHitCheckPos, v138, p132.HitParams);

        if v139 then
            if not p132._hitFired then
                local v140 = u1.makePayload(p131, p132, "OnHit", nil);
                v140.HitInstance = v139.Instance;
                v140.Other = v139.Instance;
                v140.HitPosition = v139.Position;
                v140.HitNormal = v139.Normal;
                u1.fire(p131, p132, "OnHit", p132.EventChainCtx, v140);

                if EventsCollision.handle(p131, p132, v139, v138, v137) == "snap" then
                    return;
                end;
            end;
        elseif not p132._collisionStopped then
            p132._hitFired = false;
        end;

        p132.LastHitCheckPos = WorldPosition;
        p132.LastHitCheckTime = p134;
    end;
end;

return u1;