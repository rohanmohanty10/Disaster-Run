 
 

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

function u4.lock(p7: userdata) -- Line: 87
    -- upvalues: u6 (copy)
    if u6[p7] then
        return true;
    end;

    u6[p7] = coroutine.running();

    return false;
end;

function u4.unlock(p8: userdata, p9: thread?) -- Line: 97
    -- upvalues: u6 (copy), u2 (copy)
    local v10 = u6[p8];

    if coroutine.running() ~= v10 and p9 ~= v10 then
        u2.error("attempt to unlock an instance owned by a different thread");
    end;

    u6[p8] = nil;
end;

function u4.setCollisionGroups(p11) -- Line: 107
    -- upvalues: PhysicsService (copy), RunService (copy)
    local v12 = {};

    for i, v in p11 do
        PhysicsService:RegisterCollisionGroup(i);

        if not i:match("Studio") or RunService:IsStudio() then
            v12[i] = v;
        end;
    end;

    for i, v in v12 do
        local v13 = i;

        for i2, v2 in v do
            if not i2:match("Studio") or RunService:IsStudio() then
                PhysicsService:CollisionGroupSetCollidable(v13, i2, v2);
            end;
        end;
    end;
end;

local u14 = 0;

function u4.getRandomId() -- Line: 131
    -- upvalues: u14 (ref)
    u14 = u14 + 1;

    return tostring(u14);
end;

function u4.copyProperties(p15: userdata, p16: userdata, p17: table) -- Line: 136
    for _, v in p17 do
        p16[v] = p15[v];
    end;
end;

function u4.lerp(p18: number, p19: number, p20: number) -- Line: 142
    return p18 + (p19 - p18) * p20;
end;

function u4.try(u21: string, p22: function, ...) -- Line: 146
    -- upvalues: u2 (copy)
    local v24 = { xpcall(p22, function(p23) -- Line: 147
            -- upvalues: u2 (ref), u21 (copy)
            u2.warn(string.format(u21, p23));
        end, ...) };

    return v24[1], table.unpack(v24, 2);
end;

function u4.reboundfn(u25: number, u26: function) -- Line: 154
    local u27 = nil;

    return function(...) -- Line: 157
        -- upvalues: u27 (ref), u25 (copy), u26 (copy)
        if u27 then
            task.cancel(u27);
        end;

        local u28 = { ... };
        u27 = task.delay(u25, function() -- Line: 164
            -- upvalues: u27 (ref), u26 (ref), u28 (copy)
            u27 = nil;
            u26(table.unpack(u28));
        end);
    end;
end;

function u4.randomUnitVector(p29: vector, p30: vector, p31: userdata?) -- Line: 171
    local v32 = p31 or Random.new();
    local v33 = v32:NextNumber(p29.X, p30.X);
    local v34 = v32:NextNumber(p29.Y, p30.Y);

    return Vector3.new(v33, v34, v32:NextNumber(p29.Z, p30.Z));
end;

function u4.getImpulseForce(p35: vector, p36: vector, p37: number) -- Line: 176
    return (p36 - p35) / p37 + Vector3.new(0, workspace.Gravity * p37 * 0.5, 0);
end;

function u4.isMeshVFX(p38: userdata) -- Line: 180
    local v39 = p38 and (p38:IsA("Model") and p38:FindFirstChild("Start") and (p38.Start:IsA("BasePart") and p38:FindFirstChild("End"))) and p38.End:IsA("BasePart");

    return v39;
end;

function u4.isSpinModelStatic(p40: userdata) -- Line: 189
    -- upvalues: u1 (copy)
    local v41;

    if u1.get(p40, "SpinRotation", Vector3.new(0, 0, 0), true) == Vector3.new(0, 0, 0) and (u1.get(p40, "Scale_Start", 1, true) == 1 and u1.get(p40, "Scale_End", 1, true) == 1) then
        v41 = u1.get(p40, "SyncPosition", false, true) == false;
    else
        v41 = false;
    end;

    return v41;
end;

function u4.shouldSkipNested(p42: userdata) -- Line: 196
    -- upvalues: u4 (copy)
    local v43 = p42:IsA("Beam") or p42:HasTag(u4.BEZIER_TAG) or (p42:HasTag(u4.LIGHTNING_TAG) or u4.isMeshVFX(p42)) or p42:IsA("BasePart") and u4.findFirstClassWithTag(p42, "Attachment", u4.SHOCKWAVE_TAG) ~= nil;

    return v43;
end;

function u4.createEmitPromise(u44: any, p45: userdata, u46: number, u47: any) -- Line: 204
    -- upvalues: u3 (copy), u4 (copy)
    return u3.new(function(p48) -- Line: 205
        -- upvalues: u46 (copy), u44 (copy), u47 (copy), u4 (ref)
        local v49 = {
            depth = u46,
            effects = u44
        };
        u47(v49);
        u4.cleanupScope(v49);
        p48();
    end);
