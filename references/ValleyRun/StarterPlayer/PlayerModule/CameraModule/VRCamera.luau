 

 

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
require(script.Parent:WaitForChild("CameraInput"));
require(script.Parent:WaitForChild("CameraUtils"));
local VRCameraTeleportDetector = require(script.Parent:WaitForChild("VRCameraTeleportDetector"));
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
local UserFlag = v1.getUserFlag("UserPSVRCameraInputMoveVector");
local UserFlag2 = v1.getUserFlag("UserVRRecenterOnExternalTeleport");
local UserFlag3 = v1.getUserFlag("UserVRSkipOcclusionInFirstPerson");
local UserFlag4 = v1.getUserFlag("UserFixVRImmersionAutoRotate");
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"));
local u2 = setmetatable({}, VRBaseCamera);
u2.__index = u2;

function u2.new() -- Line: 35
    -- upvalues: VRBaseCamera (copy), u2 (copy)
    local v3 = VRBaseCamera.new();
    local v4 = setmetatable(v3, u2);
    v4.lastUpdate = tick();
    v4.focusOffset = CFrame.new();
    v4:Reset();
    v4.controlModule = require(script.Parent.Parent:WaitForChild("ControlModule"));
    v4.savedAutoRotate = true;
    v4.autoRotateOverridden = false;

    return v4;
end;

function u2.Reset(p5) -- Line: 49
    -- upvalues: VRBaseCamera (copy)
    p5.needsReset = true;
    p5.needsBlackout = true;
    p5.motionDetTime = 0;
    p5.blackOutTimer = 0;
    p5.lastCameraResetPosition = nil;
    VRBaseCamera.Reset(p5);
end;

