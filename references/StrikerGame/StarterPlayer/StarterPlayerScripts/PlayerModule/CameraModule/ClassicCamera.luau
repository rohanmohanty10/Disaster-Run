 

 

Vector2.new(0, 0);
local u1 = 0;
local CFrame_fromOrientation_ret = CFrame.fromOrientation(-0.2617993877991494, 0, 0);
local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u2 = setmetatable({}, BaseCamera);
u2.__index = u2;

function u2.new() -- Line: 35
    -- upvalues: BaseCamera (copy), u2 (copy), CameraUtils (copy)
    local v3 = BaseCamera.new();
    local v4 = setmetatable(v3, u2);
    v4.isFollowCamera = false;
    v4.isCameraToggle = false;
    v4.lastUpdate = tick();
    v4.cameraToggleSpring = CameraUtils.Spring.new(5, 0);

    return v4;
end;

function u2.GetCameraToggleOffset(p5: table, p6: number) -- Line: 46
    -- upvalues: CameraInput (copy), CameraUtils (copy)
    if not p5.isCameraToggle then
        return Vector3.new();
    end;

    local currentSubjectDistance = p5.currentSubjectDistance;

    if CameraInput.getTogglePan() then
        local cameraToggleSpring = p5.cameraToggleSpring;
        local v7 = CameraUtils.map(currentSubjectDistance, 0.5, p5.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1);
        cameraToggleSpring.goal = math.clamp(v7, 0, 1);
    else
        p5.cameraToggleSpring.goal = 0;
    end;

    local v8 = CameraUtils.map(currentSubjectDistance, 0.5, 64, 0, 1);
    local v9 = math.clamp(v8, 0, 1) + 1;
    local v10 = p5.cameraToggleSpring:step(p6) * v9;

    return Vector3.new(0, v10, 0);
end;

function u2.SetCameraMovementMode(p11, p12) -- Line: 64
    -- upvalues: BaseCamera (copy)
    BaseCamera.SetCameraMovementMode(p11, p12);
    p11.isFollowCamera = p12 == Enum.ComputerCameraMovementMode.Follow;
    p11.isCameraToggle = p12 == Enum.ComputerCameraMovementMode.CameraToggle;
end;

