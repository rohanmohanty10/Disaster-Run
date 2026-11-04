 
 

local HttpService = game:GetService("HttpService");
local CollectionService = game:GetService("CollectionService");
local u1 = require("../mod/tween");
local u2 = require("../mod/shape");
local u3 = require("../mod/utility");
local u4 = require("../obj/Bezier");
local u5 = require("../pkg/Promise");
require("../obj/ObjectCache");
local u36 = {
    Box = {
        Volume = u2.getPointWithinBox,
        Surface = u2.getPointOnBox
    },
    Cylinder = {
        Volume = function(p6, p7, p8, p9, p10) -- Line: 19, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinCylinder(p6, 0, p10, p7, p8, p9);
        end,

        Surface = function(p11, p12, p13, p14, p15) -- Line: 23, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinCylinder(p11, 1, p15, p12, p13, p14);
        end
    },
    Sphere = {
        Volume = function(p16, p17, p18, p19, p20) -- Line: 29, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinSphere(p16, 0, p20, p17, p18, p19);
        end,

        Surface = function(p21, p22, p23, p24, p25) -- Line: 33, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinSphere(p21, 1, p25, p22, p23, p24);
        end
    },
    Disc = {
        Volume = function(p26, p27, p28, p29, p30) -- Line: 39, Name: Volume
            -- upvalues: u2 (copy)
            return u2.getPointWithinDisc(p26, 0, p30, p27, p28, p29);
        end,

        Surface = function(p31, p32, p33, p34, p35) -- Line: 43, Name: Surface
            -- upvalues: u2 (copy)
            return u2.getPointWithinDisc(p31, 1, p35, p32, p33, p34);
        end
    }
};
local v37 = {};
local u38 = nil;

function v37.init(p39) -- Line: 53
    -- upvalues: u38 (ref)
    u38 = p39;
end;

function v37.deinit() -- Line: 57
    -- upvalues: u38 (ref)
    u38 = nil;
end;

