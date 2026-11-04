 

 

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local u1 = require("./logger");
local u2 = require("../pkg/Promise");
local u3 = {};
local v4 = script:FindFirstAncestorOfClass("Plugin") or RunService:IsStudio() and not RunService:IsRunning();
u3.PLUGIN_CONTEXT = v4;
u3.SERVER_CONTEXT = RunService:IsServer() or u3.PLUGIN_CONTEXT;
u3.DEG_TO_RAD = 0.017453292519943295;
u3.BEZIER_TAG = "BezierParticle";
u3.LIGHTNING_TAG = "LightningBolt";
u3.SHOCKWAVE_TAG = "Shockwave";
u3.SCREENSHAKE_TAG = "CameraShake";
u3.ENABLED_VFX_TAG = "ConstantVFX";
u3.TEXTURE_LOAD_TAG = "LoadVFXTextures";
u3.CLEANUP_TAG = "__forge__cleanupOnExit";
u3.RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1;
u3.COLLISION_GROUPS = {
    StudioSelectable = {},
    ForgeDebris = {
        ForgeDebris = false
    },
    ForgeMouseIgnore = {
        StudioSelectable = false
    }
};
u3.COPY_SPECIALMESH_PROPERTIES = { "MeshId", "MeshType", "Offset", "Scale", "TextureId", "VertexColor" };
u3.COPY_PART_PROPERTIES = { "CastShadow", "Color", "Material", "MaterialVariant", "Reflectance", "Shape", "FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "TopSurface", "BottomSurface" };
u3.COPY_EXTENDED_PART_PROPERTIES = { "Size", "Transparency", "CustomPhysicalProperties", "CanCollide", "CanQuery", "CanTouch", "CollisionGroup" };
local u5 = setmetatable({}, {
    __mode = "k"
});

function u3.lock(p6: userdata) -- Line: 85
    -- upvalues: u5 (copy)
    if u5[p6] then
        return true;
    end;

    u5[p6] = coroutine.running();

    return false;
end;

function u3.unlock(p7: userdata, p8: thread?) -- Line: 95
    -- upvalues: u5 (copy), u1 (copy)
    local v9 = u5[p7];

    if coroutine.running() ~= v9 and p8 ~= v9 then
        u1.error("attempt to unlock an instance owned by a different thread");
    end;

    u5[p7] = nil;
end;

function u3.setCollisionGroups(p10) -- Line: 105
    -- upvalues: PhysicsService (copy), RunService (copy)
    local v11 = {};

    for i, v in p10 do
        PhysicsService:RegisterCollisionGroup(i);

        if not i:match("Studio") or RunService:IsStudio() then
            v11[i] = v;
        end;
    end;

    for i, v in v11 do
        local v12 = i;

        for i2, v2 in v do
            if not i2:match("Studio") or RunService:IsStudio() then
                PhysicsService:CollisionGroupSetCollidable(v12, i2, v2);
            end;
        end;
    end;
end;

local u13 = 0;

function u3.getRandomId() -- Line: 129
    -- upvalues: u13 (ref)
    u13 = u13 + 1;

    return tostring(u13);
end;

function u3.copyProperties(p14: userdata, p15: userdata, p16: table) -- Line: 134
    for _, v in p16 do
        p15[v] = p14[v];
    end;
end;

function u3.lerp(p17: number, p18: number, p19: number) -- Line: 140
    return p17 + (p18 - p17) * p19;
end;

function u3.try(u20: string, p21: function, ...) -- Line: 144
    -- upvalues: u1 (copy)
    local v23 = { xpcall(p21, function(p22) -- Line: 145
            -- upvalues: u1 (ref), u20 (copy)
            u1.warn(string.format(u20, p22));
        end, ...) };

    return v23[1], table.unpack(v23, 2);
end;

function u3.reboundfn(u24: number, u25: function) -- Line: 152
    local u26 = nil;

    return function(...) -- Line: 155
        -- upvalues: u26 (ref), u24 (copy), u25 (copy)
        if u26 then
            task.cancel(u26);
        end;

        local u27 = { ... };
        u26 = task.delay(u24, function() -- Line: 162
            -- upvalues: u26 (ref), u25 (ref), u27 (copy)
            u26 = nil;
            u25(table.unpack(u27));
        end);
    end;
end;

function u3.randomUnitVector(p28: vector, p29: vector, p30: userdata?) -- Line: 169
    local v31 = p30 or Random.new();
    local v32 = v31:NextNumber(p28.X, p29.X);
    local v33 = v31:NextNumber(p28.Y, p29.Y);

    return Vector3.new(v32, v33, v31:NextNumber(p28.Z, p29.Z));
end;

function u3.getImpulseForce(p34: vector, p35: vector, p36: number) -- Line: 174
    return (p35 - p34) / p36 + Vector3.new(0, workspace.Gravity * p36 * 0.5, 0);
end;

function u3.isMeshVFX(p37: userdata) -- Line: 178
    local v38 = p37 and (p37:IsA("Model") and p37:FindFirstChild("Start") and (p37.Start:IsA("BasePart") and p37:FindFirstChild("End"))) and p37.End:IsA("BasePart");

    return v38;
end;

function u3.isSpinModelStatic(p39: userdata) -- Line: 187
    -- upvalues: u3 (copy)
    local v40;

    if u3.getAttribute(p39, "SpinRotation", Vector3.new(0, 0, 0), true) == Vector3.new(0, 0, 0) and (u3.getAttribute(p39, "Scale_Start", 1, true) == 1 and u3.getAttribute(p39, "Scale_End", 1, true) == 1) then
        v40 = u3.getAttribute(p39, "SyncPosition", false, true) == false;
    else
        v40 = false;
    end;

    return v40;
end;

function u3.shouldSkipNested(p41: userdata) -- Line: 194
    -- upvalues: u3 (copy)
    local v42 = p41:IsA("Beam") or p41:HasTag(u3.BEZIER_TAG) or (p41:HasTag(u3.LIGHTNING_TAG) or u3.isMeshVFX(p41)) or p41:IsA("BasePart") and u3.findFirstClassWithTag(p41, "Attachment", u3.SHOCKWAVE_TAG) ~= nil;

    return v42;
end;

function u3.createEmitPromise(u43: any, p44: userdata, u45: number, u46: any) -- Line: 202
    -- upvalues: u2 (copy), u3 (copy)
    return u2.new(function(p47) -- Line: 203
        -- upvalues: u45 (copy), u43 (copy), u46 (copy), u3 (ref)
        local v48 = {
            depth = u45,
            effects = u43
        };
        u46(v48);
        u3.cleanupScope(v48);
        p47();
    end);
end;

function u3.cleanupScope(p49: table) -- Line: 216
    -- upvalues: u3 (copy)
    for i, v in p49 do
        if i ~= "depth" and i ~= "effects" then
            local v50 = typeof(v);

            if v50 == "Instance" then
                v:Destroy();
            elseif v50 == "RBXScriptConnection" then
                v:Disconnect();
            elseif v50 == "thread" then
                if coroutine.status(v) ~= "dead" then
                    task.cancel(v);
                end;
            elseif v50 == "function" then
                task.spawn(v);
            elseif v50 == "table" then
                u3.cleanupScope(v);
            end;
        end;
    end;

    table.clear(p49);
end;

function u3.protectParent(p51: table, u52: userdata) -- Line: 243
    table.insert(p51, u52.AncestryChanged:Connect(function(p53, p54) -- Line: 246
        -- upvalues: u52 (copy)
        if u52.Parent == workspace.Terrain then
            return;
        end;

        u52.Parent = workspace.Terrain;
    end));
end;

function u3.findFirstClassWithTag(p55: userdata?, p56: string, p57: string) -- Line: 256
    -- upvalues: u3 (copy)
    if p55 and p55.Parent ~= game then
        if p55.ClassName == p56 and p55:HasTag(p57) then
            return p55;
        end;

        return u3.findFirstClassWithTag(p55.Parent, p56, p57);
    end;
end;

function u3.cloneParticleAncestry(u58: userdata, u59: table) -- Line: 268
    if u58:FindFirstAncestorWhichIsA("BasePart") or u58:FindFirstAncestorOfClass("Attachment") then
        local function findAncestor(p60: userdata?) -- Line: 276
            -- upvalues: findAncestor (copy)
            if p60 then
                if p60.Parent and (p60.Parent:IsA("BasePart") or p60.Parent:IsA("Attachment")) then
                    p60 = findAncestor(p60.Parent);
                end;

                return p60;
            end;
        end;

        local function recurse(p61: userdata?) -- Line: 290
            -- upvalues: u59 (copy), u58 (copy), findAncestor (copy), recurse (copy)
            if p61 then
                local v62 = u59[p61];

                if v62 then
                    if p61 == u58 then
                        return v62, u59[p61.Parent];
                    end;

                    local Parent = p61.Parent;

                    if Parent then
                        if Parent.Parent and (Parent.Parent:IsA("BasePart") or Parent.Parent:IsA("Attachment")) then
                            Parent = findAncestor(Parent.Parent);
                        end;
                    else
                        Parent = nil;
                    end;

                    return v62, u59[Parent] or u59[p61];
                end;

                local Instance_fromExisting_ret = Instance.fromExisting(p61);
                Instance_fromExisting_ret.Archivable = false;

                if Instance_fromExisting_ret:IsA("BasePart") then
                    Instance_fromExisting_ret.Locked = true;
                end;

                if u59 then
                    u59[p61] = Instance_fromExisting_ret;
                end;

                local v63;

                if p61.Parent and (p61.Parent:IsA("BasePart") or p61.Parent:IsA("Attachment")) then
                    local v64, v65 = recurse(p61.Parent);
                    v63 = v65 or Instance_fromExisting_ret;

                    if v64 then
                        Instance_fromExisting_ret.Parent = v64;
                    end;
                else
                    v63 = Instance_fromExisting_ret;
                end;

                return Instance_fromExisting_ret, v63;
            end;
        end;

        return recurse(u58.Parent);
    end;
end;

function u3.getAttribute(p66: userdata, p67: string, p68: any, p69: boolean?) -- Line: 332
    local Attribute = p66:GetAttribute(p67);

    if Attribute ~= nil and typeof(Attribute) == typeof(p68) then
        p68 = Attribute;
    end;

    if not p69 then
        p66:SetAttribute(p67, p68);
    end;

    return p68;
end;

function u3.getRangeAttribute(p70: userdata, p71: string, p72, p73, p74: boolean?) -- Line: 346
    local Attribute = p70:GetAttribute(p71);

    if typeof(Attribute) ~= "NumberRange" then
        Attribute = p72;
    end;

    if p73 then
        Attribute = NumberRange.new(math.clamp(Attribute.Min, p73.Min, p73.Max), (math.clamp(Attribute.Max, p73.Min, p73.Max)));
    end;

    if not p74 then
        p70:SetAttribute(p71, Attribute);
    end;

    return Attribute;
end;

function u3.getEnumAttribute(p75: userdata, p76: string, p77: any, p78: table, p79: boolean?) -- Line: 374
    local Attribute = p75:GetAttribute(p76);

    if Attribute ~= nil and table.find(p78, Attribute) then
        p77 = Attribute;
    end;

    if not p79 then
        p75:SetAttribute(p76, p77);
    end;

    return p77;
end;

function u3.getTransformedOriginExtents(p80: userdata) -- Line: 388
    -- upvalues: u3 (copy)
    local CFrame_identity = CFrame.identity;

    if p80:IsA("BasePart") then
        return p80.CFrame, p80.Size;
    end;

    if p80:IsA("Attachment") then
        CFrame_identity = p80.WorldCFrame;
        local Parent = p80.Parent;
        local Attribute = u3.getAttribute(p80, "PositionScale", Vector3.new(0, 0, 0), true);

        if Parent and (Parent:IsA("BasePart") and Attribute ~= Vector3.new(0, 0, 0)) then
            CFrame_identity = CFrame_identity + Parent.Size / 2 * Attribute;
        end;

        local Attribute2 = u3.getAttribute(p80, "OverrideWorldRotation", false, true);
        local Attribute3 = u3.getAttribute(p80, "WorldRotation", Vector3.new(0, 0, 0), true);

        if Attribute2 then
            local v81 = Attribute3 * u3.DEG_TO_RAD;
            CFrame_identity = CFrame.new(CFrame_identity.Position) * CFrame.fromOrientation(v81.X, v81.Y, v81.Z);
        end;
    end;

    return CFrame_identity, Vector3.new(0, 0, 0);
end;

function u3.getMeshDecals(p82: userdata, p83: userdata) -- Line: 424
    -- upvalues: u3 (copy)
    local v84 = {};
    local v85 = {};
    local v86 = {};

    local function filter(p87: table) -- Line: 431
        local v88 = {};

        for _, v in p87 do
            if v:IsA("Decal") then
                table.insert(v88, v);
            end;
        end;

        return v88;
    end;

    if u3.getAttribute(p82, "Flipbook", false, true) then
        return filter(p83:GetChildren()), v85, v86;
    end;

    local End = p82:FindFirstChild("End");
    local Start = p82:FindFirstChild("Start");

    if End then
        for _, child in p83:GetChildren() do
            if child:IsA("Decal") then
                local v89 = End:FindFirstChild(child.Name);

                if v89 and v89:IsA("Decal") then
                    table.insert(v84, child);
                    v86[child] = v89;

                    if child:GetAttribute("FlipbookEnabled") then
                        v85[child] = u3.deserializeFlipbook(child:GetAttribute("FlipbookTextures"));
                    else
                        table.insert(v84, child);
                    end;
                end;
            end;
        end;

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local Children = child:GetChildren();
                local v90 = child;
                local v91 = 0;

                for i = 1, #Children do
                    local v92 = i - v91;
                    local v93;

                    if Children[v92]:IsA("Decal") then
                        v93 = i;
                    else
                        table.remove(Children, v92);
                        v91 = v91 + 1;
                        v93 = i;
                    end;
                end;

                if #Children ~= 0 then
                    local function idx(p94: string) -- Line: 498
                        return tonumber(p94:match("%d+")) or 0;
                    end;

                    table.sort(Children, function(p95, p96) -- Line: 502
                        return (tonumber(p95.Name:match("%d+")) or 0) < (tonumber(p96.Name:match("%d+")) or 0);
                    end);
                    local v97 = {};

                    for _, v in Children do
                        local v98 = tonumber(v.Texture:match("%d+")) or 0;
                        table.insert(v97, v98);
                        v:Destroy();
                    end;

                    local v99 = u3.serializeFlipbook(v97);
                    v90:SetAttribute("FlipbookEnabled", true);
                    v90:SetAttribute("FlipbookTextures", buffer.tostring(v99));
                end;
            end;
        end;
    end;

    return v84, v85, v86;
end;

function u3.assembleMeshVFX(p100: userdata, p101: table, u102: any) -- Line: 525
    -- upvalues: u3 (copy)
    local RandomId = u3.getRandomId();

    if not p100:IsA("Part") then
        local v103 = p100:Clone();
        v103.Archivable = false;
        v103.Locked = true;
        v103.Parent = workspace.Terrain;
        v103:AddTag(u3.CLEANUP_TAG);
        table.insert(p101, v103);

        return v103;
    end;

    local v104 = u102:get(RandomId);
    v104.CFrame = p100.CFrame;
    local v105 = v104._getReal();
    u3.copyProperties(p100, v105, u3.COPY_PART_PROPERTIES);
    u3.copyProperties(p100, v105, u3.COPY_EXTENDED_PART_PROPERTIES);
    local v106 = p100:Clone();

    for _, child in v106:GetChildren() do
        child.Parent = v105;
    end;

    v106:Destroy();
    table.insert(p101, function() -- Line: 545
        -- upvalues: u102 (copy), RandomId (copy)
        u102:free(RandomId);
    end);

    return v104;
end;

function u3.getBezierPoints(u107: userdata, u108: boolean?) -- Line: 564
    local Children = u107:GetChildren();
    table.sort(Children, function(p109, p110) -- Line: 567
        return tonumber(p109.Name) < tonumber(p110.Name);
    end);
    local u111 = {};
    local u112 = {};
    local u113 = {};

    local function vec(p114: userdata) -- Line: 575
        -- upvalues: u107 (copy), u111 (copy), u108 (copy), u113 (copy), u112 (copy)
        local v115 = u107.WorldCFrame:PointToObjectSpace(p114.WorldPosition);
        local vector_create_ret = vector.create(v115.X, v115.Y, v115.Z);
        table.insert(u111, vector_create_ret);

        if u108 then
            u113[p114] = vector_create_ret;
            table.insert(u112, p114);
        end;

        return vector_create_ret;
    end;

    for i, v in Children do
        local T0 = v:FindFirstChild("T0");
        local T1 = v:FindFirstChild("T1");

        if i == 1 then
            local v116 = u107.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v116.X, v116.Y, v116.Z);
            table.insert(u111, vector_create_ret);

            if u108 then
                u113[v] = vector_create_ret;
                table.insert(u112, v);
            end;
        end;

        if i ~= 1 then
            if T1 then
                local v117 = u107.WorldCFrame:PointToObjectSpace(T1.WorldPosition);
                local vector_create_ret = vector.create(v117.X, v117.Y, v117.Z);
                table.insert(u111, vector_create_ret);

                if u108 then
                    u113[T1] = vector_create_ret;
                    table.insert(u112, T1);
                end;
            else
                local v118 = u107.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v118.X, v118.Y, v118.Z);
                table.insert(u111, vector_create_ret);

                if u108 then
                    u113[v] = vector_create_ret;
                    table.insert(u112, v);
                end;
            end;
        end;

        if i ~= 1 and i ~= #Children then
            local v119 = u107.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v119.X, v119.Y, v119.Z);
            table.insert(u111, vector_create_ret);

            if u108 then
                u113[v] = vector_create_ret;
                table.insert(u112, v);
            end;
        end;

        if i ~= #Children then
            if T0 then
                local v120 = u107.WorldCFrame:PointToObjectSpace(T0.WorldPosition);
                local vector_create_ret = vector.create(v120.X, v120.Y, v120.Z);
                table.insert(u111, vector_create_ret);

                if u108 then
                    u113[T0] = vector_create_ret;
                    table.insert(u112, T0);
                end;
            else
                local v121 = u107.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v121.X, v121.Y, v121.Z);
                table.insert(u111, vector_create_ret);

                if u108 then
                    u113[v] = vector_create_ret;
                    table.insert(u112, v);
                end;
            end;
        end;

        if i == #Children then
            local v122 = u107.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v122.X, v122.Y, v122.Z);
            table.insert(u111, vector_create_ret);

            if u108 then
                u113[v] = vector_create_ret;
                table.insert(u112, v);
            end;
        end;
    end;

    return u111, u112, u113;
