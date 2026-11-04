 
 

local RunService = game:GetService("RunService");
local EngineAttr = require(script.Parent.Parent.EngineAttr);
local Index = require(script.Parent.Index);
local u1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

function u1.serverOnly() -- Line: 74
    -- upvalues: RunService (copy)
    local v3 = RunService:IsServer() and not RunService:IsClient();

    return v3;
end;

function u1.ownTransparency(p4) -- Line: 78
    -- upvalues: u2 (copy)
    local v5 = u2[p4];

    if v5 then
        return v5.Transparency;
    end;

    return p4.Transparency;
end;

function u1.unhidden(p6, p7) -- Line: 86
    -- upvalues: EngineAttr (copy), u1 (copy)
    EngineAttr.writeProp(p6, "LocalTransparencyModifier", 0);
    p6.Transparency = u1.ownTransparency(p7);
end;

function u1.travels(p8) -- Line: 94
    if p8:IsA("BasePart") or p8:FindFirstChildWhichIsA("BasePart", true) then
        return false;
    end;

    if p8:IsA("JointInstance") or (p8:IsA("Constraint") or (p8:IsA("WeldConstraint") or p8:IsA("NoCollisionConstraint"))) then
        return false;
    end;

    if p8:IsA("LuaSourceContainer") or p8:IsA("ValueBase") then
        return false;
    end;

    return p8.Name ~= "PartIcleProperties" and not p8:GetAttribute("Transformed") and true or false;
end;

function u1.cracked(p9) -- Line: 112
    return (p9.strike ~= nil or p9.fixed == true) and true or p9.partStands == true;
end;

local function carryTextures(p10, p11, p12) -- Line: 123
    -- upvalues: u1 (copy)
    local cut = p11.cut;

    if not (cut and (not (p11.fixed and not p11.slash) and (p11.atFace and (cut.face.axis == "Y" and cut.face.side == 1)))) then
        return;
    end;

    local part = p11.part;
    local Position = p11.rest.Position;
    local halfExt = p11.halfExt;
    local plain = p11.plain;

    if p12 then
        part = p12.part;
        Position = (p11.rest * p12.offset).Position;
        halfExt = p12.halfExt;
        plain = p12.plain;

        if p12.offset.Position.Y + halfExt.Y < p11.halfExt.Y - 0.05 then
            return;
        end;
    end;

    if plain then
        return;
    end;

    local v13 = part.CFrame:PointToObjectSpace(Position);
    local v14 = p10:IsA("MeshPart") and Vector3.new(0, 0, 0) or halfExt;

    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("Texture") and child.Face == Enum.NormalId.Top then
            local v15 = child:Clone();
            v15.OffsetStudsU = child.OffsetStudsU + part.Size.X / 2 - (v13.X + v14.X);
            v15.OffsetStudsV = child.OffsetStudsV + part.Size.Z / 2 - (v13.Z + v14.Z);
            u1.unhidden(v15, child);
            v15.Parent = p10;
        end;
    end;
end;

local function makeShard(p16, p17) -- Line: 168
    -- upvalues: u1 (copy), carryTextures (copy)
    local part = p16.part;
    local shard = p16.shard;

    if p17 then
        part = p17.part;
        shard = p17.shard;
    end;

    local v18 = shard:Clone();
    local Color = v18.Color;

    if not p16.baked then
        if v18:IsA("PartOperation") then
            v18.UsePartColor = true;
        end;

        Color = part.Color;
    end;

    if p16.fixed and not p16.slash then
        Color = Color3.new(Color.R * 0.6, Color.G * 0.6, Color.B * 0.6);
    end;

    v18.Color = Color;
    local v19 = part:IsA("MeshPart") and v18:IsA("MeshPart") and part:FindFirstChildWhichIsA("SurfaceAppearance");
    local skin = p16.skin;

    if p17 then
        skin = p17.skin;
    end;

    if v19 and not skin then
        v19:Clone().Parent = v18;
    end;

    v18.Material = part.Material;
    v18.MaterialVariant = part.MaterialVariant;
    v18.Transparency = u1.ownTransparency(part);
    v18.Reflectance = part.Reflectance;
    v18.Archivable = false;
    v18.Anchored = true;
    v18.CanCollide = false;
    v18.CanQuery = false;
    v18.CanTouch = false;
    v18.Locked = true;
    v18:SetAttribute("_PartIcleEmit", true);
    carryTextures(v18, p16, p17);

    return v18;
