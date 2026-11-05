  

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("../attributes");
local u2 = require("../shape");
local u3 = require("../tween");
local u4 = require("../utility");
local u5 = require("../color/Oklab");
local u6 = require("../../obj/Bezier");
local u49 = {
    drawFuncMap = {
        Box = {
            Volume = u2.getPointWithinBox,
            Surface = u2.getPointOnBox
        },
        Cylinder = {
            Volume = function(p7, p8, p9, p10, p11) -- Line: 21, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinCylinder(p7, 0, p11, p8, p9, p10);
            end,

            Surface = function(p12, p13, p14, p15, p16) -- Line: 25, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinCylinder(p12, 1, p16, p13, p14, p15);
            end
        },
        Sphere = {
            Volume = function(p17, p18, p19, p20, p21) -- Line: 31, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinSphere(p17, 0, p21, p18, p19, p20);
            end,

            Surface = function(p22, p23, p24, p25, p26) -- Line: 35, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinSphere(p22, 1, p26, p23, p24, p25);
            end
        },
        Disc = {
            Volume = function(p27, p28, p29, p30, p31) -- Line: 41, Name: Volume
                -- upvalues: u2 (copy)
                return u2.getPointWithinDisc(p27, 0, p31, p28, p29, p30);
            end,

            Surface = function(p32, p33, p34, p35, p36) -- Line: 45, Name: Surface
                -- upvalues: u2 (copy)
                return u2.getPointWithinDisc(p32, 1, p36, p33, p34, p35);
            end
        }
    },

    getColorAtTime = function(p37, p38) -- Line: 51, Name: getColorAtTime
        local Keypoints = p37.Keypoints;

        if p38 <= Keypoints[1].Time then
            return Keypoints[1].Value;
        end;

        if Keypoints[#Keypoints].Time <= p38 then
            return Keypoints[#Keypoints].Value;
        end;

        local v39 = nil;
        local v40 = nil;

        for i = 1, #Keypoints do
            local v41 = Keypoints[i];

            if v41.Time == p38 then
                return v41.Value;
            end;

            if v41.Time < p38 then
                v39 = v41;
            elseif p38 < v41.Time then
                v40 = v41;
                break;
            end;
        end;

        if v39 and v40 then
            return v39.Value:Lerp(v40.Value, (p38 - v39.Time) / (v40.Time - v39.Time));
        end;

        return Keypoints[1].Value;
    end,

    getColorAtTimeOklab = function(p42, p43) -- Line: 85, Name: getColorAtTimeOklab
        -- upvalues: u5 (copy)
        local Keypoints = p42.Keypoints;

        if p43 <= Keypoints[1].Time then
            return Keypoints[1].Value;
        end;

        if Keypoints[#Keypoints].Time <= p43 then
            return Keypoints[#Keypoints].Value;
        end;

        local v44 = nil;
        local v45 = nil;

        for i = 1, #Keypoints do
            local v46 = Keypoints[i];

            if v46.Time == p43 then
                return v46.Value;
            end;

            if v46.Time < p43 then
                v44 = v46;
            elseif p43 < v46.Time then
                v45 = v46;
                break;
            end;
        end;

        if not (v44 and v45) then
            return Keypoints[1].Value;
        end;

        local v47 = (p43 - v44.Time) / (v45.Time - v44.Time);
        local v48 = u5.fromSRGB(v44.Value):Lerp(u5.fromSRGB(v45.Value), v47);

        return u5.toSRGB(v48);
    end
};

function u49.getColorWithEasingOklab(p50, p51, p52) -- Line: 125
    -- upvalues: u49 (copy)
    local v53 = 1 - p52:getEase((math.clamp(p51, 0, 1))).y;

    return u49.getColorAtTimeOklab(p50, (math.clamp(v53, 0, 1)));
end;

function u49.createHitboxParams(p54, p55, p56) -- Line: 138
    -- upvalues: CollectionService (copy)
    local v57 = OverlapParams.new();
    v57.MaxParts = 1;
    v57.FilterType = Enum.RaycastFilterType[p54.filterType];
    v57.CollisionGroup = p54.collisionGroup;
    v57.RespectCanCollide = not p54.ignoreCanCollide;
    v57:AddToFilter(CollectionService:GetTagged(p54.filterTag));

    if p54.filterType == "Exclude" then
        if p56 then
            p56 = p56:FindFirstAncestorOfClass("Part");
        end;

        v57:AddToFilter({ workspace.Terrain, p55, p56 });
    end;

    return v57;
end;

function u49.calculateEmissionCFrame(p58, p59, p60, p61, p62, p63, p64) -- Line: 164
    -- upvalues: u4 (copy)
    local v65;

    if p64 then
        v65 = p58 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(p60.emissionDirection)).Rotation;
    elseif p61 then
        v65 = p61(nil, p58, p59, p60.emissionDirection, p60.partial);
    else
        v65 = p58;
    end;

    local v66 = Vector3.FromNormalId(p60.emissionDirection);
    local v67 = v66:Cross(p58.LookVector);

    if v67.Magnitude < 0.001 then
        v67 = v66:Cross(p58.UpVector);
    end;

    local fromAxisAngle = CFrame.fromAxisAngle;
    local v68 = p62:NextNumber(-p60.spreadAngle.X, p60.spreadAngle.X);
    local v69 = fromAxisAngle(v66, (math.rad(v68)));
    local fromAxisAngle2 = CFrame.fromAxisAngle;
    local v70 = p62:NextNumber(-p60.spreadAngle.Y, p60.spreadAngle.Y);
    local v71 = v65 * (v69 * fromAxisAngle2(v67, (math.rad(v70))));

    if p60.face == "Inward" or p60.face == "InAndOut" and p62:NextInteger(0, 1) == 1 then
        v71 = v71 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    if p63 and (p60.mirror and (v71.Position - p63.WorldPosition).Unit:Dot(v71.RightVector) >= 0) then
        local v72 = p60.mirrorRot * u4.DEG_TO_RAD;
        v71 = v71 * CFrame.fromOrientation(v72.X, v72.Y, v72.Z);
    end;

    return v71;
end;

function u49.createBezierWithEndpoint(p73, p74, p75, p76) -- Line: 207
    -- upvalues: u6 (copy)
    if not p75 then
        return u6.new(p73);
    end;

    local v77 = {};

    for i, v in p73 do
        local v78;

        if i == #p73 - 1 then
            v78 = p76 and p76.WorldPosition or p75.WorldPosition;
        elseif i == #p73 then
            v78 = p75.WorldPosition;
        else
            v78 = p74 * (v - p73[1]);
        end;

        table.insert(v77, v78);
    end;

    return u6.new(v77);
end;

function u49.createPosGetter(u79, u80, u81, u82, u83) -- Line: 226
    return function(p84) -- Line: 233
        -- upvalues: u83 (copy), u79 (copy), u82 (copy), u81 (copy), u80 (copy)
        local v85;

        if u83 == false then
            v85 = u79:getPosition(p84);
        else
            v85 = u79:getPositionArcSpace(p84);
        end;

        if u82 then
            return v85;
        end;

        return u81 * (v85 - u80[1]);
    end;
end;

function u49.readCommonAttributes(p86) -- Line: 244
    -- upvalues: u1 (copy)
    return {
        emitDelay = u1.get(p86, "EmitDelay", 0),
        emitCount = u1.get(p86, "EmitCount", 1),
        emitDuration = u1.get(p86, "EmitDuration", 0),
        destroyDelay = u1.get(p86, "DestroyDelay", 0),
        duration = u1.getRange(p86, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        shapeType = u1.getEnum(p86, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" }),
        shapeStyle = u1.getEnum(p86, "ShapeStyle", "Volume", { "Volume", "Surface" }),
        emissionDirection = Enum.NormalId[u1.getEnum(p86, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })],
        face = u1.getEnum(p86, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" }),
        spreadAngle = u1.get(p86, "SpreadAngle", Vector3.new(0, 0, 0)),
        partial = u1.get(p86, "ShapePartial", 1),
        syncPosition = u1.get(p86, "SyncPosition", false),
        mirror = u1.get(p86, "MirrorPaths", true),
        mirrorRot = u1.get(p86, "MirrorRotation", Vector3.new(0, 0, 180)),
        projectileEnabled = u1.get(p86, "ProjectileEnabled", false),
        projectileMatchEnd = u1.get(p86, "MatchEndDirection", false),
        projectileSpeed = u1.get(p86, "ProjectileSpeed", 30),
        projectileLifetime = u1.getRange(p86, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        hitboxEnabled = u1.get(p86, "HitboxEnabled", false),
        hitboxCollisionGroup = u1.get(p86, "HitboxCollisionGroup", "Default"),
        hitboxFilterTag = u1.get(p86, "HitboxFilterTag", ""),
        hitboxFilterType = u1.get(p86, "HitboxFilterType", "Exclude"),
        hitboxIgnoreCanCollide = u1.get(p86, "HitboxIgnoreCanCollide", false),
        speedStart = u1.get(p86, "Speed_Start", 1),
        speedEnd = u1.get(p86, "Speed_End", 1)
    };
end;

function u49.getCurrentOriginCFrame(p87, p88) -- Line: 290
    if p87:IsA("BasePart") then
        return p87.CFrame;
    end;

    if p87:IsA("Attachment") then
        return p87.WorldCFrame;
    end;

    return p88;
end;

function u49.findEndAttachments(p89) -- Line: 300
    local End = p89:FindFirstChild("End");
    local v90;

    if End then
        v90 = End:FindFirstChild("T1");
    else
        v90 = End;
    end;

    if End and not End:IsA("Attachment") then
        End = nil;
    end;

    if v90 and not v90:IsA("Attachment") then
        v90 = nil;
    end;

    return End, v90;
end;

function u49.validateParent(p91) -- Line: 315
    local Parent = p91.Parent;

    if not Parent then
        return nil;
    end;

    if Parent:IsA("BasePart") then
        p91 = Parent;
    elseif Parent:IsA("Attachment") then
        p91 = Parent;
    end;

    return p91;
end;

function u49.getPerpendicularVectors(p92) -- Line: 329
    local v93 = p92:Cross(Vector3.new(0, 1, 0));

    if v93.Magnitude < 0.001 then
        v93 = p92:Cross(Vector3.new(0, 0, 1));
    end;

    local Unit = v93.Unit;

    return Unit, p92:Cross(Unit).Unit;
end;

function u49.createPropertyTween(p94, p95, p96, p97, u98, u99, u100, u101, p102) -- Line: 343
    -- upvalues: u3 (copy), u1 (copy), u4 (copy)
    if u98 == u99 then
        return;
    end;

    local fromParams = u3.fromParams;
    local v103 = u1.get(p95, p96 .. "_Curve", u4.default_bezier);
    table.insert(p94, fromParams(v103, p97, function(p104, p105) -- Line: 363
        -- upvalues: u100 (copy), u4 (ref), u98 (copy), u99 (copy), u101 (copy)
        u100(u4.lerp(u98, u99, p104));

        return p105 * u101();
    end, p102));
end;

return u49;