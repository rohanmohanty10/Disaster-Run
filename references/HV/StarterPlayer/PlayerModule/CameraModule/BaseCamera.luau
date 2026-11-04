 

 

local Players = game:GetService("Players");
local VRService = game:GetService("VRService");
local GuiService = game:GetService("GuiService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"));
local u1 = CommonUtils.get("ConnectionUtil");
CommonUtils.get("FlagUtil");
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local CameraGamepadZoomAction = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraGamepadZoomAction");
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 74
    -- upvalues: u2 (copy), u1 (copy), LocalPlayer (copy), CameraGamepadZoomAction (copy), UserGameSettings (copy)
    local u3 = setmetatable({}, u2);
    u3._connections = u1.new();
    u3.gamepadZoomLevels = { 0, 10, 20 };
    u3.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    u3.cameraType = nil;
    u3.cameraMovementMode = nil;
    u3.lastCameraTransform = nil;
    u3.lastUserPanCamera = tick();
    u3.humanoidRootPart = nil;
    u3.humanoidCache = {};
    u3.lastSubject = nil;
    u3.lastSubjectPosition = Vector3.new(0, 5, 0);
    u3.lastSubjectCFrame = CFrame.new(u3.lastSubjectPosition);
    u3.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    u3.inFirstPerson = false;
    u3.inMouseLockedMode = false;
    u3.resetCameraAngle = true;
    u3.enabled = false;
    u3.cameraChangedConn = nil;
    u3.shouldUseVRRotation = false;
    u3.VRRotationIntensityAvailable = false;
    u3.lastVRRotationIntensityCheckTime = 0;
    u3.lastVRRotationTime = 0;
    u3.vrRotateKeyCooldown = {};
    u3.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    u3.humanoidJumpOrigin = nil;
    u3.trackingHumanoid = nil;
    u3.cameraFrozen = false;
    u3.subjectStateChangedConn = nil;
    u3.gamepadZoomPressConnection = CameraGamepadZoomAction.Pressed:Connect(function() -- Line: 122
        -- upvalues: u3 (copy)
        u3:GamepadZoomPress();
    end);
    u3.mouseLockOffset = Vector3.new(0, 0, 0);
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();

    return u3;
end;

function u2.GetModuleName(p4) -- Line: 136
    return "BaseCamera";
end;

local function onSelectedObjectChanged() -- Line: 140
    -- upvalues: CameraGamepadZoomAction (copy), GuiService (copy)
    CameraGamepadZoomAction.Enabled = not GuiService.SelectedObject;
end;

