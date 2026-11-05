  

 

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local u1 = require("./attributes");
local u2 = require("./logger");
local u3 = require("../pkg/Promise");
local u4 = {};
local v5 = script:FindFirstAncestorOfClass("Plugin") or RunService:IsStudio() and not RunService:IsRunning();
u4.PLUGIN_CONTEXT = v5;
u4.SERVER_CONTEXT = RunService:IsServer() or u4.PLUGIN_CONTEXT;
u4.DEG_TO_RAD = 0.017453292519943295;
u4.BEZIER_TAG = "BezierParticle";
u4.LIGHTNING_TAG = "LightningBolt";
u4.SHOCKWAVE_TAG = "Shockwave";
u4.SCREENSHAKE_TAG = "CameraShake";
u4.PROPERTY_TWEENER_TAG = "PropertyTweener";
u4.PROPERTY_RANDOMIZER_TAG = "PropertyRandomizer";
u4.ATTRIBUTE_TWEENER_TAG = "AttributeTweener";
u4.ATTRIBUTE_RANDOMIZER_TAG = "AttributeRandomizer";
u4.ENABLED_VFX_TAG = "ConstantVFX";
u4.TEXTURE_LOAD_TAG = "LoadVFXTextures";
u4.CLEANUP_TAG = "__forge__cleanupOnExit";
u4.EMIT_EXCLUDE_TAG = "__forge_excludeFromEmit";
u4.RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1;
u4.COLLISION_GROUPS = {
    StudioSelectable = {},
    ForgeDebris = {
        ForgeDebris = false
    },
    ForgeMouseIgnore = {
        StudioSelectable = false
    }
};
u4.COPY_SPECIALMESH_PROPERTIES = { "MeshId", "MeshType", "Offset", "Scale", "TextureId", "VertexColor" };
u4.COPY_PART_PROPERTIES = { "CastShadow", "Color", "Material", "MaterialVariant", "Reflectance", "Shape", "FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "TopSurface", "BottomSurface" };
u4.COPY_EXTENDED_PART_PROPERTIES = { "Size", "Transparency", "CustomPhysicalProperties", "CanCollide", "CanQuery", "CanTouch", "CollisionGroup" };
local u6 = setmetatable({}, {
    __mode = "k"
});

function u4.lock(p7) -- Line: 94
    -- upvalues: u6 (copy)
    if u6[p7] then
        return true;
    end;

    u6[p7] = coroutine.running();

    return false;
end;

function u4.unlock(p8, p9) -- Line: 104
    -- upvalues: u6 (copy), u2 (copy)
    local v10 = u6[p8];

    if coroutine.running() ~= v10 and p9 ~= v10 then
        u2.error("attempt to unlock an instance owned by a different thread");
    end;

    u6[p8] = nil;
end;

function u4.setCollisionGroups(p11) -- Line: 114
    -- upvalues: PhysicsService (copy), RunService (copy)
    local v12 = {};

    for i, v in p11 do
        PhysicsService:RegisterCollisionGroup(i);

        if not i:match("Studio") or RunService:IsStudio() then
            v12[i] = v;
        end;
    end;

    for i, v in v12 do
        for i2, v2 in v do
            if not i2:match("Studio") or RunService:IsStudio() then
                PhysicsService:CollisionGroupSetCollidable(i, i2, v2);
            end;
        end;
    end;
end;

local u13 = 0;

function u4.getRandomId() -- Line: 138
    -- upvalues: u13 (ref)
    u13 = u13 + 1;

    return tostring(u13);
end;

function u4.copyProperties(p14, p15, p16) -- Line: 143
    for _, v in p16 do
        p15[v] = p14[v];
    end;
end;

function u4.lerp(p17, p18, p19) -- Line: 149
    return p17 + (p18 - p17) * p19;
end;

function u4.try(u20, p21, ...) -- Line: 153
    -- upvalues: u2 (copy)
    local v23 = { xpcall(p21, function(p22) -- Line: 154
            -- upvalues: u2 (ref), u20 (copy)
            u2.warn(string.format(u20, p22));
        end, ...) };

    return v23[1], table.unpack(v23, 2);
end;

function u4.reboundfn(u24, u25) -- Line: 161
    local u26 = nil;

    return function(...) -- Line: 164
        -- upvalues: u26 (ref), u24 (copy), u25 (copy)
        if u26 then
            task.cancel(u26);
        end;

        local u27 = { ... };
        u26 = task.delay(u24, function() -- Line: 171
            -- upvalues: u26 (ref), u25 (ref), u27 (copy)
            u26 = nil;
            u25(table.unpack(u27));
        end);
    end;
end;

function u4.randomUnitVector(p28, p29, p30) -- Line: 178
    local v31 = p30 or Random.new();
    local v32 = v31:NextNumber(p28.X, p29.X);
    local v33 = v31:NextNumber(p28.Y, p29.Y);

    return Vector3.new(v32, v33, v31:NextNumber(p28.Z, p29.Z));
end;

function u4.getImpulseForce(p34, p35, p36) -- Line: 183
    return (p35 - p34) / p36 + Vector3.new(0, workspace.Gravity * p36 * 0.5, 0);
end;

function u4.isMeshVFX(p37) -- Line: 187
    local v38 = p37 and (p37:IsA("Model") and p37:FindFirstChild("Start") and (p37.Start:IsA("BasePart") and p37:FindFirstChild("End"))) and p37.End:IsA("BasePart");

    return v38;
end;

function u4.isSpinModelStatic(p39) -- Line: 196
    -- upvalues: u1 (copy)
    local v40;

    if u1.get(p39, "SpinRotation", Vector3.new(0, 0, 0), true) == Vector3.new(0, 0, 0) and (u1.get(p39, "Scale_Start", 1, true) == 1 and u1.get(p39, "Scale_End", 1, true) == 1) then
        v40 = u1.get(p39, "SyncPosition", false, true) == false;
    else
        v40 = false;
    end;

    return v40;
end;

function u4.shouldSkipNested(p41) -- Line: 203
    -- upvalues: u4 (copy)
    local v42 = p41:IsA("Beam") or p41:HasTag(u4.BEZIER_TAG) or (p41:HasTag(u4.LIGHTNING_TAG) or u4.isMeshVFX(p41)) or p41:IsA("BasePart") and u4.findFirstClassWithTag(p41, "Attachment", u4.SHOCKWAVE_TAG) ~= nil;

    return v42;
end;

function u4.getTarget(p43) -- Line: 211
    local v44 = p43:FindFirstChildOfClass("ObjectValue");

    if v44 and v44.Value then
        return v44.Value;
    end;

    local Parent = p43.Parent;

    if not Parent then
        return nil;
    end;

    while Parent:IsA("Folder") do
        Parent = Parent.Parent;

        if not Parent then
            return nil;
        end;
    end;

    return Parent;
end;

function u4.createEmitPromise(u45, p46, u47, u48, u49) -- Line: 235
    -- upvalues: u3 (copy), u4 (copy)
    local v54 = u3.new(function(p50, p51, p52) -- Line: 242
        -- upvalues: u47 (copy), u45 (copy), u49 (copy), u4 (ref), u48 (copy)
        local u53 = {
            depth = u47,
            effects = u45,
            _context = u49
        };
        p52(function() -- Line: 248
            -- upvalues: u53 (copy), u4 (ref)
            if u53._onCancel then
                for _, v in u53._onCancel do
                    v();
                end;
            end;

            u4.cleanupScope(u53);
        end);
        u48(u53);
        u4.cleanupScope(u53);
        p50();
    end);

    if u49 then
        table.insert(u49._promises, v54);
    end;

    return v54;
end;

function u4.onCancel(p55, p56) -- Line: 272
    if not p55._onCancel then
        p55._onCancel = {};
    end;

    table.insert(p55._onCancel, p56);
end;

local u57 = setmetatable({}, {
    __mode = "k"
});
local u58 = setmetatable({}, {
    __mode = "k"
});

function u4.forceEmit(p59, p60) -- Line: 287
    -- upvalues: u58 (copy)
    u58[p59] = p60 and true or nil;
end;

function u4.isForceEmitting(p61) -- Line: 291
    -- upvalues: u58 (copy)
    return u58[p61] == true;
end;

function u4.setEnabledCancelToken(p62, p63) -- Line: 295
    -- upvalues: u57 (copy)
    u57[p62] = p63;
end;

function u4.getEnabledCancelToken(p64) -- Line: 299
    -- upvalues: u57 (copy)
    return u57[p64];
end;

function u4.cancelToken(p65) -- Line: 303
    -- upvalues: u4 (copy)
    for _, v in p65._promises do
        v:cancel();
    end;

    for _, v in p65._scopes do
        u4.cleanupScope(v, true);
    end;

    table.clear(p65._promises);
    table.clear(p65._scopes);
end;

function u4.stopEmitDuration(p66) -- Line: 316
    -- upvalues: u4 (copy), u1 (copy)
    local v67 = u4.getEnabledCancelToken(p66);
    u1.trigger(p66, "Enabled", false);
    u1.clearState(p66);
    u4.forceEmit(p66, false);

    return v67;
end;

function u4.awaitEmitDuration(p68) -- Line: 326
    -- upvalues: u3 (copy)
    if not p68 then
        return;
    end;

    local v69 = {};

    for _, v in p68._promises do
        table.insert(v69, v);
    end;

    if #v69 > 0 then
        u3.all(v69):await();
    end;
end;

function u4.cleanupScope(p70, p71) -- Line: 342
    -- upvalues: u4 (copy)
    local depth = p70.depth;
    local effects = p70.effects;
    local _context = p70._context;
    local _onCancel = p70._onCancel;

    for i, v in p70 do
        if i ~= "depth" and (i ~= "effects" and (i ~= "_context" and i ~= "_onCancel")) then
            local v72 = typeof(v);

            if v72 == "Instance" then
                v:Destroy();
            elseif v72 == "RBXScriptConnection" then
                v:Disconnect();
            elseif v72 == "thread" then
                if coroutine.status(v) ~= "dead" then
                    task.cancel(v);
                end;
            elseif v72 == "function" then
                if p71 then
                    v();
                else
                    task.spawn(v);
                end;
            elseif v72 == "table" then
                u4.cleanupScope(v);
            end;
        end;
    end;

    table.clear(p70);
    p70.depth = depth;
    p70.effects = effects;
    p70._context = _context;
    p70._onCancel = _onCancel;
end;

function u4.protectParent(p73, u74) -- Line: 385
    table.insert(p73, u74.AncestryChanged:Connect(function(p75, p76) -- Line: 388
        -- upvalues: u74 (copy)
        if u74.Parent == workspace.Terrain then
            return;
        end;

        u74.Parent = workspace.Terrain;
    end));
end;

function u4.findFirstClassWithTag(p77, p78, p79) -- Line: 398
    -- upvalues: u4 (copy)
    if p77 and p77.Parent ~= game then
        if p77.ClassName == p78 and p77:HasTag(p79) then
            return p77;
        end;

        return u4.findFirstClassWithTag(p77.Parent, p78, p79);
    end;
end;

function u4.cloneParticleAncestry(u80, u81) -- Line: 410
    if u80:FindFirstAncestorWhichIsA("BasePart") or u80:FindFirstAncestorOfClass("Attachment") then
        local function findAncestor(p82) -- Line: 418
            -- upvalues: findAncestor (copy)
            if p82 then
                if p82.Parent and (p82.Parent:IsA("BasePart") or p82.Parent:IsA("Attachment")) then
                    p82 = findAncestor(p82.Parent);
                end;

                return p82;
            end;
        end;

        local function recurse(p83) -- Line: 432
            -- upvalues: u81 (copy), u80 (copy), findAncestor (copy), recurse (copy)
            if p83 then
                local v84 = u81[p83];

                if v84 then
                    if p83 == u80 then
                        return v84, u81[p83.Parent];
                    end;

                    local Parent = p83.Parent;

                    if Parent then
                        if Parent.Parent and (Parent.Parent:IsA("BasePart") or Parent.Parent:IsA("Attachment")) then
                            Parent = findAncestor(Parent.Parent);
                        end;
                    else
                        Parent = nil;
                    end;

                    return v84, u81[Parent] or u81[p83];
                end;

                local v85 = Instance.fromExisting(p83);
                v85.Archivable = false;

                if v85:IsA("BasePart") then
                    v85.Locked = true;
                end;

                if u81 then
                    u81[p83] = v85;
                end;

                local v86;

                if p83.Parent and (p83.Parent:IsA("BasePart") or p83.Parent:IsA("Attachment")) then
                    local v87, v88 = recurse(p83.Parent);
                    v86 = v88 or v85;

                    if v87 then
                        v85.Parent = v87;
                    end;
                else
                    v86 = v85;
                end;

                return v85, v86;
            end;
        end;

        return recurse(u80.Parent);
    end;
end;

function u4.getTransformedOriginExtents(p89) -- Line: 474
    -- upvalues: u1 (copy), u4 (copy)
    local identity = CFrame.identity;

    if p89:IsA("BasePart") then
        return p89.CFrame, p89.Size;
    end;

    if p89:IsA("Attachment") then
        identity = p89.WorldCFrame;
        local Parent = p89.Parent;
        local v90 = u1.get(p89, "PositionScale", Vector3.new(0, 0, 0), true);

        if Parent and (Parent:IsA("BasePart") and v90 ~= Vector3.new(0, 0, 0)) then
            identity = identity + Parent.Size / 2 * v90;
        end;

        local v91 = u1.get(p89, "OverrideWorldRotation", false, true);
        local v92 = u1.get(p89, "WorldRotation", Vector3.new(0, 0, 0), true);

        if v91 then
            local v93 = v92 * u4.DEG_TO_RAD;
            identity = CFrame.new(identity.Position) * CFrame.fromOrientation(v93.X, v93.Y, v93.Z);
        end;
    end;

    return identity, Vector3.new(0, 0, 0);
end;

function u4.getMeshDecals(p94, p95) -- Line: 510
    -- upvalues: u1 (copy), u4 (copy)
    local v96 = {};
    local v97 = {};
    local v98 = {};

    local function filter(p99) -- Line: 517
        local v100 = {};

        for _, v in p99 do
            if v:IsA("Decal") then
                table.insert(v100, v);
            end;
        end;

        return v100;
    end;

    if u1.get(p94, "Flipbook", false, true) then
        return filter(p95:GetChildren()), v97, v98;
    end;

    local End = p94:FindFirstChild("End");
    local Start = p94:FindFirstChild("Start");

    if End then
        for _, child in p95:GetChildren() do
            if child:IsA("Decal") then
                local v101 = End:FindFirstChild(child.Name);

                if v101 and v101:IsA("Decal") then
                    table.insert(v96, child);
                    v98[child] = v101;

                    if u1.get(child, "FlipbookEnabled", nil) then
                        local v102 = u1.get(child, "FlipbookTextures", nil);

                        if v102 then
                            v97[child] = u4.deserializeFlipbook(v102);
                        end;
                    else
                        table.insert(v96, child);
                    end;
                end;
            end;
        end;

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local v103 = child:GetChildren();
                local v104 = 0;

                for i = 1, #v103 do
                    local v105 = i - v104;

                    if not v103[v105]:IsA("Decal") then
                        table.remove(v103, v105);
                        v104 = v104 + 1;
                    end;
                end;

                if #v103 ~= 0 then
                    local function idx(p106) -- Line: 588
                        return tonumber(p106:match("%d+")) or 0;
                    end;

                    table.sort(v103, function(p107, p108) -- Line: 592
                        return (tonumber(p107.Name:match("%d+")) or 0) < (tonumber(p108.Name:match("%d+")) or 0);
                    end);
                    local v109 = {};

                    for _, v in v103 do
                        local v110 = tonumber(v.Texture:match("%d+")) or 0;
                        table.insert(v109, v110);
                        v:Destroy();
                    end;

                    local v111 = u4.serializeFlipbook(v109);
                    u1.set(child, "FlipbookEnabled", true);
                    u1.set(child, "FlipbookTextures", buffer.tostring(v111));
                end;
            end;
        end;
    end;

    return v96, v97, v98;
end;

function u4.assembleMeshVFX(p112, p113, u114) -- Line: 615
    -- upvalues: u4 (copy)
    local u115 = u4.getRandomId();

    if not p112:IsA("Part") then
        local v116 = p112:Clone();
        v116.Archivable = false;
        v116.Locked = true;
        v116.Parent = workspace.Terrain;
        v116:AddTag(u4.CLEANUP_TAG);
        table.insert(p113, v116);

        return v116;
    end;

    local v117 = u114:get(u115);
    v117.CFrame = p112.CFrame;
    local v118 = v117._getReal();
    u4.copyProperties(p112, v118, u4.COPY_PART_PROPERTIES);
    u4.copyProperties(p112, v118, u4.COPY_EXTENDED_PART_PROPERTIES);
    local v119 = p112:Clone();

    for _, child in v119:GetChildren() do
        child.Parent = v118;
    end;

    v119:Destroy();
    table.insert(p113, function() -- Line: 635
        -- upvalues: u114 (copy), u115 (copy)
        u114:free(u115);
    end);

    return v117;
end;

function u4.getBezierPoints(u120, u121) -- Line: 654
    local v122 = u120:GetChildren();
    table.sort(v122, function(p123, p124) -- Line: 657
        return tonumber(p123.Name) < tonumber(p124.Name);
    end);
    local u125 = {};
    local u126 = {};
    local u127 = {};

    local function vec(p128) -- Line: 665
        -- upvalues: u120 (copy), u125 (copy), u121 (copy), u127 (copy), u126 (copy)
        local v129 = u120.WorldCFrame:PointToObjectSpace(p128.WorldPosition);
        local v130 = vector.create(v129.X, v129.Y, v129.Z);
        table.insert(u125, v130);

        if u121 then
            u127[p128] = v130;
            table.insert(u126, p128);
        end;

        return v130;
    end;

    for i, v in v122 do
        local T0 = v:FindFirstChild("T0");
        local T1 = v:FindFirstChild("T1");

        if i == 1 then
            local v131 = u120.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local v132 = vector.create(v131.X, v131.Y, v131.Z);
            table.insert(u125, v132);

            if u121 then
                u127[v] = v132;
                table.insert(u126, v);
            end;
        end;

        if i ~= 1 then
            if T1 then
                local v133 = u120.WorldCFrame:PointToObjectSpace(T1.WorldPosition);
                local v134 = vector.create(v133.X, v133.Y, v133.Z);
                table.insert(u125, v134);

                if u121 then
                    u127[T1] = v134;
                    table.insert(u126, T1);
                end;
            else
                local v135 = u120.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local v136 = vector.create(v135.X, v135.Y, v135.Z);
                table.insert(u125, v136);

                if u121 then
                    u127[v] = v136;
                    table.insert(u126, v);
                end;
            end;
        end;

        if i ~= 1 and i ~= #v122 then
            local v137 = u120.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local v138 = vector.create(v137.X, v137.Y, v137.Z);
            table.insert(u125, v138);

            if u121 then
                u127[v] = v138;
                table.insert(u126, v);
            end;
        end;

        if i ~= #v122 then
            if T0 then
                local v139 = u120.WorldCFrame:PointToObjectSpace(T0.WorldPosition);
                local v140 = vector.create(v139.X, v139.Y, v139.Z);
                table.insert(u125, v140);

                if u121 then
                    u127[T0] = v140;
                    table.insert(u126, T0);
                end;
            else
                local v141 = u120.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local v142 = vector.create(v141.X, v141.Y, v141.Z);
                table.insert(u125, v142);

                if u121 then
                    u127[v] = v142;
                    table.insert(u126, v);
                end;
            end;
        end;

        if i == #v122 then
            local v143 = u120.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local v144 = vector.create(v143.X, v143.Y, v143.Z);
            table.insert(u125, v144);

            if u121 then
                u127[v] = v144;
                table.insert(u126, v);
            end;
        end;
    end;

    return u125, u126, u127;
end;

function u4.scaleNumberSequence(p145, p146) -- Line: 717
    if p146 == 1 then
        return p145;
    end;

    local v147 = {};

    for _, v in p145.Keypoints do
        local v148, v149;

        if typeof(p146) == "function" then
            v148, v149 = p146(v.Value, v.Envelope);
        else
            v148 = v.Value * p146;
            v149 = v.Envelope * p146;
        end;

        table.insert(v147, NumberSequenceKeypoint.new(v.Time, v148, v149));
    end;

    return NumberSequence.new(v147);
end;

function u4.serializePath(p150) -- Line: 742
    local v151 = buffer.create(#p150 * 4 * 6);
    local v152 = 0;

    for i, v in p150 do
        local Scale = v.Position.X.Scale;
        local Scale2 = v.Position.Y.Scale;

        if i ~= 1 then
            buffer.writef32(v151, v152, Scale + v.LeftTangent.X.Scale);
            buffer.writef32(v151, v152 + 4, Scale2 + v.LeftTangent.Y.Scale);
            v152 = v152 + 8;
        end;

        buffer.writef32(v151, v152, Scale);
        buffer.writef32(v151, v152 + 4, Scale2);
        v152 = v152 + 8;

        if i ~= #p150 then
            buffer.writef32(v151, v152, Scale + v.RightTangent.X.Scale);
            buffer.writef32(v151, v152 + 4, Scale2 + v.RightTangent.Y.Scale);
            v152 = v152 + 8;
        end;
    end;

    return v151;
end;

function u4.deserializePath(p153) -- Line: 774
    if typeof(p153) == "string" then
        p153 = buffer.fromstring(p153) or p153;
    end;

    local v154 = buffer.len(p153) / 24;
    local v155 = {};

    for i = 0, v154 - 1 do
        local v156 = i * 4 * 6;
        local v157 = buffer.readf32(p153, v156);
        local v158 = buffer.readf32(p153, v156 + 4);
        local v159 = vector.create(v157, v158);
        table.insert(v155, v159);

        if i ~= v154 - 1 then
            local v160 = buffer.readf32(p153, v156 + 8);
            local v161 = buffer.readf32(p153, v156 + 12);
            local v162 = buffer.readf32(p153, v156 + 16);
            local v163 = buffer.readf32(p153, v156 + 20);
            local v164 = vector.create(v160, v161);
            table.insert(v155, v164);
            local v165 = vector.create(v162, v163);
            table.insert(v155, v165);
        end;
    end;

    return v155;
end;

local v166 = require("./common/flipbook");
u4.serializeFlipbook = v166.serialize;
u4.deserializeFlipbook = v166.deserialize;
u4.default_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }));
u4.linear_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }));

function u4.scaleAttribute(p167, p168, p169) -- Line: 820
    -- upvalues: u1 (copy)
    local v170 = u1.get(p167, p169, nil);

    if v170 ~= nil then
        if typeof(v170) == "number" then
            u1.set(p167, p169, v170 * p168);

            return;
        end;

        if typeof(v170) == "Vector3" then
            u1.set(p167, p169, v170 * p168);

            return;
        end;

        if typeof(v170) == "NumberRange" then
            u1.set(p167, p169, NumberRange.new(v170.Min * p168, v170.Max * p168));
        end;
    end;
end;

function u4.scaleAttachmentDistance(p171, p172, p173) -- Line: 834
    if not (p171 and p172) then
        return;
    end;

    local v174 = (p171.Position + p172.Position) / 2;
    p171.Position = v174 + (p171.Position - v174) * p173;
    p172.Position = v174 + (p172.Position - v174) * p173;
end;

return u4;