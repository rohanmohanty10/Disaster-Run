  

game:GetService("ReplicatedStorage");
local GlobalConfig = require(script.Parent.Parent.Components.GlobalConfig);

local function NormalizeAngle(p1: number) -- Line: 47
    local math_deg_ret = math.deg(p1);

    while math_deg_ret > 180 do
        math_deg_ret = math_deg_ret - 360;
    end;

    while math_deg_ret <= -180 do
        math_deg_ret = math_deg_ret + 360;
    end;

    return math.rad(math_deg_ret);
end;

local function NormalizeCFrameOrientation(p2) -- Line: 54
    local v3, v4, v5 = p2:ToEulerAnglesXYZ();
    local math_deg_ret = math.deg(v3);

    while math_deg_ret > 180 do
        math_deg_ret = math_deg_ret - 360;
    end;

    while math_deg_ret <= -180 do
        math_deg_ret = math_deg_ret + 360;
    end;

    local math_rad_ret = math.rad(math_deg_ret);
    local math_deg_ret2 = math.deg(v4);

    while math_deg_ret2 > 180 do
        math_deg_ret2 = math_deg_ret2 - 360;
    end;

    while math_deg_ret2 <= -180 do
        math_deg_ret2 = math_deg_ret2 + 360;
    end;

    local math_rad_ret2 = math.rad(math_deg_ret2);
    local math_deg_ret3 = math.deg(v5);

    while math_deg_ret3 > 180 do
        math_deg_ret3 = math_deg_ret3 - 360;
    end;

    while math_deg_ret3 <= -180 do
        math_deg_ret3 = math_deg_ret3 + 360;
    end;

    local math_rad_ret3 = math.rad(math_deg_ret3);
    local v6 = math.abs(math_rad_ret) - 3.141592653589793;

    if math.abs(v6) < 0.000017453292519943296 then
        local math_deg_ret4 = math.deg(math_rad_ret3 + 3.141592653589793);
        math_rad_ret = 0;

        while math_deg_ret4 > 180 do
            math_deg_ret4 = math_deg_ret4 - 360;
        end;

        while math_deg_ret4 <= -180 do
            math_deg_ret4 = math_deg_ret4 + 360;
        end;

        math_rad_ret3 = math.rad(math_deg_ret4);
    end;

    local v7 = math.abs(math_rad_ret3) - 3.141592653589793;

    if math.abs(v7) < 0.000017453292519943296 then
        local math_deg_ret4 = math.deg(math_rad_ret + 3.141592653589793);
        math_rad_ret3 = 0;

        while math_deg_ret4 > 180 do
            math_deg_ret4 = math_deg_ret4 - 360;
        end;

        while math_deg_ret4 <= -180 do
            math_deg_ret4 = math_deg_ret4 + 360;
        end;

        math_rad_ret = math.rad(math_deg_ret4);
    end;

    return CFrame.Angles(math_rad_ret, math_rad_ret2, math_rad_ret3);
end;

local function ClampForInt16(p8: any, p9: string) -- Line: 65
    local math_clamp_ret = math.clamp(p8, -32768, 32767);

    return math_clamp_ret, math_clamp_ret ~= p8;
end;

