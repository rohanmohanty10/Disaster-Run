 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local ZoomController = require(script.Parent:WaitForChild("ZoomController"));
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"));
local CameraInput = require(script.Parent:WaitForChild("CameraInput"));
local CameraUI = require(script.Parent:WaitForChild("CameraUI"));
local LocalPlayer = Players.LocalPlayer;
local success, result = pcall(function() -- Line: 25
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom");
end);
local u1 = success and result;
local UserFlag = FlagUtil.getUserFlag("UserFixCameraCameraCharacterUpdates");
Vector2.new(0, 0);
local u2 = {};
u2.__index = u2;

function u2.new() -- Line: 81
    -- upvalues: u2 (copy), ConnectionUtil (copy), LocalPlayer (copy), UserFlag (copy), UserGameSettings (copy)
    local v3 = setmetatable({}, u2);
    v3._connections = ConnectionUtil.new();
    v3.gamepadZoomLevels = { 0, 10, 20 };
    v3.FIRST_PERSON_DISTANCE_THRESHOLD = 1;
    v3.cameraType = nil;
    v3.cameraMovementMode = nil;
    v3.lastCameraTransform = nil;
    v3.lastUserPanCamera = tick();
    v3.humanoidRootPart = nil;
    v3.humanoidCache = {};
    v3.lastSubject = nil;
    v3.lastSubjectPosition = Vector3.new(0, 5, 0);
    v3.lastSubjectCFrame = CFrame.new(v3.lastSubjectPosition);
    v3.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);
    v3.inFirstPerson = false;
    v3.inMouseLockedMode = false;
    v3.portraitMode = false;
    v3.isSmallTouchScreen = false;
    v3.resetCameraAngle = true;
    v3.enabled = false;

    if not UserFlag then
        v3.PlayerGui = nil;
    end;

    v3.cameraChangedConn = nil;
    v3.viewportSizeChangedConn = nil;
    v3.shouldUseVRRotation = false;
    v3.VRRotationIntensityAvailable = false;
    v3.lastVRRotationIntensityCheckTime = 0;
    v3.lastVRRotationTime = 0;
    v3.vrRotateKeyCooldown = {};
    v3.cameraTranslationConstraints = Vector3.new(1, 1, 1);
    v3.humanoidJumpOrigin = nil;
    v3.trackingHumanoid = nil;
    v3.cameraFrozen = false;
    v3.subjectStateChangedConn = nil;
    v3.gamepadZoomPressConnection = nil;
    v3.mouseLockOffset = Vector3.new(0, 0, 0);
    UserGameSettings:SetCameraYInvertVisible();
    UserGameSettings:SetGamepadCameraSensitivityVisible();

    return v3;
end;

function u2.GetModuleName(p4) -- Line: 150
    return "BaseCamera";
end;

