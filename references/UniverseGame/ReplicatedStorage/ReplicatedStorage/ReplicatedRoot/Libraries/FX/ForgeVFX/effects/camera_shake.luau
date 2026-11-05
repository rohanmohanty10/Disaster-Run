  

 

local RunService = game:GetService("RunService");
local u1 = require("../mod/attributes");
local u2 = require("../mod/tween");
require("../types");
local u3 = require("../mod/utility");
local u4 = require("../pkg/Shake");
local u5 = {};
local identity = CFrame.identity;

local function updateCamera() -- Line: 13
    -- upvalues: u5 (ref), RunService (copy), identity (ref)
    if #u5 == 0 then
        return;
    end;

    local CurrentCamera = workspace.CurrentCamera;

    if not RunService:IsRunning() then
        CurrentCamera.CFrame = CurrentCamera.CFrame * identity:Inverse();
        local CFrame2 = CurrentCamera.CFrame;
        local v6, v7 = CFrame2:ToOrientation();
        CurrentCamera.CFrame = CFrame.new(CFrame2.Position) * CFrame.fromOrientation(v6, v7, 0);
    end;

    local identity2 = CFrame.identity;
    local v8 = Vector3.new(0, 0, 0);
    local v9 = {};

    for _, v in u5 do
        if not v.done then
            v8 = v8 + v.pos;
            identity2 = identity2 * CFrame.Angles(v.rot.x, v.rot.y, v.rot.z);
            table.insert(v9, v);
        end;
    end;

    u5 = v9;
    local v10 = CFrame.new(v8) * identity2;

    if not RunService:IsRunning() then
        identity = v10;
    end;

    CurrentCamera.CFrame = CurrentCamera.CFrame * v10;
end;

local v11 = {};
local u12 = nil;
local u13 = nil;

function v11.init() -- Line: 63
    -- upvalues: u12 (ref), RunService (copy), u13 (ref), updateCamera (copy)
    if u12 then
        return;
    end;

    if RunService:IsRunning() then
        u12 = RunService.Heartbeat:Connect(function() -- Line: 69
            -- upvalues: u13 (ref)
            if not u13 then
                return;
            end;

            workspace.CurrentCamera.CFrame = u13;
        end);
    end;

    RunService:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, updateCamera);
end;

function v11.deinit() -- Line: 81
    -- upvalues: u12 (ref), RunService (copy)
    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;

    RunService:UnbindFromRenderStep("forge_updateCameraShake");
end;

function v11.emit(u14, p15) -- Line: 90
    -- upvalues: u1 (copy), u4 (copy), u2 (copy), u3 (copy), RunService (copy), u5 (ref), u13 (ref)
    local v16 = u1.get(u14, "EmitDelay", 0);
    local v17 = u1.get(u14, "EmitDuration", 0);
    local u18 = u1.get(u14, "Falloff", 30);
    local v19 = u1.get(u14, "Amplitude", 2.5);
    local v20 = u1.get(u14, "Frequency", 0.2);
    local v21 = u1.get(u14, "FadeInTime", 0.3);
    local v22 = u1.get(u14, "FadeOutTime", 2);
    local v23 = u1.get(u14, "SustainTime", 1);
    local v24 = u1.get(u14, "PositionInfluence", Vector3.new(1, 1, 1));
    local v25 = u1.get(u14, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2));
    local u26 = u1.get(u14, "Speed_Start", 1);
    local u27 = u1.get(u14, "Speed_End", 1);
    local v28 = v17 > 0;
    local v29 = u4.new();
    v29.Sustain = v28;
    v29.Amplitude = v19;
    v29.Frequency = v20;
    v29.FadeInTime = v21;
    v29.FadeOutTime = v22;
    v29.SustainTime = v23;
    v29.PositionInfluence = v24;
    v29.RotationInfluence = v25;
    local u30 = 1;
    local u31 = 0;

    function v29.TimeFunction() -- Line: 125
        -- upvalues: u31 (ref)
        return u31;
    end;

    if u26 ~= u27 then
        local v34 = u2.fromParams(u1.get(u14, "Speed_Curve", u3.default_bezier), u1.get(u14, "Speed_Duration", 0.1), function(p32, p33) -- Line: 133
            -- upvalues: u30 (ref), u3 (ref), u26 (copy), u27 (copy)
            u30 = u3.lerp(u26, u27, p32);

            return p33;
        end);
        table.insert(p15, v34);
    end;

    table.insert(p15, RunService.RenderStepped:Connect(function(p35) -- Line: 144
        -- upvalues: u31 (ref), u30 (ref)
        u31 = u31 + p35 * u30;
    end));
    local u36 = {
        done = false,
        pos = Vector3.new(0, 0, 0),
        rot = Vector3.new(0, 0, 0)
    };
    task.wait(v16);
    table.insert(u5, u36);
    local u37 = coroutine.running();
    v29:BindToRenderStep(u4.NextRenderName(), u3.RENDER_PRIORITY + p15.depth, function(p38, p39, p40) -- Line: 161
        -- upvalues: u13 (ref), u14 (copy), u3 (ref), u18 (copy), u36 (copy), u37 (copy)
        local CurrentCamera = workspace.CurrentCamera;
        u13 = CurrentCamera.CFrame;
        local v41 = u14:FindFirstAncestorOfClass("Attachment") or u14:FindFirstAncestorWhichIsA("BasePart");

        if v41 then
            local v42 = u3.getTransformedOriginExtents(v41);
            local v43 = 1 - math.clamp((CurrentCamera.CFrame.Position - (v42 and v42.Position or v41.Position)).Magnitude / u18, 0, 1);
            p38 = p38 * v43;
            p39 = p39 * v43;
        end;

        u36.pos = p38;
        u36.rot = p39;
        u36.done = p40;

        if p40 then
            u13 = nil;
            task.spawn(u37);
        end;
    end);
    v29:Start();

    if v28 then
        task.wait(v17);
        v29:StopSustain();
    end;

    if not u36.done then
        coroutine.yield();
    end;
end;

return v11;