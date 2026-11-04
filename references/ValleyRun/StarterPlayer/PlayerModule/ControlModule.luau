 

 

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local StarterPlayer = game:GetService("StarterPlayer");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local ContextActionService = game:GetService("ContextActionService");
local CommonUtils = require(script.Parent:WaitForChild("CommonUtils"));
local v2 = CommonUtils.get("FlagUtil");
local UserFlag = v2.getUserFlag("UserVRFixCameraCloseArticulation");
local UserFlag2 = v2.getUserFlag("UserPlayerScriptsCCLIntegrationD");
local UserFlag3 = v2.getUserFlag("UserPlayerScriptsBindActivateOnIAS");
local UserFlag4 = v2.getUserFlag("UserPlayerScriptsPlayerControlState2");
local UserFlag5 = v2.getUserFlag("UserPlayerScriptsTaskDeferSimulation");
local UserFlag6 = v2.getUserFlag("UserPlayerScriptsFixSAuthRenderStepMove");
local UserFlag7 = v2.getUserFlag("UserPlayerScriptsSupportMicroGamepad");
local UserFlag8 = v2.getUserFlag("UserAbilitiesUserInterfaceC");
local UserFlag9 = v2.getUserFlag("UserControlModuleEnabledAPI");
local UserFlag10 = v2.getUserFlag("UserPSUseBindToAnimation");
local UserFlag11 = v2.getUserFlag("UserServerAuthorityDontSetAutoRotate");
local ActionController = require(script:WaitForChild("ActionController"));
local u3;

if UserFlag2 or UserFlag4 then
    u3 = require(script:WaitForChild("InputReplication"));
else
    u3 = nil;
end;

local u4;

if UserFlag2 then
    u4 = require(script:WaitForChild("InputSlots"));
else
    u4 = nil;
end;

local u5;

if RunService:IsClient() then
    u5 = require(script:WaitForChild("DynamicThumbstick"));
else
    u5 = nil;
end;

local ClassicThumbstick = require(script:WaitForChild("ClassicThumbstick"));
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"));
local TouchJump = require(script:WaitForChild("TouchJump"));
local u6;

if UserFlag2 then
    u6 = require(script:WaitForChild("TouchAbilities"));
else
    u6 = nil;
end;

local VehicleController = require(script:WaitForChild("VehicleController"));
local u7, u8;

if UserFlag2 then
    u7 = require(script:WaitForChild("AvatarAbilitiesInterface"));
    u8 = u7.get(Players.LocalPlayer);
else
    u7 = nil;
    u8 = nil;
end;

local CameraRotationAction = script.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext"):WaitForChild("CameraRotationAction");
local _ = Enum.ContextActionPriority.Medium.Value;
local u9 = CommonUtils.get("VRFirstPersonState");
local u10 = {
    [Enum.TouchMovementMode.DPad] = u5,
    [Enum.DevTouchMovementMode.DPad] = u5,
    [Enum.TouchMovementMode.Thumbpad] = u5,
    [Enum.DevTouchMovementMode.Thumbpad] = u5,
    [Enum.TouchMovementMode.Thumbstick] = ClassicThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = ClassicThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = u5,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = u5,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = u5,
    [Enum.ComputerMovementMode.Default] = ActionController,
    [Enum.ComputerMovementMode.KeyboardMouse] = ActionController,
    [Enum.DevComputerMovementMode.KeyboardMouse] = ActionController,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController
};

