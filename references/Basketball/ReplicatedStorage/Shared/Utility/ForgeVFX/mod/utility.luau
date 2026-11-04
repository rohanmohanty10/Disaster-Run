 
 

local RunService = game:GetService("RunService");
local PhysicsService = game:GetService("PhysicsService");
local u1 = require("./logger");
local u2 = {
    DEG_TO_RAD = 0.017453292519943295,
    BEZIER_TAG = "BezierParticle",
    SHOCKWAVE_TAG = "Shockwave",
    SCREENSHAKE_TAG = "CameraShake",
    ENABLED_VFX_TAG = "ConstantVFX",
    TEXTURE_LOAD_TAG = "LoadVFXTextures",
    RENDER_PRIORITY = Enum.RenderPriority.Camera.Value + 1,
    COLLISION_GROUPS = {
        StudioSelectable = {},
        ForgeDebris = {
            ForgeDebris = false
        },
        ForgeMouseIgnore = {
            StudioSelectable = false
        }
    },
    COPY_SPECIALMESH_PROPERTIES = { "MeshId", "MeshType", "Offset", "Scale", "TextureId", "VertexColor" },
    COPY_PART_PROPERTIES = { "CastShadow", "Color", "Material", "MaterialVariant", "Reflectance", "Shape", "FrontSurface", "BackSurface", "LeftSurface", "RightSurface", "TopSurface", "BottomSurface" },
    COPY_EXTENDED_PART_PROPERTIES = { "Size", "Transparency", "CanCollide", "CanQuery", "CanTouch", "CollisionGroup" }
};
local u3 = setmetatable({}, {
    __mode = "k"
});

function u2.lock(p4: userdata) -- Line: 75
    -- upvalues: u3 (copy)
    if u3[p4] then
        return true;
    end;

    u3[p4] = coroutine.running();

    return false;
end;

function u2.unlock(p5: userdata, p6: thread?) -- Line: 85
    -- upvalues: u3 (copy), u1 (copy)
    local v7 = u3[p5];

    if coroutine.running() ~= v7 and p6 ~= v7 then
        u1.error("attempt to unlock an instance owned by a different thread");
    end;

    u3[p5] = nil;
end;

function u2.setCollisionGroups(p8) -- Line: 95
    -- upvalues: PhysicsService (copy), RunService (copy)
    local v9 = {};

    for i, v in p8 do
        PhysicsService:RegisterCollisionGroup(i);

        if not i:match("Studio") or RunService:IsStudio() then
            v9[i] = v;
        end;
    end;

    for i, v in v9 do
        local v10 = i;

        for i2, v2 in v do
            if not i2:match("Studio") or RunService:IsStudio() then
                PhysicsService:CollisionGroupSetCollidable(v10, i2, v2);
            end;
        end;
    end;
end;

local u11 = 0;

function u2.getRanomId() -- Line: 119
    -- upvalues: u11 (ref)
    u11 = u11 + 1;

    return tostring(u11);
end;

function u2.copyProperties(p12: userdata, p13: userdata, p14: table) -- Line: 124
    for _, v in p14 do
        p13[v] = p12[v];
    end;
end;

function u2.lerp(p15: number, p16: number, p17: number) -- Line: 130
    return p15 + (p16 - p15) * p17;
end;

function u2.try(u18: string, p19: function, ...) -- Line: 134
    -- upvalues: u1 (copy)
    local v21 = { xpcall(p19, function(p20) -- Line: 135
            -- upvalues: u1 (ref), u18 (copy)
            u1.warn(string.format(u18, p20));
        end, ...) };

    return v21[1], table.unpack(v21, 2);
end;

function u2.reboundfn(u22: number, u23: function) -- Line: 142
    local u24 = nil;

    return function(...) -- Line: 145
        -- upvalues: u24 (ref), u22 (copy), u23 (copy)
        if u24 then
            task.cancel(u24);
        end;

        local u25 = { ... };
        u24 = task.delay(u22, function() -- Line: 152
            -- upvalues: u24 (ref), u23 (ref), u25 (copy)
            u24 = nil;
            u23(table.unpack(u25));
        end);
    end;
