  

 

local u1 = {};
u1.__index = u1;
local _, _ = pcall(function() -- Line: 19
    return UserSettings():IsUserFeatureEnabled("UserRemoveTheCameraApi");
end);
local u2 = { "CameraMinZoomDistance", "CameraMaxZoomDistance", "CameraMode", "DevCameraOcclusionMode", "DevComputerCameraMode", "DevTouchCameraMode", "DevComputerMovementMode", "DevTouchMovementMode", "DevEnableMouseLock" };
local u3 = { "ComputerCameraMovementMode", "ComputerMovementMode", "ControlMode", "GamepadCameraSensitivity", "MouseSensitivity", "RotationType", "TouchCameraMovementMode", "TouchMovementMode" };
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local CameraUtils = require(script:WaitForChild("CameraUtils"));
local CameraInput = require(script:WaitForChild("CameraInput"));
local ClassicCamera = require(script:WaitForChild("ClassicCamera"));
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"));
local LegacyCamera = require(script:WaitForChild("LegacyCamera"));
local VehicleCamera = require(script:WaitForChild("VehicleCamera"));
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

function u1.new() -- Line: 97
    -- upvalues: u1 (copy), Players (copy), TransparencyController (copy), MouseLockController (copy), RunService (copy), u2 (copy), u3 (copy), UserGameSettings (copy), UserInputService (copy)
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

    Players.PlayerAdded:Connect(function(p7) -- Line: 118
        -- upvalues: u6 (copy)
        u6:OnPlayerAdded(p7);
    end);
    u6.activeTransparencyController = TransparencyController.new();
    u6.activeTransparencyController:Enable(true);
    u6.activeMouseLockController = MouseLockController.new();
    local v8 = u6.activeMouseLockController:GetBindableToggleEvent();

    if v8 then
        v8:Connect(function() -- Line: 129
            -- upvalues: u6 (copy)
            u6:OnMouseLockToggled();
        end);
    end;

    u6:ActivateCameraController(u6:GetCameraControlChoice());
    u6:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);
    u6:OnCurrentCameraChanged();
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p9) -- Line: 138
        -- upvalues: u6 (copy)
        u6:Update(p9);
    end);

    for _, v in pairs(u2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v):Connect(function() -- Line: 142
            -- upvalues: u6 (copy), v (copy)
            u6:OnLocalPlayerCameraPropertyChanged(v);
        end);
    end;

    for _, v in pairs(u3) do
        UserGameSettings:GetPropertyChangedSignal(v):Connect(function() -- Line: 148
            -- upvalues: u6 (copy), v (copy)
            u6:OnUserGameSettingsPropertyChanged(v);
        end);
    end;

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 152
        -- upvalues: u6 (copy)
        u6:OnCurrentCameraChanged();
    end);
    u6.lastInputType = UserInputService:GetLastInputType();
    UserInputService.LastInputTypeChanged:Connect(function(p10) -- Line: 157
        -- upvalues: u6 (copy)
        u6.lastInputType = p10;
    end);

    return u6;
end;

function u1.GetCameraMovementModeFromSettings(p11) -- Line: 164
    -- upvalues: Players (copy), CameraUtils (copy), UserInputService (copy), UserGameSettings (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic);
    end;

    local v12, v13;

    if UserInputService.TouchEnabled then
        v12 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode);
        v13 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
    else
        v12 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode);
        v13 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);
    end;

    if v12 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v13;
    end;

    return v12;
end;

function u1.ActivateOcclusionModule(p14, p15) -- Line: 189
    -- upvalues: Poppercam (copy), Invisicam (copy), u5 (copy), Players (copy)
    local v16;

    if p15 == Enum.DevCameraOcclusionMode.Zoom then
        v16 = Poppercam;
    else
        if p15 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode");

            return;
        end;

        v16 = Invisicam;
    end;

    p14.occlusionMode = p15;

    if p14.activeOcclusionModule and p14.activeOcclusionModule:GetOcclusionMode() == p15 then
        if not p14.activeOcclusionModule:GetEnabled() then
            p14.activeOcclusionModule:Enable(true);
        end;

        return;
    end;

    local activeOcclusionModule = p14.activeOcclusionModule;
    p14.activeOcclusionModule = u5[v16];

    if not p14.activeOcclusionModule then
        p14.activeOcclusionModule = v16.new();

        if p14.activeOcclusionModule then
            u5[v16] = p14.activeOcclusionModule;
        end;
    end;

    if p14.activeOcclusionModule then
        if p14.activeOcclusionModule:GetOcclusionMode() ~= p15 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", p14.activeOcclusionModule:GetOcclusionMode(), "~=", p15);
        end;

        if activeOcclusionModule then
            if activeOcclusionModule == p14.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module");
            else
                activeOcclusionModule:Enable(false);
            end;
        end;

        if p15 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                p14.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer);
            end;
        else
            for _, v in pairs(Players:GetPlayers()) do
                if v and v.Character then
                    p14.activeOcclusionModule:CharacterAdded(v.Character, v);
                end;
            end;

            p14.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject);
        end;

        p14.activeOcclusionModule:Enable(true);
    end;
