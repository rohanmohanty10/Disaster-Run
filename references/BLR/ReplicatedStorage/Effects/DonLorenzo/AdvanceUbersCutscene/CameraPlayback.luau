  

local ContentProvider = game:GetService("ContentProvider");
local RunService = game:GetService("RunService");
local u1 = {};
local u2 = nil;

function u1.Stop() -- Line: 8
    -- upvalues: u2 (ref), RunService (copy)
    local v3 = u2;
    u2 = nil;
    RunService:UnbindFromRenderStep("LorenzoAdvanceUbersExternalCamera");

    if not v3 then
        return;
    end;

    if v3.animation then
        v3.animation:Stop(0);
        v3.animation:Destroy();
    end;

    if v3.rig then
        v3.rig:Destroy();
    end;
end;

function u1.Prepare(p4) -- Line: 20
    -- upvalues: u1 (copy), ContentProvider (copy), u2 (ref), RunService (copy)
    u1.Stop();
    ContentProvider:PreloadAsync({ script.Parent.CamAnim });
    local v5 = script.Parent.CamRig:Clone();
    local v6 = {
        rig = v5
    };
    u2 = v6;
    v5.Name = "LorenzoAdvanceUbersCamera";
    v5:PivotTo(p4.HumanoidRootPart.CFrame * script.Parent:GetAttribute("CameraRigOffset"));
    v5.Parent = workspace;
    local v7 = v5.AnimationController.Animator:LoadAnimation(script.Parent.CamAnim);
    v6.animation = v7;
    v7.Priority = Enum.AnimationPriority.Action4;
    v7.Looped = false;
    local v8 = os.clock() + 10;

    while v7.Length == 0 and os.clock() < v8 do
        RunService.Heartbeat:Wait();
    end;

    assert(v7.Length > 0, "Advance Ubers camera animation failed to load");
end;

function u1.Start(u9) -- Line: 40
    -- upvalues: u2 (ref), RunService (copy), u1 (copy)
    local u10 = assert(u2, "Advance Ubers camera was not prepared");
    u10.animation:Play(0, 1, 1);
    u10.animation.TimePosition = math.min(u9.TimePosition, u10.animation.Length);
    RunService:BindToRenderStep("LorenzoAdvanceUbersExternalCamera", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 44
        -- upvalues: u2 (ref), u10 (copy), u9 (copy), u1 (ref)
        if u2 ~= u10 then
            return;
        end;

        if not (u10.rig.Parent and u9:IsPlaying()) then
            u1.Stop();

            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = u10.rig.CamPart.CFrame;
        workspace_CurrentCamera.FieldOfView = script.Parent:GetAttribute("CameraFieldOfView");
    end);
end;

return u1;