end;

function u2.randomUnitVector(p26: vector, p27: vector, p28: userdata?) -- Line: 159
    local v29 = p28 or Random.new();
    local v30 = v29:NextNumber(p26.X, p27.X);
    local v31 = v29:NextNumber(p26.Y, p27.Y);

    return Vector3.new(v30, v31, v29:NextNumber(p26.Z, p27.Z));
end;

function u2.getImpulseForce(p32: vector, p33: vector, p34: number) -- Line: 167
    return (p33 - p32) / p34 + Vector3.new(0, workspace.Gravity * p34 * 0.5, 0);
end;

function u2.isMeshVFX(p35: userdata) -- Line: 171
    local v36 = p35 and (p35:IsA("Model") and p35:FindFirstChild("Start") and (p35.Start:IsA("BasePart") and p35:FindFirstChild("End"))) and p35.End:IsA("BasePart");

    return v36;
end;

function u2.cleanupScope(p37: table) -- Line: 180
    -- upvalues: u2 (copy)
    for _, v in p37 do
        local v38 = typeof(v);

        if v38 == "Instance" then
            v:Destroy();
        elseif v38 == "RBXScriptConnection" then
            v:Disconnect();
        elseif v38 == "thread" then
            if coroutine.status(v) ~= "dead" then
                task.cancel(v);
            end;
        elseif v38 == "function" then
            task.spawn(v);
        elseif v38 == "table" then
            u2.cleanupScope(v);
        end;
    end;

    table.clear(p37);
end;

function u2.protectParent(p39: table, u40: userdata) -- Line: 202
    table.insert(p39, u40.AncestryChanged:Connect(function(p41, p42) -- Line: 205
        -- upvalues: u40 (copy)
        if u40.Parent == workspace.Terrain then
            return;
        end;

        u40.Parent = workspace.Terrain;
    end));
end;

function u2.findFirstClassWithTag(p43: userdata?, p44: string, p45: string) -- Line: 215
    -- upvalues: u2 (copy)
    if p43 and p43.Parent ~= game then
        if p43.ClassName == p44 and p43:HasTag(p45) then
            return p43;
        end;

        return u2.findFirstClassWithTag(p43.Parent, p44, p45);
    end;
end;

function u2.cloneParticleAncestry(u46: userdata, u47: table?) -- Line: 227
    if u46:FindFirstAncestorWhichIsA("BasePart") or u46:FindFirstAncestorOfClass("Attachment") then
        local function findAncestor(p48: userdata) -- Line: 232
            -- upvalues: findAncestor (copy)
            if p48.Parent and (p48.Parent:IsA("BasePart") or p48.Parent:IsA("Attachment")) then
                p48 = findAncestor(p48.Parent);
            end;

            return p48;
        end;

        local function recurse(p49: userdata) -- Line: 242
            -- upvalues: u47 (copy), u46 (copy), findAncestor (copy), recurse (copy)
            local v50 = u47[p49];

            if v50 then
                if p49 == u46 then
                    return v50, u47[p49.Parent];
                end;

                local Parent = p49.Parent;

                if Parent.Parent and (Parent.Parent:IsA("BasePart") or Parent.Parent:IsA("Attachment")) then
                    Parent = findAncestor(Parent.Parent);
                end;

                return v50, u47[Parent] or u47[p49];
            end;

            local Instance_fromExisting_ret = Instance.fromExisting(p49);
            Instance_fromExisting_ret.Archivable = false;

            if Instance_fromExisting_ret:IsA("BasePart") then
                Instance_fromExisting_ret.Locked = true;
            end;

            if u47 then
                u47[p49] = Instance_fromExisting_ret;
            end;

            local v51;

            if p49.Parent and (p49.Parent:IsA("BasePart") or p49.Parent:IsA("Attachment")) then
                local v52, v53 = recurse(p49.Parent);
                v51 = v53 or Instance_fromExisting_ret;

                if v52 then
                    Instance_fromExisting_ret.Parent = v52;
                end;
            else
                v51 = Instance_fromExisting_ret;
            end;

            return Instance_fromExisting_ret, v51;
        end;

        return recurse(u46.Parent);
    end;
