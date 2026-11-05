  

 

local u1 = Vector2.new(0.2617993877991494, 0);
local u2 = Vector2.new(0.7853981633974483, 0);
local u3 = Vector2.new(0, 0);
require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local StarterGui = game:GetService("StarterGui");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local LocalPlayer = Players.LocalPlayer;
local u4 = {};
u4.__index = u4;

function u4.new() -- Line: 61
    -- upvalues: u4 (copy), LocalPlayer (copy), UserGameSettings (copy)
    local u5 = setmetatable({}, u4);
    u5.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    u5.cameraType = nil;
    u5.cameraMovementMode = nil;
    u5.lastCameraTransform = nil;
    u5.lastUserPanCamera = tick();
    u5.humanoidRootPart = nil;
    u5.humanoidCache = {};
    u5.lastSubject = nil;
    u5.lastSubjectPosition = Vector3.new(0, 5, 0);
    u5.lastSubjectCFrame = CFrame.new(u5.lastSubjectPosition);
    u5.defaultSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    u5.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    u5.inFirstPerson = false;
    u5.inMouseLockedMode = false;
    u5.portraitMode = false;
    u5.isSmallTouchScreen = false;
    u5.resetCameraAngle = true;
    u5.enabled = false;
    u5.PlayerGui = nil;
    u5.cameraChangedConn = nil;
    u5.viewportSizeChangedConn = nil;
    u5.shouldUseVRRotation = false;
    u5.VRRotationIntensityAvailable = false;
    u5.lastVRRotationIntensityCheckTime = 0;
    u5.lastVRRotationTime = 0;
    u5.vrRotateKeyCooldown = {};
    u5.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    u5.humanoidJumpOrigin = nil;
    u5.trackingHumanoid = nil;
    u5.cameraFrozen = false;
    u5.subjectStateChangedConn = nil;
    u5.gamepadZoomPressConnection = nil;
    u5.mouseLockOffset = Vector3.new(0, 0, 0);

    if LocalPlayer.Character then
        u5:OnCharacterAdded(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(p6) -- Line: 129
        -- upvalues: u5 (copy)
        u5:OnCharacterAdded(p6);
    end);

    if u5.cameraChangedConn then
        u5.cameraChangedConn:Disconnect();
    end;

    u5.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 134
        -- upvalues: u5 (copy)
        u5:OnCurrentCameraChanged();
    end);
    u5:OnCurrentCameraChanged();

    if u5.playerCameraModeChangeConn then
        u5.playerCameraModeChangeConn:Disconnect();
    end;

    u5.playerCameraModeChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 140
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end);

    if u5.minDistanceChangeConn then
        u5.minDistanceChangeConn:Disconnect();
    end;

    u5.minDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 145
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end);

    if u5.maxDistanceChangeConn then
        u5.maxDistanceChangeConn:Disconnect();
    end;

    u5.maxDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 150
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end);

    if u5.playerDevTouchMoveModeChangeConn then
        u5.playerDevTouchMoveModeChangeConn:Disconnect();
    end;

    u5.playerDevTouchMoveModeChangeConn = LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 155
        -- upvalues: u5 (copy)
        u5:OnDevTouchMovementModeChanged();
    end);
    u5:OnDevTouchMovementModeChanged();

    if u5.gameSettingsTouchMoveMoveChangeConn then
        u5.gameSettingsTouchMoveMoveChangeConn:Disconnect();
    end;

    u5.gameSettingsTouchMoveMoveChangeConn = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 161
        -- upvalues: u5 (copy)
        u5:OnGameSettingsTouchMovementModeChanged();
    end);
    u5:OnGameSettingsTouchMovementModeChanged();
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();
    u5.hasGameLoaded = game:IsLoaded();

    if not u5.hasGameLoaded then
        u5.gameLoadedConn = game.Loaded:Connect(function() -- Line: 171
            -- upvalues: u5 (copy)
            u5.hasGameLoaded = true;
            u5.gameLoadedConn:Disconnect();
            u5.gameLoadedConn = nil;
        end);
    end;

    u5:OnPlayerCameraPropertyChange();

    return u5;
end;

function u4.GetModuleName(p7) -- Line: 183
    return "BaseCamera";
end;