function u1.new() -- Line: 106
    -- upvalues: u1 (copy), RunService (copy), Players (copy), VehicleController (copy), UserGameSettings (copy), UserFlag2 (copy), u8 (ref), GuiService (copy), UserInputService (copy), UserFlag3 (copy), ContextActionService (copy)
    local u11 = setmetatable({}, u1);

    if RunService:IsServer() then
        return u11;
    end;

    u11.controllers = {};
    u11.activeControlModule = nil;
    u11.activeController = nil;
    u11.touchJumpController = nil;
    u11.touchAbilitiesController = nil;
    u11.moveFunction = Players.LocalPlayer.Move;
    u11.humanoid = nil;
    u11.controlsEnabled = true;
    u11.enabled = false;
    u11.humanoidSeatedConn = nil;
    u11.vehicleController = nil;
    u11.touchControlFrame = nil;
    u11.currentTorsoAngle = 0;
    u11.inputMoveVector = Vector3.new(0, 0, 0);
    u11.renderedRotationOverride = nil;
    u11.vehicleController = VehicleController.new();
    Players.LocalPlayer.CharacterAdded:Connect(function(p12) -- Line: 139
        -- upvalues: u11 (copy)
        u11:OnCharacterAdded(p12);
    end);
    Players.LocalPlayer.CharacterRemoving:Connect(function(p13) -- Line: 140
        -- upvalues: u11 (copy)
        u11:OnCharacterRemoving(p13);
    end);

    if Players.LocalPlayer.Character then
        u11:OnCharacterAdded(Players.LocalPlayer.Character);
    end;

    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 145
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 148
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
    end);
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- Line: 152
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 155
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
    end);

    if UserFlag2 then
        u8:GetEnabledChangedSignal():Connect(function() -- Line: 159
            -- upvalues: u11 (copy)
            u11:UpdateAbilitiesControllers();
        end);
    end;

    u11.playerGui = nil;
    u11.touchGui = nil;
    u11.playerGuiAddedConn = nil;
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- Line: 169
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
        u11:UpdateActiveControlModuleEnabled();
    end);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 174
        -- upvalues: u11 (copy)
        u11:UpdateMovementMode();
    end);
    u11.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u11.playerGui then
        u11.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p14) -- Line: 180
            -- upvalues: u11 (copy)
            if p14:IsA("PlayerGui") then
                u11.playerGui = p14;
                u11.playerGuiAddedConn:Disconnect();
                u11.playerGuiAddedConn = nil;
                u11:UpdateMovementMode();
            end;
        end);
    end;

    if UserFlag3 then
        ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2);
    end;

    return u11;
end;

local function _fireCustomInputs(p15: userdata) -- Line: 198
    -- upvalues: UserGameSettings (copy)
    local InputContexts = p15:FindFirstChild("InputContexts");

    if InputContexts == nil then
        return;
    end;

    local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

    if CharacterContext == nil then
        return;
    end;

    local RotationAction = CharacterContext:FindFirstChild("RotationAction");
    local v16 = RotationAction and RotationAction:FindFirstChild("RotationScriptableBinding");

    if v16 then
        v16:Fire(UserGameSettings.RotationType == Enum.RotationType.CameraRelative);
    end;
end;

function u1.restoreSimulatedRotation(p17) -- Line: 218
    local renderedRotationOverride = p17.renderedRotationOverride;

    if renderedRotationOverride == nil then
        return;
    end;

    if renderedRotationOverride.rootPart.Parent ~= nil then
        renderedRotationOverride.rootPart.CFrame = CFrame.new(renderedRotationOverride.rootPart.CFrame.Position) * renderedRotationOverride.simulatedRotation;
    end;

    p17.renderedRotationOverride = nil;
end;

function u1.applyRenderedRotation(p18) -- Line: 229
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera;
    local humanoid = p18.humanoid;
    local v19;

    if humanoid then
        v19 = humanoid.RootPart;
    else
        v19 = humanoid;
    end;

    if CurrentCamera == nil or (v19 == nil or (humanoid.Sit or (humanoid.SeatPart ~= nil or (v19:IsGrounded() or humanoid:GetState() == Enum.HumanoidStateType.Swimming)))) then
        return;
    end;

    local LookVector = CurrentCamera.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

    if Vector3_new_ret.Magnitude < 0.001 then
        return;
    end;

    if p18.renderedRotationOverride ~= nil and p18.renderedRotationOverride.rootPart ~= v19 then
        p18:restoreSimulatedRotation();
    end;

    if p18.renderedRotationOverride == nil then
        p18.renderedRotationOverride = {
            rootPart = v19,
            simulatedRotation = v19.CFrame.Rotation
        };
    end;

    local Position = v19.CFrame.Position;
    v19.CFrame = CFrame.lookAt(Position, Position + Vector3_new_ret);
end;

local function _cloneInputs(p20: userdata) -- Line: 255
    -- upvalues: StarterPlayer (copy)
    local v21 = StarterPlayer.PlayerModule.InputContexts:Clone();
    v21.CharacterContext.Enabled = true;
    v21.CameraContext.Enabled = true;
    v21.Parent = p20;
end;