end;

local function makeStandIn(p20) -- Line: 217
    -- upvalues: makeShard (copy), u1 (copy), Index (copy)
    if p20.shard then
        return makeShard(p20);
    end;

    local part = p20.part;
    local Instance_fromExisting_ret = Instance.fromExisting(part);
    Instance_fromExisting_ret.Transparency = u1.ownTransparency(part);
    Instance_fromExisting_ret.Archivable = false;
    Instance_fromExisting_ret.Anchored = true;
    Instance_fromExisting_ret.CanCollide = false;
    Instance_fromExisting_ret.CanQuery = false;
    Instance_fromExisting_ret.CanTouch = false;
    Instance_fromExisting_ret.Locked = true;
    Index.unmark(Instance_fromExisting_ret);
    Instance_fromExisting_ret:SetAttribute("_PartIcleEmit", true);

    if p20.blockSize then
        Instance_fromExisting_ret.Size = p20.blockSize;

        return Instance_fromExisting_ret;
    end;

    for _, child in ipairs(part:GetChildren()) do
        if u1.travels(child) then
            local v21 = child:Clone();

            if v21 then
                if v21:IsA("Decal") then
                    u1.unhidden(v21, child);
                end;

                v21.Parent = Instance_fromExisting_ret;
            end;
        end;
    end;

    return Instance_fromExisting_ret;
end;

local function setLocalHidden(p22, p23) -- Line: 254
    -- upvalues: EngineAttr (copy)
    local v24 = p23 and 1 or 0;
    EngineAttr.writeProp(p22, "LocalTransparencyModifier", v24);

    for _, child in ipairs(p22:GetChildren()) do
        if child:IsA("Decal") then
            EngineAttr.writeProp(child, "LocalTransparencyModifier", v24);
        end;
    end;
end;

function u1.hide(p25, p26, p27) -- Line: 271
    -- upvalues: setLocalHidden (copy), u2 (copy), EngineAttr (copy)
    if not p26 then
        setLocalHidden(p25, true);

        return true;
    end;

    local v28 = u2[p25];

    if not v28 then
        v28 = {
            Transparency = p25.Transparency,
            CanCollide = p25.CanCollide,
            CanQuery = p25.CanQuery,
            decals = {}
        };
        u2[p25] = v28;
        EngineAttr.writeProp(p25, "Transparency", 1);

        for _, child in ipairs(p25:GetChildren()) do
            if child:IsA("Decal") then
                table.insert(v28.decals, child);
                u2[child] = {
                    Transparency = child.Transparency
                };
                EngineAttr.writeProp(child, "Transparency", 1);
            end;
        end;
    end;

    if p27 then
        return v28;
    end;

    EngineAttr.writeProp(p25, "CanCollide", false);
    EngineAttr.writeProp(p25, "CanQuery", false);

    return v28;
end;

function u1.show(p29, p30, p31) -- Line: 299
    -- upvalues: setLocalHidden (copy), u2 (copy), EngineAttr (copy)
    if not p30 then
        if p29.Parent then
            setLocalHidden(p29, false);
        end;

        return;
    end;

    u2[p29] = nil;

    for _, v in ipairs(p31.decals) do
        local v32 = u2[v];
        u2[v] = nil;

        if v32 then
            EngineAttr.writeProp(v, "Transparency", v32.Transparency);
        end;
    end;

    EngineAttr.writeProp(p29, "Transparency", p31.Transparency);
    EngineAttr.writeProp(p29, "CanCollide", p31.CanCollide);
    EngineAttr.writeProp(p29, "CanQuery", p31.CanQuery);
