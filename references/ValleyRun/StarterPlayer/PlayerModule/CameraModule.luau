 

 

local u1 = {};
u1.__index = u1;
local u2 = { "CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock" };
local u3 = { "ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode" };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local VRService = game:GetService("VRService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"));
local u4 = CommonUtils.get("ConnectionUtil");
local v5 = CommonUtils.get("FlagUtil");
local CameraUtils = require(script:WaitForChild("CameraUtils"));
require(script:WaitForChild("CameraInput"));
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
local u6 = {};
local u7 = {};

if not Players.LocalPlayer then
    return {};
end;

assert(Players.LocalPlayer, "Strict typing check");
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts");
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow);
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic);
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle);
local UserFlag = v5.getUserFlag("UserPlayerConnectionMemoryLeak");
local UserFlag2 = v5.getUserFlag("UserPSFixCameraControllerReset");
local UserFlag3 = v5.getUserFlag("UserVRFixCameraCloseArticulation");
local u8 = FFlagUserOrthographicOcclusion and pcall(function() -- Line: 107
    return Instance.new("Camera").ProjectionType;
end);
local u9 = CommonUtils.get("VRFirstPersonState");

function u1.new() -- Line: 151
    -- upvalues: TransparencyController (copy), UserFlag (copy), u4 (copy), u1 (copy), Players (copy), MouseLockController (copy), u2 (copy), u3 (copy), UserGameSettings (copy), UserInputService (copy)
    local v10 = {
        activeTransparencyController = TransparencyController.new()
    };
    local v11;

    if UserFlag then
        v11 = u4.new();
    else
        v11 = nil;
    end;

    v10.connectionUtil = v11;
    local u12 = setmetatable(v10, u1);
    u12.activeCameraController = nil;
    u12.activeOcclusionModule = nil;
    u12.activeMouseLockController = nil;
    u12.currentComputerCameraMovementMode = nil;
    u12.cameraSubjectChangedConn = nil;
    u12.cameraTypeChangedConn = nil;

    for _, v in pairs(Players:GetPlayers()) do
        u12:OnPlayerAdded(v);
    end;

    Players.PlayerAdded:Connect(function(p13) -- Line: 174
        -- upvalues: u12 (copy)
        u12:OnPlayerAdded(p13);
    end);

    if UserFlag then
        Players.PlayerRemoving:Connect(function(p14) -- Line: 179
            -- upvalues: u12 (copy)
            u12:OnPlayerRemoving(p14);
        end);
    end;

    u12.activeTransparencyController:Enable(true);
    u12.activeMouseLockController = MouseLockController.new();
    assert(u12.activeMouseLockController, "Strict typing check");
    local BindableToggleEvent = u12.activeMouseLockController:GetBindableToggleEvent();

    if BindableToggleEvent then
        BindableToggleEvent:Connect(function() -- Line: 191
            -- upvalues: u12 (copy)
            u12:OnMouseLockToggled();
        end);
    end;

    u12:ActivateCameraController();
    u12:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);
    u12:OnCurrentCameraChanged();

    for _, v in pairs(u2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v):Connect(function() -- Line: 201
            -- upvalues: u12 (copy), v (copy)
            u12:OnLocalPlayerCameraPropertyChanged(v);
        end);
    end;

    for _, v in pairs(u3) do
        UserGameSettings:GetPropertyChangedSignal(v):Connect(function() -- Line: 207
            -- upvalues: u12 (copy), v (copy)
            u12:OnUserGameSettingsPropertyChanged(v);
        end);
    end;

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 211
        -- upvalues: u12 (copy)
        u12:OnCurrentCameraChanged();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 214
        -- upvalues: u12 (copy)
        u12:OnPreferredInputChanged();
    end);

    return u12;
end;

function u1.GetCameraMovementModeFromSettings(p15) -- Line: 221
    -- upvalues: Players (copy), CameraUtils (copy), UserInputService (copy), UserGameSettings (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    end;

    local v16, v17;

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        v16 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode);
        v17 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
    else
        v16 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode);
        v17 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);
    end;

    if v16 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v17;
    end;

    return v16;