function u1.InitializeServerAuthority(u22) -- Line: 262
    -- upvalues: RunService (copy), UserFlag2 (copy), Players (copy), u3 (copy), StarterPlayer (copy), _cloneInputs (copy), UserFlag4 (copy), UserFlag5 (copy), u7 (ref), UserFlag10 (copy), UserFlag11 (copy), _fireCustomInputs (copy), UserGameSettings (copy), u8 (ref)
    if RunService:IsServer() then
        if UserFlag2 then
            for _, v in Players:GetPlayers() do
                u3.CloneInputsIfAbsent(v);
            end;

            Players.PlayerAdded:Connect(u3.CloneInputsIfAbsent);
        else
            for _, v in Players:GetPlayers() do
                local v23 = StarterPlayer.PlayerModule.InputContexts:Clone();
                v23.CharacterContext.Enabled = true;
                v23.CameraContext.Enabled = true;
                v23.Parent = v;
            end;

            Players.PlayerAdded:Connect(_cloneInputs);
        end;

        if UserFlag4 then
            for _, v in Players:GetPlayers() do
                u3.createPlayerControlState(v);
            end;

            Players.PlayerAdded:Connect(u3.createPlayerControlState);
        end;

        if UserFlag2 and UserFlag5 then
            for _, v in Players:GetPlayers() do
                u7.get(v);
            end;

            Players.PlayerAdded:Connect(function(p24) -- Line: 287
                -- upvalues: u7 (ref)
                u7.get(p24);
            end);
        end;

        if UserFlag10 then
            RunService:BindToAnimation(function(p25) -- Line: 293
                -- upvalues: Players (ref), u22 (copy)
                for _, v in Players:GetPlayers() do
                    u22:ProcessInputs(v, p25);
                end;
            end, Enum.StepFrequency.Hz60);
        else
            RunService:BindToSimulation(function(p26) -- Line: 299
                -- upvalues: Players (ref), u22 (copy)
                for _, v in Players:GetPlayers() do
                    u22:ProcessInputs(v, p26);
                end;
            end, Enum.StepFrequency.Hz60);
        end;
    else
        if UserFlag4 then
            u3.watchForPlayerControlState(Players.LocalPlayer);
        end;

        if UserFlag11 then
            RunService.PreAnimation:Connect(function() -- Line: 311
                -- upvalues: u22 (copy)
                u22:restoreSimulatedRotation();
            end);
        end;

        RunService:BindToRenderStep("CameraInput", Enum.RenderPriority.Last.Value, function() -- Line: 317
            -- upvalues: UserFlag4 (ref), u3 (ref), Players (ref), u22 (copy), UserFlag2 (ref), _fireCustomInputs (ref), UserFlag11 (ref), UserGameSettings (ref), u8 (ref)
            if UserFlag4 then
                u3.writeInputToPCS(Players.LocalPlayer, u22, true);
            elseif UserFlag2 then
                u3.FireCustomInputs(Players.LocalPlayer);
            else
                _fireCustomInputs(Players.LocalPlayer);
            end;

            if UserFlag11 and (UserGameSettings.RotationType == Enum.RotationType.CameraRelative and not (UserFlag2 and u8:isEnabled())) then
                u22:applyRenderedRotation();
            end;
        end);

        if UserFlag10 then
            RunService:BindToAnimation(function(p27) -- Line: 332
                -- upvalues: u22 (copy), Players (ref)
                u22:ProcessInputs(Players.LocalPlayer, p27);
            end, Enum.StepFrequency.Hz60);
        else
            RunService:BindToSimulation(function(p28) -- Line: 336
                -- upvalues: u22 (copy), Players (ref)
                u22:ProcessInputs(Players.LocalPlayer, p28);
            end, Enum.StepFrequency.Hz60);
        end;
    end;

    if u22.data and u22.data.eventBus then
        u22.data.isServerAuthority = true;
        u22.data.eventBus:publish("SERVER_AUTHORITY_CHANGED", true);
    end;
end;

local function NormalizeAngle(p29) -- Line: 349
    local v30 = (p29 + 12.566370614359172) % 6.283185307179586;

    if v30 > 3.141592653589793 then
        v30 = v30 - 6.283185307179586;
    end;

    return v30;
end;

local function AverageAngle(p31, p32) -- Line: 357
    local v33 = (p32 - p31 + 12.566370614359172) % 6.283185307179586;

    if v33 > 3.141592653589793 then
        v33 = v33 - 6.283185307179586;
    end;

    local v34 = (p31 + v33 / 2 + 12.566370614359172) % 6.283185307179586;

    if v34 > 3.141592653589793 then
        v34 = v34 - 6.283185307179586;
    end;

    return v34;
