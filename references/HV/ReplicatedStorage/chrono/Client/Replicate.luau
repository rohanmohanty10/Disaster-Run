 

 

local Shared = script.Parent.Parent.Shared;
local RunService = game:GetService("RunService");
local Ticker = require(Shared.Ticker);
local Warn = require(Shared.Warn);
local Stats = require(script.Parent.Parent.Shared.Stats);
local ApplyMounts = require(script.Parent.Parent.Shared.ApplyMounts);
local AlignDriver = require(Shared.AlignDriver);
local ClientClock = require(script.Parent.ClientClock);
local ModelResolver = require(script.Parent.ModelResolver);
local Entity = require(Shared.Entity);
local Holder = require(Shared.Holder);
local Config = require(Shared.Config);
require(Shared.Types);
local Sender = require(script.Parent.Sender);
local CLIENT = require(Shared.Stats).CLIENT;
require(script.Parent.Player);
require(script.Parent.Receiver);
local idMap = Holder.idMap;
local u1 = Vector3.new(0, 0, -1);
local u2 = Vector3.new(1, 0, 0);
local u3 = Vector3.new(0, 1, 0);
local u4 = Vector3.new(0, 0, 0);
local u5 = 0;
local u6 = 0;

local function PrepareFrustumCheck() -- Line: 32
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref)
    local CFrame = workspace.CurrentCamera.CFrame;
    u1 = CFrame.LookVector;
    u2 = CFrame.RightVector;
    u3 = CFrame.UpVector;
    u4 = CFrame.Position;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
    local v7 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y;
    u5 = math.tan(math_rad_ret) * v7;
    u6 = math.tan(math_rad_ret);
end;

local function CheckPointInFrustum(p8: vector) -- Line: 47
    -- upvalues: u4 (ref), u1 (ref), u2 (ref), u5 (ref), u3 (ref), u6 (ref)
    local v9 = p8 - u4;
    local vector_magnitude_ret = vector.magnitude(v9);

    if vector_magnitude_ret == 0 then
        return true;
    end;

    local vector_dot_ret = vector.dot(v9, u1);
    local v10 = vector_dot_ret / vector_magnitude_ret;

    if v10 < 0 then
        return false;
    end;

    if vector_dot_ret < 1 then
        return true;
    end;

    local v11 = v9 / vector_magnitude_ret;
    local vector_dot_ret2 = vector.dot(v11, u2);

    if math.abs(vector_dot_ret2) > v10 * u5 then
        return false;
    end;

    local vector_dot_ret3 = vector.dot(v11, u3);

    return math.abs(vector_dot_ret3) <= v10 * u6;
end;

