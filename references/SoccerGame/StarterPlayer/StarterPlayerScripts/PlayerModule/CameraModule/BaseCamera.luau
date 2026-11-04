  

local SpectatorController = require(game:GetService("ReplicatedStorage").Controllers.SpectatorController);
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local success, result = pcall(function() -- Line: 19
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom");
end);
local u1 = success and result;
local UserFlag = FlagUtil.getUserFlag("UserFixCameraOffsetJitter2");
Vector2.new(0.2617993877991494, 0);
Vector2.new(0.7853981633974483, 0);
Vector2.new(0, 0);
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
game:GetService("StarterGui");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 76
    -- upvalues: u2 (copy), LocalPlayer (copy), UserGameSettings (copy)
    local u3 = setmetatable({}, u2);
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
    u3.portraitMode = false;
    u3.isSmallTouchScreen = false;
    u3.resetCameraAngle = true;
    u3.enabled = false;
    u3.PlayerGui = nil;
    u3.cameraChangedConn = nil;
    u3.viewportSizeChangedConn = nil;
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
    u3.gamepadZoomPressConnection = nil;
    u3.mouseLockOffset = Vector3.new(0, 0, 0);

    if LocalPlayer.Character then
        u3:OnCharacterAdded(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p4) -- Line: 141
        -- upvalues: u3 (copy)
        u3:OnCharacterAdded(p4);
    end);

    if u3.playerCameraModeChangeConn then
        u3.playerCameraModeChangeConn:Disconnect();
    end;

    u3.playerCameraModeChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 146
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end);

    if u3.minDistanceChangeConn then
        u3.minDistanceChangeConn:Disconnect();
    end;

    u3.minDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 151
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end);

    if u3.maxDistanceChangeConn then
        u3.maxDistanceChangeConn:Disconnect();
    end;

    u3.maxDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 156
        -- upvalues: u3 (copy)
        u3:OnPlayerCameraPropertyChange();
    end);

    if u3.playerDevTouchMoveModeChangeConn then
        u3.playerDevTouchMoveModeChangeConn:Disconnect();
    end;

    u3.playerDevTouchMoveModeChangeConn = LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 161
        -- upvalues: u3 (copy)
        u3:OnDevTouchMovementModeChanged();
    end);
    u3:OnDevTouchMovementModeChanged();

    if u3.gameSettingsTouchMoveMoveChangeConn then
        u3.gameSettingsTouchMoveMoveChangeConn:Disconnect();
    end;

    u3.gameSettingsTouchMoveMoveChangeConn = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 167
        -- upvalues: u3 (copy)
        u3:OnGameSettingsTouchMovementModeChanged();
    end);
    u3:OnGameSettingsTouchMovementModeChanged();
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();
    u3.hasGameLoaded = game:IsLoaded();

    if not u3.hasGameLoaded then
        u3.gameLoadedConn = game.Loaded:Connect(function() -- Line: 177
            -- upvalues: u3 (copy)
            u3.hasGameLoaded = true;
            u3.gameLoadedConn:Disconnect();
            u3.gameLoadedConn = nil;
        end);
    end;

    u3:OnPlayerCameraPropertyChange();

    return u3;
end;

function u2.GetModuleName(p5) -- Line: 189
    return "BaseCamera";
end;

function u2.OnCharacterAdded(u6, p7) -- Line: 193
    -- upvalues: UserInputService (copy), LocalPlayer (copy)
    u6.resetCameraAngle = u6.resetCameraAngle or u6:GetEnabled();
    u6.humanoidRootPart = nil;

    if UserInputService.TouchEnabled then
        u6.PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

        for _, child in ipairs(p7:GetChildren()) do
            if child:IsA("Tool") then
                u6.isAToolEquipped = true;
            end;
        end;

        p7.ChildAdded:Connect(function(p8) -- Line: 203
            -- upvalues: u6 (copy)
            if p8:IsA("Tool") then
                u6.isAToolEquipped = true;
            end;
        end);
        p7.ChildRemoved:Connect(function(p9) -- Line: 208
            -- upvalues: u6 (copy)
            if p9:IsA("Tool") then
                u6.isAToolEquipped = false;
            end;
        end);
    end;
end;

