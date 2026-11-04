 

 

local Shared = script.Parent.Parent.Shared;
local RunService = game:GetService("RunService");
local Ticker = require(Shared.Ticker);
local Warn = require(Shared.Warn);
local ApplyMounts = require(script.Parent.Parent.Shared.ApplyMounts);
local AlignDriver = require(script.Parent.AlignDriver);
local ClientClock = require(script.Parent.ClientClock);
local ModelResolver = require(script.Parent.ModelResolver);
local Entity = require(Shared.Entity);
local Holder = require(Shared.Holder);
local Config = require(Shared.Config);
require(Shared.Types);
local Sender = require(script.Parent.Sender);
local Frustum = require(script.Parent.Frustum);
local EntityStats = require(script.Parent.EntityStats);
local CLIENT = require(Shared.Stats).CLIENT;
require(script.Parent.Player);
require(script.Parent.Receiver);
local idMap = Holder.idMap;
local u1 = 0;
local u2 = 0;
local u3 = 0;
local u4 = 0;
local os_clock_ret = os.clock();

local function GetMode(p5) -- Line: 34
    local entityConfig = p5.entityConfig;
    local v6 = p5._interpolationMode or entityConfig.INTERPOLATION_MODE;

    if v6 and (p5.interpolation and (not entityConfig.CUSTOM_INTERPOLATION and v6 ~= "NONE")) then
        return v6;
    end;

    return nil;
end;

local function CanInterpolate(p7: any, p8: userdata) -- Line: 44
    -- upvalues: Warn (copy), Frustum (copy)
    if p7.isContextOwner then
        return false;
    end;

    if p7._player and p8.Anchored then
        return false;
    end;

    if p7.entityConfig.ASSEMBLY_ROOT_PART_CHECK and (not p7._alignDriver and p8.AssemblyRootPart ~= p8) then
        Warn.low("Primary part for entity " .. p7.id .. " is not the assembly root part. Skipping interpolation for this entity.");

        return false;
    end;

    if Frustum.IsThrottled(p7) then
        return false;
    end;

    if p7.snapshot then
        return true;
    end;

    Warn.medium("No snapshot for entity", p7);

    return false;
end;

local function Interpolate(p9, p10) -- Line: 75
    -- upvalues: Entity (copy), CanInterpolate (copy), u3 (ref), os_clock_ret (ref), Frustum (copy), AlignDriver (copy), u4 (ref)
    local PrimaryPart = Entity.GetPrimaryPart(p9);

    if not (PrimaryPart and CanInterpolate(p9, PrimaryPart)) then
        return;
    end;

    local snapshot = p9.snapshot;
    u3 = u3 + 1;
    debug.profilebegin("Get Render CFrame");
    local TargetRenderTime = Entity.GetTargetRenderTime(p9);

    if p10 == "ALIGN" then
        TargetRenderTime = TargetRenderTime + (os.clock() - os_clock_ret);
    end;

    local At = snapshot:GetAt(TargetRenderTime);
    debug.profileend();

    if not At then
        return;
    end;

    if p9.broadPhase and Frustum.IsCulled(p9, At) then
        return;
    end;

    debug.profilebegin("Set CFrame");

    if At == At then
        if p10 == "ALIGN" then
            AlignDriver.Step(p9, PrimaryPart, At, TargetRenderTime);
        else
            AlignDriver.Clear(p9);
            PrimaryPart.CFrame = At;
        end;
    end;

    u4 = u4 + 1;
    debug.profileend();
end;