function u4.OnCharacterAdded(u8, p9) -- Line: 187
    -- upvalues: UserInputService (copy), LocalPlayer (copy)
    u8.resetCameraAngle = u8.resetCameraAngle or u8:GetEnabled();
    u8.humanoidRootPart = nil;

    if UserInputService.TouchEnabled then
        u8.PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

        for _, child in ipairs(p9:GetChildren()) do
            if child:IsA("Tool") then
                u8.isAToolEquipped = true;
            end;
        end;

        p9.ChildAdded:Connect(function(p10) -- Line: 197
            -- upvalues: u8 (copy)
            if p10:IsA("Tool") then
                u8.isAToolEquipped = true;
            end;
        end);
        p9.ChildRemoved:Connect(function(p11) -- Line: 202
            -- upvalues: u8 (copy)
            if p11:IsA("Tool") then
                u8.isAToolEquipped = false;
            end;
        end);
    end;
end;

function u4.GetHumanoidRootPart(p12) -- Line: 210
    -- upvalues: LocalPlayer (copy)
    local v13 = (not p12.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v13 then
        p12.humanoidRootPart = v13.RootPart;
    end;

    return p12.humanoidRootPart;
end;

function u4.GetBodyPartToFollow(p14, p15, p16) -- Line: 222
    if p15:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p15.Parent;

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or p15.RootPart;
        end;
    end;

    return p15.RootPart;
end;

function u4.GetSubjectCFrame(p17) -- Line: 234
    -- upvalues: VRService (copy)
    local lastSubjectCFrame = p17.lastSubjectCFrame;
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return lastSubjectCFrame;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v18 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;

        if VRService.VREnabled and (v18 and CurrentCamera == p17.lastSubject) then
            lastSubjectCFrame = p17.lastSubjectCFrame;
        else
            local RootPart = CurrentCamera.RootPart;

            if v18 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
                RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
            end;

            if RootPart and RootPart:IsA("BasePart") then
                local v19;

                if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                    if CurrentCamera.AutomaticScalingEnabled then
                        v19 = Vector3.new(0, 1.5, 0);
                        local RootPart2 = CurrentCamera.RootPart;

                        if RootPart == RootPart2 then
                            v19 = v19 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                        end;
                    else
                        v19 = Vector3.new(0, 2, 0);
                    end;
                else
                    v19 = Vector3.new(0, 1.5, 0);
                end;

                lastSubjectCFrame = RootPart.CFrame * CFrame.new((v18 and Vector3.new(0, 0, 0) or v19) + CurrentCamera.CameraOffset);
            end;
        end;
    elseif CurrentCamera:IsA("BasePart") then
        lastSubjectCFrame = CurrentCamera.CFrame;
    elseif CurrentCamera:IsA("Model") then
        if CurrentCamera.PrimaryPart then
            lastSubjectCFrame = CurrentCamera:GetPrimaryPartCFrame();
        else
            lastSubjectCFrame = CFrame.new();
        end;
    end;

    if lastSubjectCFrame then
        p17.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u4.GetSubjectVelocity(p20) -- Line: 304
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if CurrentCamera:IsA("BasePart") then
        return CurrentCamera.Velocity;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local RootPart = CurrentCamera.RootPart;

        if RootPart then
            return RootPart.Velocity;
        end;
    else
        local v21 = CurrentCamera:IsA("Model") and CurrentCamera.PrimaryPart;

        if v21 then
            return v21.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u4.GetSubjectRotVelocity(p22) -- Line: 333
    local CurrentCamera = workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return Vector3.new(0, 0, 0);
    end;

    if CurrentCamera:IsA("BasePart") then
        return CurrentCamera.RotVelocity;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local RootPart = CurrentCamera.RootPart;

        if RootPart then
            return RootPart.RotVelocity;
        end;
    else
        local v23 = CurrentCamera:IsA("Model") and CurrentCamera.PrimaryPart;

        if v23 then
            return v23.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u4.StepZoom(p24) -- Line: 362
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p24.currentSubjectDistance;
    local v25 = CameraInput.getZoomDelta();

    if math.abs(v25) > 0 then
        local v26;

        if v25 > 0 then
            v26 = math.max(currentSubjectDistance + v25 * (currentSubjectDistance * 0.5 + 1), p24.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v26 = math.max((currentSubjectDistance + v25) / (1 - v25 * 0.5), 0.5);
        end;

        p24:SetCameraToSubjectDistance(v26 < p24.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v26);
    end;

    return ZoomController.GetZoomRadius();
end;

function u4.GetSubjectPosition(p27) -- Line: 387
    -- upvalues: VRService (copy)
    local lastSubjectPosition = p27.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if CurrentCamera then
        if CurrentCamera:IsA("Humanoid") then
            local v28 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;

            if VRService.VREnabled and (v28 and CurrentCamera == p27.lastSubject) then
                lastSubjectPosition = p27.lastSubjectPosition;
            else
                local RootPart = CurrentCamera.RootPart;

                if v28 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
                    RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
                end;

                if RootPart and RootPart:IsA("BasePart") then
                    local v29;

                    if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                        if CurrentCamera.AutomaticScalingEnabled then
                            v29 = Vector3.new(0, 1.5, 0);

                            if RootPart == CurrentCamera.RootPart then
                                v29 = v29 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                            end;
                        else
                            v29 = Vector3.new(0, 2, 0);
                        end;
                    else
                        v29 = Vector3.new(0, 1.5, 0);
                    end;

                    lastSubjectPosition = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace((v28 and Vector3.new(0, 0, 0) or v29) + CurrentCamera.CameraOffset);
                end;
            end;
        elseif CurrentCamera:IsA("VehicleSeat") then
            lastSubjectPosition = CurrentCamera.CFrame.p + CurrentCamera.CFrame:vectorToWorldSpace(VRService.VREnabled and Vector3.new(0, 4, 0) or Vector3.new(0, 5, 0));
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

        p27.lastSubject = CurrentCamera;
        p27.lastSubjectPosition = lastSubjectPosition;

        return lastSubjectPosition;
    end;
end;

function u4.UpdateDefaultSubjectDistance(p30) -- Line: 464
    -- upvalues: LocalPlayer (copy)
    if p30.portraitMode then
        p30.defaultSubjectDistance = math.clamp(25, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        return;
    end;

    p30.defaultSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
end;

function u4.OnViewportSizeChanged(p31) -- Line: 472
    -- upvalues: UserInputService (copy)
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    p31.portraitMode = ViewportSize.X < ViewportSize.Y;
    p31.isSmallTouchScreen = UserInputService.TouchEnabled and (ViewportSize.Y < 500 and true or ViewportSize.X < 700);
    p31:UpdateDefaultSubjectDistance();
end;

function u4.OnCurrentCameraChanged(u32) -- Line: 482
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        if u32.viewportSizeChangedConn then
            u32.viewportSizeChangedConn:Disconnect();
            u32.viewportSizeChangedConn = nil;
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;

        if CurrentCamera then
            u32:OnViewportSizeChanged();
            u32.viewportSizeChangedConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 493
                -- upvalues: u32 (copy)
                u32:OnViewportSizeChanged();
            end);
        end;
    end;

    if u32.cameraSubjectChangedConn then
        u32.cameraSubjectChangedConn:Disconnect();
        u32.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u32.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 507
            -- upvalues: u32 (copy)
            u32:OnNewCameraSubject();
        end);
        u32:OnNewCameraSubject();
    end;
end;

function u4.OnDynamicThumbstickEnabled(p33) -- Line: 514
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        p33.isDynamicThumbstickEnabled = true;
    end;
end;

function u4.OnDynamicThumbstickDisabled(p34) -- Line: 520
    p34.isDynamicThumbstickEnabled = false;
end;

function u4.OnGameSettingsTouchMovementModeChanged(p35) -- Line: 524
    -- upvalues: LocalPlayer (copy), UserGameSettings (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.Default then
            p35:OnDynamicThumbstickEnabled();

            return;
        end;

        p35:OnDynamicThumbstickDisabled();
    end;
end;

function u4.OnDevTouchMovementModeChanged(p36) -- Line: 535
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        p36:OnDynamicThumbstickEnabled();

        return;
    end;

    p36:OnGameSettingsTouchMovementModeChanged();
end;

function u4.OnPlayerCameraPropertyChange(p37) -- Line: 543
    p37:SetCameraToSubjectDistance(p37.currentSubjectDistance);
end;

function u4.GetCameraHeight(p38) -- Line: 548
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p38.inFirstPerson) and 0 or 0.25881904510252074 * p38.currentSubjectDistance;
end;

function u4.InputTranslationToCameraAngleChange(p39, p40, p41) -- Line: 555
    return p40 * p41;
end;

function u4.GamepadZoomPress(p42) -- Line: 559
    local v43 = p42:GetCameraToSubjectDistance();

    if v43 > 15 then
        p42:SetCameraToSubjectDistance(10);

        return;
    end;

    if v43 > 5 then
        p42:SetCameraToSubjectDistance(0);

        return;
    end;

    p42:SetCameraToSubjectDistance(20);
end;

function u4.Enable(u44, p45) -- Line: 571
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if u44.enabled ~= p45 then
        u44.enabled = p45;

        if u44.enabled then
            CameraInput.setInputEnabled(true);
            u44.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- Line: 577
                -- upvalues: u44 (copy)
                u44:GamepadZoomPress();
            end);

            if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
                u44.currentSubjectDistance = 0.5;

                if not u44.inFirstPerson then
                    u44:EnterFirstPerson();
                end;
            end;
        else
            CameraInput.setInputEnabled(false);

            if u44.gamepadZoomPressConnection then
                u44.gamepadZoomPressConnection:Disconnect();
                u44.gamepadZoomPressConnection = nil;
            end;

            u44:Cleanup();
        end;
    end;