function u2.Update(p6, p7) -- Line: 58
    -- upvalues: Players (copy), UserFlag3 (copy), VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Focus = workspace_CurrentCamera.Focus;
    local LocalPlayer = Players.LocalPlayer;

    if p6.lastUpdate == nil or p7 > 1 then
        p6.lastCameraTransform = nil;
    end;

    p6:UpdateFadeFromBlack(p7);
    local lastSubjectPosition = p6.lastSubjectPosition;
    local SubjectPosition = p6:GetSubjectPosition();

    if p6.needsBlackout then
        p6:StartFadeFromBlack();
        local math_clamp_ret = math.clamp(p7, 0.0001, 0.1);
        p6.blackOutTimer = p6.blackOutTimer + math_clamp_ret;

        if p6.blackOutTimer > 0.1 and game:IsLoaded() then
            p6.needsBlackout = false;
            p6.needsReset = true;
        end;
    end;

    if SubjectPosition and (LocalPlayer and workspace_CurrentCamera) then
        local VRFocus = p6:GetVRFocus(SubjectPosition, p7);

        if UserFlag3 then
            local v8 = p6:IsInFirstPerson() and LocalPlayer.DevCameraOcclusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;
            p6.skipOcclusion = v8;
        end;

        if p6:IsInFirstPerson() then
            if VRService.AvatarGestures then
                CFrame2, Focus = p6:UpdateImmersionCamera(p7, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
            else
                CFrame2, Focus = p6:UpdateFirstPersonTransform(p7, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
            end;
        elseif VRService.ThirdPersonFollowCamEnabled then
            CFrame2, Focus = p6:UpdateThirdPersonFollowTransform(p7, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        else
            CFrame2, Focus = p6:UpdateThirdPersonComfortTransform(p7, CFrame2, VRFocus, lastSubjectPosition, SubjectPosition);
        end;

        p6.lastCameraTransform = CFrame2;
        p6.lastCameraFocus = Focus;
    end;

    p6.lastUpdate = tick();

    return CFrame2, Focus;
end;

function u2.GetAvatarFeetWorldYValue(p9) -- Line: 126
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

function u2.UpdateFirstPersonTransform(p10, p11, p12, p13, p14, p15) -- Line: 141
    if p10.needsReset then
        p10:StartFadeFromBlack();
        p10.needsReset = false;
    end;

    local Position = p13.Position;
    local CameraLookVector = p10:GetCameraLookVector();
    local Unit = Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z).Unit;
    local Rotation = p10:getRotation(p11);
    local v16 = p10:CalculateNewLookVectorFromArg(Unit, Vector2.new(Rotation, 0));

    return CFrame.new(Position - 0.5 * v16, Position), p13;
end;

function u2.UpdateImmersionCamera(p17, p18, p19, p20, p21, p22) -- Line: 161
    -- upvalues: Players (copy), UserFlag2 (copy), UserFlag4 (copy), VRService (copy), VRCameraTeleportDetector (copy)
    local SubjectCFrame = p17:GetSubjectCFrame();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = Players.LocalPlayer.Character;
    local Humanoid = p17:GetHumanoid();

    if not Humanoid then
        return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
    end;

    local v23;

    if UserFlag2 then
        v23 = not p21 and 0 or Vector3.new(p22.X - p21.X, 0, p22.Z - p21.Z).Magnitude;
    else
        v23 = nil;
    end;

    p17.characterOrientation = HumanoidRootPart:FindFirstChild("CharacterAlignOrientation");

    if not p17.characterOrientation then
        local RootAttachment = HumanoidRootPart:FindFirstChild("RootAttachment");

        if not RootAttachment then
            return;
        end;

        p17.characterOrientation = Instance.new("AlignOrientation");
        p17.characterOrientation.Name = "CharacterAlignOrientation";
        p17.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        p17.characterOrientation.Attachment0 = RootAttachment;
        p17.characterOrientation.RigidityEnabled = true;
        p17.characterOrientation.Parent = HumanoidRootPart;
    end;

    if p17.characterOrientation.Enabled == false then
        p17.characterOrientation.Enabled = true;
    end;

    if p17.needsReset then
        p17.needsReset = false;

        if UserFlag4 then
            p17:updateImmersionAutoRotate();
        else
            p17.savedAutoRotate = Humanoid.AutoRotate;
            Humanoid.AutoRotate = false;
        end;

        if UserFlag2 then
            VRService:RecenterUserHeadCFrame();
            p17.lastTeleportRecenter = tick();
        end;

        p17:StartFadeFromBlack();
    elseif not Humanoid.Sit then
        local EstimatedVRTorsoFrame = p17.controlModule:GetEstimatedVRTorsoFrame();
        p17.characterOrientation.CFrame = workspace_CurrentCamera.CFrame * EstimatedVRTorsoFrame;

        if p17.controlModule.inputMoveVector.Magnitude > 0 then
            p17.motionDetTime = 0.1;
        end;

        if p17.controlModule.inputMoveVector.Magnitude > 0 or p17.motionDetTime > 0 then
            p17.motionDetTime = p17.motionDetTime - p18;
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v24 = workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v25 = p22 - (v24 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + workspace_CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v25.X, p22.Y, v25.Z);
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3_new_ret;
        elseif UserFlag2 and VRCameraTeleportDetector.shouldRecenter(p17.prevSubjStep, v23, p17.lastTeleportRecenter, tick()) then
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            local v26 = workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * HumanoidRootPart2.Size.Y / 2, 0);
            local LookVector = HumanoidRootPart2.CFrame.LookVector;
            local v27 = p22 - (v26 - Vector3.new(LookVector.X, 0, LookVector.Z).Unit * HumanoidRootPart2.Size.Y * 0.125).Position + workspace_CurrentCamera.CFrame.Position;
            local Vector3_new_ret = Vector3.new(v27.X, p22.Y, v27.Z);
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3_new_ret;
            VRService:RecenterUserHeadCFrame();
            p17:StartFadeFromBlack();
            p17.lastTeleportRecenter = tick();
        else
            SubjectCFrame = workspace_CurrentCamera.CFrame.Rotation + Vector3.new(workspace_CurrentCamera.CFrame.Position.X, p22.Y, workspace_CurrentCamera.CFrame.Position.Z);
        end;

        local Rotation = p17:getRotation(p18);

        if math.abs(Rotation) > 0 then
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
            local v28 = UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale;
            local v29 = SubjectCFrame * v28;
            SubjectCFrame = CFrame.new(v29.Position) * CFrame.Angles(0, -math.rad(Rotation * 90), 0) * v29.Rotation * v28:Inverse();
        end;
    end;

    if UserFlag2 then
        p17.prevSubjStep = v23;
    end;

    return SubjectCFrame, SubjectCFrame * CFrame.new(0, 0, -0.5);
end;

function u2.UpdateThirdPersonComfortTransform(p30, p31, p32, p33, p34, p35) -- Line: 313
    -- upvalues: UserFlag (copy), VRService (copy)
    local CameraToSubjectDistance = p30:GetCameraToSubjectDistance();
    local v36 = CameraToSubjectDistance < 0.5 and 0.5 or CameraToSubjectDistance;

    if p34 ~= nil and p30.lastCameraFocus ~= nil then
        local v37;

        if UserFlag then
            v37 = p30.controlModule.inputMoveVector;
        else
            v37 = p30.controlModule:GetMoveVector();
        end;

        local v38 = (p34 - p35).magnitude > 0.01 and true or v37.magnitude > 0.01;

        if v38 then
            p30.motionDetTime = 0.1;
        end;

        p30.motionDetTime = p30.motionDetTime - p31;

        if (p30.motionDetTime > 0 and true or v38) and not p30.needsReset then
            local lastCameraFocus = p30.lastCameraFocus;
            p30.VRCameraFocusFrozen = true;

            return p32, lastCameraFocus;
        end;

        local v39 = p30.lastCameraResetPosition == nil and true or (p35 - p30.lastCameraResetPosition).Magnitude > 1;
        local Rotation = p30:getRotation(p31);

        if math.abs(Rotation) > 0 then
            local v40 = p33:ToObjectSpace(p32);
            p32 = p33 * CFrame.Angles(0, -Rotation, 0) * v40;
        end;

        if p30.VRCameraFocusFrozen and v39 or p30.needsReset then
            VRService:RecenterUserHeadCFrame();
            p30.VRCameraFocusFrozen = false;
            p30.needsReset = false;
            p30.lastCameraResetPosition = p35;
            p30:ResetZoom();
            p30:StartFadeFromBlack();
            local Humanoid = p30:GetHumanoid();
            local v41 = Humanoid.Torso and Humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0);
            local Vector3_new_ret = Vector3.new(v41.X, 0, v41.Z);
            local v42 = p33.Position - Vector3_new_ret * v36;
            local Vector3_new_ret2 = Vector3.new(p33.Position.X, v42.Y, p33.Position.Z);
            p32 = CFrame.new(v42, Vector3_new_ret2);
        end;
    end;

    return p32, p33;
