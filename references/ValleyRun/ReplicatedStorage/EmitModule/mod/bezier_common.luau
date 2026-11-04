 

 

local CollectionService = game:GetService("CollectionService");
local u1 = require("./shape");
local u2 = require("./tween");
local u3 = require("./utility");
local u4 = require("./color/Oklab");
local u5 = require("../obj/Bezier");
local u50 = {
    drawFuncMap = {
        Box = {
            Volume = u1.getPointWithinBox,
            Surface = u1.getPointOnBox
        },
        Cylinder = {
            Volume = function(p6, p7, p8, p9, p10) -- Line: 20, Name: Volume
                -- upvalues: u1 (copy)
                return u1.getPointWithinCylinder(p6, 0, p10, p7, p8, p9);
            end,

            Surface = function(p11, p12, p13, p14, p15) -- Line: 24, Name: Surface
                -- upvalues: u1 (copy)
                return u1.getPointWithinCylinder(p11, 1, p15, p12, p13, p14);
            end
        },
        Sphere = {
            Volume = function(p16, p17, p18, p19, p20) -- Line: 30, Name: Volume
                -- upvalues: u1 (copy)
                return u1.getPointWithinSphere(p16, 0, p20, p17, p18, p19);
            end,

            Surface = function(p21, p22, p23, p24, p25) -- Line: 34, Name: Surface
                -- upvalues: u1 (copy)
                return u1.getPointWithinSphere(p21, 1, p25, p22, p23, p24);
            end
        },
        Disc = {
            Volume = function(p26, p27, p28, p29, p30) -- Line: 40, Name: Volume
                -- upvalues: u1 (copy)
                return u1.getPointWithinDisc(p26, 0, p30, p27, p28, p29);
            end,

            Surface = function(p31, p32, p33, p34, p35) -- Line: 44, Name: Surface
                -- upvalues: u1 (copy)
                return u1.getPointWithinDisc(p31, 1, p35, p32, p33, p34);
            end
        }
    },

    getColorAtTime = function(p36: userdata, p37: number) -- Line: 50, Name: getColorAtTime
        local Keypoints = p36.Keypoints;

        if p37 <= Keypoints[1].Time then
            return Keypoints[1].Value;
        end;

        if Keypoints[#Keypoints].Time <= p37 then
            return Keypoints[#Keypoints].Value;
        end;

        local v38 = nil;
        local v39 = nil;

        for i = 1, #Keypoints do
            local v40 = Keypoints[i];

            if v40.Time == p37 then
                return v40.Value;
            end;

            local v41;

            if v40.Time < p37 then
                v38 = v40;
                v41 = i;
            else
                if p37 < v40.Time then
                    v39 = v40;
                    break;
                end;

                v41 = i;
            end;
        end;

        if v38 and v39 then
            return v38.Value:Lerp(v39.Value, (p37 - v38.Time) / (v39.Time - v38.Time));
        end;

        return Keypoints[1].Value;
    end,

    getColorAtTimeOklab = function(p42: userdata, p43: number) -- Line: 84, Name: getColorAtTimeOklab
        -- upvalues: u4 (copy)
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

            local v47;

            if v46.Time < p43 then
                v44 = v46;
                v47 = i;
            else
                if p43 < v46.Time then
                    v45 = v46;
                    break;
                end;

                v47 = i;
            end;
        end;

        if not (v44 and v45) then
            return Keypoints[1].Value;
        end;

        local v48 = (p43 - v44.Time) / (v45.Time - v44.Time);
        local v49 = u4.fromSRGB(v44.Value):Lerp(u4.fromSRGB(v45.Value), v48);

        return u4.toSRGB(v49);
    end
};

function u50.getColorWithEasingOklab(p51: userdata, p52: number, p53: any) -- Line: 124
    -- upvalues: u50 (copy)
    local v54 = 1 - p53:getEase((math.clamp(p52, 0, 1))).y;

    return u50.getColorAtTimeOklab(p51, (math.clamp(v54, 0, 1)));
end;

function u50.createHitboxParams(p55: table, p56: userdata, p57: userdata?) -- Line: 137
    -- upvalues: CollectionService (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.MaxParts = 1;
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType[p55.filterType];
    OverlapParams_new_ret.CollisionGroup = p55.collisionGroup;
    OverlapParams_new_ret.RespectCanCollide = not p55.ignoreCanCollide;
    OverlapParams_new_ret:AddToFilter(CollectionService:GetTagged(p55.filterTag));

    if p55.filterType == "Exclude" then
        if p57 then
            p57 = p57:FindFirstAncestorOfClass("Part");
        end;

        OverlapParams_new_ret:AddToFilter({ workspace.Terrain, p56, p57 });
    end;

    return OverlapParams_new_ret;
end;

function u50.calculateEmissionCFrame(p58, p59: vector, p60: table, p61: function?, p62: userdata, p63: userdata?, p64: boolean) -- Line: 163
    -- upvalues: u3 (copy)
    local v65;

    if p64 then
        v65 = p58 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(p60.emissionDirection)).Rotation;
    elseif p61 then
        v65 = p61(nil, p58, p59, p60.emissionDirection, p60.partial);
    else
        v65 = p58;
    end;

    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p60.emissionDirection);
    local v66 = Vector3_FromNormalId_ret:Cross(p58.LookVector);

    if v66.Magnitude < 0.001 then
        v66 = Vector3_FromNormalId_ret:Cross(p58.UpVector);
    end;

    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
    local v67 = p62:NextNumber(-p60.spreadAngle.X, p60.spreadAngle.X);
    local v68 = CFrame_fromAxisAngle(Vector3_FromNormalId_ret, (math.rad(v67)));
    local CFrame_fromAxisAngle2 = CFrame.fromAxisAngle;
    local v69 = p62:NextNumber(-p60.spreadAngle.Y, p60.spreadAngle.Y);
    local v70 = v65 * (v68 * CFrame_fromAxisAngle2(v66, (math.rad(v69))));

    if p60.face == "Inward" or p60.face == "InAndOut" and p62:NextInteger(0, 1) == 1 then
        v70 = v70 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    if p63 and (p60.mirror and (v70.Position - p63.WorldPosition).Unit:Dot(v70.RightVector) >= 0) then
        local v71 = p60.mirrorRot * u3.DEG_TO_RAD;
        v70 = v70 * CFrame.fromOrientation(v71.X, v71.Y, v71.Z);
    end;

    return v70;
end;

function u50.createBezierWithEndpoint(p72: table, p73, p74: userdata?, p75: userdata?) -- Line: 206
    -- upvalues: u5 (copy)
    if not p74 then
        return u5.new(p72);
    end;

    local v76 = {};

    for i, v in p72 do
        local v77;

        if i == #p72 - 1 then
            v77 = p75 and p75.WorldPosition or p74.WorldPosition;
        elseif i == #p72 then
            v77 = p74.WorldPosition;
        else
            v77 = p73 * (v - p72[1]);
        end;

        table.insert(v76, v77);
    end;

    return u5.new(v76);
end;

function u50.createPosGetter(u78: any, u79: table, u80, u81: userdata?, u82: boolean?) -- Line: 230
    return function(p83: number) -- Line: 237
        -- upvalues: u82 (copy), u78 (copy), u81 (copy), u80 (copy), u79 (copy)
        local v84;

        if u82 == false then
            v84 = u78:getPosition(p83);
        else
            v84 = u78:getPositionArcSpace(p83);
        end;

        if u81 then
            return v84;
        end;

        return u80 * (v84 - u79[1]);
    end;
end;

function u50.readCommonAttributes(p85: userdata) -- Line: 248
    -- upvalues: u3 (copy)
    return {
        emitDelay = u3.getAttribute(p85, "EmitDelay", 0),
        emitCount = u3.getAttribute(p85, "EmitCount", 1),
        emitDuration = u3.getAttribute(p85, "EmitDuration", 0),
        destroyDelay = u3.getAttribute(p85, "DestroyDelay", 0),
        duration = u3.getRangeAttribute(p85, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        shapeType = u3.getEnumAttribute(p85, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" }),
        shapeStyle = u3.getEnumAttribute(p85, "ShapeStyle", "Volume", { "Volume", "Surface" }),
        emissionDirection = Enum.NormalId[u3.getEnumAttribute(p85, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })],
        face = u3.getEnumAttribute(p85, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" }),
        spreadAngle = u3.getAttribute(p85, "SpreadAngle", Vector3.new(0, 0, 0)),
        partial = u3.getAttribute(p85, "ShapePartial", 1),
        syncPosition = u3.getAttribute(p85, "SyncPosition", false),
        mirror = u3.getAttribute(p85, "MirrorPaths", true),
        mirrorRot = u3.getAttribute(p85, "MirrorRotation", Vector3.new(0, 0, 180)),
        projectileEnabled = u3.getAttribute(p85, "ProjectileEnabled", false),
        projectileMatchEnd = u3.getAttribute(p85, "MatchEndDirection", false),
        projectileSpeed = u3.getAttribute(p85, "ProjectileSpeed", 30),
        projectileLifetime = u3.getRangeAttribute(p85, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        hitboxEnabled = u3.getAttribute(p85, "HitboxEnabled", false),
        hitboxCollisionGroup = u3.getAttribute(p85, "HitboxCollisionGroup", "Default"),
        hitboxFilterTag = u3.getAttribute(p85, "HitboxFilterTag", ""),
        hitboxFilterType = u3.getAttribute(p85, "HitboxFilterType", "Exclude"),
        hitboxIgnoreCanCollide = u3.getAttribute(p85, "HitboxIgnoreCanCollide", false),
        speedStart = u3.getAttribute(p85, "Speed_Start", 1),
        speedEnd = u3.getAttribute(p85, "Speed_End", 1)
    };
end;

function u50.getCurrentOriginCFrame(p86: userdata, p87) -- Line: 299
    if p86:IsA("BasePart") then
        return p86.CFrame;
    end;

    if p86:IsA("Attachment") then
        return p86.WorldCFrame;
    end;

    return p87;
end;

function u50.findEndAttachments(p88: userdata) -- Line: 309
    local End = p88:FindFirstChild("End");
    local v89;

    if End then
        v89 = End:FindFirstChild("T1");
    else
        v89 = End;
    end;

    if End and not End:IsA("Attachment") then
        End = nil;
    end;

    if v89 and not v89:IsA("Attachment") then
        v89 = nil;
    end;

    return End, v89;
end;

function u50.validateParent(p90: userdata) -- Line: 324
    local Parent = p90.Parent;

    if not Parent then
        return nil;
    end;

    if Parent:IsA("BasePart") then
        p90 = Parent;
    elseif Parent:IsA("Attachment") then
        p90 = Parent;
    end;

    return p90;
end;

function u50.getPerpendicularVectors(p91: vector) -- Line: 338
    local v92 = p91:Cross(Vector3.new(0, 1, 0));

    if v92.Magnitude < 0.001 then
        v92 = p91:Cross(Vector3.new(0, 0, 1));
    end;

    local Unit = v92.Unit;

    return Unit, p91:Cross(Unit).Unit;
end;

function u50.createPropertyTween(p93: any, p94: userdata, p95: string, p96: number, u97: number, u98: number, u99: function, u100: function, p101: any) -- Line: 352
    -- upvalues: u2 (copy), u3 (copy)
    if u97 == u98 then
        return;
    end;

    local fromParams = u2.fromParams;
    local Attribute = u3.getAttribute(p94, p95 .. "_Curve", u3.default_bezier);
    table.insert(p93, fromParams(Attribute, p96, function(p102, p103) -- Line: 372
        -- upvalues: u99 (copy), u3 (ref), u97 (copy), u98 (copy), u100 (copy)
        u99(u3.lerp(u97, u98, p102));

        return p103 * u100();
    end, p101));
end;

return u50;