local function CheckBroadPhaseInFrustum(p12: vector, p13: vector) -- Line: 79
    -- upvalues: u4 (ref), u1 (ref), u2 (ref), u5 (ref), u3 (ref), u6 (ref)
    if p13 == Vector3.new(0, 0, 0) then
        local v14 = p12 - u4;
        local vector_magnitude_ret = vector.magnitude(v14);

        if vector_magnitude_ret == 0 then
            return true;
        end;

        local vector_dot_ret = vector.dot(v14, u1);
        local v15 = vector_dot_ret / vector_magnitude_ret;

        if v15 < 0 then
            return false;
        end;

        if vector_dot_ret < 1 then
            return true;
        end;

        local v16 = v14 / vector_magnitude_ret;
        local vector_dot_ret2 = vector.dot(v16, u2);

        if math.abs(vector_dot_ret2) > v15 * u5 then
            return false;
        end;

        local vector_dot_ret3 = vector.dot(v16, u3);

        return math.abs(vector_dot_ret3) <= v15 * u6;
    end;

    local v17 = p13 * 0.5;
    local x = v17.x;
    local y = v17.y;
    local z = v17.z;
    local v18 = -x;
    local v19 = -y;
    local v20 = -z;
    local v21 = p12 + vector.create(x, y, z) - u4;
    local vector_magnitude_ret = vector.magnitude(v21);
    local v22;

    if vector_magnitude_ret == 0 then
        v22 = true;
    else
        local vector_dot_ret = vector.dot(v21, u1);
        local v23 = vector_dot_ret / vector_magnitude_ret;

        if v23 < 0 then
            v22 = false;
        elseif vector_dot_ret < 1 then
            v22 = true;
        else
            local v24 = v21 / vector_magnitude_ret;
            local vector_dot_ret2 = vector.dot(v24, u2);

            if math.abs(vector_dot_ret2) > v23 * u5 then
                v22 = false;
            else
                local vector_dot_ret3 = vector.dot(v24, u3);
                v22 = math.abs(vector_dot_ret3) <= v23 * u6;
            end;
        end;
    end;

    if not v22 then
        local v25 = p12 + vector.create(v18, y, z) - u4;
        local vector_magnitude_ret2 = vector.magnitude(v25);

        if vector_magnitude_ret2 == 0 then
            v22 = true;
        else
            local vector_dot_ret = vector.dot(v25, u1);
            local v26 = vector_dot_ret / vector_magnitude_ret2;

            if v26 < 0 then
                v22 = false;
            elseif vector_dot_ret < 1 then
                v22 = true;
            else
                local v27 = v25 / vector_magnitude_ret2;
                local vector_dot_ret2 = vector.dot(v27, u2);

                if math.abs(vector_dot_ret2) > v26 * u5 then
                    v22 = false;
                else
                    local vector_dot_ret3 = vector.dot(v27, u3);
                    v22 = math.abs(vector_dot_ret3) <= v26 * u6;
                end;
            end;
        end;

        if not v22 then
            local v28 = p12 + vector.create(x, v19, z) - u4;
            local vector_magnitude_ret3 = vector.magnitude(v28);

            if vector_magnitude_ret3 == 0 then
                v22 = true;
            else
                local vector_dot_ret = vector.dot(v28, u1);
                local v29 = vector_dot_ret / vector_magnitude_ret3;

                if v29 < 0 then
                    v22 = false;
                elseif vector_dot_ret < 1 then
                    v22 = true;
                else
                    local v30 = v28 / vector_magnitude_ret3;
                    local vector_dot_ret2 = vector.dot(v30, u2);

                    if math.abs(vector_dot_ret2) > v29 * u5 then
                        v22 = false;
                    else
                        local vector_dot_ret3 = vector.dot(v30, u3);
                        v22 = math.abs(vector_dot_ret3) <= v29 * u6;
                    end;
                end;
            end;

            if not v22 then
                local v31 = p12 + vector.create(v18, v19, z) - u4;
                local vector_magnitude_ret4 = vector.magnitude(v31);

                if vector_magnitude_ret4 == 0 then
                    v22 = true;
                else
                    local vector_dot_ret = vector.dot(v31, u1);
                    local v32 = vector_dot_ret / vector_magnitude_ret4;

                    if v32 < 0 then
                        v22 = false;
                    elseif vector_dot_ret < 1 then
                        v22 = true;
                    else
                        local v33 = v31 / vector_magnitude_ret4;
                        local vector_dot_ret2 = vector.dot(v33, u2);

                        if math.abs(vector_dot_ret2) > v32 * u5 then
                            v22 = false;
                        else
                            local vector_dot_ret3 = vector.dot(v33, u3);
                            v22 = math.abs(vector_dot_ret3) <= v32 * u6;
                        end;
                    end;
                end;

                if not v22 then
                    local v34 = p12 + vector.create(x, y, v20) - u4;
                    local vector_magnitude_ret5 = vector.magnitude(v34);

                    if vector_magnitude_ret5 == 0 then
                        v22 = true;
                    else
                        local vector_dot_ret = vector.dot(v34, u1);
                        local v35 = vector_dot_ret / vector_magnitude_ret5;

                        if v35 < 0 then
                            v22 = false;
                        elseif vector_dot_ret < 1 then
                            v22 = true;
                        else
                            local v36 = v34 / vector_magnitude_ret5;
                            local vector_dot_ret2 = vector.dot(v36, u2);

                            if math.abs(vector_dot_ret2) > v35 * u5 then
                                v22 = false;
                            else
                                local vector_dot_ret3 = vector.dot(v36, u3);
                                v22 = math.abs(vector_dot_ret3) <= v35 * u6;
                            end;
                        end;
                    end;

                    if not v22 then
                        local v37 = p12 + vector.create(v18, y, v20) - u4;
                        local vector_magnitude_ret6 = vector.magnitude(v37);

                        if vector_magnitude_ret6 == 0 then
                            v22 = true;
                        else
                            local vector_dot_ret = vector.dot(v37, u1);
                            local v38 = vector_dot_ret / vector_magnitude_ret6;

                            if v38 < 0 then
                                v22 = false;
                            elseif vector_dot_ret < 1 then
                                v22 = true;
                            else
                                local v39 = v37 / vector_magnitude_ret6;
                                local vector_dot_ret2 = vector.dot(v39, u2);

                                if math.abs(vector_dot_ret2) > v38 * u5 then
                                    v22 = false;
                                else
                                    local vector_dot_ret3 = vector.dot(v39, u3);
                                    v22 = math.abs(vector_dot_ret3) <= v38 * u6;
                                end;
                            end;
                        end;

                        if not v22 then
                            local v40 = p12 + vector.create(x, v19, v20) - u4;
                            local vector_magnitude_ret7 = vector.magnitude(v40);

                            if vector_magnitude_ret7 == 0 then
                                v22 = true;
                            else
                                local vector_dot_ret = vector.dot(v40, u1);
                                local v41 = vector_dot_ret / vector_magnitude_ret7;

                                if v41 < 0 then
                                    v22 = false;
                                elseif vector_dot_ret < 1 then
                                    v22 = true;
                                else
                                    local v42 = v40 / vector_magnitude_ret7;
                                    local vector_dot_ret2 = vector.dot(v42, u2);

                                    if math.abs(vector_dot_ret2) > v41 * u5 then
                                        v22 = false;
                                    else
                                        local vector_dot_ret3 = vector.dot(v42, u3);
                                        v22 = math.abs(vector_dot_ret3) <= v41 * u6;
                                    end;
                                end;
                            end;

                            if not v22 then
                                local v43 = p12 + vector.create(v18, v19, v20) - u4;
                                local vector_magnitude_ret8 = vector.magnitude(v43);

                                if vector_magnitude_ret8 == 0 then
                                    return true;
                                end;

                                local vector_dot_ret = vector.dot(v43, u1);
                                local v44 = vector_dot_ret / vector_magnitude_ret8;

                                if v44 < 0 then
                                    return false;
                                end;

                                if vector_dot_ret < 1 then
                                    return true;
                                end;

                                local v45 = v43 / vector_magnitude_ret8;
                                local vector_dot_ret2 = vector.dot(v45, u2);

                                if math.abs(vector_dot_ret2) > v44 * u5 then
                                    return false;
                                end;

                                local vector_dot_ret3 = vector.dot(v45, u3);

                                if math.abs(vector_dot_ret3) > v44 * u6 then
                                    return false;
                                end;

                                v22 = true;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v22;
