 
 

local HttpService = game:GetService("HttpService");
local Config = require(script.Parent:WaitForChild("Config"));
local DefaultObjectSettings = require(script.Parent:WaitForChild("DefaultObjectSettings"));
local u1 = {
    Block = "Box",
    Ball = "Sphere",
    Capsule = "Capsule",
    Sphere = "Sphere",
    Box = "Box",
    Cylinder = "Cylinder"
};

local function SafeUnit(p2: vector) -- Line: 14
    return p2.Magnitude == 0 and Vector3.new(-0, -1, -0) or p2.Unit;
end;

local u56 = {
    LogIndent = 0,

    GetRotationBetween = function(p3: vector, p4: vector) -- Line: 25, Name: GetRotationBetween
        local v5 = p3:Dot(p4);
        local Magnitude = p3:Cross(p4).Magnitude;
        local math_atan2_ret = math.atan2(Magnitude, v5);
        local v6 = p3:Cross(p4);

        return CFrame.fromAxisAngle(v6.Magnitude == 0 and Vector3.new(-0, -1, -0) or v6.Unit, math_atan2_ret);
    end,

    GetCFrameAxis = function(p7, p8: string) -- Line: 34, Name: GetCFrameAxis
        local v9, v10, v11 = p7:ToEulerAnglesXYZ();

        if p8 == "X" then
            return v9;
        end;

        if p8 == "Y" then
            return v10;
        end;

        if p8 == "Z" then
            return v11;
        end;

        return nil;
    end,

    GatherObjectSettings = function(u12: userdata) -- Line: 46, Name: GatherObjectSettings
        -- upvalues: DefaultObjectSettings (copy)
        local function Expect(p13: any, p14: string, p15: string) -- Line: 49
            -- upvalues: u12 (copy)
            if typeof(p13) == p14 then
                return true;
            end;

            warn((`[SmartBone][Object] Expected attribute {p15} on {u12.Name} to be of type {p14}, got type {typeof(p13)}`));

            return false;
        end;

        local v16 = {};

        for i, v in DefaultObjectSettings do
            local Attribute = u12:GetAttribute(i);

            if Attribute ~= nil then
                local v17 = typeof(v);
                local v18;

                if typeof(Attribute) == v17 then
                    v18 = true;
                else
                    warn((`[SmartBone][Object] Expected attribute {i} on {u12.Name} to be of type {v17}, got type {typeof(Attribute)}`));
                    v18 = false;
                end;

                if not v18 then
                    Attribute = nil;
                end;
            end;

            v16[i] = Attribute == nil and v and v or Attribute;
        end;

        return v16;
    end,

    GatherBoneSettings = function(u19: userdata) -- Line: 73, Name: GatherBoneSettings
        local function Attrib(p20: string) -- Line: 74
            -- upvalues: u19 (copy)
            return u19:GetAttribute(p20);
        end;

        local function _(p21: any, p22: string, p23: string) -- Line: 78
            -- upvalues: u19 (copy)
            if typeof(p21) ~= p22 then
                warn((`[SmartBone][Bone] Expected attribute {p23} on {u19.Name} to be of type {p22}, got type {typeof(p21)}`));
            end;
        end;

        local v24 = u19:GetAttribute("XAxisLocked") or false;
        local v25 = u19:GetAttribute("YAxisLocked") or false;
        local v26 = u19:GetAttribute("ZAxisLocked") or false;
        local v27 = u19:GetAttribute("XAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v28 = u19:GetAttribute("YAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v29 = u19:GetAttribute("ZAxisLimits") or NumberRange.new((-1 / 0), (1 / 0));
        local v30 = u19:GetAttribute("Radius") or 0.25;
        local v31 = u19:GetAttribute("RotationLimit") or 180;
        local v32 = u19:GetAttribute("Force") or "¬";
        local v33 = u19:GetAttribute("Gravity") or "¬";

        if typeof(v24) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute XAxisLocked on {u19.Name} to be of type boolean, got type {typeof(v24)}`));
        end;

        if typeof(v25) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute YAxisLocked on {u19.Name} to be of type boolean, got type {typeof(v25)}`));
        end;

        if typeof(v26) ~= "boolean" then
            warn((`[SmartBone][Bone] Expected attribute ZAxisLocked on {u19.Name} to be of type boolean, got type {typeof(v26)}`));
        end;

        if typeof(v27) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute XAxisLimits on {u19.Name} to be of type NumberRange, got type {typeof(v27)}`));
        end;

        if typeof(v28) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute YAxisLimits on {u19.Name} to be of type NumberRange, got type {typeof(v28)}`));
        end;

        if typeof(v29) ~= "NumberRange" then
            warn((`[SmartBone][Bone] Expected attribute ZAxisLimits on {u19.Name} to be of type NumberRange, got type {typeof(v29)}`));
        end;

        if typeof(v30) ~= "number" then
            warn((`[SmartBone][Bone] Expected attribute Radius on {u19.Name} to be of type number, got type {typeof(v30)}`));
        end;

        if typeof(v31) ~= "number" then
            warn((`[SmartBone][Bone] Expected attribute RotationLimit on {u19.Name} to be of type number, got type {typeof(v31)}`));
        end;

        if v32 ~= "¬" and typeof(v32) ~= "Vector3" then
            warn((`[SmartBone][Bone] Expected attribute Force on {u19.Name} to be of type Vector3, got type {typeof(v32)}`));
        end;

        if v32 ~= "¬" and typeof(v33) ~= "Vector3" then
            warn((`[SmartBone][Bone] Expected attribute Gravity on {u19.Name} to be of type Vector3, got type {typeof(v33)}`));
        end;

        return {
            AxisLocked = { v24, v25, v26 },
            XAxisLimits = v27,
            YAxisLimits = v28,
            ZAxisLimits = v29,
            RotationLimit = v31,
            Radius = v30,
            Force = v32,
            Gravity = v33
        };
    end,

    ClosestPointOnLine = function(p34: vector, p35: vector, p36: number, p37: vector) -- Line: 131, Name: ClosestPointOnLine
        local v38 = (p37 - p34):Dot(p35);

        return p34 + p35 * math.clamp(v38, -p36, p36);
    end,

    ClosestPointInBox = function(p39, p40: vector, p41: vector) -- Line: 139, Name: ClosestPointInBox
        local v42 = p39:PointToObjectSpace(p41);
        local X = p40.X;
        local X2 = p40.X;
        local Z = p40.Z;
        local X3 = v42.X;
        local Y = v42.Y;
        local Z2 = v42.Z;

        if v42 ~= v42 or p40 ~= p40 then
            return false, p39.Position, Vector3.new(0, 1, 0);
        end;

        local math_clamp_ret = math.clamp(X3, -X * 0.5, X * 0.5);
        local math_clamp_ret2 = math.clamp(Y, -X2 * 0.5, X2 * 0.5);
        local math_clamp_ret3 = math.clamp(Z2, -Z * 0.5, Z * 0.5);

        if math_clamp_ret ~= X3 or (math_clamp_ret2 ~= Y or math_clamp_ret3 ~= Z2) then
            local v43 = p39 * Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);

            return false, v43, (p41 - v43).unit;
        end;

        local v44 = X3 - X * 0.5;
        local v45 = Y - X2 * 0.5;
        local v46 = Z2 - Z * 0.5;
        local v47 = -X3 - X * 0.5;
        local v48 = -Y - X2 * 0.5;
        local v49 = -Z2 - Z * 0.5;
        local math_max_ret = math.max(v44, v45, v46, v47, v48, v49);

        if math_max_ret == v44 then
            return true, p39 * Vector3.new(X * 0.5, Y, Z2), p39.XVector;
        end;

        if math_max_ret == v45 then
            return true, p39 * Vector3.new(X3, X2 * 0.5, Z2), p39.YVector;
        end;

        if math_max_ret == v46 then
            return true, p39 * Vector3.new(X3, Y, Z * 0.5), p39.ZVector;
        end;

        if math_max_ret == v47 then
            return true, p39 * Vector3.new(-X * 0.5, Y, Z2), -p39.XVector;
        end;

        if math_max_ret == v48 then
            return true, p39 * Vector3.new(X3, -X2 * 0.5, Z2), -p39.YVector;
        end;

        if math_max_ret == v49 then
            return true, p39 * Vector3.new(X3, Y, -Z * 0.5), -p39.ZVector;
        end;

        warn("CLOSEST POINT ON BOX FAIL");

        return false, Vector3.new(0, 0, 0), Vector3.new(0, 1, 0);
    end,

    GetCollider = function(p50: userdata) -- Line: 194, Name: GetCollider
        -- upvalues: HttpService (copy), u1 (copy)
        local v51 = p50:FindFirstChild("self.Collider");
        local v52;

        if v51 and v51:IsA("ModuleScript") then
            local u53 = require(v51);
            local u54 = nil;
            pcall(function() -- Line: 203
                -- upvalues: u54 (ref), HttpService (ref), u53 (copy)
                u54 = HttpService:JSONDecode(u53);
            end);
            v52 = u54;
        else
            v52 = nil;
        end;

        if v52 then
            return v52;
        end;

        local function GetShapeName(p55) -- Line: 216
            return p55:GetAttribute("ColliderShape") or (not p55:IsA("Part") and "Box" or p55.Shape.Name);
        end;

        return {
            {
                ScaleX = 1,
                ScaleY = 1,
                ScaleZ = 1,
                OffsetX = 0,
                OffsetY = 0,
                OffsetZ = 0,
                RotationX = 0,
                RotationY = 0,
                RotationZ = 0,
                Type = u1[p50:GetAttribute("ColliderShape") or (not p50:IsA("Part") and "Box" or p50.Shape.Name)] or "Box"
            }
        };
    end
};