function u2.GetHumanoidRootPart(p10) -- Line: 216
    -- upvalues: LocalPlayer (copy)
    local v11 = (not p10.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v11 then
        p10.humanoidRootPart = v11.RootPart;
    end;

    return p10.humanoidRootPart;
end;

function u2.GetBodyPartToFollow(p12: table, p13: userdata, p14: boolean) -- Line: 228
    if p13:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p13.Parent;

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or p13.RootPart;
        end;
    end;

    return p13.RootPart;
end;

function u2.GetSubjectCFrame(p15) -- Line: 240
    -- upvalues: UserFlag (copy)
    local lastSubjectCFrame = p15.lastSubjectCFrame;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return lastSubjectCFrame;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local v16 = workspace_CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = workspace_CurrentCamera.CameraOffset;

        if UserFlag and p15:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = workspace_CurrentCamera.RootPart;

        if v16 and (workspace_CurrentCamera.Parent and workspace_CurrentCamera.Parent:IsA("Model")) then
            RootPart = workspace_CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v17;

            if workspace_CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if workspace_CurrentCamera.AutomaticScalingEnabled then
                    v17 = Vector3.new(0, 1.5, 0);
                    local RootPart2 = workspace_CurrentCamera.RootPart;

                    if RootPart == RootPart2 then
                        v17 = v17 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                    end;
                else
                    v17 = Vector3.new(0, 2, 0);
                end;
            else
                v17 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectCFrame = RootPart.CFrame * CFrame.new((v16 and Vector3.new(0, 0, 0) or v17) + CameraOffset);
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
        p15.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u2.GetSubjectVelocity(p18) -- Line: 314
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
        local v19 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v19 then
            return v19.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.GetSubjectRotVelocity(p20) -- Line: 343
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
        local v21 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v21 then
            return v21.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.StepZoom(p22) -- Line: 372
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p22.currentSubjectDistance;
    local ZoomDelta = CameraInput.getZoomDelta();

    if math.abs(ZoomDelta) > 0 then
        local v23;

        if ZoomDelta > 0 then
            v23 = math.max(currentSubjectDistance + ZoomDelta * (currentSubjectDistance * 0.5 + 1), p22.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v23 = math.max((currentSubjectDistance + ZoomDelta) / (1 - ZoomDelta * 0.5), 0.5);
        end;

        p22:SetCameraToSubjectDistance(v23 < p22.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v23);
    end;

    return ZoomController.GetZoomRadius();
end;

function u2.GetSubjectPosition(p24) -- Line: 397
    -- upvalues: UserFlag (copy)
    local lastSubjectPosition = p24.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v25 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if UserFlag and p24:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v25 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v26;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v26 = Vector3.new(0, 1.5, 0);

                    if RootPart == CurrentCamera.RootPart then
                        v26 = v26 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v26 = Vector3.new(0, 2, 0);
                end;
            else
                v26 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectPosition = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace((v25 and Vector3.new(0, 0, 0) or v26) + CameraOffset);
        end;
    elseif CurrentCamera:IsA("VehicleSeat") then
        lastSubjectPosition = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0));
    elseif CurrentCamera:IsA("SkateboardPlatform") then
        lastSubjectPosition = CurrentCamera.CFrame.p + Vector3.new(0, 5, 0);
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectPosition = CurrentCamera.CFrame.p;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectPosition = CurrentCamera:GetPrimaryPartCFrame().p;
        else
            lastSubjectPosition = CurrentCamera:GetModelCFrame().p;
        end;
    end;

    p24.lastSubject = CurrentCamera;
    p24.lastSubjectPosition = lastSubjectPosition;

    return lastSubjectPosition;
end;

function u2.OnViewportSizeChanged(p27) -- Line: 474
    -- upvalues: UserInputService (copy)
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    p27.portraitMode = ViewportSize.X < ViewportSize.Y;
    p27.isSmallTouchScreen = UserInputService.TouchEnabled and (ViewportSize.Y < 500 and true or ViewportSize.X < 700);
end;

function u2.OnCurrentCameraChanged(u28) -- Line: 482
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        if u28.viewportSizeChangedConn then
            u28.viewportSizeChangedConn:Disconnect();
            u28.viewportSizeChangedConn = nil;
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;

        if CurrentCamera then
            u28:OnViewportSizeChanged();
            u28.viewportSizeChangedConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 493
                -- upvalues: u28 (copy)
                u28:OnViewportSizeChanged();
            end);
        end;
    end;

    if u28.cameraSubjectChangedConn then
        u28.cameraSubjectChangedConn:Disconnect();
        u28.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u28.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 507
            -- upvalues: u28 (copy)
            u28:OnNewCameraSubject();
        end);
        u28:OnNewCameraSubject();
    end;
end;

function u2.OnDynamicThumbstickEnabled(p29) -- Line: 514
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        p29.isDynamicThumbstickEnabled = true;
    end;
end;

function u2.OnDynamicThumbstickDisabled(p30) -- Line: 520
    p30.isDynamicThumbstickEnabled = false;
end;

