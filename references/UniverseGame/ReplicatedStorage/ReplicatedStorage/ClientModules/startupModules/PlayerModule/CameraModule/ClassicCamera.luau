  

 

Vector2.new(0, 0);
local u1 = 0;
local u2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0);
local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"));
local u3 = setmetatable({}, BaseCamera);
u3.__index = u3;

function u3.new() -- Line: 33
    -- upvalues: BaseCamera (copy), u3 (copy), CameraUtils (copy)
    local v4 = BaseCamera.new();
    local v5 = setmetatable(v4, u3);
    v5.isFollowCamera = false;
    v5.isCameraToggle = false;
    v5.lastUpdate = tick();
    v5.cameraToggleSpring = CameraUtils.Spring.new(5, 0);

    return v5;
end;

function u3.GetCameraToggleOffset(p6, p7) -- Line: 44
    -- upvalues: CameraInput (copy), CameraUtils (copy)
    if not p6.isCameraToggle then
        return Vector3.new();
    end;

    local currentSubjectDistance = p6.currentSubjectDistance;

    if CameraInput.getTogglePan() then
        local cameraToggleSpring = p6.cameraToggleSpring;
        local v8 = CameraUtils.map(currentSubjectDistance, 0.5, p6.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1);
        cameraToggleSpring.goal = math.clamp(v8, 0, 1);
    else
        p6.cameraToggleSpring.goal = 0;
    end;

    local v9 = CameraUtils.map(currentSubjectDistance, 0.5, 64, 0, 1);
    local v10 = math.clamp(v9, 0, 1) + 1;
    local v11 = p6.cameraToggleSpring:step(p7) * v10;

    return Vector3.new(0, v11, 0);
end;

function u3.SetCameraMovementMode(p12, p13) -- Line: 62
    -- upvalues: BaseCamera (copy)
    BaseCamera.SetCameraMovementMode(p12, p13);
    p12.isFollowCamera = p13 == Enum.ComputerCameraMovementMode.Follow;
    p12.isCameraToggle = p13 == Enum.ComputerCameraMovementMode.CameraToggle;
end;

