 
 

local u1 = {};
u1.__index = u1;
local u2 = { "CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock" };
local u3 = { "ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode" };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = script.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraUtils = require(script:WaitForChild("CameraUtils"));
local CameraInput = require(script:WaitForChild("CameraInput"));
local ClassicCamera = require(script:WaitForChild("ClassicCamera"));
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"));
local LegacyCamera = require(script:WaitForChild("LegacyCamera"));
local VehicleCamera = require(script:WaitForChild("VehicleCamera"));
local VRCamera = require(script:WaitForChild("VRCamera"));
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"));
local Invisicam = require(script:WaitForChild("Invisicam"));
local Poppercam = require(script:WaitForChild("Poppercam"));
local TransparencyController = require(script:WaitForChild("TransparencyController"));
local MouseLockController = require(script:WaitForChild("MouseLockController"));
local u4 = {};
local u5 = {};
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts");
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local UserFlag = FlagUtil.getUserFlag("UserRespectLegacyCameraOptions");

function u1.new() -- Line: 99
    -- upvalues: u1 (copy), Players (copy), TransparencyController (copy), UserInputService (copy), MouseLockController (copy), UserFlag (copy), RunService (copy), u2 (copy), u3 (copy), UserGameSettings (copy)
    local u6 = setmetatable({}, u1);
    u6.activeCameraController = nil;
    u6.activeOcclusionModule = nil;
    u6.activeTransparencyController = nil;
    u6.activeMouseLockController = nil;
    u6.currentComputerCameraMovementMode = nil;
    u6.cameraSubjectChangedConn = nil;
    u6.cameraTypeChangedConn = nil;

    for _, v in pairs(Players:GetPlayers()) do
        u6:OnPlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(function(p7) -- Line: 120
        -- upvalues: u6 (copy)
        u6:OnPlayerAdded(p7);
    end);
    u6.activeTransparencyController = TransparencyController.new();
    u6.activeTransparencyController:Enable(true);

    if not UserInputService.TouchEnabled then
        u6.activeMouseLockController = MouseLockController.new();
        local BindableToggleEvent = u6.activeMouseLockController:GetBindableToggleEvent();

        if BindableToggleEvent then
            BindableToggleEvent:Connect(function() -- Line: 131
                -- upvalues: u6 (copy)
                u6:OnMouseLockToggled();
            end);
        end;
    end;

    if UserFlag then
        u6:ActivateCameraController();
    else
        u6:ActivateCameraController(u6:GetCameraControlChoice());
    end;

    u6:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);
    u6:OnCurrentCameraChanged();
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p8) -- Line: 144
        -- upvalues: u6 (copy)
        u6:Update(p8);
    end);

    for _, v in pairs(u2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v):Connect(function() -- Line: 148
            -- upvalues: u6 (copy), v (copy)
            u6:OnLocalPlayerCameraPropertyChanged(v);
        end);
    end;

    for _, v in pairs(u3) do
        UserGameSettings:GetPropertyChangedSignal(v):Connect(function() -- Line: 154
            -- upvalues: u6 (copy), v (copy)
            u6:OnUserGameSettingsPropertyChanged(v);
        end);
    end;

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 158
        -- upvalues: u6 (copy)
        u6:OnCurrentCameraChanged();
    end);

    return u6;
end;

function u1.GetCameraMovementModeFromSettings(p9) -- Line: 165
    -- upvalues: Players (copy), CameraUtils (copy), UserInputService (copy), UserGameSettings (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    end;

    local v10, v11;

    if UserInputService.TouchEnabled then
        v10 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode);
        v11 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
    else
        v10 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode);
        v11 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);
    end;

    if v10 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v11;
    end;

    return v10;
end;

function u1.ActivateOcclusionModule(p12, p13) -- Line: 190
    -- upvalues: Poppercam (copy), Invisicam (copy), u5 (copy), Players (copy)
    local v14;

    if p13 == Enum.DevCameraOcclusionMode.Zoom then
        v14 = Poppercam;
    else
        if p13 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");

            return;
        end;

        v14 = Invisicam;
    end;

    p12.occlusionMode = p13;

    if p12.activeOcclusionModule and p12.activeOcclusionModule:GetOcclusionMode() == p13 then
        if not p12.activeOcclusionModule:GetEnabled() then
            p12.activeOcclusionModule:Enable(true);
        end;

        return;
    end;

    local activeOcclusionModule = p12.activeOcclusionModule;
    p12.activeOcclusionModule = u5[v14];

    if not p12.activeOcclusionModule then
        p12.activeOcclusionModule = v14.new();

        if p12.activeOcclusionModule then
            u5[v14] = p12.activeOcclusionModule;
        end;
    end;

    if p12.activeOcclusionModule then
        if p12.activeOcclusionModule:GetOcclusionMode() ~= p13 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", p12.activeOcclusionModule:GetOcclusionMode(), "~=", p13);
        end;

        if activeOcclusionModule then
            if activeOcclusionModule == p12.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
            else
                activeOcclusionModule:Enable(false);
            end;
        end;

        if p13 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                p12.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer);
            end;
        else
            for _, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    p12.activeOcclusionModule:CharacterAdded(v.Character, v);
                end;
            end;

            p12.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
        end;

        p12.activeOcclusionModule:Enable(true);
    end;