function u56.SB_INDENT_LOG() -- Line: 250
    -- upvalues: u56 (copy)
    local v57 = u56;
    v57.LogIndent = v57.LogIndent + 1;
end;

function u56.SB_UNINDENT_LOG() -- Line: 254
    -- upvalues: u56 (copy)
    local v58 = u56;
    v58.LogIndent = v58.LogIndent - 1;
    u56.LogIndent = math.max(u56.LogIndent, 0);
end;

function u56.SB_ASSERT_CB(p59, p60, ...) -- Line: 259
    if p59 == false or p59 == nil then
        p60(...);
    end;
end;

function u56.SB_VERBOSE_LOG(p61: string) -- Line: 265
    -- upvalues: Config (copy), u56 (copy)
    if not Config.LOG_VERBOSE then
        return;
    end;

    local string_rep_ret = string.rep("    ", u56.LogIndent);
    print((`{string_rep_ret}[SmartBone][Log]: {p61}`));
end;

function u56.SB_VERBOSE_WARN(p62: string) -- Line: 275
    -- upvalues: Config (copy), u56 (copy)
    if not Config.LOG_VERBOSE then
        return;
    end;

    local string_rep_ret = string.rep("    ", u56.LogIndent);
    warn((`{string_rep_ret}[SmartBone][Warn]: {p62}`));
end;

function u56.SB_VERBOSE_ERROR(p63: string) -- Line: 285
    -- upvalues: Config (copy), u56 (copy)
    if not Config.LOG_VERBOSE then
        return;
    end;

    local string_rep_ret = string.rep("    ", u56.LogIndent);
    error((`{string_rep_ret}[SmartBone][Error]: {p63}`));
end;

return u56;