end;

local u46 = 0;
local u47 = 0;
local u48 = 0;
local u49 = 0;
local u50 = 0;
local u51 = 0;
local u52 = 0;
local os_clock_ret = os.clock();

local function Interpolate(p53: any, p54: boolean?) -- Line: 112
    -- upvalues: Entity (copy), Warn (copy), u47 (ref), u50 (ref), os_clock_ret (ref), CheckBroadPhaseInFrustum (copy), u51 (ref), u46 (ref), AlignDriver (copy), u52 (ref)
    local entityConfig = p53.entityConfig;
    local v55 = p53._interpolationMode or entityConfig.INTERPOLATION_MODE;

    if not (p53.interpolation and (not entityConfig.CUSTOM_INTERPOLATION and v55 ~= "NONE")) then
        return;
    end;

    if v55 == "ALIGN" ~= (p54 == true) then
        return false;
    end;

    local PrimaryPart = Entity.GetPrimaryPart(p53);

    if not PrimaryPart then
        return;
    end;

    if p53.isContextOwner then
        return;
    end;

    local _alignDriver = p53._alignDriver;

    if entityConfig.ASSEMBLY_ROOT_PART_CHECK and (not _alignDriver and PrimaryPart.AssemblyRootPart ~= PrimaryPart) then
        Warn.low("Primary part for entity " .. p53.id .. " is not the assembly root part. Skipping interpolation for this entity.");

        return;
    end;

    local _outofBroadPhaseTick = p53._outofBroadPhaseTick;

    if _outofBroadPhaseTick and _outofBroadPhaseTick ~= u47 then
        return;
    end;

    local snapshot = p53.snapshot;

    if not snapshot then
        Warn.medium("No snapshot for entity", p53);

        return;
    end;

    u50 = u50 + 1;
    debug.profilebegin("Get Render CFrame");
    local TargetRenderTime = Entity.GetTargetRenderTime(p53);

    if p54 then
        TargetRenderTime = TargetRenderTime + (os.clock() - os_clock_ret);
    end;

    local At = snapshot:GetAt(TargetRenderTime);
    debug.profileend();

    if not At then
        return;
    end;

    local broadPhase = p53.broadPhase;

    if broadPhase then
        local lastCheckedCFrame = p53.lastCheckedCFrame;
        debug.profilebegin("Prepare Frustum");
        local v56 = CheckBroadPhaseInFrustum(At.Position, broadPhase);
        debug.profileend();

        if not v56 then
            if not lastCheckedCFrame or lastCheckedCFrame.Position == At.Position then
                if not lastCheckedCFrame then
                    p53.lastCheckedCFrame = At;
                end;

                if not p53._outofBroadPhaseTick then
                    p53._outofBroadPhaseTick = u46;
                    u46 = u46 + 1;

                    if u46 % 4 == 0 then
                        u46 = 0;
                    end;
                end;

                u51 = u51 + 1;

                return;
            end;

            debug.profilebegin("Check Last CFrame");
            local v57 = CheckBroadPhaseInFrustum(lastCheckedCFrame.Position, broadPhase);
            debug.profileend();

            if not v57 then
                u51 = u51 + 1;

                return;
            end;
        end;

        p53.lastCheckedCFrame = nil;
        p53._outofBroadPhaseTick = nil;
    end;

    debug.profilebegin("Set CFrame");

    if At == At then
        if v55 == "ALIGN" then
            if _alignDriver and _alignDriver.part ~= PrimaryPart then
                AlignDriver.Destroy(_alignDriver);
                _alignDriver = nil;
            end;

            local v58 = _alignDriver or AlignDriver.Create(PrimaryPart);
            p53._alignDriver = v58;
            AlignDriver.Update(v58, At);
        else
            if _alignDriver then
                AlignDriver.Destroy(_alignDriver);
                p53._alignDriver = nil;
            end;

            PrimaryPart.CFrame = At;
        end;
    end;

    u52 = u52 + 1;
    debug.profileend();