end;

function u2.getAttribute(p54: userdata, p55: string, p56: any, p57: boolean?) -- Line: 280
    local Attribute = p54:GetAttribute(p55);

    if Attribute ~= nil and typeof(Attribute) == typeof(p56) then
        p56 = Attribute;
    end;

    if not p57 then
        p54:SetAttribute(p55, p56);
    end;

    return p56;
end;

function u2.getRangeAttribute(p58: userdata, p59: string, p60, p61, p62: boolean?) -- Line: 294
    local Attribute = p58:GetAttribute(p59);

    if typeof(Attribute) ~= "NumberRange" then
        Attribute = p60;
    end;

    if p61 then
        Attribute = NumberRange.new(math.clamp(Attribute.Min, p61.Min, p61.Max), (math.clamp(Attribute.Max, p61.Min, p61.Max)));
    end;

    if not p62 then
        p58:SetAttribute(p59, Attribute);
    end;

    return Attribute;
end;

function u2.getEnumAttribute(p63: userdata, p64: string, p65: any, p66: table, p67: boolean?) -- Line: 322
    local Attribute = p63:GetAttribute(p64);

    if Attribute ~= nil and table.find(p66, Attribute) then
        p65 = Attribute;
    end;

    if not p67 then
        p63:SetAttribute(p64, p65);
    end;

    return p65;
end;

function u2.getMeshDecals(p68: userdata, p69: userdata) -- Line: 336
    -- upvalues: u2 (copy)
    local v70 = {};
    local v71 = {};
    local v72 = {};

    local function filter(p73: table) -- Line: 343
        local v74 = {};

        for _, v in p73 do
            if v:IsA("Decal") then
                table.insert(v74, v);
            end;
        end;

        return v74;
    end;

    if u2.getAttribute(p68, "Flipbook", false, true) then
        return filter(p69:GetChildren()), v71, v72;
    end;

    local End = p68:FindFirstChild("End");
    local Start = p68:FindFirstChild("Start");

    if End then
        for _, child in p69:GetChildren() do
            if child:IsA("Decal") then
                local v75 = End:FindFirstChild(child.Name);

                if v75 and v75:IsA("Decal") then
                    table.insert(v70, child);
                    v72[child] = v75;

                    if child:GetAttribute("FlipbookEnabled") then
                        v71[child] = u2.deserializeFlipbook(child:GetAttribute("FlipbookTextures"));
                    else
                        table.insert(v70, child);
                    end;
                end;
            end;
        end;

        for _, child in Start:GetChildren() do
            if child:IsA("Decal") then
                local Children = child:GetChildren();
                local v76 = child;
                local v77 = 0;

                for i = 1, #Children do
                    local v78 = i - v77;
                    local v79;

                    if Children[v78]:IsA("Decal") then
                        v79 = i;
                    else
                        table.remove(Children, v78);
                        v77 = v77 + 1;
                        v79 = i;
                    end;
                end;

                if #Children ~= 0 then
                    local function idx(p80: string) -- Line: 410
                        return tonumber(p80:match("%d+")) or 0;
                    end;

                    table.sort(Children, function(p81, p82) -- Line: 414
                        return (tonumber(p81.Name:match("%d+")) or 0) < (tonumber(p82.Name:match("%d+")) or 0);
                    end);
                    local v83 = {};

                    for _, v in Children do
                        local v84 = tonumber(v.Texture:match("%d+")) or 0;
                        table.insert(v83, v84);
                        v:Destroy();
                    end;

                    local v85 = u2.serializeFlipbook(v83);
                    v76:SetAttribute("FlipbookEnabled", true);
                    v76:SetAttribute("FlipbookTextures", buffer.tostring(v85));
                end;
            end;
        end;
    end;

    return v70, v71, v72;