function u2._setUpConfigurations(u5) -- Line: 144
    -- upvalues: LocalPlayer (copy), GuiService (copy), CameraGamepadZoomAction (copy)
    u5._connections:trackConnection("CHARACTER_ADDED", LocalPlayer.CharacterAdded:Connect(function(p6) -- Line: 145
        -- upvalues: u5 (copy)
        u5:OnCharacterAdded(p6);
    end));
    u5.humanoidRootPart = nil;
    u5._connections:trackConnection("CAMERA_MODE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 150
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 153
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 156
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5._connections:trackConnection("SELECTION_MODE_CHANGED", GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(function() -- Line: 159
        -- upvalues: CameraGamepadZoomAction (ref), GuiService (ref)
        CameraGamepadZoomAction.Enabled = not GuiService.SelectedObject;
    end));
    u5:OnPlayerCameraPropertyChange();
end;

function u2.OnCharacterAdded(p7, p8) -- Line: 165
    p7.resetCameraAngle = p7.resetCameraAngle or p7:GetEnabled();
    p7.humanoidRootPart = nil;
end;

function u2.GetHumanoidRootPart(p9) -- Line: 172
    -- upvalues: LocalPlayer (copy)
    local v10 = (not p9.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v10 then
        p9.humanoidRootPart = v10.RootPart;
    end;

    return p9.humanoidRootPart;
end;

function u2.GetSubjectCFrame(p11) -- Line: 184
    local lastSubjectCFrame = p11.lastSubjectCFrame;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return lastSubjectCFrame;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local v12 = workspace_CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = workspace_CurrentCamera.CameraOffset;

        if p11:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = workspace_CurrentCamera.RootPart;

        if v12 and (workspace_CurrentCamera.Parent and workspace_CurrentCamera.Parent:IsA("Model")) then
            RootPart = workspace_CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v13;

            if workspace_CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if workspace_CurrentCamera.AutomaticScalingEnabled then
                    v13 = Vector3.new(0, 1.5, 0);
                    local RootPart2 = workspace_CurrentCamera.RootPart;

                    if RootPart == RootPart2 then
                        v13 = v13 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                    end;
                else
                    v13 = Vector3.new(0, 2, 0);
                end;
            else
                v13 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectCFrame = RootPart.CFrame * CFrame.new((v12 and Vector3.new(0, 0, 0) or v13) + CameraOffset);
        end;
    elseif workspace_CurrentCamera:IsA("BasePart") then
        lastSubjectCFrame = workspace_CurrentCamera.CFrame;
    elseif workspace_CurrentCamera:IsA("Model") then
        if workspace_CurrentCamera.PrimaryPart then
            lastSubjectCFrame = workspace_CurrentCamera:GetPrimaryPartCFrame();
        else
            lastSubjectCFrame = CFrame.new();
        end;
    end;

    if lastSubjectCFrame then
        p11.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u2.GetSubjectVelocity(p14) -- Line: 258
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if workspace_CurrentCamera:IsA("BasePart") then
        return workspace_CurrentCamera.Velocity;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local RootPart = workspace_CurrentCamera.RootPart;

        if RootPart then
            return RootPart.Velocity;
        end;
    else
        local v15 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v15 then
            return v15.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.GetSubjectRotVelocity(p16) -- Line: 287
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if workspace_CurrentCamera:IsA("BasePart") then
        return workspace_CurrentCamera.RotVelocity;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local RootPart = workspace_CurrentCamera.RootPart;

        if RootPart then
            return RootPart.RotVelocity;
        end;
    else
        local v17 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v17 then
            return v17.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.StepZoom(p18: table, p19: number?) -- Line: 316
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p18.currentSubjectDistance;
    local ZoomDelta = CameraInput.getZoomDelta(p19);

    if math.abs(ZoomDelta) > 0 then
        local v20;

        if ZoomDelta > 0 then
            v20 = math.max(currentSubjectDistance + ZoomDelta * (currentSubjectDistance * 0.5 + 1), p18.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v20 = math.max((currentSubjectDistance + ZoomDelta) / (1 - ZoomDelta * 0.5), 0.5);
        end;

        p18:SetCameraToSubjectDistance(v20 < p18.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v20);
    end;

    return ZoomController.GetZoomRadius();
end;

function u2.GetSubjectPosition(p21) -- Line: 341
    local lastSubjectPosition = p21.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v22 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if p21:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v22 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v23;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v23 = Vector3.new(0, 1.5, 0);

                    if RootPart == CurrentCamera.RootPart then
                        v23 = v23 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v23 = Vector3.new(0, 2, 0);
                end;
            else
                v23 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectPosition = RootPart.CFrame.Position + RootPart.CFrame:vectorToWorldSpace((v22 and Vector3.new(0, 0, 0) or v23) + CameraOffset);
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        lastSubjectPosition = CurrentCamera.CFrame.Position + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif CurrentCamera:IsA("SkateboardPlatform") then
        lastSubjectPosition = CurrentCamera.CFrame.Position + Vector3.new(0, 5, 0);
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectPosition = CurrentCamera.CFrame.Position;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectPosition = CurrentCamera:GetPrimaryPartCFrame().Position;
        else
            lastSubjectPosition = CurrentCamera:GetModelCFrame().Position;
        end;
    end;

    p21.lastSubject = CurrentCamera;
    p21.lastSubjectPosition = lastSubjectPosition;

    return lastSubjectPosition;
end;

function u2.OnCurrentCameraChanged(u24) -- Line: 419
    if u24.cameraSubjectChangedConn then
        u24.cameraSubjectChangedConn:Disconnect();
        u24.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u24.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 428
            -- upvalues: u24 (copy)
            u24:OnNewCameraSubject();
        end);
        u24:OnNewCameraSubject();
    end;
end;

function u2.OnPlayerCameraPropertyChange(p25) -- Line: 435
    p25:SetCameraToSubjectDistance(p25.currentSubjectDistance);
end;

function u2.InputTranslationToCameraAngleChange(p26, p27, p28) -- Line: 440
    return p27 * p28;
end;

function u2.GamepadZoomPress(p29) -- Line: 446
    -- upvalues: LocalPlayer (copy)
    local CameraToSubjectDistance = p29:GetCameraToSubjectDistance();
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance;

    for i = #p29.gamepadZoomLevels, 1, -1 do
        local v30 = p29.gamepadZoomLevels[i];
        local v31;

        if CameraMaxZoomDistance < v30 then
            v31 = i;
        else
            if v30 < LocalPlayer.CameraMinZoomDistance then
                v30 = LocalPlayer.CameraMinZoomDistance;

                if CameraMaxZoomDistance == v30 then
                    break;
                end;
            end;

            if v30 + (CameraMaxZoomDistance - v30) / 2 < CameraToSubjectDistance then
                p29:SetCameraToSubjectDistance(v30);

                return;
            end;

            CameraMaxZoomDistance = v30;
            v31 = i;
        end;
    end;

    p29:SetCameraToSubjectDistance(p29.gamepadZoomLevels[#p29.gamepadZoomLevels]);
end;

function u2.Enable(p32: table, p33: boolean) -- Line: 483
    if p32.enabled ~= p33 then
        p32.enabled = p33;
        p32:OnEnabledChanged();
    end;
end;

function u2.OnEnabledChanged(u34) -- Line: 491
    -- upvalues: CameraInput (copy), CameraGamepadZoomAction (copy), LocalPlayer (copy)
    if not u34.enabled then
        u34._connections:disconnectAll();
        CameraInput.setInputEnabled(false);
        CameraGamepadZoomAction.Enabled = false;
        u34:Cleanup();

        return;
    end;

    u34:_setUpConfigurations();
    CameraInput.setInputEnabled(true);
    CameraGamepadZoomAction.Enabled = true;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        u34.currentSubjectDistance = 0.5;

        if not u34.inFirstPerson then
            u34:EnterFirstPerson();
        end;
    end;

    if u34.cameraChangedConn then
        u34.cameraChangedConn:Disconnect();
        u34.cameraChangedConn = nil;
    end;

    u34.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 507
        -- upvalues: u34 (copy)
        u34:OnCurrentCameraChanged();
    end);
    u34:OnCurrentCameraChanged();
end;

function u2.GetEnabled(p35) -- Line: 522
    return p35.enabled;
end;

function u2.Cleanup(p36) -- Line: 526
    -- upvalues: CameraUtils (copy)
    if p36.subjectStateChangedConn then
        p36.subjectStateChangedConn:Disconnect();
        p36.subjectStateChangedConn = nil;
    end;

    if p36.cameraChangedConn then
        p36.cameraChangedConn:Disconnect();
        p36.cameraChangedConn = nil;
    end;

    p36.lastCameraTransform = nil;
    p36.lastSubjectCFrame = nil;
    CameraUtils.restoreMouseBehavior();
end;

function u2.UpdateMouseBehavior(p37) -- Line: 543
    -- upvalues: UserGameSettings (copy), CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), CameraUtils (copy)
    if p37.isCameraToggle and UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p37.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p37.inFirstPerson or p37.inMouseLockedMode then
        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);

        return;
    end;

    CameraUtils.restoreRotationType();

    if CameraInput.getPanActivated() then
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);

        return;
    end;

    CameraUtils.restoreMouseBehavior();