end;

function u1.quiet(p33) -- Line: 321
    for _, descendant in ipairs(p33:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or (descendant:IsA("Light") or descendant:IsA("Highlight")))) then
            descendant.Enabled = false;
        end;
    end;
end;

function u1.unhide(p34) -- Line: 333
    -- upvalues: setLocalHidden (copy)
    setLocalHidden(p34, false);
end;

function u1.new(u35, u36, u37, u38) -- Line: 340
    -- upvalues: u1 (copy), makeShard (copy), makeStandIn (copy)
    local u39 = {};
    local u40 = nil;
    local u41 = {};
    local u42 = {};
    local u43 = {};
    local u44 = {};
    local u45 = 0;
    local u46 = {};
    local u47 = nil;

    local function hideOriginal(p48, p49) -- Line: 359
        -- upvalues: u38 (copy), u43 (copy), u1 (ref), u37 (copy)
        if u38 or u43[p48] then
            return;
        end;

        u43[p48] = u1.hide(p48, u37, p49);
    end;

    local function showOriginal(p50) -- Line: 366
        -- upvalues: u43 (copy), u1 (ref), u37 (copy)
        local v51 = u43[p50];

        if not v51 then
            return;
        end;

        u43[p50] = nil;
        u1.show(p50, u37, v51);
    end;

    local function place(p52) -- Line: 375
        -- upvalues: u35 (copy), u47 (ref), u39 (copy), u42 (copy), u40 (ref), makeShard (ref), u36 (copy), makeStandIn (ref)
        local v53 = u35[p52];

        if v53.own then
            if v53.standOffset then
                u47 = u47 or {};
            end;

            u39[p52] = v53.part;
            u42[p52] = nil;

            return 1;
        end;

        local layered = v53.layered;

        if layered then
            u40 = u40 or {};
            local table_create_ret = table.create(#layered - 1);

            for i, v in ipairs(layered) do
                local v54 = makeShard(v53, v);
                v54.CFrame = v53.rest * v.standOffset;
                v54.Parent = u36;

                if i == 1 then
                    u39[p52] = v54;
                else
                    table_create_ret[i - 1] = v54;
                end;
            end;

            u40[p52] = table_create_ret;
            u42[p52] = nil;

            return #layered;
        end;

        local v55 = makeStandIn(v53);

        if v53.standOffset then
            u47 = u47 or {};
            v55.CFrame = v53.rest * v53.standOffset;
        else
            v55.CFrame = v53.rest;
        end;

        v55.Parent = u36;
        u39[p52] = v55;
        u42[p52] = nil;

        return 1;
    end;

    local function dropExtras(p56) -- Line: 418
        -- upvalues: u40 (ref)
        local v57 = u40 and u40[p56];

        if v57 then
            for _, v in ipairs(v57) do
                v:Destroy();
            end;

            u40[p56] = nil;
        end;
    end;

    function u46.wake(p58) -- Line: 429
        -- upvalues: u35 (copy), u39 (copy), u42 (copy), place (copy), u1 (ref), u38 (copy), u43 (copy), u37 (copy)
        local v59 = u35[p58];
        local v60 = 0;

        if v59.siblings then
            for _, v in ipairs(v59.siblings) do
                if not (u39[v] or v ~= p58 and u42[v]) then
                    v60 = v60 + place(v);
                end;
            end;
        elseif not u39[p58] then
            v60 = place(p58);
        end;

        if not v59.own then
            local part = v59.part;
            local v61 = u1.cracked(v59);

            if not u38 then
                if u43[part] then
                    return v60;
                end;

                u43[part] = u1.hide(part, u37, v61);
            end;
        end;

        return v60;
    end;

    function u46.move(p62, p63, p64) -- Line: 449
        -- upvalues: u40 (ref), u35 (copy), u44 (copy), u39 (copy), u41 (copy), u45 (ref), u47 (ref)
        if u40 then
            local v65 = 0;

            for i = 1, p64 do
                local v66 = p62[i];
                local v67 = u35[v66];
                local v68 = p63[i];
                v65 = v65 + 1;
                u44[v65] = u39[v66];

                if v67.standOffset then
                    u41[v65] = v68 * v67.standOffset;
                else
                    u41[v65] = v68;
                end;

                local v69 = u40[v66];
                local v70;

                if v69 then
                    local layered = v67.layered;
                    v70 = i;

                    for i2 = 1, #v69 do
                        v65 = v65 + 1;
                        u44[v65] = v69[i2];
                        u41[v65] = v68 * layered[i2 + 1].standOffset;
                        local _ = i2;
                    end;
                else
                    v70 = i;
                end;
            end;

            for i = v65 + 1, u45 do
                u44[i] = nil;
                u41[i] = nil;
                local _ = i;
            end;

            u45 = v65;
            workspace:BulkMoveTo(u44, u41, Enum.BulkMoveMode.FireCFrameChanged);

            return;
        end;

        for i = 1, p64 do
            u44[i] = u39[p62[i]];
            local _ = i;
        end;

        for i = p64 + 1, u45 do
            u44[i] = nil;
            local _ = i;
        end;

        if u47 then
            for i = 1, p64 do
                local standOffset = u35[p62[i]].standOffset;
                local v71;

                if standOffset then
                    u47[i] = p63[i] * standOffset;
                    v71 = i;
                else
                    u47[i] = p63[i];
                    v71 = i;
                end;
            end;

            for i = p64 + 1, u45 do
                u47[i] = nil;
                local _ = i;
            end;

            p63 = u47;
        end;

        u45 = p64;
        workspace:BulkMoveTo(u44, p63, Enum.BulkMoveMode.FireCFrameChanged);
    end;

    function u46.drop(p72) -- Line: 506
        -- upvalues: u39 (copy), u35 (copy), u1 (ref), u37 (copy), u40 (ref), u42 (copy)
        local v73 = u39[p72];

        if v73 then
            if u35[p72].own then
                u1.hide(v73, u37, false);
                u1.quiet(v73);
            else
                v73:Destroy();
            end;

            local v74 = u40 and u40[p72];

            if v74 then
                for _, v in ipairs(v74) do
                    v:Destroy();
                end;

                u40[p72] = nil;
            end;

            u39[p72] = nil;
            u42[p72] = true;
        end;
    end;

    function u46.restore(p75) -- Line: 523
        -- upvalues: u35 (copy), u39 (copy), u42 (copy), u46 (copy), u43 (copy), u1 (ref), u37 (copy)
        local v76 = u35[p75];

        if v76.own then
            u39[p75] = nil;
            u42[p75] = nil;

            return;
        end;

        if v76.siblings then
            for _, v in ipairs(v76.siblings) do
                u46.drop(v);
                u42[v] = nil;
            end;
        else
            u46.drop(p75);
            u42[p75] = nil;
        end;

        local part = v76.part;
        local v77 = u43[part];

        if not v77 then
            return;
        end;

        u43[part] = nil;
        u1.show(part, u37, v77);
    end;

    function u46.clear() -- Line: 542
        -- upvalues: u39 (copy), u35 (copy), u40 (ref), u43 (copy), u1 (ref), u37 (copy)
        for i, v in pairs(u39) do
            if not u35[i].own then
                v:Destroy();
            end;

            local v78 = u40 and u40[i];
            local v79;

            if v78 then
                v79 = i;

                for _, v2 in ipairs(v78) do
                    v2:Destroy();
                end;

                u40[v79] = nil;
            else
                v79 = i;
            end;

            u39[v79] = nil;
        end;

        for i in pairs(table.clone(u43)) do
            local v80 = u43[i];

            if v80 then
                u43[i] = nil;
                u1.show(i, u37, v80);
            end;
        end;
    end;

    function u46.original(p81) -- Line: 556
        -- upvalues: u35 (copy)
        return u35[p81].part;
    end;

    return u46;
end;

return u1;