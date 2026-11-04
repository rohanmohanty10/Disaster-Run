  

if not script.Parent:IsA("Actor") then
    return;
end;

local Event = script.Parent.Event;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local v1 = { game:GetService("ReplicatedStorage"), Players.LocalPlayer:WaitForChild("PlayerScripts") };
local v2 = nil;

for _, v in pairs(v1) do
    local Smartbone = v:FindFirstChild("Smartbone", true);

    if Smartbone and Smartbone:IsA("ModuleScript") then
        v2 = Smartbone;
        break;
    end;
end;

if not v2 then
    warn("SmartBone was not found!");

    return;
end;

local Dependencies = v2:WaitForChild("Dependencies");
local Config = require(Dependencies:WaitForChild("Config"));
local u3 = require(v2);
local CameraUtil = require(Dependencies:WaitForChild("CameraUtil"));
local Debug = Config.Debug;
local os_clock = os.clock;
local u4 = os_clock();
local u5 = 60;
local u6 = {};

local function roundNumber(p7) -- Line: 55
    return math.floor(p7 * 1000 + 0.5) / 1000;
end;

local function smoothDelta() -- Line: 59
    -- upvalues: os_clock (copy), u6 (copy), u5 (ref), u4 (copy)
    local v8 = os_clock();

    for i = #u6, 1, -1 do
        local v9;

        if u6[i] >= v8 - 1 then
            v9 = u6[i] or nil;
        else
            v9 = nil;
        end;

        u6[i + 1] = v9;
        local _ = i;
    end;

    u6[1] = v8;
    local v10 = os_clock() - u4 >= 1 and #u6 or #u6 / (os_clock() - u4);
    u5 = math.floor(v10);

    return math.floor((u5 * (1 / u5) ^ 2 + 0.001) * 1000 + 0.5) / 1000;
end;

local function Initialize(p11: userdata, p12: table, p13: any) -- Line: 72
    -- upvalues: u3 (copy), RunService (copy), smoothDelta (copy), CameraUtil (copy), Debug (copy)
    local u14 = u3.new(p11, p12, p13);
    local u15 = 0;
    u14.SimulationConnection = RunService.Heartbeat:ConnectParallel(function(p16: number) -- Line: 77
        -- upvalues: smoothDelta (ref), u15 (ref), u14 (copy), CameraUtil (ref), Debug (ref)
        local v17 = smoothDelta();
        u15 = u15 + v17;
        local Magnitude = (workspace.CurrentCamera.CFrame.Position - u14.RootPart.Position).Magnitude;
        local ActivationDistance = u14.Settings.ActivationDistance;
        local v18 = math.clamp(Magnitude - u14.Settings.ThrottleDistance, 0, ActivationDistance) / ActivationDistance;
        local v19 = (1 - math.clamp(v18, 0, 1)) * u14.Settings.UpdateRate;
        local math_clamp_ret = math.clamp(v19, 1, u14.Settings.UpdateRate);
        local math_floor_ret = math.floor(math_clamp_ret);
        local v20 = CameraUtil.WithinViewport(u14.RootPart);

        if u15 >= 1 / math_floor_ret then
            if Magnitude < ActivationDistance and v20 then
                local v21 = u15;
                u15 = 0;
                debug.profilebegin("SmartBone");

                if u14.InRange == false then
                    u14.InRange = true;
                end;

                u14:UpdateBones(v21, math_floor_ret);
                debug.profileend();
                task.synchronize();
                debug.profilebegin("SmartBoneTransform");

                for _, v in u14.ParticleTrees do
                    u14:TransformBones(v, v21);

                    if Debug then
                        u14:DEBUG(v, v21);
                    end;
                end;

                debug.profileend();
                task.desynchronize();

                return;
            end;

            if u14.InRange == true then
                u14.InRange = false;

                for _, v in u14.ParticleTrees do
                    u14:ResetParticles(v);
                end;

                task.synchronize();

                for _, v in u14.ParticleTrees do
                    u14:ResetTransforms(v, v17);
                end;

                task.desynchronize();
            end;
        end;
    end);

    return u14;
end;

function Event.OnInvoke(p22: userdata, p23: table, p24: any) -- Line: 148
    -- upvalues: u3 (copy), RunService (copy), smoothDelta (copy), CameraUtil (copy), Debug (copy)
    local u25 = u3.new(p22, p23, p24);
    local u26 = 0;
    u25.SimulationConnection = RunService.Heartbeat:ConnectParallel(function(p27: number) -- Line: 77
        -- upvalues: smoothDelta (ref), u26 (ref), u25 (copy), CameraUtil (ref), Debug (ref)
        local v28 = smoothDelta();
        u26 = u26 + v28;
        local Magnitude = (workspace.CurrentCamera.CFrame.Position - u25.RootPart.Position).Magnitude;
        local ActivationDistance = u25.Settings.ActivationDistance;
        local v29 = math.clamp(Magnitude - u25.Settings.ThrottleDistance, 0, ActivationDistance) / ActivationDistance;
        local v30 = (1 - math.clamp(v29, 0, 1)) * u25.Settings.UpdateRate;
        local math_clamp_ret = math.clamp(v30, 1, u25.Settings.UpdateRate);
        local math_floor_ret = math.floor(math_clamp_ret);
        local v31 = CameraUtil.WithinViewport(u25.RootPart);

        if u26 >= 1 / math_floor_ret then
            if Magnitude < ActivationDistance and v31 then
                local v32 = u26;
                u26 = 0;
                debug.profilebegin("SmartBone");

                if u25.InRange == false then
                    u25.InRange = true;
                end;

                u25:UpdateBones(v32, math_floor_ret);
                debug.profileend();
                task.synchronize();
                debug.profilebegin("SmartBoneTransform");

                for _, v in u25.ParticleTrees do
                    u25:TransformBones(v, v32);

                    if Debug then
                        u25:DEBUG(v, v32);
                    end;
                end;

                debug.profileend();
                task.desynchronize();

                return;
            end;

            if u25.InRange == true then
                u25.InRange = false;

                for _, v in u25.ParticleTrees do
                    u25:ResetParticles(v);
                end;

                task.synchronize();

                for _, v in u25.ParticleTrees do
                    u25:ResetTransforms(v, v28);
                end;

                task.desynchronize();
            end;
        end;
    end);

    return u25;
end;