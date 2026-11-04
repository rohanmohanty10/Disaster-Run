  

local HttpService = game:GetService("HttpService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("./mod/tween");
local u2 = require("./mod/shape");
local u3 = require("./mod/utility");
local u4 = require("./obj/Bezier");
require("./obj/ObjectCache");
local Promise = require(script.Parent.obj.Promise);
local u35 = {
    Box = {
        Volume = u2.getPointWithinBox,
        Surface = u2.getPointOnBox
    },
    Cylinder = {
        Volume = function(p5, p6, p7, p8, p9) -- Line: 20, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinCylinder(p5, 0, p9, p6, p7, p8);
        end,

        Surface = function(p10, p11, p12, p13, p14) -- Line: 24, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinCylinder(p10, 1, p14, p11, p12, p13);
        end
    },
    Sphere = {
        Volume = function(p15, p16, p17, p18, p19) -- Line: 30, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinSphere(p15, 0, p19, p16, p17, p18);
        end,

        Surface = function(p20, p21, p22, p23, p24) -- Line: 34, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinSphere(p20, 1, p24, p21, p22, p23);
        end
    },
    Disc = {
        Volume = function(p25, p26, p27, p28, p29) -- Line: 40, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinDisc(p25, 0, p29, p26, p27, p28);
        end,

        Surface = function(p30, p31, p32, p33, p34) -- Line: 44, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinDisc(p30, 1, p34, p31, p32, p33);
        end
    }
};
local v36 = {};
local u37 = nil;

function v36.init(p38) -- Line: 54
    -- upvalues: u37 (ref)
    u37 = p38;
end;

function v36.deinit() -- Line: 58
    -- upvalues: u37 (ref)
    u37 = nil;
end;

function v36.emit(u39: userdata, u40: userdata, u41: any, p42: boolean?) -- Line: 62
    -- upvalues: u37 (ref), u3 (copy), u35 (copy), u1 (copy), u4 (copy), CollectionService (copy), Promise (copy), HttpService (copy)
    local Points = u39:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u37)) then
        return;
    end;

    local Attribute = u3.getAttribute(u39, "EmitDelay", 0);
    local Attribute2 = u3.getAttribute(u39, "EmitCount", 1);
    local Attribute3 = u3.getAttribute(u39, "EmitDuration", 0);
    local Attribute4 = u3.getAttribute(u39, "DestroyDelay", 0);
    local RangeAttribute = u3.getRangeAttribute(u39, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));
    local EnumAttribute = u3.getEnumAttribute(u39, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" });
    local Attribute5 = u3.getAttribute(u39, "SpreadAngle", Vector3.new(0, 0, 0));
    local Attribute6 = u3.getAttribute(u39, "SyncPosition", false);
    local Attribute7 = u3.getAttribute(u39, "MirrorPaths", true);
    local Attribute8 = u3.getAttribute(u39, "MirrorRotation", Vector3.new(0, 0, 180));
    local Attribute9 = u3.getAttribute(u39, "FacePath", false);
    local Attribute10 = u3.getAttribute(u39, "ArcSpace", false);
    local Attribute11 = u3.getAttribute(u39, "ShapePartial", 1);
    local EnumAttribute2 = u3.getEnumAttribute(u39, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" });
    local EnumAttribute3 = u3.getEnumAttribute(u39, "ShapeStyle", "Volume", { "Volume", "Surface" });
    local u43 = Enum.NormalId[u3.getEnumAttribute(u39, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })];
    local Attribute12 = u3.getAttribute(u39, "ProjectileEnabled", false);
    local Attribute13 = u3.getAttribute(u39, "MatchEndDirection", false);
    local Attribute14 = u3.getAttribute(u39, "ProjectileSpeed", 30);
    local RangeAttribute2 = u3.getRangeAttribute(u39, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));
    local Attribute15 = u3.getAttribute(u39, "HitboxEnabled", false);
    local Attribute16 = u3.getAttribute(u39, "HitboxCollisionGroup", "Default");
    local Attribute17 = u3.getAttribute(u39, "HitboxFilterTag", "");
    local Attribute18 = u3.getAttribute(u39, "HitboxFilterType", "Exclude");
    local Attribute19 = u3.getAttribute(u39, "HitboxIgnoreCanCollide", false);
    local RangeAttribute3 = u3.getRangeAttribute(u39, "RotSpeed_Start", NumberRange.new(0, 0));
    local RangeAttribute4 = u3.getRangeAttribute(u39, "RotSpeed_End", NumberRange.new(0, 0));
    local Attribute20 = u3.getAttribute(u39, "MinInitRot", Vector3.new(0, 0, 0));
    local Attribute21 = u3.getAttribute(u39, "MaxInitRot", Vector3.new(0, 0, 0));
    local Attribute22 = u3.getAttribute(u39, "Speed_Start", 1);
    local Attribute23 = u3.getAttribute(u39, "Speed_End", 1);
    local u44 = u35[EnumAttribute2] and u35[EnumAttribute2][EnumAttribute3];

    if not u44 then
        return;
    end;

    local u45 = {};
    task.wait(Attribute);

    if not (Attribute3 > 0) or p42 then
        if Attribute2 > 0 then
            local u46 = nil;
            local u47 = nil;
            local Parent = u39.Parent;

            if not Parent then
                return;
            end;

            if not (Parent:IsA("BasePart") or Parent:IsA("Attachment")) then
                Parent = u39;
            end;

            if Parent:IsA("BasePart") then
                u46 = Parent.Size;
                u47 = Parent.CFrame;
            elseif Parent:IsA("Attachment") then
                u47 = Parent.WorldCFrame;
                u46 = Vector3.new(0, 0, 0);
            end;

            if not u47 then
                return;
            end;

            local End = u39:FindFirstChild("End");
            End = End;
            local u48;

            if End then
                u48 = End:FindFirstChild("T1");
            end;

            if End and not End:IsA("Attachment") then
                End = nil;
            end;

            if u48 and not u48:IsA("Attachment") then
                u48 = nil;
            end;

            local BezierPoints = u3.getBezierPoints(Points);
            local Random_new_ret = Random.new();
            local u49 = not End and u4.new(BezierPoints);
            local OverlapParams_new_ret = OverlapParams.new();
            OverlapParams_new_ret.MaxParts = 1;
            OverlapParams_new_ret.FilterType = Enum.RaycastFilterType[Attribute18];
            OverlapParams_new_ret.CollisionGroup = Attribute16;
            OverlapParams_new_ret.RespectCanCollide = not Attribute19;
            OverlapParams_new_ret:AddToFilter(CollectionService:GetTagged(Attribute17));

            if Attribute18 == "Exclude" then
                OverlapParams_new_ret:AddToFilter({ workspace.Terrain, Parent, Points:FindFirstAncestorOfClass("Part") });
            end;

            for i = 1, Attribute2 do
                local u50 = Random_new_ret:NextNumber(RangeAttribute3.Min, RangeAttribute3.Max);
                local u51 = Random_new_ret:NextNumber(RangeAttribute4.Min, RangeAttribute4.Max);
                local v52 = Random_new_ret:NextNumber(Attribute20.x, Attribute21.x);
                local v53 = Random_new_ret:NextNumber(Attribute20.y, Attribute21.y);
                local vector_create_ret = vector.create(v52, v53, Random_new_ret:NextNumber(Attribute20.z, Attribute21.z));
                local u54 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
                local u55;

                if Attribute12 then
                    u55 = Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max);
                else
                    u55 = Attribute12;
                end;

                table.insert(u45, Promise.new(function(u56) -- Line: 232
                    -- upvalues: Parent (ref), u47 (ref), u43 (copy), u44 (copy), u46 (ref), Attribute11 (copy), Random_new_ret (copy), Attribute5 (copy), EnumAttribute (copy), End (ref), Attribute7 (copy), Attribute8 (copy), u3 (ref), u49 (copy), BezierPoints (copy), u48 (ref), u4 (ref), Attribute10 (copy), HttpService (ref), u37 (ref), u40 (copy), u45 (copy), u41 (copy), Attribute15 (copy), OverlapParams_new_ret (copy), Attribute22 (copy), u50 (copy), vector_create_ret (copy), Attribute23 (copy), u39 (copy), u1 (ref), u51 (copy), u54 (copy), Attribute9 (copy), Attribute6 (copy), Attribute12 (copy), u55 (copy), Attribute13 (copy), Attribute14 (copy)
                    local v57;

                    if Parent:IsA("Attachment") then
                        v57 = u47 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(u43)).Rotation;
                    else
                        v57 = u44(nil, u47, u46, u43, Attribute11);
                    end;

                    local Vector3_FromNormalId_ret = Vector3.FromNormalId(u43);
                    local v58 = Vector3_FromNormalId_ret:Cross(u47.LookVector);

                    if v58.Magnitude < 0.001 then
                        v58 = Vector3_FromNormalId_ret:Cross(u47.UpVector);
                    end;

                    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
                    local v59 = Random_new_ret:NextNumber(-Attribute5.x, Attribute5.x);
                    local v60 = CFrame_fromAxisAngle(Vector3_FromNormalId_ret, (math.rad(v59)));
                    local CFrame_fromAxisAngle2 = CFrame.fromAxisAngle;
                    local v61 = Random_new_ret:NextNumber(-Attribute5.y, Attribute5.y);
                    local u62 = v57 * (v60 * CFrame_fromAxisAngle2(v58, (math.rad(v61))));

                    if EnumAttribute == "Inward" or EnumAttribute == "InAndOut" and Random_new_ret:NextInteger(0, 1) == 1 then
                        u62 = u62 * CFrame.fromOrientation(0, 3.141592653589793, 0);
                    end;

                    if End and (Attribute7 and (u62.Position - End.WorldPosition).Unit:Dot(u62.RightVector) >= 0) then
                        local v63 = Attribute8 * u3.DEG_TO_RAD;
                        u62 = u62 * CFrame.fromOrientation(v63.x, v63.y, v63.z);
                    end;

                    local u64 = u49;

                    if End then
                        local v65 = {};

                        for i2, v in BezierPoints do
                            local v66;

                            if i2 == #BezierPoints - 1 then
                                v66 = u48 and u48.WorldPosition or End.WorldPosition;
                            elseif i2 == #BezierPoints then
                                v66 = End.WorldPosition;
                            else
                                v66 = u62 * (v - BezierPoints[1]);
                            end;

                            table.insert(v65, v66);
                        end;

                        u64 = u4.new(v65);
                    end;

                    local function getPos(p67: number) -- Line: 276
                        -- upvalues: Attribute10 (ref), u64 (ref), End (ref), u62 (ref), BezierPoints (ref)
                        local v68 = Attribute10 and u64:getPositionArcSpace(p67) or u64:getPosition(p67);

                        if End then
                            return v68;
                        end;

                        return u62 * (v68 - BezierPoints[1]);
                    end;

                    local u69 = HttpService:GenerateGUID(false);

                    if not u37 then
                        u56();

                        return;
                    end;

                    local u70 = u37:get(u69);
                    local CFrame_new = CFrame.new;
                    local v71 = Attribute10 and u64:getPositionArcSpace(0) or u64:getPosition(0);

                    if not End then
                        v71 = u62 * (v71 - BezierPoints[1]);
                    end;

                    u70.CFrame = CFrame_new(v71);
                    local u72 = u70._getReal();
                    u3.copyProperties(u40, u72, u3.COPY_PART_PROPERTIES);
                    u3.copyProperties(u40, u72, u3.COPY_EXTENDED_PART_PROPERTIES);
                    local v73 = u40:Clone();

                    for _, child in v73:GetChildren() do
                        child.Parent = u72;
                    end;

                    v73:Destroy();
                    local EmitOnFinish = u72:FindFirstChild("EmitOnFinish");

                    if EmitOnFinish then
                        EmitOnFinish.Parent = nil;
                    end;

                    if shared.vfx and #u72:GetChildren() ~= 0 then
                        local Finished = shared.vfx.emit(u72).Finished;
                        table.insert(u45, Finished);
                    end;

                    table.insert(u41, function() -- Line: 322
                        -- upvalues: u37 (ref), u69 (copy)
                        if u37 then
                            u37:free(u69);
                        end;
                    end);
                    local u74 = Vector3.new(0, 0, 0);
                    local u75 = Vector3.new(0, 0, 0);
                    local u76 = false;

                    local function onFinish() -- Line: 333
                        -- upvalues: u76 (ref), EmitOnFinish (copy), u72 (copy), u56 (copy)
                        if u76 then
                            return;
                        end;

                        u76 = true;
                        local v77 = EmitOnFinish and EmitOnFinish:GetChildren();

                        if not v77 or #v77 == 0 then
                            u56();

                            return;
                        end;

                        for _, v in v77 do
                            v.Parent = u72;
                        end;

                        shared.vfx.emit(table.unpack(v77)).Finished:finally(function() -- Line: 349
                            -- upvalues: u56 (ref)
                            u56();
                        end);
                    end;

                    local function shapecast() -- Line: 357
                        -- upvalues: Attribute15 (ref), u72 (copy), OverlapParams_new_ret (ref)
                        if Attribute15 then
                            return workspace:GetPartsInPart(u72, OverlapParams_new_ret)[1] and true or false;
                        end;
                    end;

                    local function getOriginCFrame() -- Line: 371
                        -- upvalues: u47 (ref), Parent (ref)
                        local v78 = u47;

                        if Parent:IsA("BasePart") then
                            return Parent.CFrame;
                        end;

                        if Parent:IsA("Attachment") then
                            v78 = Parent.WorldCFrame;
                        end;

                        return v78;
                    end;

                    local u79 = false;
                    local CFrame_identity = CFrame.identity;
                    local u80 = Attribute22;
                    local u81 = u50;
                    local CFrame_fromOrientation_ret = CFrame.fromOrientation(vector_create_ret.x, vector_create_ret.y, vector_create_ret.z);
                    local u82;

                    if Attribute22 == Attribute23 or u39:GetAttribute("SpeedOverride") then
                        u82 = nil;
                    else
                        u82 = u1.fromParams(u3.getAttribute(u39, "Speed_Curve", u3.default_bezier), u3.getAttribute(u39, "Speed_Duration", 0.1), function(p83, p84) -- Line: 397
                            -- upvalues: u80 (ref), u3 (ref), Attribute22 (ref), Attribute23 (ref)
                            u80 = u3.lerp(Attribute22, Attribute23, p83);

                            return p84;
                        end);
                        table.insert(u41, u82);
                    end;

                    if u50 ~= u51 then
                        local fromParams = u1.fromParams;
                        local Attribute24 = u3.getAttribute(u39, "RotSpeed_Curve", u3.default_bezier);
                        table.insert(u41, fromParams(Attribute24, u54, function(p85, p86) -- Line: 412
                            -- upvalues: u81 (ref), u3 (ref), u50 (ref), u51 (ref), u39 (ref), u80 (ref)
                            u81 = u3.lerp(u50, u51, p85);

                            return p86 * (u39:GetAttribute("SpeedOverride") or u80);
                        end, u82));
                    end;

                    local fromParams = u1.fromParams;
                    local Attribute24 = u3.getAttribute(u39, "Easing_Curve", u3.linear_bezier);
                    table.insert(u41, fromParams(Attribute24, u54, function(p87, p88, p89) -- Line: 426
                        -- upvalues: Attribute10 (ref), u64 (ref), End (ref), u62 (ref), BezierPoints (ref), Attribute9 (ref), u54 (ref), CFrame_identity (ref), vector_create_ret (ref), u81 (ref), u3 (ref), CFrame_fromOrientation_ret (ref), Attribute6 (ref), u70 (copy), u47 (ref), Parent (ref), u75 (ref), u74 (ref), Attribute15 (ref), u72 (copy), OverlapParams_new_ret (ref), onFinish (copy), u79 (ref), u39 (ref), u80 (ref), u82 (ref), Attribute12 (ref), u55 (ref)
                        local v90 = Attribute10 and u64:getPositionArcSpace(p87) or u64:getPosition(p87);

                        if not End then
                            v90 = u62 * (v90 - BezierPoints[1]);
                        end;

                        local CFrame_new_ret = CFrame.new(v90);

                        if Attribute9 then
                            local math_clamp_ret = math.clamp((p89 + 0.016666666666666666) / u54, 0, 1);
                            local v91 = Attribute10 and u64:getPositionArcSpace(math_clamp_ret) or u64:getPosition(math_clamp_ret);

                            if not End then
                                v91 = u62 * (v91 - BezierPoints[1]);
                            end;

                            if v90 == v91 then
                                CFrame_new_ret = CFrame_new_ret * CFrame_identity.Rotation;
                            else
                                CFrame_new_ret = CFrame.lookAt(v90, v91);
                            end;
                        end;

                        local v92 = vector_create_ret:Sign() * u81 * u3.DEG_TO_RAD * p88;
                        CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v92.x, v92.y, v92.z);
                        CFrame_identity = CFrame_new_ret;
                        local v93 = CFrame_new_ret * CFrame_fromOrientation_ret;

                        if Attribute6 then
                            local v94 = u47;

                            if Parent:IsA("BasePart") then
                                v94 = Parent.CFrame;
                            elseif Parent:IsA("Attachment") then
                                v94 = Parent.WorldCFrame;
                            end;

                            u70.CFrame = v94 * u47:ToObjectSpace(v93);
                        else
                            u70.CFrame = v93;
                        end;

                        u75 = (v90 - u74) / p88;
                        u74 = v90;
                        local v95;

                        if Attribute15 then
                            v95 = workspace:GetPartsInPart(u72, OverlapParams_new_ret)[1] and true or false;
                        else
                            v95 = nil;
                        end;

                        if v95 then
                            onFinish();
                            u79 = true;

                            return nil;
                        end;

                        local v96 = u39:GetAttribute("SpeedOverride") or u80;
                        u80 = v96;

                        if v96 == 0 then
                            local v97;

                            if u82 then
                                v97 = not u82.Connected;
                            else
                                v97 = not u39:GetAttribute("SpeedTweening");
                            end;

                            if v97 then
                                return nil;
                            end;
                        end;

                        if not ((not Attribute12 or p87 * u54 >= u55) and Attribute12) then
                            return p88 * v96;
                        end;

                        onFinish();

                        return nil;
                    end, u82, function(p98) -- Line: 486
                        -- upvalues: Attribute12 (ref), u79 (ref), onFinish (copy), Attribute13 (ref), End (ref), u75 (ref), Attribute14 (ref), u72 (copy), u47 (ref), Parent (ref), u1 (ref), u55 (ref), Attribute6 (ref), u70 (copy), Attribute15 (ref), OverlapParams_new_ret (ref), u39 (ref), u80 (ref), u82 (ref), u41 (ref), u3 (ref)
                        if not Attribute12 or u79 then
                            if p98 then
                                onFinish();
                            end;

                            return;
                        end;

                        local v99;

                        if Attribute13 and End then
                            v99 = End.WorldCFrame.LookVector;
                        else
                            v99 = u75.Unit;
                        end;

                        u75 = (v99 ~= v99 and Vector3.new(0, 0, 0) or v99) * Attribute14;
                        local Position = u72.Position;
                        local u100 = u47;

                        if Parent:IsA("BasePart") then
                            u100 = Parent.CFrame;
                        elseif Parent:IsA("Attachment") then
                            u100 = Parent.WorldCFrame;
                        end;

                        u1.timer(u55, function(p101, p102) -- Line: 506
                            -- upvalues: Attribute6 (ref), u70 (ref), u47 (ref), Parent (ref), u100 (copy), Position (copy), u75 (ref), u72 (ref), Attribute15 (ref), OverlapParams_new_ret (ref), onFinish (ref), u79 (ref), u39 (ref), u80 (ref), u82 (ref)
                            if Attribute6 then
                                local v103 = u47;

                                if Parent:IsA("BasePart") then
                                    v103 = Parent.CFrame;
                                elseif Parent:IsA("Attachment") then
                                    v103 = Parent.WorldCFrame;
                                end;

                                u70.CFrame = v103 * u100:ToObjectSpace(CFrame.new(Position + u75 * p102));
                            else
                                u70.CFrame = CFrame.new(Position + u75 * p102) * u72.CFrame.Rotation;
                            end;

                            local v104;

                            if Attribute15 then
                                v104 = workspace:GetPartsInPart(u72, OverlapParams_new_ret)[1] and true or false;
                            else
                                v104 = nil;
                            end;

                            if v104 then
                                onFinish();
                                u79 = true;

                                return nil;
                            end;

                            local v105 = u39:GetAttribute("SpeedOverride") or u80;
                            u80 = v105;

                            if v105 > 0 then
                                return p101 * v105;
                            end;

                            if p102 > 0 then
                                local v106;

                                if u82 then
                                    v106 = u82.Connected;
                                else
                                    v106 = u39:GetAttribute("SpeedTweening");
                                end;

                                if v106 then
                                    return p101 * v105;
                                end;
                            end;

                            return nil;
                        end, u82, u41, u3.RENDER_PRIORITY + u41.depth);

                        if not u79 then
                            onFinish();
                        end;
                    end, true, u3.RENDER_PRIORITY + u41.depth));
                end));
                local _ = i;
            end;

            Promise.all(u45):await();
            task.wait(Attribute4);
        end;

        return;
    end;

    u39:SetAttribute("Enabled", true);

    if Attribute22 ~= Attribute23 then
        u39:SetAttribute("SpeedTweening", true);
        local fromParams = u1.fromParams;
        local Attribute24 = u3.getAttribute(u39, "Speed_Curve", u3.default_bezier);
        local Attribute25 = u3.getAttribute(u39, "Speed_Duration", 0.1);
        table.insert(u41, fromParams(Attribute24, Attribute25, function(p107, p108) -- Line: 145
            -- upvalues: u39 (copy), u3 (ref), Attribute22 (copy), Attribute23 (copy)
            u39:SetAttribute("SpeedOverride", u3.lerp(Attribute22, Attribute23, p107));

            return p108;
        end, nil, function() -- Line: 150
            -- upvalues: u39 (copy)
            u39:SetAttribute("SpeedTweening", nil);
        end));
    end;

    task.wait(Attribute3);
    u39:SetAttribute("Enabled", false);
    u39:SetAttribute("SpeedOverride", nil);
end;

return v36;