function u2._setUpConfigurations(u5) -- Line: 154
    -- upvalues: LocalPlayer (copy), UserFlag (copy)
    u5._connections:trackConnection("CHARACTER_ADDED", LocalPlayer.CharacterAdded:Connect(function(p6) -- Line: 155
        -- upvalues: u5 (copy)
        u5:OnCharacterAdded(p6);
    end));

    if UserFlag then
        u5.humanoidRootPart = nil;
    elseif LocalPlayer.Character then
        u5:OnCharacterAdded(LocalPlayer.Character);
    end;

    u5._connections:trackConnection("CAMERA_MODE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- Line: 166
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5._connections:trackConnection("CAMERA_MIN_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- Line: 169
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5._connections:trackConnection("CAMERA_MAX_DISTANCE_CHANGED", LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- Line: 172
        -- upvalues: u5 (copy)
        u5:OnPlayerCameraPropertyChange();
    end));
    u5:OnPlayerCameraPropertyChange();
end;

function u2.OnCharacterAdded(u7, p8) -- Line: 178
    -- upvalues: UserFlag (copy), UserInputService (copy), LocalPlayer (copy)
    u7.resetCameraAngle = u7.resetCameraAngle or u7:GetEnabled();
    u7.humanoidRootPart = nil;

    if not UserFlag and UserInputService.TouchEnabled then
        u7.PlayerGui = LocalPlayer:WaitForChild("PlayerGui");

        for _, child in ipairs(p8:GetChildren()) do
            if child:IsA("Tool") then
                u7.isAToolEquipped = true;
            end;
        end;

        p8.ChildAdded:Connect(function(p9) -- Line: 191
            -- upvalues: u7 (copy)
            if p9:IsA("Tool") then
                u7.isAToolEquipped = true;
            end;
        end);
        p8.ChildRemoved:Connect(function(p10) -- Line: 196
            -- upvalues: u7 (copy)
            if p10:IsA("Tool") then
                u7.isAToolEquipped = false;
            end;
        end);
    end;
end;

function u2.GetHumanoidRootPart(p11) -- Line: 205
    -- upvalues: LocalPlayer (copy)
    local v12 = (not p11.humanoidRootPart and LocalPlayer.Character and true or false) and LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v12 then
        p11.humanoidRootPart = v12.RootPart;
    end;

    return p11.humanoidRootPart;
end;

function u2.GetBodyPartToFollow(p13: table, p14: userdata, p15: boolean) -- Line: 217
    if p14:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p14.Parent;

        if Parent and Parent:IsA("Model") then
            return Parent:FindFirstChild("Head") or p14.RootPart;
        end;
    end;

    return p14.RootPart;
end;

function u2.GetSubjectCFrame(p16) -- Line: 229
    local lastSubjectCFrame = p16.lastSubjectCFrame;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        workspace_CurrentCamera = workspace_CurrentCamera.CameraSubject;
    end;

    if not workspace_CurrentCamera then
        return lastSubjectCFrame;
    end;

    if workspace_CurrentCamera:IsA("Humanoid") then
        local v17 = workspace_CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = workspace_CurrentCamera.CameraOffset;

        if p16:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = workspace_CurrentCamera.RootPart;

        if v17 and (workspace_CurrentCamera.Parent and workspace_CurrentCamera.Parent:IsA("Model")) then
            RootPart = workspace_CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v18;

            if workspace_CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if workspace_CurrentCamera.AutomaticScalingEnabled then
                    v18 = Vector3.new(0, 1.5, 0);
                    local RootPart2 = workspace_CurrentCamera.RootPart;

                    if RootPart == RootPart2 then
                        v18 = v18 + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0);
                    end;
                else
                    v18 = Vector3.new(0, 2, 0);
                end;
            else
                v18 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectCFrame = RootPart.CFrame * CFrame.new((v17 and Vector3.new(0, 0, 0) or v18) + CameraOffset);
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
        p16.lastSubjectCFrame = lastSubjectCFrame;
    end;

    return lastSubjectCFrame;
end;

function u2.GetSubjectVelocity(p19) -- Line: 303
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
        local v20 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v20 then
            return v20.Velocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.GetSubjectRotVelocity(p21) -- Line: 332
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
        local v22 = workspace_CurrentCamera:IsA("Model") and workspace_CurrentCamera.PrimaryPart;

        if v22 then
            return v22.RotVelocity;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u2.StepZoom(p23) -- Line: 361
    -- upvalues: CameraInput (copy), ZoomController (copy)
    local currentSubjectDistance = p23.currentSubjectDistance;
    local ZoomDelta = CameraInput.getZoomDelta();

    if math.abs(ZoomDelta) > 0 then
        local v24;

        if ZoomDelta > 0 then
            v24 = math.max(currentSubjectDistance + ZoomDelta * (currentSubjectDistance * 0.5 + 1), p23.FIRST_PERSON_DISTANCE_THRESHOLD);
        else
            v24 = math.max((currentSubjectDistance + ZoomDelta) / (1 - ZoomDelta * 0.5), 0.5);
        end;

        p23:SetCameraToSubjectDistance(v24 < p23.FIRST_PERSON_DISTANCE_THRESHOLD and 0.5 or v24);
    end;

    return ZoomController.GetZoomRadius();
end;