end;

function u4.GetEnabled(p46) -- Line: 600
    return p46.enabled;
end;

function u4.Cleanup(p47) -- Line: 604
    -- upvalues: UserInputService (copy)
    if p47.subjectStateChangedConn then
        p47.subjectStateChangedConn:Disconnect();
        p47.subjectStateChangedConn = nil;
    end;

    if p47.viewportSizeChangedConn then
        p47.viewportSizeChangedConn:Disconnect();
        p47.viewportSizeChangedConn = nil;
    end;

    p47.lastCameraTransform = nil;
    p47.lastSubjectCFrame = nil;

    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    end;
end;

function u4.UpdateMouseBehavior(p48) -- Line: 623
    -- upvalues: CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), UserGameSettings (copy), UserInputService (copy)
    if p48.isCameraToggle then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p48.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p48.inFirstPerson or p48.inMouseLockedMode then
        UserGameSettings.RotationType = Enum.RotationType.CameraRelative;
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;

        return;
    end;

    UserGameSettings.RotationType = Enum.RotationType.MovementRelative;
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u4.UpdateForDistancePropertyChange(p49) -- Line: 643
    p49:SetCameraToSubjectDistance(p49.currentSubjectDistance);
end;

function u4.SetCameraToSubjectDistance(p50, p51) -- Line: 649
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p50.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p50.currentSubjectDistance = 0.5;

        if not p50.inFirstPerson then
            p50:EnterFirstPerson();
        end;
    else
        local v52 = math.clamp(p51, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if v52 < 1 then
            p50.currentSubjectDistance = 0.5;

            if not p50.inFirstPerson then
                p50:EnterFirstPerson();
            end;
        else
            p50.currentSubjectDistance = v52;

            if p50.inFirstPerson then
                p50:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p50.currentSubjectDistance, (math.sign(p51 - currentSubjectDistance)));

    return p50.currentSubjectDistance;
