 
 

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
UserSettings():GetService("UserGameSettings");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local u1 = setmetatable({}, VRBaseCamera);
u1.__index = u1;

function u1.new() -- Line: 25
    -- upvalues: VRBaseCamera (copy), u1 (copy)
    local v2 = VRBaseCamera.new();
    local v3 = setmetatable(v2, u1);
    v3.lastUpdate = tick();
    v3.focusOffset = CFrame.new();
    v3:Reset();

    return v3;
end;

function u1.Reset(p4) -- Line: 35
    -- upvalues: VRBaseCamera (copy)
    p4.needsReset = true;
    p4.needsBlackout = true;
    p4.motionDetTime = 0;
    p4.blackOutTimer = 0;
    p4.lastCameraResetPosition = nil;
    VRBaseCamera.Reset(p4);
end;

function u1.Update(p5, p6) -- Line: 44
    -- upvalues: Players (copy), VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Focus = workspace_CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;
    p5:GetHumanoid();
    local _ = workspace_CurrentCamera.CameraSubject;

    if p5.lastUpdate == nil or p6 > 1 then
        p5.lastCameraTransform = nil;
    end;

    p5:UpdateFadeFromBlack(p6);
    p5:UpdateEdgeBlur(LocalPlayer, p6);
    local lastSubjectPosition = p5.lastSubjectPosition;
    local SubjectPosition = p5:GetSubjectPosition();

    if p5.needsBlackout then
        p5:StartFadeFromBlack();
        local math_clamp_ret = math.clamp(p6, 0.0001, 0.1);
        p5.blackOutTimer = p5.blackOutTimer + math_clamp_ret;

        if p5.blackOutTimer > 0.1 and game:IsLoaded() then
            p5.needsBlackout = false;
            p5.needsReset = true;
        end;
    end;

    if SubjectPosition and (LocalPlayer and workspace_CurrentCamera) then
        local VRFocus = p5:GetVRFocus(SubjectPosition, p6);

        if p5:IsInFirstPerson() then
            CFrame2, Focus = p5:UpdateFirstPersonTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        elseif VRService.ThirdPersonFollowCamEnabled then
            CFrame2, Focus = p5:UpdateThirdPersonFollowTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        else
            CFrame2, Focus = p5:UpdateThirdPersonComfortTransform(p6, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        end;

        p5.lastCameraTransform = CFrame2;
        p5.lastCameraFocus = Focus;
    end;

    p5.lastUpdate = tick();

    return CFrame2, Focus;
end;

function u1.GetAvatarFeetWorldYValue(p7) -- Line: 101
    local CameraSubject = workspace.CurrentCamera.CameraSubject;

    if not CameraSubject then
        return nil;
    end;

    if not (CameraSubject:IsA("Humanoid") and CameraSubject.RootPart) then
        return nil;
    end;

    local RootPart = CameraSubject.RootPart;

    return RootPart.Position.Y - RootPart.Size.Y / 2 - CameraSubject.HipHeight;
end;

function u1.UpdateFirstPersonTransform(p8, p9, p10, p11, p12, p13) -- Line: 116
    -- upvalues: Players (copy)
    if p8.needsReset then
        p8:StartFadeFromBlack();
        p8.needsReset = false;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if (p12 - p13).magnitude > 0.01 then
        p8:StartVREdgeBlur(LocalPlayer);
    end;

    local p = p11.p;
    local CameraLookVector = p8:GetCameraLookVector();
    local Unit = Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z).Unit;
    local Rotation = p8:getRotation(p9);
    local v14 = p8:CalculateNewLookVectorFromArg(Unit, Vector2.new(Rotation, 0));

    return CFrame.new(p - 0.5 * v14, p), p11;
end;