function u2.GetSubjectPosition(p25) -- Line: 386
    local lastSubjectPosition = p25.lastSubjectPosition;
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        CurrentCamera = CurrentCamera.CameraSubject;
    end;

    if not CurrentCamera then
        return nil;
    end;

    if CurrentCamera:IsA("Humanoid") then
        local v26 = CurrentCamera:GetState() == Enum.HumanoidStateType.Dead;
        local CameraOffset = CurrentCamera.CameraOffset;

        if p25:GetIsMouseLocked() then
            CameraOffset = Vector3.new();
        end;

        local RootPart = CurrentCamera.RootPart;

        if v26 and (CurrentCamera.Parent and CurrentCamera.Parent:IsA("Model")) then
            RootPart = CurrentCamera.Parent:FindFirstChild("Head") or RootPart;
        end;

        if RootPart and RootPart:IsA("BasePart") then
            local v27;

            if CurrentCamera.RigType == Enum.HumanoidRigType.R15 then
                if CurrentCamera.AutomaticScalingEnabled then
                    v27 = Vector3.new(0, 1.5, 0);

                    if RootPart == CurrentCamera.RootPart then
                        v27 = v27 + Vector3.new(0, CurrentCamera.RootPart.Size.Y / 2 - 1, 0);
                    end;
                else
                    v27 = Vector3.new(0, 2, 0);
                end;
            else
                v27 = Vector3.new(0, 1.5, 0);
            end;

            lastSubjectPosition = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace((v26 and Vector3.new(0, 0, 0) or v27) + CameraOffset);
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

    p25.lastSubject = CurrentCamera;
    p25.lastSubjectPosition = lastSubjectPosition;

    return lastSubjectPosition;
end;

function u2.OnViewportSizeChanged(p28) -- Line: 463
    -- upvalues: UserInputService (copy)
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize;
    p28.portraitMode = ViewportSize.X < ViewportSize.Y;
    p28.isSmallTouchScreen = UserInputService.TouchEnabled and (ViewportSize.Y < 500 and true or ViewportSize.X < 700);
end;

function u2.OnCurrentCameraChanged(u29) -- Line: 471
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        if u29.viewportSizeChangedConn then
            u29.viewportSizeChangedConn:Disconnect();
            u29.viewportSizeChangedConn = nil;
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;

        if CurrentCamera then
            u29:OnViewportSizeChanged();
            u29.viewportSizeChangedConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 482
                -- upvalues: u29 (copy)
                u29:OnViewportSizeChanged();
            end);
        end;
    end;

    if u29.cameraSubjectChangedConn then
        u29.cameraSubjectChangedConn:Disconnect();
        u29.cameraSubjectChangedConn = nil;
    end;

    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        u29.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 496
            -- upvalues: u29 (copy)
            u29:OnNewCameraSubject();
        end);
        u29:OnNewCameraSubject();
    end;
end;

function u2.OnPlayerCameraPropertyChange(p30) -- Line: 503
    p30:SetCameraToSubjectDistance(p30.currentSubjectDistance);
end;

function u2.InputTranslationToCameraAngleChange(p31, p32, p33) -- Line: 508
    return p32 * p33;
end;

function u2.GamepadZoomPress(p34) -- Line: 514
    -- upvalues: LocalPlayer (copy), u1 (ref)
    local CameraToSubjectDistance = p34:GetCameraToSubjectDistance();
    local CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance;

    for i = #p34.gamepadZoomLevels, 1, -1 do
        local v35 = p34.gamepadZoomLevels[i];
        local v36;

        if CameraMaxZoomDistance < v35 then
            v36 = i;
        else
            if v35 < LocalPlayer.CameraMinZoomDistance then
                v35 = LocalPlayer.CameraMinZoomDistance;

                if u1 and CameraMaxZoomDistance == v35 then
                    break;
                end;
            end;

            if not u1 and CameraMaxZoomDistance == v35 then
                break;
            end;

            if v35 + (CameraMaxZoomDistance - v35) / 2 < CameraToSubjectDistance then
                p34:SetCameraToSubjectDistance(v35);

                return;
            end;

            CameraMaxZoomDistance = v35;
            v36 = i;
        end;
    end;

    p34:SetCameraToSubjectDistance(p34.gamepadZoomLevels[#p34.gamepadZoomLevels]);
end;

function u2.Enable(p37: table, p38: boolean) -- Line: 559
    if p37.enabled ~= p38 then
        p37.enabled = p38;
        p37:OnEnabledChanged();
    end;
end;

function u2.OnEnabledChanged(u39) -- Line: 567
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if not u39.enabled then
        u39._connections:disconnectAll();
        CameraInput.setInputEnabled(false);

        if u39.gamepadZoomPressConnection then
            u39.gamepadZoomPressConnection:Disconnect();
            u39.gamepadZoomPressConnection = nil;
        end;

        u39:Cleanup();

        return;
    end;

    u39:_setUpConfigurations();
    CameraInput.setInputEnabled(true);
    u39.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- Line: 573
        -- upvalues: u39 (copy)
        u39:GamepadZoomPress();
    end);

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        u39.currentSubjectDistance = 0.5;

        if not u39.inFirstPerson then
            u39:EnterFirstPerson();
        end;
    end;

    if u39.cameraChangedConn then
        u39.cameraChangedConn:Disconnect();
        u39.cameraChangedConn = nil;
    end;

    u39.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 585
        -- upvalues: u39 (copy)
        u39:OnCurrentCameraChanged();
    end);
    u39:OnCurrentCameraChanged();