end;

function u4.SetCameraType(p53, p54) -- Line: 683
    p53.cameraType = p54;
end;

function u4.GetCameraType(p55) -- Line: 688
    return p55.cameraType;
end;

function u4.SetCameraMovementMode(p56, p57) -- Line: 693
    p56.cameraMovementMode = p57;
end;

function u4.GetCameraMovementMode(p58) -- Line: 697
    return p58.cameraMovementMode;
end;

function u4.SetIsMouseLocked(p59, p60) -- Line: 701
    p59.inMouseLockedMode = p60;
end;

function u4.GetIsMouseLocked(p61) -- Line: 705
    return p61.inMouseLockedMode;
end;

function u4.SetMouseLockOffset(p62, p63) -- Line: 709
    p62.mouseLockOffset = p63;
end;

function u4.GetMouseLockOffset(p64) -- Line: 713
    return p64.mouseLockOffset;
end;

function u4.InFirstPerson(p65) -- Line: 717
    return p65.inFirstPerson;
end;

function u4.EnterFirstPerson(p66) -- Line: 721
end;

function u4.LeaveFirstPerson(p67) -- Line: 725
end;

function u4.GetCameraToSubjectDistance(p68) -- Line: 730
    return p68.currentSubjectDistance;
end;

function u4.GetMeasuredDistanceToFocus(p69) -- Line: 737
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude;
    end;

    return nil;
end;

function u4.GetCameraLookVector(p70) -- Line: 745
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.lookVector or Vector3.new(0, 0, 1);
end;

