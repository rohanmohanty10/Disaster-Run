 
 

local Shared = script.Parent.Parent.Shared;
require(Shared.Types);
local CLIENT = require(Shared.Stats).CLIENT;
local u1 = Vector3.new(0, 0, -1);
local u2 = Vector3.new(1, 0, 0);
local u3 = Vector3.new(0, 1, 0);
local u4 = Vector3.new(0, 0, 0);
local u5 = 0;
local u6 = 0;
local u7 = 0;
local u8 = 0;
local u9 = 0;
local v10 = {};

local function CheckPoint(p11: vector) -- Line: 36
    -- upvalues: u4 (ref), u1 (ref), u2 (ref), u5 (ref), u3 (ref), u6 (ref)
    local v12 = p11 - u4;
    local vector_magnitude_ret = vector.magnitude(v12);

    if vector_magnitude_ret == 0 then
        return true;
    end;

    local vector_dot_ret = vector.dot(v12, u1);
    local v13 = vector_dot_ret / vector_magnitude_ret;

    if v13 < 0 then
        return false;
    end;

    if vector_dot_ret < 1 then
        return true;
    end;

    local v14 = v12 / vector_magnitude_ret;
    local vector_dot_ret2 = vector.dot(v14, u2);

    if math.abs(vector_dot_ret2) > v13 * u5 then
        return false;
    end;

    local vector_dot_ret3 = vector.dot(v14, u3);

    return math.abs(vector_dot_ret3) <= v13 * u6;
end;