function u3.Update(p14) -- Line: 69
    -- upvalues: u2 (copy), Players (copy), CameraInput (copy), u1 (ref), CameraUtils (copy), VRService (copy)
    local v15 = tick();
    local v16 = v15 - p14.lastUpdate;
    local CurrentCamera = workspace.CurrentCamera;
    local CFrame2 = CurrentCamera.CFrame;
    local Focus = CurrentCamera.Focus;
    local v17;

    if p14.resetCameraAngle then
        local v18 = p14:GetHumanoidRootPart();

        if v18 then
            v17 = (v18.CFrame * u2).lookVector;
        else
            v17 = u2.lookVector;
        end;

        p14.resetCameraAngle = false;
    else
        v17 = nil;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local v19 = p14:GetHumanoid();
    local CameraSubject = CurrentCamera.CameraSubject;
    local v20;

    if CameraSubject then
        v20 = CameraSubject:IsA("VehicleSeat");
    else
        v20 = CameraSubject;
    end;

    local v21;

    if CameraSubject then
        v21 = CameraSubject:IsA("SkateboardPlatform");
    else
        v21 = CameraSubject;
    end;

    local v22;

    if v19 then
        v22 = v19:GetState() == Enum.HumanoidStateType.Climbing;
    else
        v22 = v19;
    end;

    if p14.lastUpdate == nil or v16 > 1 then
        p14.lastCameraTransform = nil;
    end;

    local v23 = CameraInput.getRotation();
    p14:StepZoom();
    local v24 = p14:GetCameraHeight();

    if CameraInput.getRotation() ~= Vector2.new() then
        u1 = 0;
        p14.lastUserPanCamera = tick();
    end;

    local v25 = v15 - p14.lastUserPanCamera < 2;
    local v26 = p14:GetSubjectPosition();

    if v26 and (LocalPlayer and CurrentCamera) then
        local v27 = p14:GetCameraToSubjectDistance();
        local v28 = v27 < 0.5 and 0.5 or v27;

        if p14:GetIsMouseLocked() and not p14:IsInFirstPerson() then
            local v29 = p14:CalculateNewLookCFrameFromArg(v17, v23);
            local v30 = p14:GetMouseLockOffset();
            local v31 = v30.X * v29.rightVector + v30.Y * v29.upVector + v30.Z * v29.lookVector;

            if CameraUtils.IsFiniteVector3(v31) then
                v26 = v26 + v31;
            end;
        elseif CameraInput.getRotation() == Vector2.new() and p14.lastCameraTransform then
            local v32 = p14:IsInFirstPerson();

            if (v20 or (v21 or p14.isFollowCamera and v22)) and (p14.lastUpdate and (v19 and v19.Torso)) then
                if v32 then
                    if p14.lastSubjectCFrame and (v20 or v21) and CameraSubject:IsA("BasePart") then
                        local v33 = -CameraUtils.GetAngleBetweenXZVectors(p14.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector);

                        if CameraUtils.IsFinite(v33) then
                            v23 = v23 + Vector2.new(v33, 0);
                        end;

                        u1 = 0;
                    end;
                elseif not v25 then
                    local lookVector = v19.Torso.CFrame.lookVector;
                    u1 = math.clamp(u1 + 3.839724354387525 * v16, 0, 4.363323129985824);
                    local v34 = math.clamp(u1 * v16, 0, 1);
                    local v35 = p14:IsInFirstPerson() and not (p14.isFollowCamera and p14.isClimbing) and 1 or v34;
                    local v36 = CameraUtils.GetAngleBetweenXZVectors(lookVector, p14:GetCameraLookVector());

                    if CameraUtils.IsFinite(v36) and math.abs(v36) > 0.0001 then
                        v23 = v23 + Vector2.new(v36 * v35, 0);
                    end;
                end;
            elseif p14.isFollowCamera and not (v32 or (v25 or VRService.VREnabled)) then
                local v37 = CameraUtils.GetAngleBetweenXZVectors(-(p14.lastCameraTransform.p - v26), p14:GetCameraLookVector());

                if CameraUtils.IsFinite(v37) and (math.abs(v37) > 0.0001 and math.abs(v37) > 0.4 * v16) then
                    v23 = v23 + Vector2.new(v37, 0);
                end;
            end;
        end;

        local v38;

        if p14.isFollowCamera then
            local v39 = p14:CalculateNewLookVectorFromArg(v17, v23);

            if VRService.VREnabled then
                v38 = p14:GetVRFocus(v26, v16);
            else
                v38 = CFrame.new(v26);
            end;

            CFrame2 = CFrame.new(v38.p - v28 * v39, v38.p) + Vector3.new(0, v24, 0);
        else
            local VREnabled = VRService.VREnabled;

            if VREnabled then
                v38 = p14:GetVRFocus(v26, v16);
            else
                v38 = CFrame.new(v26);
            end;

            local p = v38.p;

            if VREnabled and not p14:IsInFirstPerson() then
                local magnitude = (v26 - CurrentCamera.CFrame.p).magnitude;

                if v28 < magnitude or v23.x ~= 0 then
                    local v40 = math.min(magnitude, v28);
                    local v41 = p14:CalculateNewLookVectorFromArg(nil, v23) * v40;
                    local v42 = p - v41;
                    local lookVector = CurrentCamera.CFrame.lookVector;

                    if v23.x == 0 then
                        v41 = lookVector;
                    end;

                    local v43 = Vector3.new(v42.x + v41.x, v42.y, v42.z + v41.z);
                    CFrame2 = CFrame.new(v42, v43) + Vector3.new(0, v24, 0);
                end;
            else
                local v44 = p14:CalculateNewLookVectorFromArg(v17, v23);
                CFrame2 = CFrame.new(p - v28 * v44, p);
            end;
        end;

        local v45 = p14:GetCameraToggleOffset(v16);
        Focus = v38 + v45;
        CFrame2 = CFrame2 + v45;
        p14.lastCameraTransform = CFrame2;
        p14.lastCameraFocus = Focus;

        if (v20 or v21) and CameraSubject:IsA("BasePart") then
            p14.lastSubjectCFrame = CameraSubject.CFrame;
        else
            p14.lastSubjectCFrame = nil;
        end;
    end;

    p14.lastUpdate = v15;

    return CFrame2, Focus;
end;

function u3.EnterFirstPerson(p46) -- Line: 243
    p46.inFirstPerson = true;
    p46:UpdateMouseBehavior();
end;

function u3.LeaveFirstPerson(p47) -- Line: 248
    p47.inFirstPerson = false;
    p47:UpdateMouseBehavior();
end;

return u3;