end;

function u4.cleanupScope(p50: table) -- Line: 218
    -- upvalues: u4 (copy)
    for i, v in p50 do
        if i ~= "depth" and i ~= "effects" then
            local v51 = typeof(v);

            if v51 == "Instance" then
                v:Destroy();
            elseif v51 == "RBXScriptConnection" then
                v:Disconnect();
            elseif v51 == "thread" then
                if coroutine.status(v) ~= "dead" then
                    task.cancel(v);
                end;
            elseif v51 == "function" then
                task.spawn(v);
            elseif v51 == "table" then
                u4.cleanupScope(v);
            end;
        end;
    end;

    table.clear(p50);
end;

function u4.protectParent(p52: table, u53: userdata) -- Line: 245
    table.insert(p52, u53.AncestryChanged:Connect(function(p54, p55) -- Line: 248
        -- upvalues: u53 (copy)
        if u53.Parent == workspace.Terrain then
            return;
        end;

        u53.Parent = workspace.Terrain;
    end));
end;

function u4.findFirstClassWithTag(p56: userdata?, p57: string, p58: string) -- Line: 258
    -- upvalues: u4 (copy)
    if p56 and p56.Parent ~= game then
        if p56.ClassName == p57 and p56:HasTag(p58) then
            return p56;
        end;

        return u4.findFirstClassWithTag(p56.Parent, p57, p58);
    end;
end;

function u4.cloneParticleAncestry(u59: userdata, u60: table) -- Line: 270
    if u59:FindFirstAncestorWhichIsA("BasePart") or u59:FindFirstAncestorOfClass("Attachment") then
        local function findAncestor(p61: userdata?) -- Line: 278
            -- upvalues: findAncestor (copy)
            if p61 then
                if p61.Parent and (p61.Parent:IsA("BasePart") or p61.Parent:IsA("Attachment")) then
                    p61 = findAncestor(p61.Parent);
                end;

                return p61;
            end;
        end;

        local function recurse(p62: userdata?) -- Line: 292
            -- upvalues: u60 (copy), u59 (copy), findAncestor (copy), recurse (copy)
            if p62 then
                local v63 = u60[p62];

                if v63 then
                    if p62 == u59 then
                        return v63, u60[p62.Parent];
                    end;

                    local Parent = p62.Parent;

                    if Parent then
                        if Parent.Parent and (Parent.Parent:IsA("BasePart") or Parent.Parent:IsA("Attachment")) then
                            Parent = findAncestor(Parent.Parent);
                        end;
                    else
                        Parent = nil;
                    end;

                    return v63, u60[Parent] or u60[p62];
                end;

                local Instance_fromExisting_ret = Instance.fromExisting(p62);
                Instance_fromExisting_ret.Archivable = false;

                if Instance_fromExisting_ret:IsA("BasePart") then
                    Instance_fromExisting_ret.Locked = true;
                end;

                if u60 then
                    u60[p62] = Instance_fromExisting_ret;
                end;

                local v64;

                if p62.Parent and (p62.Parent:IsA("BasePart") or p62.Parent:IsA("Attachment")) then
                    local v65, v66 = recurse(p62.Parent);
                    v64 = v66 or Instance_fromExisting_ret;

                    if v65 then
                        Instance_fromExisting_ret.Parent = v65;
                    end;
                else
                    v64 = Instance_fromExisting_ret;
                end;

                return Instance_fromExisting_ret, v64;
            end;
        end;

        return recurse(u59.Parent);
    end;
end;

function u4.getTransformedOriginExtents(p67: userdata) -- Line: 334
    -- upvalues: u1 (copy), u4 (copy)
    local CFrame_identity = CFrame.identity;

    if p67:IsA("BasePart") then
        return p67.CFrame, p67.Size;
    end;

    if p67:IsA("Attachment") then
        CFrame_identity = p67.WorldCFrame;
        local Parent = p67.Parent;
        local v68 = u1.get(p67, "PositionScale", Vector3.new(0, 0, 0), true);

        if Parent and (Parent:IsA("BasePart") and v68 ~= Vector3.new(0, 0, 0)) then
            CFrame_identity = CFrame_identity + Parent.Size / 2 * v68;
        end;

        local v69 = u1.get(p67, "OverrideWorldRotation", false, true);
        local v70 = u1.get(p67, "WorldRotation", Vector3.new(0, 0, 0), true);

        if v69 then
            local v71 = v70 * u4.DEG_TO_RAD;
            CFrame_identity = CFrame.new(CFrame_identity.Position) * CFrame.fromOrientation(v71.X, v71.Y, v71.Z);
        end;
    end;

    return CFrame_identity, Vector3.new(0, 0, 0);
end;