return {
    AddPlayerOwnedNetworkPartConstraints = function(p10, p11) -- Line: 77, Name: AddPlayerOwnedNetworkPartConstraints
        local AlignOrientation = Instance.new("AlignOrientation");
        local AlignPosition = Instance.new("AlignPosition");
        local Attachment = Instance.new("Attachment");
        local Attachment2 = Instance.new("Attachment");
        Attachment.Parent = p10;
        Attachment2.Parent = p11;
        AlignPosition.Attachment0 = Attachment;
        AlignPosition.Attachment1 = Attachment2;
        AlignPosition.MaxForce = 4000;
        AlignPosition.MaxVelocity = (1 / 0);
        AlignPosition.Responsiveness = 200;
        AlignPosition.RigidityEnabled = true;
        AlignPosition.Parent = p10;
        AlignOrientation.Attachment0 = Attachment;
        AlignOrientation.Attachment1 = Attachment2;
        AlignOrientation.MaxTorque = 4000;
        AlignOrientation.MaxAngularVelocity = (1 / 0);
        AlignOrientation.Responsiveness = 200;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.Parent = p10;

        return AlignOrientation, AlignPosition, Attachment, Attachment2;
    end,

    IsVelocityOrCFrameRedundant = function(p12, p13) -- Line: 110, Name: IsVelocityOrCFrameRedundant
        -- upvalues: GlobalConfig (copy)
        if typeof(p12) ~= typeof(p13) then
            return false;
        end;

        local function ClampVector3(p14: vector, p15: number) -- Line: 113
            if (p15 or 1) < p14.Magnitude then
                return p14.Unit * (p15 or 1);
            end;

            return p14;
        end;

        local Optimizations = GlobalConfig.Optimizations;

        if typeof(p12) ~= "Vector3" then
            if typeof(p12) ~= "CFrame" then
                warn("Unrecognized type: " .. typeof(p12), debug.traceback());

                return false;
            end;

            if p12.LookVector:Dot(p13.LookVector) < Optimizations.IgnoreRedundantRootCFrameUpdates.DotResemblance then
                return false;
            end;

            if p12.UpVector:Dot(p13.UpVector) < Optimizations.IgnoreRedundantRootCFrameUpdates.DotResemblance then
                return false;
            end;

            return (p12.Position - p13.Position).Magnitude <= Optimizations.IgnoreRedundantRootCFrameUpdates.PositionalCutoff;
        end;

        local Magnitude = p12.Magnitude;
        local Magnitude2 = p13.Magnitude;

        if Magnitude > 0.01 and Magnitude2 > 0.01 then
            if p12.Magnitude > 1 then
                p12 = p12.Unit * 1;
            end;

            if p13.Magnitude > 1 then
                p13 = p13.Unit * 1;
            end;

            if p12:Dot(p13) < Optimizations.IgnoreRedundantVelocityUpdates.DotResemblance then
                return false;
            end;
        elseif Magnitude <= 0.01 and Magnitude2 <= 0.01 then
            return true;
        end;

        if math.abs(Magnitude - Magnitude2) >= Optimizations.IgnoreRedundantVelocityUpdates.MagnitudeCutoff.Studs then
            return false;
        end;

        return math.abs(1 - Magnitude / Magnitude2) <= Optimizations.IgnoreRedundantVelocityUpdates.MagnitudeCutoff.Percent / 100;
    end,

    Serialize = function(p16: any, p17: table) -- Line: 158, Name: Serialize
        -- upvalues: GlobalConfig (copy), NormalizeCFrameOrientation (copy)
        local v18 = p17 or {};

        if typeof(p16) == "Vector3" then
            if not GlobalConfig.Optimizations.UseSmartCompression.RootVelocity then
                return p16;
            end;

            local v19 = 10 ^ (v18.DecimalPrecision or 1);
            local v20 = p16.X * v19;
            local math_clamp_ret = math.clamp(v20, -32768, 32767);
            local v21 = p16.Y * v19;
            local math_clamp_ret2 = math.clamp(v21, -32768, 32767);
            local v22 = p16.Z * v19;
            local math_clamp_ret3 = math.clamp(v22, -32768, 32767);

            if math_clamp_ret ~= v20 or (math_clamp_ret2 ~= v21 or math_clamp_ret3 ~= v22) then
                return p16;
            end;

            return Vector3int16.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
        end;

        if typeof(p16) ~= "CFrame" then
            warn("Unrecognized type: " .. typeof(p16), debug.traceback());

            return p16;
        end;

        if not GlobalConfig.Optimizations.UseSmartCompression.RootCFrame then
            return p16;
        end;

        local v23, _, v24 = NormalizeCFrameOrientation(p16):ToEulerAnglesXYZ();
        local math_deg_ret = math.deg(v23);

        if math.abs(math_deg_ret) < 1 then
            local math_deg_ret2 = math.deg(v24);

            if math.abs(math_deg_ret2) < 1 then
                local LookVector = p16.LookVector;
                local math_atan2_ret = math.atan2(-LookVector.X, -LookVector.Z);
                local math_deg_ret3 = math.deg(math_atan2_ret);

                if math_deg_ret3 < 0 then
                    math_deg_ret3 = math_deg_ret3 + 360;
                end;

                local math_rad_ret = math.rad(math_deg_ret3);
                local Position = p16.Position;
                local v25 = 10 ^ (v18.DecimalPrecision or 1);
                local v26 = Position.X * v25;
                local math_clamp_ret = math.clamp(v26, -32768, 32767);
                local v27 = Position.Y * v25;
                local math_clamp_ret2 = math.clamp(v27, -32768, 32767);
                local v28 = Position.Z * v25;
                local math_clamp_ret3 = math.clamp(v28, -32768, 32767);
                local v29 = math_rad_ret * 5000;
                local math_clamp_ret4 = math.clamp(v29, -32768, 32767);

                if math_clamp_ret ~= v26 or (math_clamp_ret2 ~= v27 or (math_clamp_ret3 ~= v28 or math_clamp_ret4 ~= v29)) then
                    return p16;
                end;

                return Vector2int16.new(math_clamp_ret, math_clamp_ret2), Vector2int16.new(math_clamp_ret3, math_clamp_ret4);
            end;
        end;

        local v30, v31, v32 = p16:ToEulerAnglesXYZ();
        local Position = p16.Position;
        local v33 = 10 ^ (v18.DecimalPrecision or 1);
        local v34 = Position.X * v33;
        local math_clamp_ret = math.clamp(v34, -32768, 32767);
        local v35 = Position.Y * v33;
        local math_clamp_ret2 = math.clamp(v35, -32768, 32767);
        local v36 = Position.Z * v33;
        local math_clamp_ret3 = math.clamp(v36, -32768, 32767);
        local v37 = v30 * 5000;
        local math_clamp_ret4 = math.clamp(v37, -32768, 32767);
        local v38 = v31 * 5000;
        local math_clamp_ret5 = math.clamp(v38, -32768, 32767);
        local v39 = v32 * 5000;
        local math_clamp_ret6 = math.clamp(v39, -32768, 32767);

        if math_clamp_ret ~= v34 or (math_clamp_ret2 ~= v35 or (math_clamp_ret3 ~= v36 or (math_clamp_ret4 ~= v37 or (math_clamp_ret5 ~= v38 or math_clamp_ret6 ~= v39)))) then
            return p16;
        end;

        return Vector3int16.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3), Vector3int16.new(math_clamp_ret4, math_clamp_ret5, math_clamp_ret6);
    end,

    Deserialize = function(p40: any, p41: table) -- Line: 237, Name: Deserialize
        local v42 = p41 or {};

        if typeof(p40[1]) == "Vector3int16" and p40[2] == nil then
            local v43 = p40[1];
            local v44 = 10 ^ (v42.DecimalPrecision or 1);

            return Vector3.new(v43.X / v44, v43.Y / v44, v43.Z / v44);
        end;

        if typeof(p40[1]) == "Vector3int16" and typeof(p40[2]) == "Vector3int16" then
            local v45 = 10 ^ (v42.DecimalPrecision or 1);
            local v46 = p40[1];
            local v47 = p40[2];
            local Vector3_new_ret = Vector3.new(v46.X / v45, v46.Y / v45, v46.Z / v45);
            local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ(v47.X / 5000, v47.Y / 5000, v47.Z / 5000);

            return CFrame.new(Vector3_new_ret) * CFrame_fromEulerAnglesXYZ_ret;
        end;

        if typeof(p40[1]) == "Vector2int16" and typeof(p40[2]) == "Vector2int16" then
            local v48 = 10 ^ (v42.DecimalPrecision or 1);
            local v49 = p40[1];
            local v50 = p40[2];
            local Vector3_new_ret = Vector3.new(v49.X / v48, v49.Y / v48, v50.X / v48);
            local CFrame_fromEulerAnglesXYZ_ret = CFrame.fromEulerAnglesXYZ(0, v50.Y / 5000, 0);

            return CFrame.new(Vector3_new_ret) * CFrame_fromEulerAnglesXYZ_ret;
        end;

        if typeof(p40[1]) == "CFrame" then
            return p40[1];
        end;

        if typeof(p40[1]) == "Vector3" then
            return p40[1];
        end;

        error("Unable to determine serialization protocol for: " .. debug.traceback());
    end
};