end;

function u2.UpdateForDistancePropertyChange(p38) -- Line: 571
    p38:SetCameraToSubjectDistance(p38.currentSubjectDistance);
end;

function u2.SetCameraToSubjectDistance(p39: table, p40: number) -- Line: 577
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p39.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p39.currentSubjectDistance = 0.5;

        if not p39.inFirstPerson then
            p39:EnterFirstPerson();
        end;
    else
        local math_clamp_ret = math.clamp(p40, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if math_clamp_ret < 1 then
            p39.currentSubjectDistance = 0.5;

            if not p39.inFirstPerson then
                p39:EnterFirstPerson();
            end;
        else
            p39.currentSubjectDistance = math_clamp_ret;

            if p39.inFirstPerson then
                p39:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p39.currentSubjectDistance, (math.sign(p40 - currentSubjectDistance)));

    return p39.currentSubjectDistance;
end;

function u2.SetCameraType(p41, p42) -- Line: 611
    p41.cameraType = p42;
end;

function u2.GetCameraType(p43) -- Line: 616
    return p43.cameraType;
end;

function u2.SetCameraMovementMode(p44, p45) -- Line: 621
    p44.cameraMovementMode = p45;
end;

function u2.GetCameraMovementMode(p46) -- Line: 625
    return p46.cameraMovementMode;