function u4.getMeshDecals(p72: userdata, p73: userdata) -- Line: 370
    -- upvalues: u1 (copy), u4 (copy)
    local v74 = {};
    local v75 = {};
    local v76 = {};

    local function filter(p77: table) -- Line: 377
        local v78 = {};

        for _, v in p77 do
            if v:IsA("Decal") then
                table.insert(v78, v);
            end;
        end;

        return v78;
    end;

    if u1.get(p72, "Flipbook", false, true) then
        return filter(p73:GetChildren()), v75, v76;
    end;

    local End = p72:FindFirstChild("End");
    local Start = p72:FindFirstChild("Start");

    if End then
        for _, child in p73:GetChildren() do
            if child:IsA("Decal") then
                local v79 = End:FindFirstChild(child.Name);

                if v79 and v79:IsA("Decal") then
                    table.insert(v74, child);
                    v76[child] = v79;

                    if child:GetAttribute("FlipbookEnabled") then
                        v75[child] = u4.deserializeFlipbook(child:GetAttribute("FlipbookTextures"));
                    else
                        table.insert(v74, child);
                    end;
                end;
            end;
        end;

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local Children = child:GetChildren();
                local v80 = child;
                local v81 = 0;

                for i = 1, #Children do
                    local v82 = i - v81;
                    local v83;

                    if Children[v82]:IsA("Decal") then
                        v83 = i;
                    else
                        table.remove(Children, v82);
                        v81 = v81 + 1;
                        v83 = i;
                    end;
                end;

                if #Children ~= 0 then
                    local function idx(p84: string) -- Line: 444
                        return tonumber(p84:match("%d+")) or 0;
                    end;

                    table.sort(Children, function(p85, p86) -- Line: 448
                        return (tonumber(p85.Name:match("%d+")) or 0) < (tonumber(p86.Name:match("%d+")) or 0);
                    end);
                    local v87 = {};

                    for _, v in Children do
                        local v88 = tonumber(v.Texture:match("%d+")) or 0;
                        table.insert(v87, v88);
                        v:Destroy();
                    end;

                    local v89 = u4.serializeFlipbook(v87);
                    v80:SetAttribute("FlipbookEnabled", true);
                    v80:SetAttribute("FlipbookTextures", buffer.tostring(v89));
                end;
            end;
        end;
    end;

    return v74, v75, v76;
end;

function u4.assembleMeshVFX(p90: userdata, p91: table, u92: any) -- Line: 471
    -- upvalues: u4 (copy)
    local RandomId = u4.getRandomId();

    if not p90:IsA("Part") then
        local v93 = p90:Clone();
        v93.Archivable = false;
        v93.Locked = true;
        v93.Parent = workspace.Terrain;
        v93:AddTag(u4.CLEANUP_TAG);
        table.insert(p91, v93);

        return v93;
    end;

    local v94 = u92:get(RandomId);
    v94.CFrame = p90.CFrame;
    local v95 = v94._getReal();
    u4.copyProperties(p90, v95, u4.COPY_PART_PROPERTIES);
    u4.copyProperties(p90, v95, u4.COPY_EXTENDED_PART_PROPERTIES);
    local v96 = p90:Clone();

    for _, child in v96:GetChildren() do
        child.Parent = v95;
    end;

    v96:Destroy();
    table.insert(p91, function() -- Line: 491
        -- upvalues: u92 (copy), RandomId (copy)
        u92:free(RandomId);
    end);

    return v94;
end;