function u2.OnGameSettingsTouchMovementModeChanged(p31) -- Line: 524
    -- upvalues: LocalPlayer (copy), UserGameSettings (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.Default then
            p31:OnDynamicThumbstickEnabled();

            return;
        end;

        p31:OnDynamicThumbstickDisabled();
    end;
end;

function u2.OnDevTouchMovementModeChanged(p32) -- Line: 535
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        p32:OnDynamicThumbstickEnabled();

        return;
    end;

    p32:OnGameSettingsTouchMovementModeChanged();
end;

function u2.OnPlayerCameraPropertyChange(p33) -- Line: 543
    p33:SetCameraToSubjectDistance(p33.currentSubjectDistance);
end;

function u2.InputTranslationToCameraAngleChange(p34, p35, p36) -- Line: 548
    return p35 * p36;
end;

function u2.GamepadZoomPress(p37) -- Line: 554
    -- upvalues: LocalPlayer (copy), u1 (ref)
    local CameraToSubjectDistance = p37:GetCameraToSubjectDistance();
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance;

    for i = #p37.gamepadZoomLevels, 1, -1 do
        local v38 = p37.gamepadZoomLevels[i];
        local v39;

        if CameraMaxZoomDistance < v38 then
            v39 = i;
        else
            if v38 < LocalPlayer.CameraMinZoomDistance then
                v38 = LocalPlayer.CameraMinZoomDistance;

                if u1 and CameraMaxZoomDistance == v38 then
                    break;
                end;
            end;

            if not u1 and CameraMaxZoomDistance == v38 then
                break;
            end;

            if v38 + (CameraMaxZoomDistance - v38) / 2 < CameraToSubjectDistance then
                p37:SetCameraToSubjectDistance(v38);

                return;
            end;

            CameraMaxZoomDistance = v38;
            v39 = i;
        end;
    end;

    p37:SetCameraToSubjectDistance(p37.gamepadZoomLevels[#p37.gamepadZoomLevels]);
end;

function u2.Enable(p40: table, p41: boolean) -- Line: 599
    if p40.enabled ~= p41 then
        p40.enabled = p41;
        p40:OnEnabledChanged();
    end;
end;

function u2.OnEnabledChanged(u42) -- Line: 607
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if not u42.enabled then
        CameraInput.setInputEnabled(false);

        if u42.gamepadZoomPressConnection then
            u42.gamepadZoomPressConnection:Disconnect();
            u42.gamepadZoomPressConnection = nil;
        end;

        u42:Cleanup();

        return;
    end;

    CameraInput.setInputEnabled(true);
    u42.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- Line: 611
        -- upvalues: u42 (copy)
        u42:GamepadZoomPress();
    end);

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        u42.currentSubjectDistance = 0.5;

        if not u42.inFirstPerson then
            u42:EnterFirstPerson();
        end;
    end;

    if u42.cameraChangedConn then
        u42.cameraChangedConn:Disconnect();
        u42.cameraChangedConn = nil;
    end;

    u42.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 623
        -- upvalues: u42 (copy)
        u42:OnCurrentCameraChanged();
    end);
    u42:OnCurrentCameraChanged();
end;

function u2.GetEnabled(p43) -- Line: 639
    return p43.enabled;
end;

function u2.Cleanup(p44) -- Line: 643
    -- upvalues: CameraUtils (copy)
    if p44.subjectStateChangedConn then
        p44.subjectStateChangedConn:Disconnect();
        p44.subjectStateChangedConn = nil;
    end;

    if p44.viewportSizeChangedConn then
        p44.viewportSizeChangedConn:Disconnect();
        p44.viewportSizeChangedConn = nil;
    end;

    if p44.cameraChangedConn then
        p44.cameraChangedConn:Disconnect();
        p44.cameraChangedConn = nil;
    end;

    p44.lastCameraTransform = nil;
    p44.lastSubjectCFrame = nil;
    CameraUtils.restoreMouseBehavior();
end;

function u2.UpdateMouseBehavior(p45) -- Line: 664
    -- upvalues: UserGameSettings (copy), CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), CameraUtils (copy)
    if p45.isCameraToggle and UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p45.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p45.inFirstPerson or p45.inMouseLockedMode then
        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative);
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter);

        return;
    end;

    CameraUtils.restoreRotationType();

    if CameraInput.getRotationActivated() then
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition);

        return;
    end;

    CameraUtils.restoreMouseBehavior();
end;

function u2.UpdateForDistancePropertyChange(p46) -- Line: 692
    p46:SetCameraToSubjectDistance(p46.currentSubjectDistance);
end;