end;

function u2.UpdateThirdPersonFollowTransform(p43, p44, p45, p46, p47, p48) -- Line: 379
    -- upvalues: VRService (copy), UserFlag (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CameraToSubjectDistance = p43:GetCameraToSubjectDistance();
    local VRFocus = p43:GetVRFocus(p48, p44);

    if p43.needsReset then
        p43.needsReset = false;
        VRService:RecenterUserHeadCFrame();
        p43:ResetZoom();
        p43:StartFadeFromBlack();
    end;

    if p43.recentered then
        local SubjectCFrame = p43:GetSubjectCFrame();

        if not SubjectCFrame then
            return workspace_CurrentCamera.CFrame, workspace_CurrentCamera.Focus;
        end;

        local v49 = VRFocus * SubjectCFrame.Rotation * CFrame.new(0, 0, CameraToSubjectDistance);
        p43.focusOffset = VRFocus:ToObjectSpace(v49);
        p43.recentered = false;

        return v49, VRFocus;
    end;

    local v50 = VRFocus:ToWorldSpace(p43.focusOffset);
    local controlModule = p43.controlModule;
    local v51;

    if UserFlag then
        v51 = controlModule.inputMoveVector;
    else
        v51 = controlModule:GetMoveVector();
    end;

    if (p47 - p48).magnitude > 0.01 or v51.magnitude > 0 then
        local EstimatedVRTorsoFrame = controlModule:GetEstimatedVRTorsoFrame();
        local v52 = workspace_CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * workspace_CurrentCamera.HeadScale);
        local LookVector = v52.LookVector;
        local v53 = Vector3.new(LookVector.X, 0, LookVector.Z).Unit * CameraToSubjectDistance;
        v50 = v50:Lerp(CFrame.new(workspace_CurrentCamera.CFrame.Position + (VRFocus.Position - v53) - v52.Position) * v50.Rotation, 0.01);
    end;

    local Rotation = p43:getRotation(p44);

    if math.abs(Rotation) > 0 then
        local v54 = VRFocus:ToObjectSpace(v50);
        v50 = VRFocus * CFrame.Angles(0, -Rotation, 0) * v54;
    end;

    p43.focusOffset = VRFocus:ToObjectSpace(v50);

    return v50, v50 * CFrame.new(0, 0, -CameraToSubjectDistance);
end;

function u2.updateImmersionAutoRotate(p55) -- Line: 453
    -- upvalues: VRService (copy)
    local Humanoid = p55:GetHumanoid();

    if not Humanoid then
        return;
    end;

    if not (p55:IsInFirstPerson() and VRService.AvatarGestures) then
        if p55.autoRotateOverridden then
            Humanoid.AutoRotate = p55.savedAutoRotate;
            p55.autoRotateOverridden = false;
        end;

        return;
    end;

    if not p55.autoRotateOverridden then
        p55.savedAutoRotate = Humanoid.AutoRotate;
        p55.autoRotateOverridden = true;
    end;

    Humanoid.AutoRotate = false;
end;

function u2.OnEnabledChanged(u56) -- Line: 473
    -- upvalues: VRBaseCamera (copy), UserFlag4 (copy), VRService (copy)
    VRBaseCamera.OnEnabledChanged(u56);

    if not UserFlag4 then
        return;
    end;

    if u56.enabled then
        if not u56.avatarGesturesChangedConn then
            u56.avatarGesturesChangedConn = VRService:GetPropertyChangedSignal("AvatarGestures"):Connect(function() -- Line: 482
                -- upvalues: u56 (copy)
                u56:updateImmersionAutoRotate();
            end);
        end;
    elseif u56.avatarGesturesChangedConn then
        u56.avatarGesturesChangedConn:Disconnect();
        u56.avatarGesturesChangedConn = nil;
    end;
end;

function u2.LeaveFirstPerson(p57) -- Line: 492
    -- upvalues: VRBaseCamera (copy), UserFlag4 (copy)
    VRBaseCamera.LeaveFirstPerson(p57);
    p57.needsReset = true;

    if p57.VRBlur then
        p57.VRBlur.Visible = false;
    end;

    if p57.characterOrientation then
        p57.characterOrientation.Enabled = false;
    end;

    if UserFlag4 then
        p57:updateImmersionAutoRotate();

        return;
    end;

    local Humanoid = p57:GetHumanoid();

    if Humanoid then
        Humanoid.AutoRotate = p57.savedAutoRotate;
    end;
end;

return u2;