end;

function u1.ActivateOcclusionModule(p18, p19) -- Line: 246
    -- upvalues: Poppercam (copy), Invisicam (copy), u7 (copy), Players (copy)
    local v20;

    if p19 == Enum.DevCameraOcclusionMode.Zoom then
        v20 = Poppercam;
    else
        if p19 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");

            return;
        end;

        v20 = Invisicam;
    end;

    p18.occlusionMode = p19;

    if p18.activeOcclusionModule and p18.activeOcclusionModule:GetOcclusionMode() == p19 then
        if not p18.activeOcclusionModule:GetEnabled() then
            p18.activeOcclusionModule:Enable(true);
        end;

        return;
    end;

    local activeOcclusionModule = p18.activeOcclusionModule;
    p18.activeOcclusionModule = u7[v20];

    if not p18.activeOcclusionModule then
        p18.activeOcclusionModule = v20.new();

        if p18.activeOcclusionModule then
            u7[v20] = p18.activeOcclusionModule;
        end;
    end;

    if p18.activeOcclusionModule then
        if p18.activeOcclusionModule:GetOcclusionMode() ~= p19 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", p18.activeOcclusionModule:GetOcclusionMode(), "~=", p19);
        end;

        if activeOcclusionModule then
            if activeOcclusionModule == p18.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
            else
                activeOcclusionModule:Enable(false);
            end;
        end;

        if p19 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                p18.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer);
            end;
        else
            for _, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    p18.activeOcclusionModule:CharacterAdded(v.Character, v);
                end;
            end;

            p18.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
        end;

        p18.activeOcclusionModule:Enable(true);
    end;
end;

function u1.ShouldUseVehicleCamera(p21) -- Line: 325
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return false;
    end;

    local CameraType = workspace_CurrentCamera.CameraType;
    local CameraSubject = workspace_CurrentCamera.CameraSubject;
    local v22 = CameraType == Enum.CameraType.Custom and true or CameraType == Enum.CameraType.Follow;
    local v23 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false;
    local v24 = p21.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;

    if v23 then
        if not v22 then
            v24 = v22;
        end;
    else
        v24 = v23;
    end;

    return v24;
end;

