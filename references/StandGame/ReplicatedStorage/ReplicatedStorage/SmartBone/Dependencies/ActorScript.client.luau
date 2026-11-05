 

 

if not script.Parent:IsA("Actor") then
    return;
end;
local l__Event__1 = script.Parent.Event;
local l__Players__2 = game:GetService("Players");
local l__RunService__3 = game:GetService("RunService");
local v1 = { game:GetService("ReplicatedStorage"), l__Players__2.LocalPlayer:WaitForChild("PlayerScripts") };
local v2 = nil;
for _, v3 in pairs(v1) do
    local v4 = v3:FindFirstChild("SmartBone", true);
    if v4 and v4:IsA("ModuleScript") then
        v2 = v4;
        break;
    end;
end;
if v2 then
    local l__Dependencies__4 = v2:WaitForChild("Dependencies");
    local l__Config__5 = require(l__Dependencies__4:WaitForChild("Config"));
    local u5 = require(v2);
    local l__CameraUtil__6 = require(l__Dependencies__4:WaitForChild("CameraUtil"));
    local l__Debug__7 = l__Config__5.Debug;
    local l__clock__8 = os.clock;
    local u6 = l__clock__8();
    local u7 = 60;
    local u8 = {};
    local function u15() --[[ Line: 59 ]]
        -- upvalues: l__clock__8 (copy), u8 (copy), u7 (ref), u6 (copy)
        local v9 = l__clock__8();
        for v10 = #u8, 1, -1 do
            local v11 = u8;
            local v12 = v10 + 1;
            local v13;
            if u8[v10] >= v9 - 1 then
                v13 = u8[v10] or nil;
            else
                v13 = nil;
            end;
            v11[v12] = v13;
        end;
        u8[1] = v9;
        local v14 = l__clock__8() - u6 >= 1 and #u8 or #u8 / (l__clock__8() - u6);
        u7 = math.floor(v14);
        return math.floor((u7 * (1 / u7) ^ 2 + 0.001) * 1000 + 0.5) / 1000;
    end;
    function l__Event__1.OnInvoke(p16, p17) --[[ Line: 148 ]]
        -- upvalues: u5 (copy), l__RunService__3 (copy), u15 (copy), l__CameraUtil__6 (copy), l__Debug__7 (copy)
        local u18 = u5.new(p16, p17);
        local u19 = 0;
        u18.SimulationConnection = l__RunService__3.Heartbeat:ConnectParallel(function(_) --[[ Line: 77 ]]
            -- upvalues: u15 (ref), u19 (ref), u18 (copy), l__CameraUtil__6 (ref), l__Debug__7 (ref)
            local v20 = u15();
            u19 = u19 + v20;
            local l__Position__9 = workspace.CurrentCamera.CFrame.Position;
            local l__Position__10 = u18.RootPart.Position;
            local l__ThrottleDistance__11 = u18.Settings.ThrottleDistance;
            local l__Magnitude__12 = (l__Position__9 - l__Position__10).Magnitude;
            local l__ActivationDistance__13 = u18.Settings.ActivationDistance;
            local v21 = math.clamp(l__Magnitude__12 - l__ThrottleDistance__11, 0, l__ActivationDistance__13) / l__ActivationDistance__13;
            local v22 = (1 - math.clamp(v21, 0, 1)) * u18.Settings.UpdateRate;
            local v23 = math.clamp(v22, 1, u18.Settings.UpdateRate);
            local v24 = math.floor(v23);
            local v25 = l__CameraUtil__6.WithinViewport(u18.RootPart);
            if u19 >= 1 / v24 then
                if l__Magnitude__12 < l__ActivationDistance__13 and v25 then
                    local v26 = u19;
                    u19 = 0;
                    debug.profilebegin("SmartBone");
                    if u18.InRange == false then
                        u18.InRange = true;
                    end;
                    u18:UpdateBones(v26, v24);
                    debug.profileend();
                    task.synchronize();
                    debug.profilebegin("SmartBoneTransform");
                    for _, v27 in u18.ParticleTrees do
                        u18:TransformBones(v27, v26);
                        if l__Debug__7 then
                            u18:DEBUG(v27, v26);
                        end;
                    end;
                    debug.profileend();
                    task.desynchronize();
                    return;
                end;
                if u18.InRange == true then
                    u18.InRange = false;
                    for _, v28 in u18.ParticleTrees do
                        u18:ResetParticles(v28);
                    end;
                    task.synchronize();
                    for _, v29 in u18.ParticleTrees do
                        u18:ResetTransforms(v29, v20);
                    end;
                    task.desynchronize();
                end;
            end;
        end);
        return u18;
    end;
else
    warn("SmartBone was not found!");
end;