end;

function u2.getBezierPoints(u86: userdata, u87: boolean) -- Line: 437
    local Children = u86:GetChildren();
    table.sort(Children, function(p88, p89) -- Line: 440
        return tonumber(p88.Name) < tonumber(p89.Name);
    end);
    local u90 = {};
    local u91 = {};
    local u92 = {};

    local function vec(p93: userdata) -- Line: 448
        -- upvalues: u86 (copy), u90 (copy), u87 (copy), u92 (copy), u91 (copy)
        local v94 = u86.WorldCFrame:PointToObjectSpace(p93.WorldPosition);
        local vector_create_ret = vector.create(v94.X, v94.Y, v94.Z);
        table.insert(u90, vector_create_ret);

        if u87 then
            u92[p93] = vector_create_ret;
            table.insert(u91, p93);
        end;

        return vector_create_ret;
    end;

    for i, v in Children do
        local T0 = v:FindFirstChild("T0");
        local T1 = v:FindFirstChild("T1");

        if i == 1 then
            local v95 = u86.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v95.X, v95.Y, v95.Z);
            table.insert(u90, vector_create_ret);

            if u87 then
                u92[v] = vector_create_ret;
                table.insert(u91, v);
            end;
        end;

        if i ~= 1 then
            if T1 then
                local v96 = u86.WorldCFrame:PointToObjectSpace(T1.WorldPosition);
                local vector_create_ret = vector.create(v96.X, v96.Y, v96.Z);
                table.insert(u90, vector_create_ret);

                if u87 then
                    u92[T1] = vector_create_ret;
                    table.insert(u91, T1);
                end;
            else
                local v97 = u86.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v97.X, v97.Y, v97.Z);
                table.insert(u90, vector_create_ret);

                if u87 then
                    u92[v] = vector_create_ret;
                    table.insert(u91, v);
                end;
            end;
        end;

        if i ~= 1 and i ~= #Children then
            local v98 = u86.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v98.X, v98.Y, v98.Z);
            table.insert(u90, vector_create_ret);

            if u87 then
                u92[v] = vector_create_ret;
                table.insert(u91, v);
            end;
        end;

        if i ~= #Children then
            if T0 then
                local v99 = u86.WorldCFrame:PointToObjectSpace(T0.WorldPosition);
                local vector_create_ret = vector.create(v99.X, v99.Y, v99.Z);
                table.insert(u90, vector_create_ret);

                if u87 then
                    u92[T0] = vector_create_ret;
                    table.insert(u91, T0);
                end;
            else
                local v100 = u86.WorldCFrame:PointToObjectSpace(v.WorldPosition);
                local vector_create_ret = vector.create(v100.X, v100.Y, v100.Z);
                table.insert(u90, vector_create_ret);

                if u87 then
                    u92[v] = vector_create_ret;
                    table.insert(u91, v);
                end;
            end;
        end;

        if i == #Children then
            local v101 = u86.WorldCFrame:PointToObjectSpace(v.WorldPosition);
            local vector_create_ret = vector.create(v101.X, v101.Y, v101.Z);
            table.insert(u90, vector_create_ret);

            if u87 then
                u92[v] = vector_create_ret;
                table.insert(u91, v);
            end;
        end;
    end;

    return u90, u91, u92;
end;

function u2.scaleNumberSequence(p102: userdata, p103: any) -- Line: 500
    if p103 == 1 then
        return p102;
    end;

    local v104 = {};

    for _, v in p102.Keypoints do
        local v105, v106;

        if typeof(p103) == "function" then
            v105, v106 = p103(v.Value, v.Envelope);
        else
            v105 = v.Value * p103;
            v106 = v.Envelope * p103;
        end;

        table.insert(v104, NumberSequenceKeypoint.new(v.Time, v105, v106));
    end;

    return NumberSequence.new(v104);