function u1.UpdateThirdPersonComfortTransform(p15, p16, p17, p18, p19, p20) -- Line: 143
    -- upvalues: Players (copy), VRService (copy)
    local CameraToSubjectDistance = p15:GetCameraToSubjectDistance();
    local v21 = CameraToSubjectDistance < 0.5 and 0.5 or CameraToSubjectDistance;

    if p19 ~= nil and p15.lastCameraFocus ~= nil then
        local MoveVector = require(Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")):GetMoveVector();
        local v22 = (p19 - p20).magnitude > 0.01 and true or MoveVector.magnitude > 0.01;

        if v22 then
            p15.motionDetTime = 0.1;
        end;

        p15.motionDetTime = p15.motionDetTime - p16;

        if (p15.motionDetTime > 0 and true or v22) and not p15.needsReset then
            local lastCameraFocus = p15.lastCameraFocus;
            p15.VRCameraFocusFrozen = true;

            return p17, lastCameraFocus;
        end;

        local v23 = p15.lastCameraResetPosition == nil and true or (p20 - p15.lastCameraResetPosition).Magnitude > 1;
        local Rotation = p15:getRotation(p16);

        if math.abs(Rotation) > 0 then
            local v24 = p18:ToObjectSpace(p17);
            p17 = p18 * CFrame.Angles(0, -Rotation, 0) * v24;
        end;

        if p15.VRCameraFocusFrozen and v23 or p15.needsReset then
            VRService:RecenterUserHeadCFrame();
            p15.VRCameraFocusFrozen = false;
            p15.needsReset = false;
            p15.lastCameraResetPosition = p20;
            p15:ResetZoom();
            p15:StartFadeFromBlack();
            local Humanoid = p15:GetHumanoid();
            local v25 = Humanoid.Torso and Humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local Vector3_new_ret = Vector3.new(v25.X, 0, v25.Z);
            local v26 = p18.Position - Vector3_new_ret * v21;
            local Vector3_new_ret2 = Vector3.new(p18.Position.X, v26.Y, p18.Position.Z);
            p17 = CFrame.new(v26, Vector3_new_ret2);
        end;
    end;

    return p17, p18;
end;

function u1.UpdateThirdPersonFollowTransform(p27, p28, p29, p30, p31, p32) -- Line: 210
    -- upvalues: VRService (copy), Players (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CameraToSubjectDistance = p27:GetCameraToSubjectDistance();
    local VRFocus = p27:GetVRFocus(p32, p28);

    if p27.needsReset then
        p27.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p27:ResetZoom();
        p27:StartFadeFromBlack();
    end;

    if p27.recentered then
        local SubjectCFrame = p27:GetSubjectCFrame();

        if not SubjectCFrame then
            return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
        end;

        local v33 = VRFocus * SubjectCFrame.Rotation * CFrame.new(0, 0, CameraToSubjectDistance);
        p27.focusOffset = VRFocus:ToObjectSpace(v33);
        p27.recentered = false;

        return v33, VRFocus;
    end;

    local v34 = VRFocus:ToWorldSpace(p27.focusOffset);
    local ControlModule = require(Players.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"));
    local MoveVector = ControlModule:GetMoveVector();

    if (p31 - p32).magnitude > 0.01 or MoveVector.magnitude > 0 then
        local EstimatedVRTorsoFrame = ControlModule:GetEstimatedVRTorsoFrame();
        local v35 = workspace_CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * workspace_CurrentCamera.HeadScale);
        local LookVector = v35.LookVector;
        local v36 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * CameraToSubjectDistance;
        v34 = v34:Lerp(CFrame.new(workspace_CurrentCamera.CFrame.Position + (VRFocus.Position - v36) - v35.Position) * v34.Rotation, 0.01);
    end;

    local Rotation = p27:getRotation(p28);

    if math.abs(Rotation) > 0 then
        local v37 = VRFocus:ToObjectSpace(v34);
        v34 = VRFocus * CFrame.Angles(0, -Rotation, 0) * v37;
    end;

    p27.focusOffset = VRFocus:ToObjectSpace(v34);
    local v38 = v34 * CFrame.new(0, 0, -CameraToSubjectDistance);

    if (v38.Position - workspace_CurrentCamera.Focus.Position).Magnitude > 0.01 then
        p27:StartVREdgeBlur(Players.LocalPlayer);
    end;

    return v34, v38;
end;

function u1.LeaveFirstPerson(p39) -- Line: 288
    -- upvalues: VRBaseCamera (copy)
    VRBaseCamera.LeaveFirstPerson(p39);
    p39.needsReset = true;

    if p39.VRBlur then
        p39.VRBlur.Visible = false;
    end;
end;

return u1;