function v37.emit(u40: userdata, u41: userdata, u42: any, p43: boolean?) -- Line: 61
    -- upvalues: u38 (ref), u3 (copy), u36 (copy), u1 (copy), u4 (copy), CollectionService (copy), u5 (copy), HttpService (copy)
    local Points = u40:FindFirstChild("Points");

    if not (Points and (Points:IsA("Attachment") and u38)) then
        return;
    end;

    local Attribute = u3.getAttribute(u40, "EmitDelay", 0);
    local Attribute2 = u3.getAttribute(u40, "EmitCount", 1);
    local Attribute3 = u3.getAttribute(u40, "EmitDuration", 0);
    local Attribute4 = u3.getAttribute(u40, "DestroyDelay", 0);
    local RangeAttribute = u3.getRangeAttribute(u40, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));
    local EnumAttribute = u3.getEnumAttribute(u40, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" });
    local Attribute5 = u3.getAttribute(u40, "SpreadAngle", Vector3.new(0, 0, 0));
    local Attribute6 = u3.getAttribute(u40, "SyncPosition", false);
    local Attribute7 = u3.getAttribute(u40, "MirrorPaths", true);
    local Attribute8 = u3.getAttribute(u40, "MirrorRotation", Vector3.new(0, 0, 180));
    local Attribute9 = u3.getAttribute(u40, "FacePath", false);
    local Attribute10 = u3.getAttribute(u40, "ArcSpace", false);
    local Attribute11 = u3.getAttribute(u40, "ShapePartial", 1);
    local EnumAttribute2 = u3.getEnumAttribute(u40, "Shape", "Box", { "Box", "Cylinder", "Sphere", "Disc" });
    local EnumAttribute3 = u3.getEnumAttribute(u40, "ShapeStyle", "Volume", { "Volume", "Surface" });
    local u44 = Enum.NormalId[u3.getEnumAttribute(u40, "EmissionDirection", "Top", { "Top", "Bottom", "Left", "Right", "Front", "Back" })];
    local Attribute12 = u3.getAttribute(u40, "ProjectileEnabled", false);
    local Attribute13 = u3.getAttribute(u40, "MatchEndDirection", false);
    local Attribute14 = u3.getAttribute(u40, "ProjectileSpeed", 30);
    local RangeAttribute2 = u3.getRangeAttribute(u40, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0)));
    local Attribute15 = u3.getAttribute(u40, "HitboxEnabled", false);
    local Attribute16 = u3.getAttribute(u40, "HitboxCollisionGroup", "Default");
    local Attribute17 = u3.getAttribute(u40, "HitboxFilterTag", "");
    local Attribute18 = u3.getAttribute(u40, "HitboxFilterType", "Exclude");
    local Attribute19 = u3.getAttribute(u40, "HitboxIgnoreCanCollide", false);
    local RangeAttribute3 = u3.getRangeAttribute(u40, "RotSpeed_Start", NumberRange.new(0, 0));
    local RangeAttribute4 = u3.getRangeAttribute(u40, "RotSpeed_End", NumberRange.new(0, 0));
    local Attribute20 = u3.getAttribute(u40, "MinInitRot", Vector3.new(0, 0, 0));
    local Attribute21 = u3.getAttribute(u40, "MaxInitRot", Vector3.new(0, 0, 0));
    local Attribute22 = u3.getAttribute(u40, "Speed_Start", 1);
    local Attribute23 = u3.getAttribute(u40, "Speed_End", 1);
    local u45 = u36[EnumAttribute2] and u36[EnumAttribute2][EnumAttribute3];

    if not u45 then
        return;
    end;

    local u46 = {};
    task.wait(Attribute);

    if not (Attribute3 > 0) or p43 then
        if Attribute2 > 0 then
            local u47 = nil;
            local u48 = nil;
            local Parent = u40.Parent;

            if not Parent then
                return;
            end;

            if not (Parent:IsA("BasePart") or Parent:IsA("Attachment")) then
                Parent = u40;
            end;

            if Parent:IsA("BasePart") then
                u47 = Parent.Size;
                u48 = Parent.CFrame;
            elseif Parent:IsA("Attachment") then
                u48 = Parent.WorldCFrame;
                u47 = Vector3.new(0, 0, 0);
            end;

            if not u48 then
                return;
            end;

            local End = u40:FindFirstChild("End");
            End = End;
            local u49;

            if End then
                u49 = End:FindFirstChild("T1");
            end;

            if End and not End:IsA("Attachment") then
                End = nil;
            end;

            if u49 and not u49:IsA("Attachment") then
                u49 = nil;
            end;

            local BezierPoints = u3.getBezierPoints(Points);
            local Random_new_ret = Random.new();
            local u50 = not End and u4.new(BezierPoints);
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
                local u51 = Random_new_ret:NextNumber(RangeAttribute3.Min, RangeAttribute3.Max);
                local u52 = Random_new_ret:NextNumber(RangeAttribute4.Min, RangeAttribute4.Max);
                local v53 = Random_new_ret:NextNumber(Attribute20.x, Attribute21.x);
                local v54 = Random_new_ret:NextNumber(Attribute20.y, Attribute21.y);
                local vector_create_ret = vector.create(v53, v54, Random_new_ret:NextNumber(Attribute20.z, Attribute21.z));
                local u55 = Random_new_ret:NextNumber(RangeAttribute.Min, RangeAttribute.Max);
                local u56;

                if Attribute12 then
                    u56 = Random_new_ret:NextNumber(RangeAttribute2.Min, RangeAttribute2.Max);
                else
                    u56 = Attribute12;
                end;

                table.insert(u46, u5.new(function(u57) -- Line: 231
                    -- upvalues: Parent (ref), u48 (ref), u44 (copy), u45 (copy), u47 (ref), Attribute11 (copy), Random_new_ret (copy), Attribute5 (copy), EnumAttribute (copy), End (ref), Attribute7 (copy), Attribute8 (copy), u3 (ref), u50 (copy), BezierPoints (copy), u49 (ref), u4 (ref), Attribute10 (copy), HttpService (ref), u38 (ref), u41 (copy), u42 (copy), u46 (copy), Attribute15 (copy), OverlapParams_new_ret (copy), Attribute22 (copy), u51 (copy), vector_create_ret (copy), Attribute23 (copy), u40 (copy), u1 (ref), u52 (copy), u55 (copy), Attribute9 (copy), Attribute6 (copy), Attribute12 (copy), u56 (copy), Attribute13 (copy), Attribute14 (copy)
                    local v58;

                    if Parent:IsA("Attachment") then
                        v58 = u48 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(u44)).Rotation;
                    else
                        v58 = u45(nil, u48, u47, u44, Attribute11);
                    end;

                    local Vector3_FromNormalId_ret = Vector3.FromNormalId(u44);
                    local v59 = Vector3_FromNormalId_ret:Cross(u48.LookVector);

                    if v59.Magnitude < 0.001 then
                        v59 = Vector3_FromNormalId_ret:Cross(u48.UpVector);
                    end;

                    local CFrame_fromAxisAngle = CFrame.fromAxisAngle;
                    local v60 = Random_new_ret:NextNumber(-Attribute5.x, Attribute5.x);
                    local v61 = CFrame_fromAxisAngle(Vector3_FromNormalId_ret, (math.rad(v60)));
                    local CFrame_fromAxisAngle2 = CFrame.fromAxisAngle;
                    local v62 = Random_new_ret:NextNumber(-Attribute5.y, Attribute5.y);
                    local u63 = v58 * (v61 * CFrame_fromAxisAngle2(v59, (math.rad(v62))));

                    if EnumAttribute == "Inward" or EnumAttribute == "InAndOut" and Random_new_ret:NextInteger(0, 1) == 1 then
                        u63 = u63 * CFrame.fromOrientation(0, 3.141592653589793, 0);
                    end;

                    if End and (Attribute7 and (u63.Position - End.WorldPosition).Unit:Dot(u63.RightVector) >= 0) then
                        local v64 = Attribute8 * u3.DEG_TO_RAD;
                        u63 = u63 * CFrame.fromOrientation(v64.x, v64.y, v64.z);
                    end;

                    local u65 = u50;

                    if End then
                        local v66 = {};

                        for i2, v in BezierPoints do
                            local v67;

                            if i2 == #BezierPoints - 1 then
                                v67 = u49 and u49.WorldPosition or End.WorldPosition;
                            elseif i2 == #BezierPoints then
                                v67 = End.WorldPosition;
                            else
                                v67 = u63 * (v - BezierPoints[1]);
                            end;

                            table.insert(v66, v67);
                        end;

                        u65 = u4.new(v66);
                    end;

                    local function getPos(p68: number) -- Line: 275
                        -- upvalues: Attribute10 (ref), u65 (ref), End (ref), u63 (ref), BezierPoints (ref)
                        local v69 = Attribute10 and u65:getPositionArcSpace(p68) or u65:getPosition(p68);

                        if End then
                            return v69;
                        end;

                        return u63 * (v69 - BezierPoints[1]);
                    end;

                    local u70 = HttpService:GenerateGUID(false);

                    if not u38 then
                        u57();

                        return;
                    end;

                    local u71 = u38:get(u70);
                    local CFrame_new = CFrame.new;
                    local v72 = Attribute10 and u65:getPositionArcSpace(0) or u65:getPosition(0);

                    if not End then
                        v72 = u63 * (v72 - BezierPoints[1]);
                    end;

                    u71.CFrame = CFrame_new(v72);
                    local u73 = u71._getReal();
                    u3.copyProperties(u41, u73, u3.COPY_PART_PROPERTIES);
                    u3.copyProperties(u41, u73, u3.COPY_EXTENDED_PART_PROPERTIES);
                    local v74 = u41:Clone();

                    for _, child in v74:GetChildren() do
                        child.Parent = u73;
                    end;

                    v74:Destroy();
                    local EmitOnFinish = u73:FindFirstChild("EmitOnFinish");

                    if EmitOnFinish then
                        EmitOnFinish.Parent = nil;
                        table.insert(u42, EmitOnFinish);
                    end;

                    if shared.vfx and #u73:GetChildren() ~= 0 then
                        local Finished = shared.vfx.emit(u73).Finished;
                        table.insert(u46, Finished);
                    end;

                    table.insert(u42, function() -- Line: 322
                        -- upvalues: u38 (ref), u70 (copy)
                        if u38 then
                            u38:free(u70);
                        end;
                    end);
                    local u75 = Vector3.new(0, 0, 0);
                    local u76 = Vector3.new(0, 0, 0);
                    local u77 = false;

                    local function onFinish() -- Line: 333
                        -- upvalues: u77 (ref), EmitOnFinish (copy), u73 (copy), u57 (copy)
                        if u77 then
                            return;
                        end;

                        u77 = true;
                        local v78 = EmitOnFinish and EmitOnFinish:GetChildren();

                        if not v78 or #v78 == 0 then
                            u57();

                            return;
                        end;

                        for _, v in v78 do
                            v.Parent = u73;
                        end;

                        shared.vfx.emit(table.unpack(v78)).Finished:finally(function() -- Line: 349
                            -- upvalues: u57 (ref)
                            u57();
                        end);
                    end;

                    local function shapecast() -- Line: 357
                        -- upvalues: Attribute15 (ref), u73 (copy), OverlapParams_new_ret (ref)
                        if Attribute15 then
                            return workspace:GetPartsInPart(u73, OverlapParams_new_ret)[1] and true or false;
                        end;
                    end;

                    local function getOriginCFrame() -- Line: 371
                        -- upvalues: u48 (ref), Parent (ref)
                        local v79 = u48;

                        if Parent:IsA("BasePart") then
                            return Parent.CFrame;
                        end;

                        if Parent:IsA("Attachment") then
                            v79 = Parent.WorldCFrame;
                        end;

                        return v79;
                    end;

                    local u80 = false;
                    local CFrame_identity = CFrame.identity;
                    local u81 = Attribute22;
                    local u82 = u51;
                    local CFrame_fromOrientation_ret = CFrame.fromOrientation(vector_create_ret.x, vector_create_ret.y, vector_create_ret.z);
                    local u83;

                    if Attribute22 == Attribute23 or u40:GetAttribute("SpeedOverride") then
                        u83 = nil;
                    else
                        u83 = u1.fromParams(u3.getAttribute(u40, "Speed_Curve", u3.default_bezier), u3.getAttribute(u40, "Speed_Duration", 0.1), function(p84, p85) -- Line: 397
                            -- upvalues: u81 (ref), u3 (ref), Attribute22 (ref), Attribute23 (ref)
                            u81 = u3.lerp(Attribute22, Attribute23, p84);

                            return p85;
                        end);
                        table.insert(u42, u83);
                    end;

                    if u51 ~= u52 then
                        local fromParams = u1.fromParams;
                        local Attribute24 = u3.getAttribute(u40, "RotSpeed_Curve", u3.default_bezier);
                        table.insert(u42, fromParams(Attribute24, u55, function(p86, p87) -- Line: 412
                            -- upvalues: u82 (ref), u3 (ref), u51 (ref), u52 (ref), u40 (ref), u81 (ref)
                            u82 = u3.lerp(u51, u52, p86);

                            return p87 * (u40:GetAttribute("SpeedOverride") or u81);
                        end, u83));
                    end;

                    local fromParams = u1.fromParams;
                    local Attribute24 = u3.getAttribute(u40, "Easing_Curve", u3.linear_bezier);
                    table.insert(u42, fromParams(Attribute24, u55, function(p88, p89, p90) -- Line: 426
                        -- upvalues: Attribute10 (ref), u65 (ref), End (ref), u63 (ref), BezierPoints (ref), Attribute9 (ref), u55 (ref), CFrame_identity (ref), vector_create_ret (ref), u82 (ref), u3 (ref), CFrame_fromOrientation_ret (ref), Attribute6 (ref), u71 (copy), u48 (ref), Parent (ref), u76 (ref), u75 (ref), Attribute15 (ref), u73 (copy), OverlapParams_new_ret (ref), onFinish (copy), u80 (ref), u40 (ref), u81 (ref), u83 (ref), Attribute12 (ref), u56 (ref)
                        local v91 = Attribute10 and u65:getPositionArcSpace(p88) or u65:getPosition(p88);

                        if not End then
                            v91 = u63 * (v91 - BezierPoints[1]);
                        end;

                        local CFrame_new_ret = CFrame.new(v91);

                        if Attribute9 then
                            local math_clamp_ret = math.clamp((p90 + 0.016666666666666666) / u55, 0, 1);
                            local v92 = Attribute10 and u65:getPositionArcSpace(math_clamp_ret) or u65:getPosition(math_clamp_ret);

                            if not End then
                                v92 = u63 * (v92 - BezierPoints[1]);
                            end;

                            if v91 == v92 then
                                CFrame_new_ret = CFrame_new_ret * CFrame_identity.Rotation;
                            else
                                CFrame_new_ret = CFrame.lookAt(v91, v92);
                            end;
                        end;

                        local v93 = vector_create_ret:Sign() * u82 * u3.DEG_TO_RAD * p89;
                        CFrame_fromOrientation_ret = CFrame_fromOrientation_ret * CFrame.fromOrientation(v93.x, v93.y, v93.z);
                        CFrame_identity = CFrame_new_ret;
                        local v94 = CFrame_new_ret * CFrame_fromOrientation_ret;

                        if Attribute6 then
                            local v95 = u48;

                            if Parent:IsA("BasePart") then
                                v95 = Parent.CFrame;
                            elseif Parent:IsA("Attachment") then
                                v95 = Parent.WorldCFrame;
                            end;

                            u71.CFrame = v95 * u48:ToObjectSpace(v94);
                        else
                            u71.CFrame = v94;
                        end;

                        u76 = (v91 - u75) / p89;
                        u75 = v91;
                        local v96;

                        if Attribute15 then
                            v96 = workspace:GetPartsInPart(u73, OverlapParams_new_ret)[1] and true or false;
                        else
                            v96 = nil;
                        end;

                        if v96 then
                            onFinish();
                            u80 = true;

                            return nil;
                        end;

                        local v97 = u40:GetAttribute("SpeedOverride") or u81;
                        u81 = v97;

                        if v97 == 0 then
                            local v98;

                            if u83 then
                                v98 = not u83.Connected;
                            else
                                v98 = not u40:GetAttribute("SpeedTweening");
                            end;

                            if v98 then
                                return nil;
                            end;
                        end;

                        if not ((not Attribute12 or p88 * u55 >= u56) and Attribute12) then
                            return p89 * v97;
                        end;

                        onFinish();

                        return nil;
                    end, u83, function(p99) -- Line: 486
                        -- upvalues: Attribute12 (ref), u80 (ref), onFinish (copy), Attribute13 (ref), End (ref), u76 (ref), Attribute14 (ref), u73 (copy), u48 (ref), Parent (ref), u1 (ref), u56 (ref), Attribute6 (ref), u71 (copy), Attribute15 (ref), OverlapParams_new_ret (ref), u40 (ref), u81 (ref), u83 (ref), u42 (ref), u3 (ref)
                        if not Attribute12 or u80 then
                            if p99 then
                                onFinish();
                            end;

                            return;
                        end;

                        local v100;

                        if Attribute13 and End then
                            v100 = End.WorldCFrame.LookVector;
                        else
                            v100 = u76.Unit;
                        end;

                        u76 = (v100 ~= v100 and Vector3.new(0, 0, 0) or v100) * Attribute14;
                        local Position = u73.Position;
                        local u101 = u48;

                        if Parent:IsA("BasePart") then
                            u101 = Parent.CFrame;
                        elseif Parent:IsA("Attachment") then
                            u101 = Parent.WorldCFrame;
                        end;

                        u1.timer(u56, function(p102, p103) -- Line: 506
                            -- upvalues: Attribute6 (ref), u71 (ref), u48 (ref), Parent (ref), u101 (copy), Position (copy), u76 (ref), u73 (ref), Attribute15 (ref), OverlapParams_new_ret (ref), onFinish (ref), u80 (ref), u40 (ref), u81 (ref), u83 (ref)
                            if Attribute6 then
                                local v104 = u48;

                                if Parent:IsA("BasePart") then
                                    v104 = Parent.CFrame;
                                elseif Parent:IsA("Attachment") then
                                    v104 = Parent.WorldCFrame;
                                end;

                                u71.CFrame = v104 * u101:ToObjectSpace(CFrame.new(Position + u76 * p103));
                            else
                                u71.CFrame = CFrame.new(Position + u76 * p103) * u73.CFrame.Rotation;
                            end;

                            local v105;

                            if Attribute15 then
                                v105 = workspace:GetPartsInPart(u73, OverlapParams_new_ret)[1] and true or false;
                            else
                                v105 = nil;
                            end;

                            if v105 then
                                onFinish();
                                u80 = true;

                                return nil;
                            end;

                            local v106 = u40:GetAttribute("SpeedOverride") or u81;
                            u81 = v106;

                            if v106 > 0 then
                                return p102 * v106;
                            end;

                            if p103 > 0 then
                                local v107;

                                if u83 then
                                    v107 = u83.Connected;
                                else
                                    v107 = u40:GetAttribute("SpeedTweening");
                                end;

                                if v107 then
                                    return p102 * v106;
                                end;
                            end;

                            return nil;
                        end, u83, u42, u3.RENDER_PRIORITY + u42.depth);

                        if not u80 then
                            onFinish();
                        end;
                    end, true, u3.RENDER_PRIORITY + u42.depth));
                end));
                local _ = i;
            end;

            u5.all(u46):await();
            task.wait(Attribute4);
        end;

        return;
    end;

    u40:SetAttribute("Enabled", true);

    if Attribute22 ~= Attribute23 then
        u40:SetAttribute("SpeedTweening", true);
        local fromParams = u1.fromParams;
        local Attribute24 = u3.getAttribute(u40, "Speed_Curve", u3.default_bezier);
        local Attribute25 = u3.getAttribute(u40, "Speed_Duration", 0.1);
        table.insert(u42, fromParams(Attribute24, Attribute25, function(p108, p109) -- Line: 144
            -- upvalues: u40 (copy), u3 (ref), Attribute22 (copy), Attribute23 (copy)
            u40:SetAttribute("SpeedOverride", u3.lerp(Attribute22, Attribute23, p108));

            return p109;
        end, nil, function() -- Line: 149
            -- upvalues: u40 (copy)
            u40:SetAttribute("SpeedTweening", nil);
        end));
    end;

    task.wait(Attribute3);
    u40:SetAttribute("Enabled", false);
    u40:SetAttribute("SpeedOverride", nil);
end;

return v37;