end;

function u2.GetEnabled(p40) -- Line: 603
    return p40.enabled;
end;

function u2.Cleanup(p41) -- Line: 607
    -- upvalues: CameraUtils (copy)
    if p41.subjectStateChangedConn then
        p41.subjectStateChangedConn:Disconnect();
        p41.subjectStateChangedConn = nil;
    end;

    if p41.viewportSizeChangedConn then
        p41.viewportSizeChangedConn:Disconnect();
        p41.viewportSizeChangedConn = nil;
    end;

    if p41.cameraChangedConn then
        p41.cameraChangedConn:Disconnect();
        p41.cameraChangedConn = nil;
    end;

    p41.lastCameraTransform = nil;
    p41.lastSubjectCFrame = nil;
    CameraUtils.restoreMouseBehavior();
end;

function u2.UpdateMouseBehavior(p42) -- Line: 628
    -- upvalues: UserGameSettings (copy), CameraUI (copy), CameraInput (copy), CameraToggleStateController (copy), CameraUtils (copy)
    if p42.isCameraToggle and UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove == false then
        CameraUI.setCameraModeToastEnabled(true);
        CameraInput.enableCameraToggleInput();
        CameraToggleStateController(p42.inFirstPerson);

        return;
    end;

    CameraUI.setCameraModeToastEnabled(false);
    CameraInput.disableCameraToggleInput();

    if p42.inFirstPerson or p42.inMouseLockedMode then
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

function u2.UpdateForDistancePropertyChange(p43) -- Line: 656
    p43:SetCameraToSubjectDistance(p43.currentSubjectDistance);
end;

function u2.SetCameraToSubjectDistance(p44: table, p45: number) -- Line: 662
    -- upvalues: LocalPlayer (copy), ZoomController (copy)
    local currentSubjectDistance = p44.currentSubjectDistance;

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        p44.currentSubjectDistance = 0.5;

        if not p44.inFirstPerson then
            p44:EnterFirstPerson();
        end;
    else
        local math_clamp_ret = math.clamp(p45, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance);

        if math_clamp_ret < 1 then
            p44.currentSubjectDistance = 0.5;

            if not p44.inFirstPerson then
                p44:EnterFirstPerson();
            end;
        else
            p44.currentSubjectDistance = math_clamp_ret;

            if p44.inFirstPerson then
                p44:LeaveFirstPerson();
            end;
        end;
    end;

    ZoomController.SetZoomParameters(p44.currentSubjectDistance, (math.sign(p45 - currentSubjectDistance)));

    return p44.currentSubjectDistance;
end;

function u2.SetCameraType(p46, p47) -- Line: 696
    p46.cameraType = p47;
end;

function u2.GetCameraType(p48) -- Line: 701
    return p48.cameraType;
end;

function u2.SetCameraMovementMode(p49, p50) -- Line: 706
    p49.cameraMovementMode = p50;
end;

function u2.GetCameraMovementMode(p51) -- Line: 710
    return p51.cameraMovementMode;
end;

function u2.SetIsMouseLocked(p52: table, p53: boolean) -- Line: 714
    p52.inMouseLockedMode = p53;
end;

function u2.GetIsMouseLocked(p54) -- Line: 718
    return p54.inMouseLockedMode;
end;

