 

local u1 = game:GetService("CollectionService")
local u2 = require("../attributes")
local u3 = require("../shape")
local u4 = require("../tween")
local u5 = require("../utility")
local u6 = require("../color/Oklab")
local u7 = require("../../obj/Bezier")
local u8 = {}
local v39 = {
    ["Box"] = {
        ["Volume"] = u3.getPointWithinBox,
        ["Surface"] = u3.getPointOnBox
    },
    ["Cylinder"] = {
        ["Volume"] = function(p9, p10, p11, p12, p13) --[[ Name: Volume, Line 21 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinCylinder(p9, 0, p13, p10, p11, p12)
        end,
        ["Surface"] = function(p14, p15, p16, p17, p18) --[[ Name: Surface, Line 25 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinCylinder(p14, 1, p18, p15, p16, p17)
        end
    },
    ["Sphere"] = {
        ["Volume"] = function(p19, p20, p21, p22, p23) --[[ Name: Volume, Line 31 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinSphere(p19, 0, p23, p20, p21, p22)
        end,
        ["Surface"] = function(p24, p25, p26, p27, p28) --[[ Name: Surface, Line 35 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinSphere(p24, 1, p28, p25, p26, p27)
        end
    },
    ["Disc"] = {
        ["Volume"] = function(p29, p30, p31, p32, p33) --[[ Name: Volume, Line 41 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinDisc(p29, 0, p33, p30, p31, p32)
        end,
        ["Surface"] = function(p34, p35, p36, p37, p38) --[[ Name: Surface, Line 45 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            return u3.getPointWithinDisc(p34, 1, p38, p35, p36, p37)
        end
    }
}
u8.drawFuncMap = v39
function u8.getColorAtTime(p40, p41) --[[ Line: 51 ]]
    local v42 = p40.Keypoints
    if p41 <= v42[1].Time then
        return v42[1].Value
    end
    if v42[#v42].Time <= p41 then
        return v42[#v42].Value
    end
    local v43 = nil
    local v44 = nil
    for v45 = 1, #v42 do
        local v46 = v42[v45]
        if v46.Time == p41 then
            return v46.Value
        end
        if v46.Time < p41 then
            v43 = v46
        elseif p41 < v46.Time then
            v44 = v46
            break
        end
    end
    if not (v43 and v44) then
        return v42[1].Value
    end
    local v47 = (p41 - v43.Time) / (v44.Time - v43.Time)
    return v43.Value:Lerp(v44.Value, v47)
end
function u8.getColorAtTimeOklab(p48, p49) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v50 = p48.Keypoints
    if p49 <= v50[1].Time then
        return v50[1].Value
    end
    if v50[#v50].Time <= p49 then
        return v50[#v50].Value
    end
    local v51 = nil
    local v52 = nil
    for v53 = 1, #v50 do
        local v54 = v50[v53]
        if v54.Time == p49 then
            return v54.Value
        end
        if v54.Time < p49 then
            v51 = v54
        elseif p49 < v54.Time then
            v52 = v54
            break
        end
    end
    if not (v51 and v52) then
        return v50[1].Value
    end
    local v55 = (p49 - v51.Time) / (v52.Time - v51.Time)
    local v56 = u6.fromSRGB(v51.Value):Lerp(u6.fromSRGB(v52.Value), v55)
    return u6.toSRGB(v56)
end
function u8.getColorWithEasingOklab(p57, p58, p59) --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v60 = 1 - p59:getEase((math.clamp(p58, 0, 1))).y
    return u8.getColorAtTimeOklab(p57, (math.clamp(v60, 0, 1)))
end
function u8.createHitboxParams(p61, p62, p63) --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v64 = OverlapParams.new()
    v64.MaxParts = 1
    v64.FilterType = Enum.RaycastFilterType[p61.filterType]
    v64.CollisionGroup = p61.collisionGroup
    v64.RespectCanCollide = not p61.ignoreCanCollide
    v64:AddToFilter(u1:GetTagged(p61.filterTag))
    if p61.filterType == "Exclude" then
        if p63 then
            p63 = p63:FindFirstAncestorOfClass("Part")
        end
        v64:AddToFilter({ workspace.Terrain, p62, p63 })
    end
    return v64
end
function u8.calculateEmissionCFrame(p65, p66, p67, p68, p69, p70, p71) --[[ Line: 164 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v72
    if p71 then
        v72 = p65 * CFrame.new(Vector3.new(0, 0, 0), Vector3.FromNormalId(p67.emissionDirection)).Rotation
    elseif p68 then
        v72 = p68(nil, p65, p66, p67.emissionDirection, p67.partial)
    else
        v72 = p65
    end
    local v73 = Vector3.FromNormalId(p67.emissionDirection)
    local v74 = v73:Cross(p65.LookVector)
    if v74.Magnitude < 0.001 then
        v74 = v73:Cross(p65.UpVector)
    end
    local v75 = CFrame.fromAxisAngle
    local v76 = p69:NextNumber(-p67.spreadAngle.X, p67.spreadAngle.X)
    local v77 = v75(v73, (math.rad(v76)))
    local v78 = CFrame.fromAxisAngle
    local v79 = p69:NextNumber(-p67.spreadAngle.Y, p67.spreadAngle.Y)
    local v80 = v72 * (v77 * v78(v74, (math.rad(v79))))
    if p67.face == "Inward" or p67.face == "InAndOut" and p69:NextInteger(0, 1) == 1 then
        v80 = v80 * CFrame.fromOrientation(0, 3.141592653589793, 0)
    end
    if p70 and (p67.mirror and (v80.Position - p70.WorldPosition).Unit:Dot(v80.RightVector) >= 0) then
        local v81 = p67.mirrorRot * u5.DEG_TO_RAD
        v80 = v80 * CFrame.fromOrientation(v81.X, v81.Y, v81.Z)
    end
    return v80
end
function u8.createBezierWithEndpoint(p82, p83, p84, p85) --[[ Line: 207 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    if not p84 then
        return u7.new(p82)
    end
    local v86 = {}
    for v87, v88 in p82 do
        local v89
        if v87 == #p82 - 1 then
            v89 = p85 and p85.WorldPosition or p84.WorldPosition
        elseif v87 == #p82 then
            v89 = p84.WorldPosition
        else
            v89 = p83 * (v88 - p82[1])
        end
        table.insert(v86, v89)
    end
    return u7.new(v86)
end
function u8.createPosGetter(u90, u91, u92, u93, u94) --[[ Line: 226 ]]
    return function(p95) --[[ Line: 233 ]]
        --[[
        Upvalues:
            [1] = u94
            [2] = u90
            [3] = u93
            [4] = u92
            [5] = u91
        --]]
        local v96
        if u94 == false then
            v96 = u90:getPosition(p95)
        else
            v96 = u90:getPositionArcSpace(p95)
        end
        if u93 then
            return v96
        else
            return u92 * (v96 - u91[1])
        end
    end
end
function u8.readCommonAttributes(p97) --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    return {
        ["emitDelay"] = u2.get(p97, "EmitDelay", 0),
        ["emitCount"] = u2.get(p97, "EmitCount", 1),
        ["emitDuration"] = u2.get(p97, "EmitDuration", 0),
        ["destroyDelay"] = u2.get(p97, "DestroyDelay", 0),
        ["duration"] = u2.getRange(p97, "Duration", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        ["shapeType"] = u2.getEnum(p97, "Shape", "Box", {
            "Box",
            "Cylinder",
            "Sphere",
            "Disc"
        }),
        ["shapeStyle"] = u2.getEnum(p97, "ShapeStyle", "Volume", { "Volume", "Surface" }),
        ["emissionDirection"] = Enum.NormalId[u2.getEnum(p97, "EmissionDirection", "Top", {
            "Top",
            "Bottom",
            "Left",
            "Right",
            "Front",
            "Back"
        })],
        ["face"] = u2.getEnum(p97, "ShapeFace", "Outward", { "InAndOut", "Inward", "Outward" }),
        ["spreadAngle"] = u2.get(p97, "SpreadAngle", Vector3.new(0, 0, 0)),
        ["partial"] = u2.get(p97, "ShapePartial", 1),
        ["syncPosition"] = u2.get(p97, "SyncPosition", false),
        ["mirror"] = u2.get(p97, "MirrorPaths", true),
        ["mirrorRot"] = u2.get(p97, "MirrorRotation", Vector3.new(0, 0, 180)),
        ["projectileEnabled"] = u2.get(p97, "ProjectileEnabled", false),
        ["projectileMatchEnd"] = u2.get(p97, "MatchEndDirection", false),
        ["projectileSpeed"] = u2.get(p97, "ProjectileSpeed", 30),
        ["projectileLifetime"] = u2.getRange(p97, "ProjectileLifetime", NumberRange.new(1, 1), NumberRange.new(0, (1 / 0))),
        ["hitboxEnabled"] = u2.get(p97, "HitboxEnabled", false),
        ["hitboxCollisionGroup"] = u2.get(p97, "HitboxCollisionGroup", "Default"),
        ["hitboxFilterTag"] = u2.get(p97, "HitboxFilterTag", ""),
        ["hitboxFilterType"] = u2.get(p97, "HitboxFilterType", "Exclude"),
        ["hitboxIgnoreCanCollide"] = u2.get(p97, "HitboxIgnoreCanCollide", false),
        ["speedStart"] = u2.get(p97, "Speed_Start", 1),
        ["speedEnd"] = u2.get(p97, "Speed_End", 1)
    }
end
function u8.getCurrentOriginCFrame(p98, p99) --[[ Line: 290 ]]
    if p98:IsA("BasePart") then
        return p98.CFrame
    elseif p98:IsA("Attachment") then
        return p98.WorldCFrame
    else
        return p99
    end
end
function u8.findEndAttachments(p100) --[[ Line: 300 ]]
    local v101 = p100:FindFirstChild("End")
    local v102
    if v101 then
        v102 = v101:FindFirstChild("T1")
    else
        v102 = v101
    end
    if v101 and not v101:IsA("Attachment") then
        v101 = nil
    end
    if v102 and not v102:IsA("Attachment") then
        v102 = nil
    end
    return v101, v102
end
function u8.validateParent(p103) --[[ Line: 315 ]]
    local v104 = p103.Parent
    if not v104 then
        return nil
    end
    if v104:IsA("BasePart") then
        p103 = v104
    elseif v104:IsA("Attachment") then
        p103 = v104
    end
    return p103
end
function u8.getPerpendicularVectors(p105) --[[ Line: 329 ]]
    local v106 = p105:Cross(Vector3.new(0, 1, 0))
    if v106.Magnitude < 0.001 then
        v106 = p105:Cross(Vector3.new(0, 0, 1))
    end
    local v107 = v106.Unit
    return v107, p105:Cross(v107).Unit
end
function u8.createPropertyTween(p108, p109, p110, p111, u112, u113, u114, u115, p116) --[[ Line: 343 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
        [3] = u5
    --]]
    if u112 ~= u113 then
        local v117 = u4.fromParams
        local v118 = u2.get(p109, p110 .. "_Curve", u5.default_bezier)
        local function v121(p119, p120) --[[ Line: 363 ]]
            --[[
            Upvalues:
                [1] = u114
                [2] = u5
                [3] = u112
                [4] = u113
                [5] = u115
            --]]
            u114(u5.lerp(u112, u113, p119))
            return p120 * u115()
        end
        table.insert(p108, v117(v118, p111, v121, p116))
    end
end
return u8