end;

function u1.GetEstimatedVRTorsoFrame(p35) -- Line: 362
    -- upvalues: VRService (copy)
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v36, _ = UserCFrame:ToEulerAnglesYXZ();
    local v37 = -v36;

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local UserCFrame2 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local UserCFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v38 = UserCFrame.Position - UserCFrame2.Position;
        local v39 = UserCFrame.Position - UserCFrame3.Position;
        local v40 = -math.atan2(v38.X, v38.Z);
        local v41 = (-math.atan2(v39.X, v39.Z) - v40 + 12.566370614359172) % 6.283185307179586;

        if v41 > 3.141592653589793 then
            v41 = v41 - 6.283185307179586;
        end;

        local v42 = (v40 + v41 / 2 + 12.566370614359172) % 6.283185307179586;

        if v42 > 3.141592653589793 then
            v42 = v42 - 6.283185307179586;
        end;

        local v43 = (v37 - p35.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v43 > 3.141592653589793 then
            v43 = v43 - 6.283185307179586;
        end;

        local v44 = (v42 - p35.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v44 > 3.141592653589793 then
            v44 = v44 - 6.283185307179586;
        end;

        local v45;

        if v44 > -1.5707963267948966 then
            v45 = v44 < 1.5707963267948966;
        else
            v45 = false;
        end;

        if not v45 then
            v44 = v43;
        end;

        local math_min_ret = math.min(v44, v43);
        local math_max_ret = math.max(v44, v43);
        local v46 = 0;

        if math_min_ret > 0 then
            math_max_ret = math_min_ret;
        elseif math_max_ret >= 0 then
            math_max_ret = v46;
        end;

        p35.currentTorsoAngle = math_max_ret + p35.currentTorsoAngle;
    else
        p35.currentTorsoAngle = v37;
    end;

    return CFrame.new(UserCFrame.Position) * CFrame.fromEulerAnglesYXZ(0, -p35.currentTorsoAngle, 0);
end;

function u1.GetActiveController(p47) -- Line: 406
    return p47.activeController;
end;

function u1.UpdateAbilitiesControllers(p48) -- Line: 410
    -- upvalues: UserInputService (copy), ClickToMoveController (copy), ClassicThumbstick (copy), u5 (ref), u8 (ref), TouchJump (copy), u6 (copy)
    local v49 = p48.enabled and p48.touchControlFrame;

    if v49 then
        if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
            v49 = (p48.activeControlModule == ClickToMoveController or p48.activeControlModule == ClassicThumbstick) and true or p48.activeControlModule == u5;
        else
            v49 = false;
        end;
    end;

    local v50;

    if v49 then
        v50 = not u8:isEnabled();
    else
        v50 = v49;
    end;

    if v49 then
        v49 = u8:isEnabled();
    end;

    if v50 then
        if not p48.controllers[TouchJump] then
            p48.controllers[TouchJump] = TouchJump.new(p48.data);
        end;

        p48.touchJumpController = p48.controllers[TouchJump];
        p48.touchJumpController:Enable(true, p48.touchControlFrame);
    elseif p48.touchJumpController then
        p48.touchJumpController:Enable(false);
    end;

    if not v49 then
        if p48.touchAbilitiesController then
            p48.touchAbilitiesController:Enable(false);
        end;

        return;
    end;

    if not p48.controllers[u6] then
        p48.controllers[u6] = u6.new(p48.touchControlFrame);
    end;

    p48.touchAbilitiesController = p48.controllers[u6];
    p48.touchAbilitiesController:Enable(true);
end;

function u1.UpdateActiveControlModuleEnabled(u51) -- Line: 446
    -- upvalues: UserFlag2 (copy), u8 (ref), Players (copy), UserInputService (copy), ClickToMoveController (copy), ClassicThumbstick (copy), u5 (ref), TouchJump (copy), GuiService (copy)
    local function v52() -- Line: 448
        -- upvalues: UserFlag2 (ref), u51 (copy), u8 (ref), Players (ref)
        if UserFlag2 then
            u51.enabled = false;
        end;

        u51.activeController:Enable(false);

        if UserFlag2 then
            u51:UpdateAbilitiesControllers();
        elseif u51.touchJumpController then
            u51.touchJumpController:Enable(false);
        end;

        if u51.moveFunction and not (UserFlag2 and u8:isEnabled()) then
            u51.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;

    local function v53() -- Line: 468
        -- upvalues: UserFlag2 (ref), u51 (copy), UserInputService (ref), ClickToMoveController (ref), ClassicThumbstick (ref), u5 (ref), TouchJump (ref), Players (ref)
        if UserFlag2 then
            u51.enabled = true;
            u51:UpdateAbilitiesControllers();
        elseif u51.touchControlFrame and (UserInputService.PreferredInput == Enum.PreferredInput.Touch and (u51.activeControlModule == ClickToMoveController or (u51.activeControlModule == ClassicThumbstick or u51.activeControlModule == u5))) then
            if not u51.controllers[TouchJump] then
                u51.controllers[TouchJump] = TouchJump.new(u51.data);
            end;

            u51.touchJumpController = u51.controllers[TouchJump];
            u51.touchJumpController:Enable(true, u51.touchControlFrame);
        elseif u51.touchJumpController then
            u51.touchJumpController:Enable(false);
        end;

        if u51.activeControlModule == ClickToMoveController then
            u51.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, u51.touchJumpController);

            return;
        end;

        if u51.touchControlFrame then
            u51.activeController:Enable(true, u51.touchControlFrame);

            return;
        end;

        u51.activeController:Enable(true);
    end;

    if not u51.activeController then
        return;
    end;

    if not u51.controlsEnabled then
        v52();

        return;
    end;

    if GuiService.TouchControlsEnabled or (UserInputService.PreferredInput ~= Enum.PreferredInput.Touch or u51.activeControlModule ~= ClickToMoveController and (u51.activeControlModule ~= ClassicThumbstick and u51.activeControlModule ~= u5)) then
        v53();

        return;
    end;

    v52();
end;

function u1.Enable(p54: table, p55: boolean?) -- Line: 533
    local v56 = p55 == nil and true or p55;

    if p54.controlsEnabled == v56 then
        return;
    end;

    p54.controlsEnabled = v56;

    if not p54.activeController then
        return;
    end;

    p54:UpdateActiveControlModuleEnabled();
end;

function u1.Disable(p57) -- Line: 548
    p57:Enable(false);
end;

function u1.SelectComputerMovementModule(p58) -- Line: 554
    -- upvalues: UserFlag7 (copy), UserInputService (copy), ActionController (copy), Players (copy), UserGameSettings (copy), ClickToMoveController (copy), u10 (copy)
    local u59 = false;

    if UserFlag7 then
        pcall(function() -- Line: 557
            -- upvalues: u59 (ref), UserInputService (ref)
            u59 = UserInputService.PreferredInput == Enum.PreferredInput.MicroGamepad;
        end);
    end;

    if UserInputService.PreferredInput ~= Enum.PreferredInput.KeyboardAndMouse and (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad and not u59) then
        return nil, false;
    end;

    local v60 = ActionController;
    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove then
            v60 = ClickToMoveController;
        end;
    else
        v60 = u10[DevComputerMovementMode];

        if not v60 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode);
        end;
    end;

    if v60 then
        return v60, true;
    end;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true;
    end;

    return nil, false;
