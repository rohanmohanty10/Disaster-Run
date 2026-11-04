 
 

local RunService = game:GetService("RunService");
local u1 = require("../mod/tween");
local u2 = require("../mod/utility");
local u3 = require("../pkg/Shake");
local u4 = {};
local CFrame_identity = CFrame.identity;

local function updateCamera() -- Line: 11
    -- upvalues: u4 (ref), RunService (copy), CFrame_identity (ref)
    if #u4 == 0 then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not RunService:IsRunning() then
        workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * CFrame_identity:Inverse();
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local v5, v6 = CFrame2:ToOrientation();
        workspace_CurrentCamera.CFrame = CFrame.new(CFrame2.Position) * CFrame.fromOrientation(v5, v6, 0);
    end;

    local CFrame_identity2 = CFrame.identity;
    local v7 = Vector3.new(0, 0, 0);
    local v8 = {};

    for _, v in u4 do
        if not v.done then
            v7 = v7 + v.pos;
            CFrame_identity2 = CFrame_identity2 * CFrame.Angles(v.rot.x, v.rot.y, v.rot.z);
            table.insert(v8, v);
        end;
    end;

    u4 = v8;
    local v9 = CFrame.new(v7) * CFrame_identity2;

    if not RunService:IsRunning() then
        CFrame_identity = v9;
    end;

    workspace_CurrentCamera.CFrame = workspace_CurrentCamera.CFrame * v9;
end;

local v10 = {};
local u11 = nil;
local u12 = nil;

function v10.init() -- Line: 61
    -- upvalues: u11 (ref), RunService (copy), u12 (ref), updateCamera (copy)
    if u11 then
        return;
    end;

    if RunService:IsRunning() then
        u11 = RunService.Heartbeat:Connect(function() -- Line: 67
            -- upvalues: u12 (ref)
            if not u12 then
                return;
            end;

            workspace.CurrentCamera.CFrame = u12;
        end);
    end;

    RunService:BindToRenderStep("forge_updateCameraShake", Enum.RenderPriority.Last.Value + 1, updateCamera);
end;

function v10.deinit() -- Line: 79
    -- upvalues: u11 (ref), RunService (copy)
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;

    RunService:UnbindFromRenderStep("forge_updateCameraShake");
end;

function v10.emit(u13: userdata, p14: any) -- Line: 88
    -- upvalues: u2 (copy), u3 (copy), u1 (copy), RunService (copy), u4 (ref), u12 (ref)
    local Attribute = u2.getAttribute(u13, "EmitDelay", 0);
    local Attribute2 = u2.getAttribute(u13, "EmitDuration", 0);
    local Attribute3 = u2.getAttribute(u13, "Falloff", 30);
    local Attribute4 = u2.getAttribute(u13, "Amplitude", 2.5);
    local Attribute5 = u2.getAttribute(u13, "Frequency", 0.2);
    local Attribute6 = u2.getAttribute(u13, "FadeInTime", 0.3);
    local Attribute7 = u2.getAttribute(u13, "FadeOutTime", 2);
    local Attribute8 = u2.getAttribute(u13, "SustainTime", 1);
    local Attribute9 = u2.getAttribute(u13, "PositionInfluence", Vector3.new(1, 1, 1));
    local Attribute10 = u2.getAttribute(u13, "RotationInfluence", Vector3.new(0.2, 0.2, 0.2));
    local Attribute11 = u2.getAttribute(u13, "Speed_Start", 1);
    local Attribute12 = u2.getAttribute(u13, "Speed_End", 1);
    local v15 = Attribute2 > 0;
    local v16 = u3.new();
    v16.Sustain = v15;
    v16.Amplitude = Attribute4;
    v16.Frequency = Attribute5;
    v16.FadeInTime = Attribute6;
    v16.FadeOutTime = Attribute7;
    v16.SustainTime = Attribute8;
    v16.PositionInfluence = Attribute9;
    v16.RotationInfluence = Attribute10;
    local u17 = 1;
    local u18 = 0;

    function v16.TimeFunction() -- Line: 123
        -- upvalues: u18 (ref)
        return u18;
    end;

    if Attribute11 ~= Attribute12 then
        speedTween = u1.fromParams(u2.getAttribute(u13, "Speed_Curve", u2.default_bezier), u2.getAttribute(u13, "Speed_Duration", 0.1), function(p19, p20) -- Line: 131
            -- upvalues: u17 (ref), u2 (ref), Attribute11 (copy), Attribute12 (copy)
            u17 = u2.lerp(Attribute11, Attribute12, p19);

            return p20;
        end);
        table.insert(p14, speedTween);
    end;

    table.insert(p14, RunService.RenderStepped:Connect(function(p21) -- Line: 142
        -- upvalues: u18 (ref), u17 (ref)
        u18 = u18 + p21 * u17;
    end));
    local u22 = {
        done = false,
        pos = Vector3.new(0, 0, 0),
        rot = Vector3.new(0, 0, 0)
    };
    task.wait(Attribute);
    table.insert(u4, u22);
    local coroutine_running_ret = coroutine.running();
    v16:BindToRenderStep(u3.NextRenderName(), u2.RENDER_PRIORITY + p14.depth, function(p23, p24, p25) -- Line: 159
        -- upvalues: u12 (ref), u13 (copy), Attribute3 (copy), u22 (copy), coroutine_running_ret (copy)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        u12 = workspace_CurrentCamera.CFrame;
        local v26 = u13:FindFirstAncestorOfClass("Attachment") or u13:FindFirstAncestorWhichIsA("BasePart");

        if v26 then
            local Position = workspace_CurrentCamera.CFrame.Position;
            local v27 = v26:IsA("Attachment") and v26.WorldPosition or v26.Position;
            local v28 = 1 - math.clamp((Position - v27).Magnitude / Attribute3, 0, 1);
            p23 = p23 * v28;
            p24 = p24 * v28;
        end;

        u22.pos = p23;
        u22.rot = p24;
        u22.done = p25;

        if p25 then
            u12 = nil;
            task.spawn(coroutine_running_ret);
        end;
    end);
    v16:Start();

    if v15 then
        task.wait(Attribute2);
        v16:StopSustain();
    end;

    if not u22.done then
        coroutine.yield();
    end;
end;

return v10;