function u2.SetMouseLockOffset(p55, p56) -- Line: 722
    p55.mouseLockOffset = p56;
end;

function u2.GetMouseLockOffset(p57) -- Line: 726
    return p57.mouseLockOffset;
end;

function u2.InFirstPerson(p58) -- Line: 730
    return p58.inFirstPerson;
end;

function u2.EnterFirstPerson(p59) -- Line: 734
    p59.inFirstPerson = true;
    p59:UpdateMouseBehavior();
end;

function u2.LeaveFirstPerson(p60) -- Line: 739
    p60.inFirstPerson = false;
    p60:UpdateMouseBehavior();
end;

function u2.GetCameraToSubjectDistance(p61) -- Line: 745
    return p61.currentSubjectDistance;
end;

function u2.GetMeasuredDistanceToFocus(p62) -- Line: 752
    local CurrentCamera = game.Workspace.CurrentCamera;

    if CurrentCamera then
        return (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude;
    end;

    return nil;
end;

function u2.GetCameraLookVector(p63) -- Line: 760
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1);
end;

function u2.CalculateNewLookCFrameFromArg(p64: table, p65: vector?, p66) -- Line: 764
    -- upvalues: ReplicatedStorage (copy)
    local v67 = workspace.CurrentCamera:GetAttribute("Spectate") and workspace.CurrentCamera.CameraSubject == ReplicatedStorage.Basketball.Value and -0.2617993877991494 or 1.3962634015954636;
    local v68 = p65 or p64:GetCameraLookVector();
    local math_clamp_ret = math.clamp(v68.Y, -1, 1);
    local math_asin_ret = math.asin(math_clamp_ret);
    local math_clamp_ret2 = math.clamp(p66.Y, -v67 + math_asin_ret, math_asin_ret + 1.3962634015954636);
    local Vector2_new_ret = Vector2.new(p66.X, math_clamp_ret2);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), v68);

    return CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0);
end;

function u2.CalculateNewLookVectorFromArg(p69: table, p70: vector?, p71) -- Line: 782
    return p69:CalculateNewLookCFrameFromArg(p70, p71).LookVector;
end;

function u2.CalculateNewLookVectorVRFromArg(p72: table, p73) -- Line: 787
    local unit = ((p72:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit;
    local Vector2_new_ret = Vector2.new(p73.X, 0);
    local CFrame_new_ret = CFrame.new(Vector3.new(0, 0, 0), unit);

    return ((CFrame.Angles(0, -Vector2_new_ret.X, 0) * CFrame_new_ret * CFrame.Angles(-Vector2_new_ret.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit;
end;

function u2.GetHumanoid(p74) -- Line: 797
    -- upvalues: LocalPlayer (copy)
    local v75 = LocalPlayer and LocalPlayer.Character;

    if not v75 then
        return nil;
    end;

    local v76 = p74.humanoidCache[LocalPlayer];

    if v76 and v76.Parent == v75 then
        return v76;
    end;

    p74.humanoidCache[LocalPlayer] = nil;
    local v77 = v75:FindFirstChildOfClass("Humanoid");

    if v77 then
        p74.humanoidCache[LocalPlayer] = v77;
    end;

    return v77;
end;

function u2.GetHumanoidPartToFollow(p78: table, p79: userdata, p80: any) -- Line: 815
    if p80 ~= Enum.HumanoidStateType.Dead then
        return p79.Torso;
    end;

    local Parent = p79.Parent;

    if Parent then
        return Parent:FindFirstChild("Head") or p79.Torso;
    end;

    return p79.Torso;
end;

function u2.OnNewCameraSubject(p81) -- Line: 829
    if p81.subjectStateChangedConn then
        p81.subjectStateChangedConn:Disconnect();
        p81.subjectStateChangedConn = nil;
    end;
end;

function u2.IsInFirstPerson(p82) -- Line: 836
    return p82.inFirstPerson;
end;

function u2.Update(p83, p84) -- Line: 840
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2);
end;

function u2.GetCameraHeight(p85) -- Line: 844
    -- upvalues: VRService (copy)
    return (not VRService.VREnabled or p85.inFirstPerson) and 0 or 0.25881904510252074 * p85.currentSubjectDistance;
end;

return u2;