end;

function u1.SelectTouchModule(p61) -- Line: 598
    -- upvalues: Players (copy), u10 (copy), UserGameSettings (copy)
    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode;
    local v62;

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v62 = u10[UserGameSettings.TouchMovementMode];
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;

        v62 = u10[DevTouchMovementMode];
    end;

    return v62, true;
end;

function u1.calculateRawMoveVector(p63: table, p64: userdata, p65: vector) -- Line: 611
    -- upvalues: Workspace (copy), VRService (copy), CameraRotationAction (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p65;
    end;

    local CFrame2 = CurrentCamera.CFrame;

    if VRService.VREnabled and p64.RootPart then
        local EstimatedVRTorsoFrame = p63:GetEstimatedVRTorsoFrame();

        if (CurrentCamera.Focus.Position - CFrame2.Position).Magnitude < 3 then
            CFrame2 = CFrame2 * EstimatedVRTorsoFrame;
        else
            CFrame2 = CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale);
        end;
    end;

    if p64:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v66, v67, v68, _, _, v69, _, _, v66 = CFrame2:GetComponents();

        if v69 >= 1 or v69 <= -1 then
            v68 = -v67 * math.sign(v69);
        end;

        local math_sqrt_ret = math.sqrt(v66 * v66 + v68 * v68);

        return Vector3.new((v66 * p65.X + v68 * p65.Z) / math_sqrt_ret, 0, (v66 * p65.Z - v68 * p65.X) / math_sqrt_ret);
    end;

    if not VRService.VREnabled then
        return CFrame2:VectorToWorldSpace(p65);
    end;

    local Vector3_new_ret = Vector3.new(p65.X, 0, p65.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local v70 = not (CameraRotationAction and CameraRotationAction.Enabled) and 0 or -CameraRotationAction:GetState().Y / 2.31;
    local math_atan2_ret = math.atan2(-Vector3_new_ret.X, -Vector3_new_ret.Z);
    local _, v71, _ = CFrame2:ToEulerAnglesYXZ();

    return CFrame.fromEulerAnglesYXZ(v70, math_atan2_ret + v71, 0).LookVector;
end;

function u1.initialize(p72, p73) -- Line: 672
    -- upvalues: ActionController (copy), UserFlag2 (copy), u4 (copy)
    p72.data = p73;
    p72:UpdateMovementMode();
    ActionController.initializeActions(p72.data);

    if UserFlag2 then
        u4.setupSlotActions(p72.data.player, p72.data.isServerAuthority);
    end;
end;

function u1.Update(p74, p75, p76) -- Line: 683
    -- upvalues: UserFlag9 (copy), ActionController (copy), VRService (copy), UserFlag4 (copy), UserFlag2 (copy), u8 (ref), u3 (copy), Players (copy), UserFlag6 (copy)
    assert(p75.player);
    assert(p75.character);

    if UserFlag9 then
        if not p74.humanoid then
            return;
        end;

        if not p75.playerModule.ControlModule.Enabled then
            p75.isJumping = false;
            p75.moveVector = Vector2.new();
            p75.worldMoveVector = Vector3.new();
            ActionController.update(p75);
            p74.inputMoveVector = Vector3.new();

            if p74.vehicleController then
                p74.vehicleController:Update(Vector3.new(), true);
            end;

            p74:characterMove(p75);

            return;
        end;
    end;

    ActionController.initializeActions(p75);

    if not (UserFlag9 or p75.actions.MoveAction and p75.actions.JumpAction) then
        return;
    end;

    if p74.activeController and (p74.activeController.enabled and p74.humanoid) then
        ActionController.update(p75);
        p74:GetClickToMoveController():Update(p75, p76);
        local Vector3_new_ret = Vector3.new(p75.moveVector.X, 0, -p75.moveVector.Y);

        if p74.vehicleController then
            local v77;
            Vector3_new_ret, v77 = p74.vehicleController:Update(Vector3_new_ret, true);
            _ = v77;
        end;

        local v78 = p74:calculateRawMoveVector(p74.humanoid, Vector3_new_ret);
        p74.inputMoveVector = v78;

        if VRService.VREnabled then
            v78 = p74:updateVRMoveVector(v78);
        end;

        if UserFlag9 then
            p75.worldMoveVector = v78;
            p74:characterMove(p75);

            return;
        end;

        if UserFlag4 then
            if not p75.isServerAuthority then
                if UserFlag2 and u8:isEnabled() then
                    u3.writeInputToPCS(Players.LocalPlayer, p74, false);

                    return;
                end;

                p74.moveFunction(Players.LocalPlayer, v78, false);
                p74.humanoid.Jump = p75.isJumping;
            end;
        elseif not (UserFlag6 and p75.isServerAuthority or UserFlag2 and u8:isEnabled()) then
            p74.moveFunction(Players.LocalPlayer, v78, false);
            p74.humanoid.Jump = p75.isJumping;
        end;
    end;
end;

function u1.characterMove(p79, p80) -- Line: 764
    -- upvalues: UserFlag4 (copy), UserFlag2 (copy), u8 (ref), u3 (copy), Players (copy), UserFlag6 (copy)
    if UserFlag4 then
        if not p80.isServerAuthority then
            if UserFlag2 and u8:isEnabled() then
                u3.writeInputToPCS(Players.LocalPlayer, p79, false);

                return;
            end;

            p79.moveFunction(Players.LocalPlayer, p80.worldMoveVector, false);
            p79.humanoid.Jump = p80.isJumping;
        end;
    elseif not (UserFlag6 and p80.isServerAuthority or UserFlag2 and u8:isEnabled()) then
        p79.moveFunction(Players.LocalPlayer, p80.worldMoveVector, false);
        p79.humanoid.Jump = p80.isJumping;
    end;
end;

function u1.updateVRMoveVector(p81, p82) -- Line: 784
    -- upvalues: UserFlag (copy), u9 (copy), VRService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v83 = workspace_CurrentCamera.Focus.Position - workspace_CurrentCamera.CFrame.Position;
    local v84;

    if UserFlag then
        v84 = u9.inFirstPerson;
    else
        v84 = v83.Magnitude < 5;
    end;

    if p82.Magnitude ~= 0 or not (v84 and (VRService.AvatarGestures and (p81.humanoid and not p81.humanoid.Sit))) then
        return p82;
    end;

    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local v85 = (workspace_CurrentCamera.CFrame * (UserCFrame.Rotation + UserCFrame.Position * workspace_CurrentCamera.HeadScale) * CFrame.new(0, -0.7 * p81.humanoid.RootPart.Size.Y / 2, 0)).Position - p81.humanoid.RootPart.CFrame.Position;
    local Vector3_new_ret = Vector3.new(v85.x, 0, v85.z);

    if UserFlag and (workspace_CurrentCamera.Focus.Position - workspace_CurrentCamera.CFrame.Position).Magnitude > math.max(4 * workspace_CurrentCamera.HeadScale, 1) then
        return p82;
    end;

    return Vector3_new_ret;
end;

function u1.OnHumanoidSeated(p86: table, p87: boolean, p88: userdata) -- Line: 825
    if p87 then
        if p88 and p88:IsA("VehicleSeat") then
            if not p86.vehicleController then
                p86.vehicleController = p86.vehicleController.new();
            end;

            p86.vehicleController:Enable(true, p88);
        end;
    elseif p86.vehicleController then
        p86.vehicleController:Enable(false, p88);
    end;
end;

function u1.OnCharacterAdded(u89, p90) -- Line: 840
    u89.humanoid = p90:FindFirstChildOfClass("Humanoid");

    while not u89.humanoid do
        p90.ChildAdded:wait();
        u89.humanoid = p90:FindFirstChildOfClass("Humanoid");
    end;

    if u89.humanoidSeatedConn then
        u89.humanoidSeatedConn:Disconnect();
        u89.humanoidSeatedConn = nil;
    end;

    u89.humanoidSeatedConn = u89.humanoid.Seated:Connect(function(p91, p92) -- Line: 851
        -- upvalues: u89 (copy)
        u89:OnHumanoidSeated(p91, p92);
    end);
    u89:UpdateMovementMode();
end;

function u1.OnCharacterRemoving(p93, p94) -- Line: 858
    p93.humanoid = nil;
    p93:UpdateMovementMode();
end;

function u1.UpdateTouchGuiVisibility(p95) -- Line: 864
    -- upvalues: GuiService (copy), UserInputService (copy)
    local v96 = p95.humanoid and GuiService.TouchControlsEnabled and UserInputService.PreferredInput == Enum.PreferredInput.Touch;

    if v96 and not p95.touchGui then
        p95:CreateTouchGuiContainer();
    end;

    if p95.touchGui then
        p95.touchGui.Enabled = v96 and true or false;
    end;
end;

function u1.SwitchToController(p97, p98) -- Line: 883
    if p98 then
        if not p97.controllers[p98] then
            p97.controllers[p98] = p98.new(p97.data);
        end;

        if p97.activeController ~= p97.controllers[p98] then
            if p97.activeController then
                p97.activeController:Enable(false);
            end;

            p97.activeController = p97.controllers[p98];
            p97.activeControlModule = p98;
            p97:UpdateActiveControlModuleEnabled();
        end;

        return;
    end;

    if p97.activeController then
        p97.activeController:Enable(false);
    end;

    p97.activeController = nil;
    p97.activeControlModule = nil;
end;

function u1.UpdateMovementMode(p99) -- Line: 922
    -- upvalues: UserInputService (copy)
    p99:UpdateTouchGuiVisibility();

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        local v100, v101 = p99:SelectTouchModule();

        if v101 and p99.touchControlFrame then
            p99:SwitchToController(v100);
        end;
    else
        p99:SwitchToController((p99:SelectComputerMovementModule()));
    end;
end;

function u1.CreateTouchGuiContainer(p102) -- Line: 938
    -- upvalues: UserFlag2 (copy), UserFlag8 (copy)
    if not p102.playerGui then
        return;
    end;

    if p102.touchGui then
        p102.touchGui:Destroy();
    end;

    p102.touchGui = Instance.new("ScreenGui");
    p102.touchGui.Name = "TouchGui";
    p102.touchGui.ResetOnSpawn = false;
    p102.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    if UserFlag2 and UserFlag8 then
        p102.touchGui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets;
    end;

    p102.touchGui.ClipToDeviceSafeArea = false;
    p102.touchControlFrame = Instance.new("Frame");
    p102.touchControlFrame.Name = "TouchControlFrame";
    p102.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p102.touchControlFrame.BackgroundTransparency = 1;
    p102.touchControlFrame.Parent = p102.touchGui;
    p102.touchGui.Parent = p102.playerGui;
end;

function u1.GetClickToMoveController(p103) -- Line: 965
    -- upvalues: ClickToMoveController (copy)
    if not p103.controllers[ClickToMoveController] then
        p103.controllers[ClickToMoveController] = ClickToMoveController.new();
    end;

    return p103.controllers[ClickToMoveController];
end;

function u1.ProcessInputs(p104: table, p105: userdata, p106: number) -- Line: 972
    -- upvalues: UserFlag2 (copy), u7 (ref), UserFlag4 (copy), u3 (copy)
    if UserFlag2 then
        if not u7.get(p105):isEnabled() then
            if UserFlag4 then
                u3.processPCSInputs(p105);

                return;
            end;

            u3.SendInputToHumanoidForServerAuth(p105);
        end;
    else
        if UserFlag4 then
            u3.processPCSInputs(p105);

            return;
        end;

        local Character = p105.Character;

        if Character == nil then
            return;
        end;

        local Humanoid = Character:FindFirstChild("Humanoid");

        if Humanoid == nil then
            return;
        end;

        local InputContexts = p105:FindFirstChild("InputContexts");

        if InputContexts == nil then
            return;
        end;

        local CharacterContext = InputContexts:FindFirstChild("CharacterContext");

        if CharacterContext == nil then
            return;
        end;

        local MoveAction = CharacterContext.MoveAction;
        local RotationAction = CharacterContext.RotationAction;
        local JumpAction = CharacterContext.JumpAction;

        local function isValidInput2D(p107) -- Line: 1008
            return p107.X == p107.X and (p107.Y == p107.Y and p107.X ~= (1 / 0)) and p107.Y ~= (1 / 0);
        end;

        local function isValidInput3D(p108: vector) -- Line: 1016
            return p108.X == p108.X and (p108.Y == p108.Y and (p108.Z == p108.Z and (p108.X ~= (1 / 0) and p108.Y ~= (1 / 0)))) and p108.Z ~= (1 / 0);
        end;

        local v109;

        if MoveAction == nil then
            v109 = Vector2.new(0, 0);
        else
            v109 = MoveAction:GetState();
        end;

        local LookVector = p105:GetCameraState().CFrame.LookVector;

        if not (v109.X ~= v109.X or (v109.Y ~= v109.Y or v109.X == (1 / 0)) or v109.Y == (1 / 0) or (LookVector.X ~= LookVector.X or (LookVector.Y ~= LookVector.Y or (LookVector.Z ~= LookVector.Z or (LookVector.X == (1 / 0) or LookVector.Y == (1 / 0)))) or LookVector.Z == (1 / 0) or LookVector.Magnitude <= 0)) then
            if Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming then
                LookVector = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
            end;

            local Unit = LookVector:Cross(Vector3.new(0, 1, 0)).Unit;
            Humanoid:Move(LookVector * v109.Y + Unit * v109.X);

            if RotationAction:GetState() then
                Humanoid.AutoRotate = false;

                if Humanoid.SeatPart == nil and (Humanoid.RootPart ~= nil and not (Humanoid.Sit or Humanoid.RootPart:IsGrounded())) then
                    Humanoid.RootPart.CFrame = CFrame.new(Humanoid.RootPart.CFrame.Position, Humanoid.RootPart.CFrame.Position + LookVector);
                end;
            else
                Humanoid.AutoRotate = true;
            end;
        end;

        local v110;

        if JumpAction == nil then
            v110 = false;
        else
            v110 = JumpAction:GetState();
        end;

        Humanoid.Jump = v110;
    end;
end;

if RunService:IsClient() then
    return u1.new();
end;

return u1;