end;

function u1.ShouldUseVehicleCamera(p17) -- Line: 268
    local CurrentCamera = workspace.CurrentCamera;

    if not CurrentCamera then
        return false;
    end;

    local CameraType = CurrentCamera.CameraType;
    local CameraSubject = CurrentCamera.CameraSubject;
    local v18 = CameraType == Enum.CameraType.Custom and true or CameraType == Enum.CameraType.Follow;
    local v19 = CameraSubject and CameraSubject:IsA("VehicleSeat") or false;
    local v20 = p17.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam;

    if v19 then
        if not v18 then
            v20 = v18;
        end;
    else
        v20 = v19;
    end;

    return v20;
end;

function u1.ActivateCameraController(p21, p22, p23) -- Line: 286
    -- upvalues: LegacyCamera (copy), ClassicCamera (copy), OrbitalCamera (copy), VehicleCamera (copy), u4 (copy)
    local v24 = nil;

    if p23 ~= nil then
        if p23 == Enum.CameraType.Scriptable then
            if p21.activeCameraController then
                p21.activeCameraController:Enable(false);
                p21.activeCameraController = nil;

                return;
            end;
        elseif p23 == Enum.CameraType.Custom then
            p22 = p21:GetCameraMovementModeFromSettings();
        elseif p23 == Enum.CameraType.Track then
            p22 = Enum.ComputerCameraMovementMode.Classic;
        elseif p23 == Enum.CameraType.Follow then
            p22 = Enum.ComputerCameraMovementMode.Follow;
        elseif p23 == Enum.CameraType.Orbital then
            p22 = Enum.ComputerCameraMovementMode.Orbital;
        elseif p23 == Enum.CameraType.Attach or (p23 == Enum.CameraType.Watch or p23 == Enum.CameraType.Fixed) then
            v24 = LegacyCamera;
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", p23);
        end;
    end;

    if not v24 then
        if p22 == Enum.ComputerCameraMovementMode.Classic or (p22 == Enum.ComputerCameraMovementMode.Follow or (p22 == Enum.ComputerCameraMovementMode.Default or p22 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v24 = ClassicCamera;
        else
            if p22 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.");

                return;
            end;

            v24 = OrbitalCamera;
        end;
    end;

    if p21:ShouldUseVehicleCamera() then
        v24 = VehicleCamera;
    end;

    local v25;

    if u4[v24] then
        v25 = u4[v24];

        if v25.Reset then
            v25:Reset();
        end;
    else
        v25 = v24.new();
        u4[v24] = v25;
    end;

    if p21.activeCameraController then
        if p21.activeCameraController == v25 then
            if not p21.activeCameraController:GetEnabled() then
                p21.activeCameraController:Enable(true);
            end;
        else
            p21.activeCameraController:Enable(false);
            p21.activeCameraController = v25;
            p21.activeCameraController:Enable(true);
        end;
    elseif v25 ~= nil then
        p21.activeCameraController = v25;
        p21.activeCameraController:Enable(true);
    end;

    if p21.activeCameraController then
        if p22 ~= nil then
            p21.activeCameraController:SetCameraMovementMode(p22);

            return;
        end;

        if p23 ~= nil then
            p21.activeCameraController:SetCameraType(p23);
        end;
    end;
end;

function u1.OnCameraSubjectChanged(p26) -- Line: 384
    local CurrentCamera = workspace.CurrentCamera;
    local v27;

    if CurrentCamera then
        v27 = CurrentCamera.CameraSubject;
    else
        v27 = CurrentCamera;
    end;

    if p26.activeTransparencyController then
        p26.activeTransparencyController:SetSubject(v27);
    end;

    if p26.activeOcclusionModule then
        p26.activeOcclusionModule:OnCameraSubjectChanged(v27);
    end;

    p26:ActivateCameraController(nil, CurrentCamera.CameraType);
end;

function u1.OnCameraTypeChanged(p28, p29) -- Line: 399
    -- upvalues: UserInputService (copy)
    if p29 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
    end;

    p28:ActivateCameraController(nil, p29);
end;

function u1.OnCurrentCameraChanged(u30) -- Line: 411
    local CurrentCamera = game.Workspace.CurrentCamera;

    if not CurrentCamera then
        return;
    end;

    if u30.cameraSubjectChangedConn then
        u30.cameraSubjectChangedConn:Disconnect();
    end;

    if u30.cameraTypeChangedConn then
        u30.cameraTypeChangedConn:Disconnect();
    end;

    u30.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 423
        -- upvalues: u30 (copy), CurrentCamera (copy)
        u30:OnCameraSubjectChanged(CurrentCamera.CameraSubject);
    end);
    u30.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 427
        -- upvalues: u30 (copy), CurrentCamera (copy)
        u30:OnCameraTypeChanged(CurrentCamera.CameraType);
    end);
    u30:OnCameraSubjectChanged(CurrentCamera.CameraSubject);
    u30:OnCameraTypeChanged(CurrentCamera.CameraType);