end;

function u3.scaleNumberSequence(p123: userdata, p124: any) -- Line: 627
    if p124 == 1 then
        return p123;
    end;

    local v125 = {};

    for _, v in p123.Keypoints do
        local v126, v127;

        if typeof(p124) == "function" then
            v126, v127 = p124(v.Value, v.Envelope);
        else
            v126 = v.Value * p124;
            v127 = v.Envelope * p124;
        end;

        table.insert(v125, NumberSequenceKeypoint.new(v.Time, v126, v127));
    end;

    return NumberSequence.new(v125);
end;

function u3.serializePath(p128: table) -- Line: 652
    local buffer_create_ret = buffer.create(#p128 * 4 * 6);
    local v129 = 0;

    for i, v in p128 do
        local Scale = v.Position.X.Scale;
        local Scale2 = v.Position.Y.Scale;

        if i ~= 1 then
            buffer.writef32(buffer_create_ret, v129, Scale + v.LeftTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v129 + 4, Scale2 + v.LeftTangent.Y.Scale);
            v129 = v129 + 8;
        end;

        buffer.writef32(buffer_create_ret, v129, Scale);
        buffer.writef32(buffer_create_ret, v129 + 4, Scale2);
        v129 = v129 + 8;

        if i ~= #p128 then
            buffer.writef32(buffer_create_ret, v129, Scale + v.RightTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v129 + 4, Scale2 + v.RightTangent.Y.Scale);
            v129 = v129 + 8;
        end;
    end;

    return buffer_create_ret;
end;

function u3.deserializePath(p130) -- Line: 684
    if typeof(p130) == "string" then
        p130 = buffer.fromstring(p130) or p130;
    end;

    local v131 = buffer.len(p130) / 24;
    local v132 = {};

    for i = 0, v131 - 1 do
        local v133 = i * 4 * 6;
        local buffer_readf32_ret = buffer.readf32(p130, v133);
        local buffer_readf32_ret2 = buffer.readf32(p130, v133 + 4);
        local vector_create_ret = vector.create(buffer_readf32_ret, buffer_readf32_ret2);
        table.insert(v132, vector_create_ret);
        local v134;

        if i == v131 - 1 then
            v134 = i;
        else
            local buffer_readf32_ret3 = buffer.readf32(p130, v133 + 8);
            local buffer_readf32_ret4 = buffer.readf32(p130, v133 + 12);
            local buffer_readf32_ret5 = buffer.readf32(p130, v133 + 16);
            local buffer_readf32_ret6 = buffer.readf32(p130, v133 + 20);
            local vector_create_ret2 = vector.create(buffer_readf32_ret3, buffer_readf32_ret4);
            table.insert(v132, vector_create_ret2);
            local vector_create_ret3 = vector.create(buffer_readf32_ret5, buffer_readf32_ret6);
            table.insert(v132, vector_create_ret3);
            v134 = i;
        end;
    end;

    return v132;
end;

function u3.serializeFlipbook(p135: table) -- Line: 713
    local buffer_create_ret = buffer.create(#p135 * 8);

    for i, v in p135 do
        buffer.writef64(buffer_create_ret, (i - 1) * 8, v);
    end;

    return buffer_create_ret;
end;

function u3.deserializeFlipbook(p136) -- Line: 723
    if typeof(p136) == "string" then
        p136 = buffer.fromstring(p136) or p136;
    end;

    local v137 = {};

    for i = 0, buffer.len(p136) / 8 - 1 do
        local buffer_readf64_ret = buffer.readf64(p136, i * 8);
        table.insert(v137, buffer_readf64_ret);
        local _ = i;
    end;

    return v137;
end;

u3.default_bezier = buffer.tostring(u3.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }));
u3.linear_bezier = buffer.tostring(u3.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }));

return u3;