local function CheckBroadPhase(p15: vector, p16: vector) -- Line: 68
    -- upvalues: u4 (ref), u1 (ref), u2 (ref), u5 (ref), u3 (ref), u6 (ref)
    if p16 == Vector3.new(0, 0, 0) then
        local v17 = p15 - u4;
        local vector_magnitude_ret = vector.magnitude(v17);

        if vector_magnitude_ret == 0 then
            return true;
        end;

        local vector_dot_ret = vector.dot(v17, u1);
        local v18 = vector_dot_ret / vector_magnitude_ret;

        if v18 < 0 then
            return false;
        end;

        if vector_dot_ret < 1 then
            return true;
        end;

        local v19 = v17 / vector_magnitude_ret;
        local vector_dot_ret2 = vector.dot(v19, u2);

        if math.abs(vector_dot_ret2) > v18 * u5 then
            return false;
        end;

        local vector_dot_ret3 = vector.dot(v19, u3);

        return math.abs(vector_dot_ret3) <= v18 * u6;
    end;

    local v20 = p16 * 0.5;
    local x = v20.x;
    local y = v20.y;
    local z = v20.z;
    local v21 = -x;
    local v22 = -y;
    local v23 = -z;
    local v24 = p15 + vector.create(x, y, z) - u4;
    local vector_magnitude_ret = vector.magnitude(v24);
    local v25;

    if vector_magnitude_ret == 0 then
        v25 = true;
    else
        local vector_dot_ret = vector.dot(v24, u1);
        local v26 = vector_dot_ret / vector_magnitude_ret;

        if v26 < 0 then
            v25 = false;
        elseif vector_dot_ret < 1 then
            v25 = true;
        else
            local v27 = v24 / vector_magnitude_ret;
            local vector_dot_ret2 = vector.dot(v27, u2);

            if math.abs(vector_dot_ret2) > v26 * u5 then
                v25 = false;
            else
                local vector_dot_ret3 = vector.dot(v27, u3);
                v25 = math.abs(vector_dot_ret3) <= v26 * u6;
            end;
        end;
    end;

    if not v25 then
        local v28 = p15 + vector.create(v21, y, z) - u4;
        local vector_magnitude_ret2 = vector.magnitude(v28);

        if vector_magnitude_ret2 == 0 then
            v25 = true;
        else
            local vector_dot_ret = vector.dot(v28, u1);
            local v29 = vector_dot_ret / vector_magnitude_ret2;

            if v29 < 0 then
                v25 = false;
            elseif vector_dot_ret < 1 then
                v25 = true;
            else
                local v30 = v28 / vector_magnitude_ret2;
                local vector_dot_ret2 = vector.dot(v30, u2);

                if math.abs(vector_dot_ret2) > v29 * u5 then
                    v25 = false;
                else
                    local vector_dot_ret3 = vector.dot(v30, u3);
                    v25 = math.abs(vector_dot_ret3) <= v29 * u6;
                end;
            end;
        end;

        if not v25 then
            local v31 = p15 + vector.create(x, v22, z) - u4;
            local vector_magnitude_ret3 = vector.magnitude(v31);

            if vector_magnitude_ret3 == 0 then
                v25 = true;
            else
                local vector_dot_ret = vector.dot(v31, u1);
                local v32 = vector_dot_ret / vector_magnitude_ret3;

                if v32 < 0 then
                    v25 = false;
                elseif vector_dot_ret < 1 then
                    v25 = true;
                else
                    local v33 = v31 / vector_magnitude_ret3;
                    local vector_dot_ret2 = vector.dot(v33, u2);

                    if math.abs(vector_dot_ret2) > v32 * u5 then
                        v25 = false;
                    else
                        local vector_dot_ret3 = vector.dot(v33, u3);
                        v25 = math.abs(vector_dot_ret3) <= v32 * u6;
                    end;
                end;
            end;

            if not v25 then
                local v34 = p15 + vector.create(v21, v22, z) - u4;
                local vector_magnitude_ret4 = vector.magnitude(v34);

                if vector_magnitude_ret4 == 0 then
                    v25 = true;
                else
                    local vector_dot_ret = vector.dot(v34, u1);
                    local v35 = vector_dot_ret / vector_magnitude_ret4;

                    if v35 < 0 then
                        v25 = false;
                    elseif vector_dot_ret < 1 then
                        v25 = true;
                    else
                        local v36 = v34 / vector_magnitude_ret4;
                        local vector_dot_ret2 = vector.dot(v36, u2);

                        if math.abs(vector_dot_ret2) > v35 * u5 then
                            v25 = false;
                        else
                            local vector_dot_ret3 = vector.dot(v36, u3);
                            v25 = math.abs(vector_dot_ret3) <= v35 * u6;
                        end;
                    end;
                end;

                if not v25 then
                    local v37 = p15 + vector.create(x, y, v23) - u4;
                    local vector_magnitude_ret5 = vector.magnitude(v37);

                    if vector_magnitude_ret5 == 0 then
                        v25 = true;
                    else
                        local vector_dot_ret = vector.dot(v37, u1);
                        local v38 = vector_dot_ret / vector_magnitude_ret5;

                        if v38 < 0 then
                            v25 = false;
                        elseif vector_dot_ret < 1 then
                            v25 = true;
                        else
                            local v39 = v37 / vector_magnitude_ret5;
                            local vector_dot_ret2 = vector.dot(v39, u2);

                            if math.abs(vector_dot_ret2) > v38 * u5 then
                                v25 = false;
                            else
                                local vector_dot_ret3 = vector.dot(v39, u3);
                                v25 = math.abs(vector_dot_ret3) <= v38 * u6;
                            end;
                        end;
                    end;

                    if not v25 then
                        local v40 = p15 + vector.create(v21, y, v23) - u4;
                        local vector_magnitude_ret6 = vector.magnitude(v40);

                        if vector_magnitude_ret6 == 0 then
                            v25 = true;
                        else
                            local vector_dot_ret = vector.dot(v40, u1);
                            local v41 = vector_dot_ret / vector_magnitude_ret6;

                            if v41 < 0 then
                                v25 = false;
                            elseif vector_dot_ret < 1 then
                                v25 = true;
                            else
                                local v42 = v40 / vector_magnitude_ret6;
                                local vector_dot_ret2 = vector.dot(v42, u2);

                                if math.abs(vector_dot_ret2) > v41 * u5 then
                                    v25 = false;
                                else
                                    local vector_dot_ret3 = vector.dot(v42, u3);
                                    v25 = math.abs(vector_dot_ret3) <= v41 * u6;
                                end;
                            end;
                        end;

                        if not v25 then
                            local v43 = p15 + vector.create(x, v22, v23) - u4;
                            local vector_magnitude_ret7 = vector.magnitude(v43);

                            if vector_magnitude_ret7 == 0 then
                                v25 = true;
                            else
                                local vector_dot_ret = vector.dot(v43, u1);
                                local v44 = vector_dot_ret / vector_magnitude_ret7;

                                if v44 < 0 then
                                    v25 = false;
                                elseif vector_dot_ret < 1 then
                                    v25 = true;
                                else
                                    local v45 = v43 / vector_magnitude_ret7;
                                    local vector_dot_ret2 = vector.dot(v45, u2);

                                    if math.abs(vector_dot_ret2) > v44 * u5 then
                                        v25 = false;
                                    else
                                        local vector_dot_ret3 = vector.dot(v45, u3);
                                        v25 = math.abs(vector_dot_ret3) <= v44 * u6;
                                    end;
                                end;
                            end;

                            if not v25 then
                                local v46 = p15 + vector.create(v21, v22, v23) - u4;
                                local vector_magnitude_ret8 = vector.magnitude(v46);

                                if vector_magnitude_ret8 == 0 then
                                    return true;
                                end;

                                local vector_dot_ret = vector.dot(v46, u1);
                                local v47 = vector_dot_ret / vector_magnitude_ret8;

                                if v47 < 0 then
                                    return false;
                                end;

                                if vector_dot_ret < 1 then
                                    return true;
                                end;

                                local v48 = v46 / vector_magnitude_ret8;
                                local vector_dot_ret2 = vector.dot(v48, u2);

                                if math.abs(vector_dot_ret2) > v47 * u5 then
                                    return false;
                                end;

                                local vector_dot_ret3 = vector.dot(v48, u3);

                                if math.abs(vector_dot_ret3) > v47 * u6 then
                                    return false;
                                end;

                                v25 = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v25;