function u4.CalculateNewLookCFrameFromArg(p71, p72, p73) -- Line: 749
    local v74 = p72 or p71:GetCameraLookVector();
    local v75 = math.asin(v74.y);
    local v76 = math.clamp(p73.y, v75 + -1.3962634015954636, v75 + 1.3962634015954636);
    local v77 = Vector2.new(p73.x, v76);
    local v78 = CFrame.new(Vector3.new(0, 0, 0), v74);

    return CFrame.Angles(0, -v77.x, 0) * v78 * CFrame.Angles(-v77.y, 0, 0);
end;

function u4.CalculateNewLookVectorFromArg(p79, p80, p81) -- Line: 759
    return p79:CalculateNewLookCFrameFromArg(p80, p81).lookVector;
end;

function u4.CalculateNewLookVectorVRFromArg(p82, p83) -- Line: 764
    local unit = ((p82:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local v84 = Vector2.new(p83.x, 0);
    local v85 = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -v84.x, 0) * v85 * CFrame.Angles(-v84.y, 0, 0)).lookVector * Vector3.new(1, 0, 1)).unit;
end;

function u4.GetHumanoid(p86) -- Line: 774
    -- upvalues: LocalPlayer (copy)
    local v87 = LocalPlayer and LocalPlayer.Character;

    if not v87 then
        return nil;
    end;

    local v88 = p86.humanoidCache[LocalPlayer];

    if v88 and v88.Parent == v87 then
        return v88;
    end;

    p86.humanoidCache[LocalPlayer] = nil;
    local v89 = v87:FindFirstChildOfClass("Humanoid");

    if v89 then
        p86.humanoidCache[LocalPlayer] = v89;
    end;

    return v89;
end;

function u4.GetHumanoidPartToFollow(p90, p91, p92) -- Line: 792
    if p92 ~= Enum.HumanoidStateType.Dead then
        return p91.Torso;
    end;

    local Parent = p91.Parent;

    if Parent then
        return Parent:FindFirstChild("Head") or p91.Torso;
    end;

    return p91.Torso;
end;

function u4.ApplyVRTransform(p93) -- Line: 807
    -- upvalues: VRService (copy)
    if not VRService.VREnabled then
        return;
    end;

    local v94 = p93.humanoidRootPart and p93.humanoidRootPart:FindFirstChild("RootJoint");

    if not v94 then
        return;
    end;

    local CameraSubject = game.Workspace.CurrentCamera.CameraSubject;

    if CameraSubject then
        CameraSubject = CameraSubject:IsA("VehicleSeat");
    end;

    if not p93.inFirstPerson or CameraSubject then
        v94.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);

        return;
    end;

    local v95 = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    v94.C0 = CFrame.new((v95 - v95.p):vectorToObjectSpace(v95.p)) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, 0);
end;

function u4.IsInFirstPerson(p96) -- Line: 830
    return p96.inFirstPerson;
end;

function u4.ShouldUseVRRotation(p97) -- Line: 834
    -- upvalues: VRService (copy), StarterGui (copy)
    if not VRService.VREnabled then
        return false;
    end;

    if not p97.VRRotationIntensityAvailable and tick() - p97.lastVRRotationIntensityCheckTime < 1 then
        return false;
    end;

    local success, result = pcall(function() -- Line: 843
        -- upvalues: StarterGui (ref)
        return StarterGui:GetCore("VRRotationIntensity");
    end);
    local v98;

    if success then
        v98 = result ~= nil;
    else
        v98 = success;
    end;

    p97.VRRotationIntensityAvailable = v98;
    p97.lastVRRotationIntensityCheckTime = tick();

    if success then
        if result == nil then
            success = false;
        else
            success = result ~= "Smooth";
        end;
    end;

    p97.shouldUseVRRotation = success;

    return p97.shouldUseVRRotation;
end;

function u4.GetVRRotationInput(p99) -- Line: 852
    -- upvalues: u3 (copy), StarterGui (copy)
    local v100 = u3;
    local success, result = pcall(function() -- Line: 854
        -- upvalues: StarterGui (ref)
        return StarterGui:GetCore("VRRotationIntensity");
    end);

    if success then
        local v101 = u3;
        local v102 = tick() - p99.lastVRRotationTime >= p99:GetRepeatDelayValue(result);

        if math.abs(v101.x) >= p99:GetActivateValue() then
            if v102 or not p99.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] then
                local v103 = v101.x < 0 and -1 or 1;
                v100 = v100 + p99:GetRotateAmountValue(result) * v103;
                p99.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = true;
            end;
        elseif math.abs(v101.x) < p99:GetActivateValue() - 0.1 then
            p99.vrRotateKeyCooldown[Enum.KeyCode.Thumbstick2] = nil;
        end;

        p99.vrRotateKeyCooldown[Enum.KeyCode.Left] = nil;
        p99.vrRotateKeyCooldown[Enum.KeyCode.Right] = nil;

        if v100 ~= u3 then
            p99.lastVRRotationTime = tick();
        end;

        return v100;
    end;