end;

function u1.OnLocalPlayerCameraPropertyChanged(p31, p32) -- Line: 435
    -- upvalues: Players (copy), CameraUtils (copy)
    if p32 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.Classic then
                warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode);

                return;
            end;

            local v33 = p31:GetCameraMovementModeFromSettings();
            p31:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(v33));

            return;
        end;

        if not p31.activeCameraController or p31.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p31:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic));
        end;

        if p31.activeCameraController then
            p31.activeCameraController:UpdateForDistancePropertyChange();
        end;
    else
        if p32 == "DevComputerCameraMode" or p32 == "DevTouchCameraMode" then
            local v34 = p31:GetCameraMovementModeFromSettings();
            p31:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(v34));

            return;
        end;

        if p32 == "DevCameraOcclusionMode" then
            p31:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode);

            return;
        end;

        if p32 == "CameraMinZoomDistance" or p32 == "CameraMaxZoomDistance" then
            if p31.activeCameraController then
                p31.activeCameraController:UpdateForDistancePropertyChange();
            end;
        else
            if p32 == "DevTouchMovementMode" then
                return;
            end;

            if p32 == "DevComputerMovementMode" then
                return;
            end;

            local _ = p32 == "DevEnableMouseLock";
        end;
    end;
end;

function u1.OnUserGameSettingsPropertyChanged(p35, p36) -- Line: 479
    -- upvalues: CameraUtils (copy)
    if p36 == "ComputerCameraMovementMode" then
        local v37 = p35:GetCameraMovementModeFromSettings();
        p35:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(v37));
    end;
end;

function u1.Update(p38, p39) -- Line: 492
    -- upvalues: UserInputService (copy), CameraInput (copy)
    if p38.activeCameraController then
        p38.activeCameraController:UpdateMouseBehavior();

        if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
            p38.activeCameraController:SetIsMouseLocked(true);
        end;

        local v40, v41 = p38.activeCameraController:Update(p39);
        p38.activeCameraController:ApplyVRTransform();

        if p38.activeOcclusionModule then
            v40, v41 = p38.activeOcclusionModule:Update(p39, v40, v41);
        end;

        game.Workspace.CurrentCamera.CFrame = v40;
        game.Workspace.CurrentCamera.Focus = v41;

        if p38.activeTransparencyController then
            p38.activeTransparencyController:Update();
        end;

        if CameraInput.getInputEnabled() then
            CameraInput.resetInputForFrameEnd();
        end;
    end;
end;

function u1.GetCameraControlChoice(p42) -- Line: 522
    -- upvalues: Players (copy), UserInputService (copy), CameraUtils (copy), UserGameSettings (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer then
        if p42.lastInputType == Enum.UserInputType.Touch or UserInputService.TouchEnabled then
            if LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
                return CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode);
            end;

            return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevTouchCameraMode);
        end;

        if LocalPlayer.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
            return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevComputerCameraMode);
        end;

        local v43 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode);

        return CameraUtils.ConvertCameraModeEnumToStandard(v43);
    end;
end;

function u1.OnCharacterAdded(p44, p45, p46) -- Line: 545
    if p44.activeOcclusionModule then
        p44.activeOcclusionModule:CharacterAdded(p45, p46);
    end;
end;

function u1.OnCharacterRemoving(p47, p48, p49) -- Line: 551
    if p47.activeOcclusionModule then
        p47.activeOcclusionModule:CharacterRemoving(p48, p49);
    end;
end;

function u1.OnPlayerAdded(u50, u51) -- Line: 557
    u51.CharacterAdded:Connect(function(p52) -- Line: 558
        -- upvalues: u50 (copy), u51 (copy)
        u50:OnCharacterAdded(p52, u51);
    end);
    u51.CharacterRemoving:Connect(function(p53) -- Line: 561
        -- upvalues: u50 (copy), u51 (copy)
        u50:OnCharacterRemoving(p53, u51);
    end);
end;

function u1.OnMouseLockToggled(p54) -- Line: 566
    if p54.activeMouseLockController then
        local v55 = p54.activeMouseLockController:GetIsMouseLocked();
        local v56 = p54.activeMouseLockController:GetMouseLockOffset();

        if p54.activeCameraController then
            p54.activeCameraController:SetIsMouseLocked(v55);
            p54.activeCameraController:SetMouseLockOffset(v56);
        end;
    end;
end;

return u1.new();