end;

function u2.SetIsMouseLocked(p47: table, p48: boolean) -- Line: 629
    p47.inMouseLockedMode = p48;
end;

function u2.GetIsMouseLocked(p49) -- Line: 633
    return p49.inMouseLockedMode;
end;

function u2.SetMouseLockOffset(p50, p51) -- Line: 637
    p50.mouseLockOffset = p51;
end;

function u2.GetMouseLockOffset(p52) -- Line: 641
    return p52.mouseLockOffset;
end;

function u2.InFirstPerson(p53) -- Line: 645
    return p53.inFirstPerson;
end;

function u2.EnterFirstPerson(p54) -- Line: 649
    p54.inFirstPerson = true;
    p54:UpdateMouseBehavior();
end;

function u2.LeaveFirstPerson(p55) -- Line: 654
    p55.inFirstPerson = false;
    p55:UpdateMouseBehavior();
end;

function u2.GetCameraToSubjectDistance(p56) -- Line: 660
    return p56.currentSubjectDistance;
end;

function u2.GetMeasuredDistanceToFocus(p57) -- Line: 667
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.Position - CurrentCamera.Focus.Position).magnitude;
    end;

    return nil;
end;

function u2.GetCameraLookVector(p58) -- Line: 675
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

function u2.CalculateNewLookCFrameFromArg(p59: table, p60: vector?, p61) -- Line: 679
    local v62 = p60 or p59:GetCameraLookVector();
    local math_asin_ret = math.asin(v62.Y);
    local math_clamp_ret = math.clamp(p61.Y, math_asin_ret + -1.3962634015954636, math_asin_ret + 1.3962634015954636);
    local Vector2_new_ret = Vector2.new(p61.X, math_clamp_ret);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), v62);

    return CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0);
end;

function u2.CalculateNewLookVectorFromArg(p63: table, p64: vector?, p65) -- Line: 689
    return p63:CalculateNewLookCFrameFromArg(p64, p65).LookVector;
end;

function u2.CalculateNewLookVectorVRFromArg(p66: table, p67) -- Line: 694
    local unit = ((p66:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.Position) * Vector3.new(1, 0, 1)).unit;
    local Vector2_new_ret = Vector2.new(p67.X, 0);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;

function u2.GetHumanoid(p68) -- Line: 704
    -- upvalues: LocalPlayer (copy)
    local v69 = LocalPlayer and LocalPlayer.Character;

    if not v69 then
        return nil;
    end;

    local v70 = p68.humanoidCache[LocalPlayer];

    if v70 and v70.Parent == v69 then
        return v70;
    end;

    p68.humanoidCache[LocalPlayer] = nil;
    local v71 = v69:FindFirstChildOfClass("Humanoid");

    if v71 then
        p68.humanoidCache[LocalPlayer] = v71;
    end;

    return v71;
end;

function u2.OnNewCameraSubject(p72) -- Line: 722
    if p72.subjectStateChangedConn then
        p72.subjectStateChangedConn:Disconnect();
        p72.subjectStateChangedConn = nil;
    end;
end;

function u2.IsInFirstPerson(p73) -- Line: 729
    return p73.inFirstPerson;
end;

function u2.Update(p74, p75) -- Line: 733
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

function u2.GetCameraHeight(p76) -- Line: 737
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p76.inFirstPerson) and 0 or 0.25881904510252074 * p76.currentSubjectDistance;
end;

return u2;