Config._WaitForLock(function() -- Line: 108
    -- upvalues: RunService (copy), Frustum (copy), ClientClock (copy), os_clock_ret (ref), idMap (copy), ModelResolver (copy), AlignDriver (copy), Interpolate (copy), EntityStats (copy), u1 (ref), u2 (ref), ApplyMounts (copy), CLIENT (copy), u4 (ref), u3 (ref), Sender (copy), Ticker (copy), Shared (copy)
    local u11 = {};
    RunService.Heartbeat:Connect(function(p12: number) -- Line: 110
        -- upvalues: u11 (ref), Frustum (ref), ClientClock (ref), os_clock_ret (ref), idMap (ref), ModelResolver (ref), AlignDriver (ref), Interpolate (ref), EntityStats (ref), u1 (ref), u2 (ref), ApplyMounts (ref), CLIENT (ref), u4 (ref), u3 (ref), Sender (ref), Ticker (ref)
        u11 = {};
        Frustum.Update();
        ClientClock.UpdateAll(p12);
        os_clock_ret = os.clock();
        debug.profilebegin("Prepare Frustum Check");
        Frustum.Prepare();
        debug.profileend();
        local os_clock_ret2 = os.clock();
        debug.profilebegin("Interpolate Entities");
        local v13 = 0;

        for _, v in idMap do
            ModelResolver(v);

            if not v.destroyed then
                if v.mountParentId then
                    AlignDriver.Clear(v);
                elseif not v.paused then
                    v13 = v13 + 1;
                    local entityConfig = v.entityConfig;
                    local v14 = v._interpolationMode or entityConfig.INTERPOLATION_MODE;

                    if not (v14 and (v.interpolation and (not entityConfig.CUSTOM_INTERPOLATION and v14 ~= "NONE"))) then
                        v14 = nil;
                    end;

                    if v14 == "ALIGN" then
                        if not v._alignDriver then
                            Interpolate(v, v14);
                        end;

                        table.insert(u11, v);
                    elseif v14 then
                        Interpolate(v, v14);
                    elseif v._alignDriver then
                        AlignDriver.Clear(v);
                    end;
                end;
            end;
        end;

        debug.profileend();
        local os_clock_ret3 = os.clock();
        debug.profilebegin("Update Entity Stats");
        EntityStats();
        debug.profileend();
        debug.profilebegin("Apply Velocities");
        AlignDriver.ApplyVelocities();
        debug.profileend();
        u1 = u1 + (os_clock_ret3 - os_clock_ret2);
        u2 = u2 + 1;
        ApplyMounts();

        if not CLIENT._PAUSE then
            CLIENT.TOTAL_CLIENT_ENTITIES_CHECKED_THIS_FRAME = v13;
            CLIENT.ENTITIES_MOVED_THIS_FRAME = u4;
            CLIENT.TOTAL_CLIENT_ENTITIES = v13;
            CLIENT.AVG_INTERPOLATION_TIME_MS = u1 / u2 * 1000;
        end;

        u4 = 0;
        u3 = 0;

        if u2 > 60 then
            u1 = 0;
            u2 = 0;
        end;

        Sender.Update();
        Ticker._IncrementGlobalTick();
    end);
    RunService.PreSimulation:Connect(function() -- Line: 175
        -- upvalues: Frustum (ref), u11 (ref), Interpolate (ref)
        debug.profilebegin("Interpolate Align Entities");
        Frustum.Prepare();

        for _, v in u11 do
            if not (v.destroyed or (v.paused or v.mountParentId)) then
                local entityConfig = v.entityConfig;
                local v15 = v._interpolationMode or entityConfig.INTERPOLATION_MODE;

                if not (v15 and (v.interpolation and (not entityConfig.CUSTOM_INTERPOLATION and v15 ~= "NONE"))) then
                    v15 = nil;
                end;

                if v15 == "ALIGN" then
                    Interpolate(v, "ALIGN");
                end;
            end;
        end;

        debug.profileend();
    end);
    local ClientHeartbeat = Shared.Remotes.ClientHeartbeat;
    ClientHeartbeat:FireServer(os.clock());
    local u16 = 0;
    RunService.Heartbeat:Connect(function(p17: number) -- Line: 193
        -- upvalues: u16 (ref), ClientHeartbeat (copy)
        u16 = u16 + p17;

        if u16 >= 15 then
            u16 = 0;
            ClientHeartbeat:FireServer(os.clock());
        end;
    end);
    Shared.Remotes.ClientLoaded:FireServer();
end);

return nil;