end;

function u1.ShouldUseVehicleCamera(p15) -- Line: 269
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return false;
    end;

    local CameraType = workspace_CurrentCamera.CameraType;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local v16 = CameraType == Enum.CameraType.Custom and true or CameraType == Enum.CameraType.Follow;
    local v17 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false;
    local v18 = p15.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;

    if v17 then
        if not v16 then
            v18 = v16;
        end;
    else
        v18 = v17;
    end;

    return v18;
end;

function u1.ActivateCameraController(p19, p20, p21) -- Line: 285
    -- upvalues: UserFlag (copy), LegacyCamera (copy), VRService (copy), VRCamera (copy), ClassicCamera (copy), OrbitalCamera (copy), VRVehicleCamera (copy), VehicleCamera (copy), u4 (copy)
    if UserFlag then
        p21 = workspace.CurrentCamera.CameraType;
        p20 = p19:GetCameraMovementModeFromSettings();
    end;

    local v22 = nil;

    if UserFlag and true or p21 ~= nil then
        if p21 == Enum.CameraType.Scriptable then
            if p19.activeCameraController then
                p19.activeCameraController:Enable(false);
                p19.activeCameraController = nil;
            end;

            return;
        end;

        if p21 == Enum.CameraType.Custom then
            p20 = p19:GetCameraMovementModeFromSettings();
        elseif p21 == Enum.CameraType.Track then
            p20 = Enum.ComputerCameraMovementMode.Classic;
        elseif p21 == Enum.CameraType.Follow then
            p20 = Enum.ComputerCameraMovementMode.Follow;
        elseif p21 == Enum.CameraType.Orbital then
            p20 = Enum.ComputerCameraMovementMode.Orbital;
        elseif p21 == Enum.CameraType.Attach or (p21 == Enum.CameraType.Watch or p21 == Enum.CameraType.Fixed) then
            v22 = LegacyCamera;
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", p21);
        end;
    end;

    if not v22 then
        if VRService.VREnabled then
            v22 = VRCamera;
        elseif p20 == Enum.ComputerCameraMovementMode.Classic or (p20 == Enum.ComputerCameraMovementMode.Follow or (p20 == Enum.ComputerCameraMovementMode.Default or p20 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v22 = ClassicCamera;
        else
            if p20 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");

                return;
            end;

            v22 = OrbitalCamera;
        end;
    end;

    if p19:ShouldUseVehicleCamera() then
        if VRService.VREnabled then
            v22 = VRVehicleCamera;
        else
            v22 = VehicleCamera;
        end;
    end;

    local v23;

    if u4[v22] then
        v23 = u4[v22];

        if v23.Reset then
            v23:Reset();
        end;
    else
        v23 = v22.new();
        u4[v22] = v23;
    end;

    if p19.activeCameraController then
        if p19.activeCameraController == v23 then
            if not p19.activeCameraController:GetEnabled() then
                p19.activeCameraController:Enable(true);
            end;
        else
            p19.activeCameraController:Enable(false);
            p19.activeCameraController = v23;
            p19.activeCameraController:Enable(true);
        end;
    elseif v23 ~= nil then
        p19.activeCameraController = v23;
        p19.activeCameraController:Enable(true);
    end;

    if p19.activeCameraController then
        if UserFlag then
            p19.activeCameraController:SetCameraMovementMode(p20);
            p19.activeCameraController:SetCameraType(p21);

            return;
        end;

        if p20 ~= nil then
            p19.activeCameraController:SetCameraMovementMode(p20);

            return;
        end;

        if p21 ~= nil then
            p19.activeCameraController:SetCameraType(p21);
        end;
    end;
end;

function u1.OnCameraSubjectChanged(p24) -- Line: 397
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v25;

    if workspace_CurrentCamera then
        v25 = workspace_CurrentCamera.CameraSubject;
    else
        v25 = workspace_CurrentCamera;
    end;

    if p24.activeTransparencyController then
        p24.activeTransparencyController:SetSubject(v25);
    end;

    if p24.activeOcclusionModule then
        p24.activeOcclusionModule:OnCameraSubjectChanged(v25);
    end;

    p24:ActivateCameraController(nil, workspace_CurrentCamera.CameraType);
end;

function u1.OnCameraTypeChanged(p26, p27) -- Line: 412
    -- upvalues: UserInputService (copy), CameraUtils (copy)
    if p27 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior();
    end;

    p26:ActivateCameraController(nil, p27);
end;

function u1.OnCurrentCameraChanged(u28) -- Line: 424
    local CurrentCamera = game.Workspace.CurrentCamera;

    if not CurrentCamera then
        return;
    end;

    if u28.cameraSubjectChangedConn then
        u28.cameraSubjectChangedConn:Disconnect();
    end;

    if u28.cameraTypeChangedConn then
        u28.cameraTypeChangedConn:Disconnect();
    end;

    u28.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 436
        -- upvalues: u28 (copy), CurrentCamera (copy)
        u28:OnCameraSubjectChanged(CurrentCamera.CameraSubject);
    end);
    u28.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 440
        -- upvalues: u28 (copy), CurrentCamera (copy)
        u28:OnCameraTypeChanged(CurrentCamera.CameraType);
    end);
    u28:OnCameraSubjectChanged(CurrentCamera.CameraSubject);
    u28:OnCameraTypeChanged(CurrentCamera.CameraType);