end;

local function updateEntityStats() -- Line: 227
    -- upvalues: Stats (copy), CLIENT (copy), idMap (copy), ClientClock (copy), Entity (copy)
    if not Stats.SERVER._SHOULD_REPLICATE or CLIENT._PAUSE then
        return;
    end;

    local v59 = {};

    for _, v in idMap do
        local id = v.id;
        local entityConfig = v.entityConfig;
        local v60 = entityConfig and entityConfig.NAME or "DEFAULT";
        local networkOwner = v.networkOwner;
        local v61 = v._player ~= nil;
        local v62 = v.latestTime or 0;
        local v63 = v.lastReplicatedTime or 0;
        local _clientClock = v._clientClock;

        if not _clientClock then
            local CLIENT_CLOCK = v.entityConfig.CLIENT_CLOCK;

            if CLIENT_CLOCK then
                _clientClock = v.isHalfTicked and CLIENT_CLOCK.HALF or CLIENT_CLOCK.NORMAL;
            end;
        end;

        local v64 = 0;
        local v65 = 0;
        local v66, v67;

        if _clientClock then
            v66 = _clientClock:GetTargetRenderTime();
            local buffer = _clientClock.buffer;

            if buffer then
                v64 = buffer.averageLatency;
                v65 = buffer.deviation;
            end;

            v67 = ClientClock._getBuffer(_clientClock);
        else
            v67 = 0;
            v66 = 0;
        end;

        local PrimaryPart = Entity.GetPrimaryPart(v);
        local snapshot = v.snapshot;

        if PrimaryPart then
            PrimaryPart = PrimaryPart.Position;
        end;

        local v68 = {};
        local v69;

        if snapshot then
            v69 = v;

            for _, v2 in snapshot.cache do
                table.insert(v68, {
                    t = v2.t,
                    value = v2.value,
                    velocity = v2.velocity
                });
            end;

            table.sort(v68, function(p70, p71) -- Line: 273
                return p70.t > p71.t;
            end);
        else
            v69 = v;
        end;

        table.insert(v59, {
            id = id,
            entity = v69,
            networkOwner = networkOwner,
            isCharacter = v61,
            config = v60,
            lastReceivedTime = v62,
            lastReplicatedTime = v63,
            targetTime = v66,
            averageLatency = v64,
            deviation = v65,
            bufferedTime = v67,
            currentPosition = PrimaryPart,
            snapshots = v68
        });
    end;

    CLIENT.CLIENT_ENTITIES = v59;