function u1.ActivateCameraController(p25) -- Line: 341
    -- upvalues: LegacyCamera (copy), VRService (copy), VRCamera (copy), ClassicCamera (copy), OrbitalCamera (copy), VRVehicleCamera (copy), VehicleCamera (copy), u6 (copy), UserFlag2 (copy)
    local CameraType = workspace.CurrentCamera.CameraType;
    local CameraMovementModeFromSettings = p25:GetCameraMovementModeFromSettings();
    local v26 = nil;

    if CameraType == Enum.CameraType.Scriptable then
        if p25.activeCameraController then
            p25.activeCameraController:Enable(false);
            p25.activeCameraController = nil;
        end;

        return;
    end;

    if CameraType == Enum.CameraType.Custom then
        CameraMovementModeFromSettings = p25:GetCameraMovementModeFromSettings();
    elseif CameraType == Enum.CameraType.Track then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Classic;
    elseif CameraType == Enum.CameraType.Follow then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Follow;
    elseif CameraType == Enum.CameraType.Orbital then
        CameraMovementModeFromSettings = Enum.ComputerCameraMovementMode.Orbital;
    elseif CameraType == Enum.CameraType.Attach or (CameraType == Enum.CameraType.Watch or CameraType == Enum.CameraType.Fixed) then
        v26 = LegacyCamera;
    else
        warn("CameraScript encountered an unhandled Camera.CameraType value: ", CameraType);
    end;

    if not v26 then
        if VRService.VREnabled then
            v26 = VRCamera;
        elseif CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Classic or (CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Follow or (CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.Default or CameraMovementModeFromSettings == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v26 = ClassicCamera;
        else
            if CameraMovementModeFromSettings ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");

                return;
            end;

            v26 = OrbitalCamera;
        end;
    end;

    if p25:ShouldUseVehicleCamera() then
        if VRService.VREnabled then
            v26 = VRVehicleCamera;
        else
            v26 = VehicleCamera;
        end;
    end;

    local v27;

    if u6[v26] then
        v27 = u6[v26];

        if UserFlag2 then
            if v27.Reset and p25.activeCameraController ~= v27 then
                v27:Reset();
            end;
        elseif v27.Reset then
            v27:Reset();
        end;
    else
        v27 = v26.new();
        u6[v26] = v27;
    end;

    if p25.activeCameraController then
        if p25.activeCameraController == v27 then
            if not p25.activeCameraController:GetEnabled() then
                p25.activeCameraController:Enable(true);
            end;
        else
            if v27.HandleSubjectDistance then
                v27:HandleSubjectDistance(p25.activeCameraController);
            end;

            p25.activeCameraController:Enable(false);
            p25.activeCameraController = v27;
            p25.activeCameraController:Enable(true);
        end;
    elseif v27 ~= nil then
        p25.activeCameraController = v27;
        assert(p25.activeCameraController, "Strict typing check");
        p25.activeCameraController:Enable(true);
    end;

    if p25.activeCameraController then
        p25.activeCameraController:SetCameraMovementMode(CameraMovementModeFromSettings);
        p25.activeCameraController:SetCameraType(CameraType);
    end;
end;

function u1.OnCameraSubjectChanged(p28) -- Line: 450
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v29;

    if workspace_CurrentCamera then
        v29 = workspace_CurrentCamera.CameraSubject;
    else
        v29 = nil;
    end;

    if p28.activeTransparencyController then
        p28.activeTransparencyController:SetSubject(v29);
    end;

    if p28.activeOcclusionModule then
        p28.activeOcclusionModule:OnCameraSubjectChanged(v29);
    end;

    p28:ActivateCameraController();
end;

function u1.OnCameraTypeChanged(p30, p31) -- Line: 465
    -- upvalues: UserInputService (copy), CameraUtils (copy)
    if p31 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior();
    end;

    p30:ActivateCameraController();
end;

function u1.OnCurrentCameraChanged(u32) -- Line: 477
    local CurrentCamera = game.Workspace.CurrentCamera;

    if not CurrentCamera then
        return;
    end;

    if u32.cameraSubjectChangedConn then
        u32.cameraSubjectChangedConn:Disconnect();
    end;

    if u32.cameraTypeChangedConn then
        u32.cameraTypeChangedConn:Disconnect();
    end;

    u32.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 489
        -- upvalues: u32 (copy)
        u32:OnCameraSubjectChanged();
    end);
    u32.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 493
        -- upvalues: u32 (copy), CurrentCamera (copy)
        u32:OnCameraTypeChanged(CurrentCamera.CameraType);
    end);
    u32:OnCameraSubjectChanged();
    u32:OnCameraTypeChanged(CurrentCamera.CameraType);
end;

function u1.OnLocalPlayerCameraPropertyChanged(p33: table, p34: string) -- Line: 501
    -- upvalues: Players (copy)
    if p34 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                p33:ActivateCameraController();

                return;
            end;

            warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode);

            return;
        end;

        if not p33.activeCameraController or p33.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p33:ActivateCameraController();
        end;

        if p33.activeCameraController then
            p33.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p34 == "DevComputerCameraMode" or p34 == "DevTouchCameraMode" then
            p33:ActivateCameraController();

            return;
        end;

        if p34 == "DevCameraOcclusionMode" then
            p33:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);

            return;
        end;

        if p34 == "CameraMinZoomDistance" or p34 == "CameraMaxZoomDistance" then
            if p33.activeCameraController then
                p33.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p34 == "DevTouchMovementMode" then
                return;
            end;

            if p34 == "DevComputerMovementMode" then
                return;
            end;

            local _ = p34 == "DevEnableMouseLock";
        end;
    end;
end;

function u1.OnUserGameSettingsPropertyChanged(p35: table, p36: string) -- Line: 543
    if p36 == "ComputerCameraMovementMode" then
        p35:ActivateCameraController();
    end;