end;

function u1.OnLocalPlayerCameraPropertyChanged(p29: table, p30: string) -- Line: 448
    -- upvalues: Players (copy), CameraUtils (copy)
    if p30 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.Classic then
                warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode);

                return;
            end;

            local CameraMovementModeFromSettings = p29:GetCameraMovementModeFromSettings();
            p29:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings));

            return;
        end;

        if not p29.activeCameraController or p29.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p29:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic));
        end;

        if p29.activeCameraController then
            p29.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p30 == "DevComputerCameraMode" or p30 == "DevTouchCameraMode" then
            local CameraMovementModeFromSettings = p29:GetCameraMovementModeFromSettings();
            p29:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings));

            return;
        end;

        if p30 == "DevCameraOcclusionMode" then
            p29:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);

            return;
        end;

        if p30 == "CameraMinZoomDistance" or p30 == "CameraMaxZoomDistance" then
            if p29.activeCameraController then
                p29.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p30 == "DevTouchMovementMode" then
                return;
            end;

            if p30 == "DevComputerMovementMode" then
                return;
            end;

            local _ = p30 == "DevEnableMouseLock";
        end;
    end;
end;

function u1.OnUserGameSettingsPropertyChanged(p31: table, p32: string) -- Line: 492
    -- upvalues: CameraUtils (copy)
    if p32 == "ComputerCameraMovementMode" then
        local CameraMovementModeFromSettings = p31:GetCameraMovementModeFromSettings();
        p31:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings));
    end;
end;

function u1.Update(p33, p34) -- Line: 505
    -- upvalues: CameraInput (copy)
    if p33.activeCameraController then
        p33.activeCameraController:UpdateMouseBehavior();
        local v35, v36 = p33.activeCameraController:Update(p34);

        if p33.activeOcclusionModule then
            v35, v36 = p33.activeOcclusionModule:Update(p34, v35, v36);
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;
        CurrentCamera.CFrame = v35;
        CurrentCamera.Focus = v36;

        if p33.activeTransparencyController then
            p33.activeTransparencyController:Update(p34);
        end;

        if CameraInput.getInputEnabled() then
            CameraInput.resetInputForFrameEnd();
        end;
    end;
end;

if not UserFlag then
    function u1.GetCameraControlChoice(p37) -- Line: 534
        -- upvalues: Players (copy), UserInputService (copy), CameraUtils (copy), UserGameSettings (copy)
        local LocalPlayer = Players.LocalPlayer;

        if LocalPlayer then
            if UserInputService:GetLastInputType() == Enum.UserInputType.Touch or UserInputService.TouchEnabled then
                if LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
                    return CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
                end;

                return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevTouchCameraMode);
            end;

            if LocalPlayer.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
                return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevComputerCameraMode);
            end;

            local v38 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);

            return CameraUtils.ConvertCameraModeEnumToStandard(v38);
        end;
    end;
end;

function u1.OnCharacterAdded(p39, p40, p41) -- Line: 558
    if p39.activeOcclusionModule then
        p39.activeOcclusionModule:CharacterAdded(p40, p41);
    end;
end;

function u1.OnCharacterRemoving(p42, p43, p44) -- Line: 564
    if p42.activeOcclusionModule then
        p42.activeOcclusionModule:CharacterRemoving(p43, p44);
    end;
end;

function u1.OnPlayerAdded(u45, u46) -- Line: 570
    u46.CharacterAdded:Connect(function(p47) -- Line: 571
        -- upvalues: u45 (copy), u46 (copy)
        u45:OnCharacterAdded(p47, u46);
    end);
    u46.CharacterRemoving:Connect(function(p48) -- Line: 574
        -- upvalues: u45 (copy), u46 (copy)
        u45:OnCharacterRemoving(p48, u46);
    end);
end;

function u1.OnMouseLockToggled(p49) -- Line: 579
    if p49.activeMouseLockController then
        local IsMouseLocked = p49.activeMouseLockController:GetIsMouseLocked();
        local MouseLockOffset = p49.activeMouseLockController:GetMouseLockOffset();

        if p49.activeCameraController then
            p49.activeCameraController:SetIsMouseLocked(IsMouseLocked);
            p49.activeCameraController:SetMouseLockOffset(MouseLockOffset);
        end;
    end;
end;

u1.new();

return {};