end;

Config._WaitForLock(function() -- Line: 296
    -- upvalues: RunService (copy), u47 (ref), CLIENT (copy), u51 (ref), ClientClock (copy), os_clock_ret (ref), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), idMap (copy), ModelResolver (copy), Interpolate (copy), updateEntityStats (copy), u48 (ref), u49 (ref), ApplyMounts (copy), u52 (ref), u50 (ref), Sender (copy), Ticker (copy), Shared (copy)
    local u72 = {};
    RunService.Heartbeat:Connect(function(p73: number) -- Line: 298
        -- upvalues: u72 (ref), u47 (ref), CLIENT (ref), u51 (ref), ClientClock (ref), os_clock_ret (ref), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), idMap (ref), ModelResolver (ref), Interpolate (ref), updateEntityStats (ref), u48 (ref), u49 (ref), ApplyMounts (ref), u52 (ref), u50 (ref), Sender (ref), Ticker (ref)
        u72 = {};
        u47 = u47 + 1;

        if u47 % 4 == 0 then
            CLIENT.TOTAL_ENTITIES_CULLED = u51;
            u51 = 0;
            u47 = 0;
        end;

        ClientClock.UpdateAll(p73);
        os_clock_ret = os.clock();
        debug.profilebegin("Prepare Frustum Check");
        local CFrame = workspace.CurrentCamera.CFrame;
        u1 = CFrame.LookVector;
        u2 = CFrame.RightVector;
        u3 = CFrame.UpVector;
        u4 = CFrame.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
        local v74 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y;
        u5 = math.tan(math_rad_ret) * v74;
        u6 = math.tan(math_rad_ret);
        debug.profileend();
        local os_clock_ret2 = os.clock();
        debug.profilebegin("Interpolate Entities");
        local v75 = 0;

        for _, v in idMap do
            ModelResolver(v);

            if not (v.destroyed or (v.paused or v.mountParentId)) then
                v75 = v75 + 1;

                if Interpolate(v) == false then
                    table.insert(u72, v);
                end;
            end;
        end;

        debug.profileend();
        local os_clock_ret3 = os.clock();
        debug.profilebegin("Update Entity Stats");
        updateEntityStats();
        debug.profileend();
        u48 = u48 + (os_clock_ret3 - os_clock_ret2);
        u49 = u49 + 1;
        ApplyMounts();

        if not CLIENT._PAUSE then
            CLIENT.TOTAL_CLIENT_ENTITIES_CHECKED_THIS_FRAME = v75;
            CLIENT.ENTITIES_MOVED_THIS_FRAME = u52;
            CLIENT.TOTAL_CLIENT_ENTITIES = v75;
            CLIENT.AVG_INTERPOLATION_TIME_MS = u48 / u49 * 1000;
        end;

        u52 = 0;
        u50 = 0;

        if u49 > 60 then
            u48 = 0;
            u49 = 0;
        end;

        Sender.Update();
        Ticker._IncrementGlobalTick();
    end);
    RunService.PreSimulation:Connect(function() -- Line: 352
        -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u72 (ref), Interpolate (ref)
        debug.profilebegin("Interpolate Align Entities");
        local CFrame = workspace.CurrentCamera.CFrame;
        u1 = CFrame.LookVector;
        u2 = CFrame.RightVector;
        u3 = CFrame.UpVector;
        u4 = CFrame.Position;
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local math_rad_ret = math.rad(workspace_CurrentCamera.FieldOfView / 2);
        local v76 = workspace_CurrentCamera.ViewportSize.X / workspace_CurrentCamera.ViewportSize.Y;
        u5 = math.tan(math_rad_ret) * v76;
        u6 = math.tan(math_rad_ret);

        for _, v in u72 do
            if not (v.destroyed or (v.paused or v.mountParentId)) then
                Interpolate(v, true);
            end;
        end;

        debug.profileend();
    end);
    local ClientHeartbeat = Shared.Remotes.ClientHeartbeat;
    ClientHeartbeat:FireServer(os.clock());
    local u77 = 0;
    RunService.Heartbeat:Connect(function(p78: number) -- Line: 368
        -- upvalues: u77 (ref), ClientHeartbeat (copy)
        u77 = u77 + p78;

        if u77 >= 15 then
            u77 = 0;
            ClientHeartbeat:FireServer(os.clock());
        end;
    end);
    Shared.Remotes.ClientLoaded:FireServer();
end);

return nil;