end;

function u4.CancelCameraFreeze(p104, p105) -- Line: 886
    if not p105 then
        p104.cameraTranslationConstraints = Vector3.new(p104.cameraTranslationConstraints.x, 1, p104.cameraTranslationConstraints.z);
    end;

    if p104.cameraFrozen then
        p104.trackingHumanoid = nil;
        p104.cameraFrozen = false;
    end;
end;

function u4.StartCameraFreeze(p106, p107, p108) -- Line: 896
    if not p106.cameraFrozen then
        p106.humanoidJumpOrigin = p107;
        p106.trackingHumanoid = p108;
        p106.cameraTranslationConstraints = Vector3.new(p106.cameraTranslationConstraints.x, 0, p106.cameraTranslationConstraints.z);
        p106.cameraFrozen = true;
    end;
end;

function u4.OnNewCameraSubject(u109) -- Line: 905
    -- upvalues: VRService (copy)
    if u109.subjectStateChangedConn then
        u109.subjectStateChangedConn:Disconnect();
        u109.subjectStateChangedConn = nil;
    end;

    local u110 = workspace.CurrentCamera and workspace.CurrentCamera.CameraSubject;

    if u109.trackingHumanoid ~= u110 then
        u109:CancelCameraFreeze();
    end;

    if u110 and u110:IsA("Humanoid") then
        u109.subjectStateChangedConn = u110.StateChanged:Connect(function(p111, p112) -- Line: 916
            -- upvalues: VRService (ref), u109 (copy), u110 (copy)
            if VRService.VREnabled and (p112 == Enum.HumanoidStateType.Jumping and not u109.inFirstPerson) then
                u109:StartCameraFreeze(u109:GetSubjectPosition(), u110);

                return;
            end;

            if p112 ~= Enum.HumanoidStateType.Jumping and p112 ~= Enum.HumanoidStateType.Freefall then
                u109:CancelCameraFreeze(true);
            end;
        end);
    end;
end;

function u4.GetVRFocus(p113, p114, p115) -- Line: 926
    local v116 = p113.LastCameraFocus or p114;

    if not p113.cameraFrozen then
        local x = p113.cameraTranslationConstraints.x;
        local v117 = math.min(1, p113.cameraTranslationConstraints.y + 0.42 * p115);
        p113.cameraTranslationConstraints = Vector3.new(x, v117, p113.cameraTranslationConstraints.z);
    end;

    local v118;

    if p113.cameraFrozen and (p113.humanoidJumpOrigin and p113.humanoidJumpOrigin.y > v116.y) then
        local new = CFrame.new;
        local x = p114.x;
        local v119 = math.min(p113.humanoidJumpOrigin.y, v116.y + 5 * p115);
        v118 = new((Vector3.new(x, v119, p114.z)));
    else
        v118 = CFrame.new(Vector3.new(p114.x, v116.y, p114.z):lerp(p114, p113.cameraTranslationConstraints.y));
    end;

    if p113.cameraFrozen then
        if p113.inFirstPerson then
            p113:CancelCameraFreeze();
        end;

        if p113.humanoidJumpOrigin and p114.y < p113.humanoidJumpOrigin.y - 0.5 then
            p113:CancelCameraFreeze();
        end;
    end;

    return v118;
end;

function u4.GetRotateAmountValue(p120, p121) -- Line: 954
    -- upvalues: StarterGui (copy), u1 (copy), u2 (copy), u3 (copy)
    local v122 = p121 or StarterGui:GetCore("VRRotationIntensity");

    if v122 then
        if v122 == "Low" then
            return u1;
        end;

        if v122 == "High" then
            return u2;
        end;
    end;

    return u3;
end;

function u4.GetRepeatDelayValue(p123, p124) -- Line: 966
    -- upvalues: StarterGui (copy)
    local v125 = p124 or StarterGui:GetCore("VRRotationIntensity");

    if v125 then
        if v125 == "Low" then
            return 0.1;
        end;

        if v125 == "High" then
            return 0.4;
        end;
    end;

    return 0;
end;

function u4.Update(p126, p127) -- Line: 978
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

return u4;