function u4.getBezierPoints(u97: userdata, u98: boolean?) -- Line: 510
    local Children = u97:GetChildren();
    table.sort(Children, function(p99, p100) -- Line: 513
        return tonumber(p99.Name) < tonumber(p100.Name);
    end);
    local u101 = {};
    local u102 = {};
    local u103 = {};

    local function vec(p104: userdata) -- Line: 521
        -- upvalues: u97 (copy), u101 (copy), u98 (copy), u103 (copy), u102 (copy)
        local v105 = u97.WorldCFrame:PointToObjectSpace(p104.WorldPosition);
        local vector_create_ret = vector.create(v105.X, v105.Y, v105.Z);
        table.insert(u101, vector_create_ret);

        if u98 then
            u103[p104] = vector_create_ret;
            table.insert(u102, p104);
        end;

        return vector_create_ret;
    end;

    for i, v in Children do
        local T0 = v:FindFirstChild("T0");
        local T1 = v:FindFirstChild("T1");

        if i == 1 then
            local v106 = u97.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v106.X, v106.Y, v106.Z);
            table.insert(u101, vector_create_ret);

            if u98 then
                u103[v] = vector_create_ret;
                table.insert(u102, v);
            end;
        end;

        if i ~= 1 then
            if T1 then
                local v107 = u97.WorldCFrame:PointToObjectSpace(T1.WorldPosition);
                local vector_create_ret = vector.create(v107.X, v107.Y, v107.Z);
                table.insert(u101, vector_create_ret);

                if u98 then
                    u103[T1] = vector_create_ret;
                    table.insert(u102, T1);
                end;
            else
                local v108 = u97.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v108.X, v108.Y, v108.Z);
                table.insert(u101, vector_create_ret);

                if u98 then
                    u103[v] = vector_create_ret;
                    table.insert(u102, v);
                end;
            end;
        end;

        if i ~= 1 and i ~= #Children then
            local v109 = u97.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v109.X, v109.Y, v109.Z);
            table.insert(u101, vector_create_ret);

            if u98 then
                u103[v] = vector_create_ret;
                table.insert(u102, v);
            end;
        end;

        if i ~= #Children then
            if T0 then
                local v110 = u97.WorldCFrame:PointToObjectSpace(T0.WorldPosition);
                local vector_create_ret = vector.create(v110.X, v110.Y, v110.Z);
                table.insert(u101, vector_create_ret);

                if u98 then
                    u103[T0] = vector_create_ret;
                    table.insert(u102, T0);
                end;
            else
                local v111 = u97.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v111.X, v111.Y, v111.Z);
                table.insert(u101, vector_create_ret);

                if u98 then
                    u103[v] = vector_create_ret;
                    table.insert(u102, v);
                end;
            end;
        end;

        if i == #Children then
            local v112 = u97.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v112.X, v112.Y, v112.Z);
            table.insert(u101, vector_create_ret);

            if u98 then
                u103[v] = vector_create_ret;
                table.insert(u102, v);
            end;
        end;
    end;

    return u101, u102, u103;
end;

function u4.scaleNumberSequence(p113: userdata, p114: any) -- Line: 573
    if p114 == 1 then
        return p113;
    end;

    local v115 = {};

    for _, v in p113.Keypoints do
        local v116, v117;

        if typeof(p114) == "function" then
            v116, v117 = p114(v.Value, v.Envelope);
        else
            v116 = v.Value * p114;
            v117 = v.Envelope * p114;
        end;

        table.insert(v115, NumberSequenceKeypoint.new(v.Time, v116, v117));
    end;

    return NumberSequence.new(v115);
end;

function u4.serializePath(p118: table) -- Line: 598
    local buffer_create_ret = buffer.create(#p118 * 4 * 6);
    local v119 = 0;

    for i, v in p118 do
        local Scale = v.Position.X.Scale;
        local Scale2 = v.Position.Y.Scale;

        if i ~= 1 then
            buffer.writef32(buffer_create_ret, v119, Scale + v.LeftTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v119 + 4, Scale2 + v.LeftTangent.Y.Scale);
            v119 = v119 + 8;
        end;

        buffer.writef32(buffer_create_ret, v119, Scale);
        buffer.writef32(buffer_create_ret, v119 + 4, Scale2);
        v119 = v119 + 8;

        if i ~= #p118 then
            buffer.writef32(buffer_create_ret, v119, Scale + v.RightTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v119 + 4, Scale2 + v.RightTangent.Y.Scale);
            v119 = v119 + 8;
        end;
    end;

    return buffer_create_ret;
end;

function u4.deserializePath(p120) -- Line: 630
    if typeof(p120) == "string" then
        p120 = buffer.fromstring(p120) or p120;
    end;

    local v121 = buffer.len(p120) / 24;
    local v122 = {};

    for i = 0, v121 - 1 do
        local v123 = i * 4 * 6;
        local buffer_readf32_ret = buffer.readf32(p120, v123);
        local buffer_readf32_ret2 = buffer.readf32(p120, v123 + 4);
        local vector_create_ret = vector.create(buffer_readf32_ret, buffer_readf32_ret2);
        table.insert(v122, vector_create_ret);
        local v124;

        if i == v121 - 1 then
            v124 = i;
        else
            local buffer_readf32_ret3 = buffer.readf32(p120, v123 + 8);
            local buffer_readf32_ret4 = buffer.readf32(p120, v123 + 12);
            local buffer_readf32_ret5 = buffer.readf32(p120, v123 + 16);
            local buffer_readf32_ret6 = buffer.readf32(p120, v123 + 20);
            local vector_create_ret2 = vector.create(buffer_readf32_ret3, buffer_readf32_ret4);
            table.insert(v122, vector_create_ret2);
            local vector_create_ret3 = vector.create(buffer_readf32_ret5, buffer_readf32_ret6);
            table.insert(v122, vector_create_ret3);
            v124 = i;
        end;
    end;

    return v122;
end;

local v125 = require("./common/flipbook");
u4.serializeFlipbook = v125.serialize;
u4.deserializeFlipbook = v125.deserialize;
u4.default_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }));
u4.linear_bezier = buffer.tostring(u4.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }));

return u4;