function u2.SetCameraToSubjectDistance(p47: table, p48: number) -- Line: 698
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p47.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p47.currentSubjectDistance = 0.5;

        if not p47.inFirstPerson then
            p47:EnterFirstPerson();
        end;
    else
        local math_clamp_ret = math.clamp(p48, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if math_clamp_ret < 1 then
            p47.currentSubjectDistance = 0.5;

            if not p47.inFirstPerson then
                p47:EnterFirstPerson();
            end;
        else
            p47.currentSubjectDistance = math_clamp_ret;

            if p47.inFirstPerson then
                p47:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p47.currentSubjectDistance, (math.sign(p48 - currentSubjectDistance)));

    return p47.currentSubjectDistance;
end;

function u2.SetCameraType(p49, p50) -- Line: 732
    p49.cameraType = p50;
end;

function u2.GetCameraType(p51) -- Line: 737
    return p51.cameraType;
end;

function u2.SetCameraMovementMode(p52, p53) -- Line: 742
    p52.cameraMovementMode = p53;
end;

function u2.GetCameraMovementMode(p54) -- Line: 746
    return p54.cameraMovementMode;
end;

function u2.SetIsMouseLocked(p55: table, p56: boolean) -- Line: 750
    p55.inMouseLockedMode = p56;
end;

function u2.GetIsMouseLocked(p57) -- Line: 754
    return p57.inMouseLockedMode;
end;

function u2.SetMouseLockOffset(p58, p59) -- Line: 758
    p58.mouseLockOffset = p59;
end;

function u2.GetMouseLockOffset(p60) -- Line: 762
    return p60.mouseLockOffset;
end;

function u2.InFirstPerson(p61) -- Line: 766
    return p61.inFirstPerson;
end;

function u2.EnterFirstPerson(p62) -- Line: 770
    p62.inFirstPerson = true;
    p62:UpdateMouseBehavior();
end;

function u2.LeaveFirstPerson(p63) -- Line: 775
    p63.inFirstPerson = false;
    p63:UpdateMouseBehavior();
end;

function u2.GetCameraToSubjectDistance(p64) -- Line: 781
    return p64.currentSubjectDistance;
end;

function u2.GetMeasuredDistanceToFocus(p65) -- Line: 788
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude;
    end;

    return nil;
end;

function u2.GetCameraLookVector(p66) -- Line: 796
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

function u2.CalculateNewLookCFrameFromArg(p67: table, p68: vector?, p69) -- Line: 800
    -- upvalues: SpectatorController (copy)
    local v70 = SpectatorController.IsSpectating and SpectatorController.SpectatingTarget == "Ball" and -0.2617993877991494 or 1.3962634015954636;
    local v71 = p68 or p67:GetCameraLookVector();
    local math_asin_ret = math.asin(v71.Y);
    local math_clamp_ret = math.clamp(p69.Y, -v70 + math_asin_ret, math_asin_ret + 1.3962634015954636);
    local Vector2_new_ret = Vector2.new(p69.X, math_clamp_ret);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), v71);

    return CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0);
end;

function u2.CalculateNewLookVectorFromArg(p72: table, p73: vector?, p74) -- Line: 816
    return p72:CalculateNewLookCFrameFromArg(p73, p74).LookVector;
end;

function u2.CalculateNewLookVectorVRFromArg(p75: table, p76) -- Line: 821
    local unit = ((p75:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local Vector2_new_ret = Vector2.new(p76.X, 0);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;

function u2.GetHumanoid(p77) -- Line: 831
    -- upvalues: LocalPlayer (copy)
    local v78 = LocalPlayer and LocalPlayer.Character;

    if not v78 then
        return nil;
    end;

    local v79 = p77.humanoidCache[LocalPlayer];

    if v79 and v79.Parent == v78 then
        return v79;
    end;

    p77.humanoidCache[LocalPlayer] = nil;
    local v80 = v78:FindFirstChildOfClass("Humanoid");

    if v80 then
        p77.humanoidCache[LocalPlayer] = v80;
    end;

    return v80;
end;

function u2.GetHumanoidPartToFollow(p81: table, p82: userdata, p83: any) -- Line: 849
    if p83 ~= Enum.HumanoidStateType.Dead then
        return p82.Torso;
    end;

    local Parent = p82.Parent;

    if Parent then
        return Parent:FindFirstChild("Head") or p82.Torso;
    end;

    return p82.Torso;
end;

function u2.OnNewCameraSubject(p84) -- Line: 863
    if p84.subjectStateChangedConn then
        p84.subjectStateChangedConn:Disconnect();
        p84.subjectStateChangedConn = nil;
    end;
end;

function u2.IsInFirstPerson(p85) -- Line: 870
    return p85.inFirstPerson;
end;

function u2.Update(p86, p87) -- Line: 874
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

function u2.GetCameraHeight(p88) -- Line: 878
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p88.inFirstPerson) and 0 or 0.25881904510252074 * p88.currentSubjectDistance;
end;

return u2;