end;

function u2.serializePath(p107: table) -- Line: 525
    local buffer_create_ret = buffer.create(#p107 * 4 * 6);
    local v108 = 0;

    for i, v in p107 do
        local Scale = v.Position.X.Scale;
        local Scale2 = v.Position.Y.Scale;

        if i ~= 1 then
            buffer.writef32(buffer_create_ret, v108, Scale + v.LeftTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v108 + 4, Scale2 + v.LeftTangent.Y.Scale);
            v108 = v108 + 8;
        end;

        buffer.writef32(buffer_create_ret, v108, Scale);
        buffer.writef32(buffer_create_ret, v108 + 4, Scale2);
        v108 = v108 + 8;

        if i ~= #p107 then
            buffer.writef32(buffer_create_ret, v108, Scale + v.RightTangent.X.Scale);
            buffer.writef32(buffer_create_ret, v108 + 4, Scale2 + v.RightTangent.Y.Scale);
            v108 = v108 + 8;
        end;
    end;

    return buffer_create_ret;
end;

function u2.deserializePath(p109) -- Line: 558
    if typeof(p109) == "string" then
        p109 = buffer.fromstring(p109) or p109;
    end;

    local v110 = buffer.len(p109) / 24;
    local v111 = {};

    for i = 0, v110 - 1 do
        local v112 = i * 4 * 6;
        local buffer_readf32_ret = buffer.readf32(p109, v112);
        local buffer_readf32_ret2 = buffer.readf32(p109, v112 + 4);
        local vector_create_ret = vector.create(buffer_readf32_ret, buffer_readf32_ret2);
        table.insert(v111, vector_create_ret);
        local v113;

        if i == v110 - 1 then
            v113 = i;
        else
            local buffer_readf32_ret3 = buffer.readf32(p109, v112 + 8);
            local buffer_readf32_ret4 = buffer.readf32(p109, v112 + 12);
            local buffer_readf32_ret5 = buffer.readf32(p109, v112 + 16);
            local buffer_readf32_ret6 = buffer.readf32(p109, v112 + 20);
            local vector_create_ret2 = vector.create(buffer_readf32_ret3, buffer_readf32_ret4);
            table.insert(v111, vector_create_ret2);
            local vector_create_ret3 = vector.create(buffer_readf32_ret5, buffer_readf32_ret6);
            table.insert(v111, vector_create_ret3);
            v113 = i;
        end;
    end;

    return v111;
end;

function u2.serializeFlipbook(p114: table) -- Line: 588
    local buffer_create_ret = buffer.create(#p114 * 8);

    for i, v in p114 do
        buffer.writef64(buffer_create_ret, (i - 1) * 8, v);
    end;

    return buffer_create_ret;
end;

function u2.deserializeFlipbook(p115) -- Line: 599
    if typeof(p115) == "string" then
        p115 = buffer.fromstring(p115) or p115;
    end;

    local v116 = {};

    for i = 0, buffer.len(p115) / 8 - 1 do
        local buffer_readf64_ret = buffer.readf64(p115, i * 8);
        table.insert(v116, buffer_readf64_ret);
        local _ = i;
    end;

    return v116;
end;

u2.default_bezier = buffer.tostring(u2.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1), UDim2.new(), UDim2.fromScale(0.215, -0.61)), Path2DControlPoint.new(UDim2.fromScale(1, 0), UDim2.fromScale(-0.645, 0), UDim2.new()) }));
u2.linear_bezier = buffer.tostring(u2.serializePath({ Path2DControlPoint.new(UDim2.fromScale(0, 1)), Path2DControlPoint.new(UDim2.fromScale(1, 0)) }));

return u2;