end;

function u1.OnPreferredInputChanged(p37) -- Line: 549
    p37:ActivateCameraController();
end;

function u1.Update(p38, p39, p40) -- Line: 559
    -- upvalues: UserFlag3 (copy), VRService (copy), u9 (copy), u8 (copy)
    if p38.activeCameraController then
        p38.activeCameraController:UpdateMouseBehavior();
        local v41, v42 = p38.activeCameraController:Update(p40);

        if UserFlag3 and (VRService.VREnabled and p38.activeCameraController.IsInFirstPerson) then
            u9.inFirstPerson = p38.activeCameraController:IsInFirstPerson();
        end;

        local CurrentCamera = game.Workspace.CurrentCamera;

        if u8 then
            if p38.activeOcclusionModule and (not p38.activeCameraController.skipOcclusion and CurrentCamera.ProjectionType ~= Enum.ProjectionType.Orthographic) then
                v41, v42 = p38.activeOcclusionModule:Update(p40, v41, v42);
            end;
        elseif p38.activeOcclusionModule and not p38.activeCameraController.skipOcclusion then
            v41, v42 = p38.activeOcclusionModule:Update(p40, v41, v42);
        end;

        CurrentCamera.CFrame = v41;
        CurrentCamera.Focus = v42;

        if p38.activeTransparencyController then
            p38.activeTransparencyController:Update(p40);
        end;
    elseif UserFlag3 and VRService.VREnabled then
        u9.inFirstPerson = false;
    end;
end;

function u1.OnCharacterAdded(p43: table, p44: userdata, p45: userdata) -- Line: 596
    if p43.activeOcclusionModule then
        p43.activeOcclusionModule:CharacterAdded(p44, p45);
    end;
end;

function u1.OnCharacterRemoving(p46, p47, p48) -- Line: 602
    if p46.activeOcclusionModule then
        p46.activeOcclusionModule:CharacterRemoving(p47, p48);
    end;
end;

function u1.OnPlayerAdded(u49: table, u50: userdata) -- Line: 608
    -- upvalues: UserFlag (copy)
    if UserFlag then
        if u49.connectionUtil then
            u49.connectionUtil:trackConnection(`{u50.UserId}CharacterAdded`, u50.CharacterAdded:Connect(function(p51) -- Line: 612
                -- upvalues: u49 (copy), u50 (copy)
                u49:OnCharacterAdded(p51, u50);
            end));
            u49.connectionUtil:trackConnection(`{u50.UserId}CharacterRemoving`, u50.CharacterRemoving:Connect(function(p52) -- Line: 615
                -- upvalues: u49 (copy), u50 (copy)
                u49:OnCharacterRemoving(p52, u50);
            end));
        end;
    else
        u50.CharacterAdded:Connect(function(p53) -- Line: 620
            -- upvalues: u49 (copy), u50 (copy)
            u49:OnCharacterAdded(p53, u50);
        end);
        u50.CharacterRemoving:Connect(function(p54) -- Line: 623
            -- upvalues: u49 (copy), u50 (copy)
            u49:OnCharacterRemoving(p54, u50);
        end);
    end;
end;

function u1.OnPlayerRemoving(p55: table, p56: userdata) -- Line: 629
    if p55.connectionUtil then
        p55.connectionUtil:disconnect((`{p56.UserId}CharacterAdded`));
        p55.connectionUtil:disconnect((`{p56.UserId}CharacterRemoving`));
    end;
end;

function u1.OnMouseLockToggled(p57) -- Line: 637
    if p57.activeMouseLockController then
        local IsMouseLocked = p57.activeMouseLockController:GetIsMouseLocked();
        local MouseLockOffset = p57.activeMouseLockController:GetMouseLockOffset();

        if p57.activeCameraController then
            p57.activeCameraController:SetIsMouseLocked(IsMouseLocked);
            p57.activeCameraController:SetMouseLockOffset(MouseLockOffset);
        end;
    end;
end;

if RunService:IsClient() then
    return u1.new();
end;

return u1;