function u2.Update(p13) -- Line: 71
    -- upvalues: Players (copy), CFrame_fromOrientation_ret (copy), CameraInput (copy), u1 (ref), CameraUtils (copy), VRService (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v14 = tick();
    local v15 = v14 - p13.lastUpdate;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = workspace_CurrentCamera.CFrame;
    local Focus = workspace_CurrentCamera.Focus;
    local v16;

    if p13.resetCameraAngle then
        local HumanoidRootPart = p13:GetHumanoidRootPart();

        if HumanoidRootPart then
            v16 = (HumanoidRootPart.CFrame * CFrame_fromOrientation_ret).lookVector;
        else
            v16 = CFrame_fromOrientation_ret.lookVector;
        end;

        p13.resetCameraAngle = false;
    else
        v16 = nil;
    end;

    local Humanoid = p13:GetHumanoid();
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local v17;

    if CameraSubject then
        v17 = CameraSubject:IsA("VehicleSeat");
    else
        v17 = CameraSubject;
    end;

    local v18;

    if CameraSubject then
        v18 = CameraSubject:IsA("SkateboardPlatform");
    else
        v18 = CameraSubject;
    end;

    local v19;

    if Humanoid then
        v19 = Humanoid:GetState() == Enum.HumanoidStateType.Climbing;
    else
        v19 = Humanoid;
    end;

    if p13.lastUpdate == nil or v15 > 1 then
        p13.lastCameraTransform = nil;
    end;

    local Rotation = CameraInput.getRotation();
    p13:StepZoom();
    local CameraHeight = p13:GetCameraHeight();

    if CameraInput.getRotation() ~= Vector2.new() then
        u1 = 0;
        p13.lastUserPanCamera = tick();
    end;

    local v20 = v14 - p13.lastUserPanCamera < 2;
    local SubjectPosition = p13:GetSubjectPosition();

    if SubjectPosition and (LocalPlayer and workspace_CurrentCamera) then
        local CameraToSubjectDistance = p13:GetCameraToSubjectDistance();
        local v21 = CameraToSubjectDistance < 0.5 and 0.5 or CameraToSubjectDistance;

        if p13:IsInFirstPerson() then
            if CameraInput.getRotation() == Vector2.new() and p13.lastCameraTransform then
                local v22 = p13:IsInFirstPerson();

                if (v17 or (v18 or p13.isFollowCamera and v19)) and (p13.lastUpdate and (Humanoid and Humanoid.Torso)) then
                    if v22 then
                        if p13.lastSubjectCFrame and (v17 or v18) and CameraSubject:IsA("BasePart") then
                            local v23 = -CameraUtils.GetAngleBetweenXZVectors(p13.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector);

                            if CameraUtils.IsFinite(v23) then
                                Rotation = Rotation + Vector2.new(v23, 0);
                            end;

                            u1 = 0;
                        end;
                    elseif not v20 then
                        local lookVector = Humanoid.Torso.CFrame.lookVector;
                        u1 = math.clamp(u1 + 3.839724354387525 * v15, 0, 4.363323129985824);
                        local math_clamp_ret = math.clamp(u1 * v15, 0, 1);
                        local v24 = p13:IsInFirstPerson() and not (p13.isFollowCamera and p13.isClimbing) and 1 or math_clamp_ret;
                        local AngleBetweenXZVectors = CameraUtils.GetAngleBetweenXZVectors(lookVector, p13:GetCameraLookVector());

                        if CameraUtils.IsFinite(AngleBetweenXZVectors) and math.abs(AngleBetweenXZVectors) > 0.0001 then
                            Rotation = Rotation + Vector2.new(AngleBetweenXZVectors * v24, 0);
                        end;
                    end;
                elseif p13.isFollowCamera and not (v22 or (v20 or VRService.VREnabled)) then
                    local AngleBetweenXZVectors = CameraUtils.GetAngleBetweenXZVectors(-(p13.lastCameraTransform.p - SubjectPosition), p13:GetCameraLookVector());

                    if CameraUtils.IsFinite(AngleBetweenXZVectors) and (math.abs(AngleBetweenXZVectors) > 0.0001 and math.abs(AngleBetweenXZVectors) > 0.4 * v15) then
                        Rotation = Rotation + Vector2.new(AngleBetweenXZVectors, 0);
                    end;
                end;
            end;
        else
            local v25 = p13:CalculateNewLookCFrameFromArg(v16, Rotation);
            local MouseLockOffset = p13:GetMouseLockOffset();
            local v26 = MouseLockOffset.X * v25.RightVector + MouseLockOffset.Y * v25.UpVector + MouseLockOffset.Z * v25.LookVector;

            if CameraUtils.IsFiniteVector3(v26) then
                SubjectPosition = SubjectPosition + v26;
            end;
        end;

        local v27;

        if p13.isFollowCamera then
            local v28 = p13:CalculateNewLookVectorFromArg(v16, Rotation);

            if VRService.VREnabled then
                v27 = p13:GetVRFocus(SubjectPosition, v15);
            else
                v27 = CFrame.new(SubjectPosition);
            end;

            CFrame2 = CFrame.new(v27.p - v21 * v28, v27.p) + Vector3.new(0, CameraHeight, 0);
        else
            local VREnabled = VRService.VREnabled;

            if VREnabled then
                v27 = p13:GetVRFocus(SubjectPosition, v15);
            else
                v27 = CFrame.new(SubjectPosition);
            end;

            local p = v27.p;

            if VREnabled and not p13:IsInFirstPerson() then
                local magnitude = (SubjectPosition - workspace_CurrentCamera.CFrame.p).magnitude;

                if v21 < magnitude or Rotation.x ~= 0 then
                    local math_min_ret = math.min(magnitude, v21);
                    local v29 = p13:CalculateNewLookVectorFromArg(nil, Rotation) * math_min_ret;
                    local v30 = p - v29;
                    local lookVector = workspace_CurrentCamera.CFrame.lookVector;

                    if Rotation.x == 0 then
                        v29 = lookVector;
                    end;

                    local Vector3_new_ret = Vector3.new(v30.x + v29.x, v30.y, v30.z + v29.z);
                    CFrame2 = CFrame.new(v30, Vector3_new_ret) + Vector3.new(0, CameraHeight, 0);
                end;
            else
                local v31 = p13:CalculateNewLookVectorFromArg(v16, Rotation);
                CFrame2 = CFrame.new(p - v21 * v31, p);
            end;
        end;

        local CameraToggleOffset = p13:GetCameraToggleOffset(v15);
        Focus = v27 + CameraToggleOffset;
        CFrame2 = CFrame2 + CameraToggleOffset;
        p13.lastCameraTransform = CFrame2;
        p13.lastCameraFocus = Focus;

        if (v17 or v18) and CameraSubject:IsA("BasePart") then
            p13.lastSubjectCFrame = CameraSubject.CFrame;
        else
            p13.lastSubjectCFrame = nil;
        end;
    end;

    p13.lastUpdate = v14;

    return CFrame2, Focus;
end;

return u2;