end;

local function Update() -- Line: 91
    -- upvalues: u7 (ref), CLIENT (copy), u9 (ref)
    u7 = u7 + 1;

    if u7 % 4 == 0 then
        CLIENT.TOTAL_ENTITIES_CULLED = u9;
        u9 = 0;
        u7 = 0;
    end;
end;

local function IsThrottled(p49) -- Line: 100
    -- upvalues: u7 (ref)
    local _outofBroadPhaseTick = p49._outofBroadPhaseTick;
    local v50;

    if _outofBroadPhaseTick == nil then
        v50 = false;
    else
        v50 = _outofBroadPhaseTick ~= u7;
    end;

    return v50;
end;

local function IsCulled(p51: any, p52) -- Line: 105
    -- upvalues: CheckBroadPhase (copy), u9 (ref), u8 (ref)
    local broadPhase = p51.broadPhase;
    local lastCheckedCFrame = p51.lastCheckedCFrame;
    debug.profilebegin("Prepare Frustum");
    local v53 = CheckBroadPhase(p52.Position, broadPhase);
    debug.profileend();

    if not v53 then
        if not lastCheckedCFrame or lastCheckedCFrame.Position == p52.Position then
            if not lastCheckedCFrame then
                p51.lastCheckedCFrame = p52;
            end;

            if not p51._outofBroadPhaseTick then
                p51._outofBroadPhaseTick = u8;
                u8 = u8 + 1;

                if u8 % 4 == 0 then
                    u8 = 0;
                end;
            end;

            u9 = u9 + 1;

            return true;
        end;

        debug.profilebegin("Check Last CFrame");
        local v54 = CheckBroadPhase(lastCheckedCFrame.Position, broadPhase);
        debug.profileend();

        if not v54 then
            u9 = u9 + 1;

            return true;
        end;
    end;

    p51.lastCheckedCFrame = nil;
    p51._outofBroadPhaseTick = nil;

    return false;
end;

function v10.Prepare() -- Line: 21
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    local CFrame = workspace.CurrentCamera.CFrame;
    u1 = CFrame.LookVector;
    u2 = CFrame.RightVector;
    u3 = CFrame.UpVector;
    u4 = CFrame.Position;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
    local v55 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y;
    u5 = math.tan(math_rad_ret) * v55;
    u6 = math.tan(math_rad_ret);
end;

v10.CheckPoint = CheckPoint;
v10.CheckBroadPhase = CheckBroadPhase;
v10.Update = Update;
v10.IsThrottled = IsThrottled;
v10.IsCulled = IsCulled;

return v10;