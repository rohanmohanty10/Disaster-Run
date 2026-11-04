 

 

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Workspace = game:GetService("Workspace");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local VRService = game:GetService("VRService");
local Keyboard = require(script:WaitForChild("Keyboard"));
local Gamepad = require(script:WaitForChild("Gamepad"));
local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"));
local success, result = pcall(function() -- Line: 32
    return UserSettings():IsUserFeatureEnabled("UserHideControlsWhenMenuOpen");
end);
local u2 = success and result;
local success2, result2 = pcall(function() -- Line: 39
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate");
end);
local u3 = success2 and result2;
local TouchThumbstick = require(script:WaitForChild("TouchThumbstick"));
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"));
local TouchJump = require(script:WaitForChild("TouchJump"));
local VehicleController = require(script:WaitForChild("VehicleController"));
local Value = Enum.ContextActionPriority.Medium.Value;
local u4 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = DynamicThumbstick,
    [Enum.ComputerMovementMode.Default] = Keyboard,
    [Enum.ComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController
};
local u5 = {
    [Enum.UserInputType.Keyboard] = Keyboard,
    [Enum.UserInputType.MouseButton1] = Keyboard,
    [Enum.UserInputType.MouseButton2] = Keyboard,
    [Enum.UserInputType.MouseButton3] = Keyboard,
    [Enum.UserInputType.MouseWheel] = Keyboard,
    [Enum.UserInputType.MouseMovement] = Keyboard,
    [Enum.UserInputType.Gamepad1] = Gamepad,
    [Enum.UserInputType.Gamepad2] = Gamepad,
    [Enum.UserInputType.Gamepad3] = Gamepad,
    [Enum.UserInputType.Gamepad4] = Gamepad
};
local u6 = nil;

function u1.new() -- Line: 96
    -- upvalues: u1 (copy), Players (copy), u2 (ref), GuiService (copy), VehicleController (copy), Value (copy), RunService (copy), UserInputService (copy), UserGameSettings (copy)
    local u7 = setmetatable({}, u1);
    u7.controllers = {};
    u7.activeControlModule = nil;
    u7.activeController = nil;
    u7.touchJumpController = nil;
    u7.moveFunction = Players.LocalPlayer.Move;
    u7.humanoid = nil;
    u7.lastInputType = Enum.UserInputType.None;
    u7.controlsEnabled = true;
    u7.humanoidSeatedConn = nil;
    u7.vehicleController = nil;
    u7.touchControlFrame = nil;
    u7.currentTorsoAngle = 0;

    if u2 then
        GuiService.MenuOpened:Connect(function() -- Line: 119
            -- upvalues: u7 (copy)
            if u7.touchControlFrame and u7.touchControlFrame.Visible then
                u7.touchControlFrame.Visible = false;
            end;
        end);
        GuiService.MenuClosed:Connect(function() -- Line: 125
            -- upvalues: u7 (copy)
            if u7.touchControlFrame then
                u7.touchControlFrame.Visible = true;
            end;
        end);
    end;

    u7.vehicleController = VehicleController.new(Value);
    Players.LocalPlayer.CharacterAdded:Connect(function(p8) -- Line: 134
        -- upvalues: u7 (copy)
        u7:OnCharacterAdded(p8);
    end);
    Players.LocalPlayer.CharacterRemoving:Connect(function(p9) -- Line: 135
        -- upvalues: u7 (copy)
        u7:OnCharacterRemoving(p9);
    end);

    if Players.LocalPlayer.Character then
        u7:OnCharacterAdded(Players.LocalPlayer.Character);
    end;

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p10) -- Line: 140
        -- upvalues: u7 (copy)
        u7:OnRenderStepped(p10);
    end);
    UserInputService.LastInputTypeChanged:Connect(function(p11) -- Line: 144
        -- upvalues: u7 (copy)
        u7:OnLastInputTypeChanged(p11);
    end);
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 149
        -- upvalues: u7 (copy)
        u7:OnTouchMovementModeChange();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 152
        -- upvalues: u7 (copy)
        u7:OnTouchMovementModeChange();
    end);
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- Line: 156
        -- upvalues: u7 (copy)
        u7:OnComputerMovementModeChange();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 159
        -- upvalues: u7 (copy)
        u7:OnComputerMovementModeChange();
    end);
    u7.playerGui = nil;
    u7.touchGui = nil;
    u7.playerGuiAddedConn = nil;
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- Line: 168
        -- upvalues: u7 (copy)
        u7:UpdateTouchGuiVisibility();
        u7:UpdateActiveControlModuleEnabled();
    end);

    if not UserInputService.TouchEnabled then
        u7:OnLastInputTypeChanged(UserInputService:GetLastInputType());

        return u7;
    end;

    u7.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u7.playerGui then
        u7.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p12) -- Line: 179
            -- upvalues: u7 (copy), UserInputService (ref)
            if p12:IsA("PlayerGui") then
                u7.playerGui = p12;
                u7:CreateTouchGuiContainer();
                u7.playerGuiAddedConn:Disconnect();
                u7.playerGuiAddedConn = nil;
                u7:OnLastInputTypeChanged(UserInputService:GetLastInputType());
            end;
        end);

        return u7;
    end;

    u7:CreateTouchGuiContainer();
    u7:OnLastInputTypeChanged(UserInputService:GetLastInputType());

    return u7;
end;

function u1.GetMoveVector(p13) -- Line: 199
    return not p13.activeController and Vector3.new(0, 0, 0) or p13.activeController:GetMoveVector();
end;

local function NormalizeAngle(p14) -- Line: 206
    local v15 = (p14 + 12.566370614359172) % 6.283185307179586;

    if v15 > 3.141592653589793 then
        v15 = v15 - 6.283185307179586;
    end;

    return v15;
end;

local function AverageAngle(p16, p17) -- Line: 214
    local v18 = (p17 - p16 + 12.566370614359172) % 6.283185307179586;

    if v18 > 3.141592653589793 then
        v18 = v18 - 6.283185307179586;
    end;

    local v19 = (p16 + v18 / 2 + 12.566370614359172) % 6.283185307179586;

    if v19 > 3.141592653589793 then
        v19 = v19 - 6.283185307179586;
    end;

    return v19;
end;

function u1.GetEstimatedVRTorsoFrame(p20) -- Line: 219
    -- upvalues: VRService (copy)
    local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head);
    local _, v21, _ = UserCFrame:ToEulerAnglesYXZ();
    local v22 = -v21;

    if VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local UserCFrame2 = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand);
        local UserCFrame3 = VRService:GetUserCFrame(Enum.UserCFrame.RightHand);
        local v23 = UserCFrame.Position - UserCFrame2.Position;
        local v24 = UserCFrame.Position - UserCFrame3.Position;
        local v25 = -math.atan2(v23.X, v23.Z);
        local v26 = (-math.atan2(v24.X, v24.Z) - v25 + 12.566370614359172) % 6.283185307179586;

        if v26 > 3.141592653589793 then
            v26 = v26 - 6.283185307179586;
        end;

        local v27 = (v25 + v26 / 2 + 12.566370614359172) % 6.283185307179586;

        if v27 > 3.141592653589793 then
            v27 = v27 - 6.283185307179586;
        end;

        local v28 = (v22 - p20.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v28 > 3.141592653589793 then
            v28 = v28 - 6.283185307179586;
        end;

        local v29 = (v27 - p20.currentTorsoAngle + 12.566370614359172) % 6.283185307179586;

        if v29 > 3.141592653589793 then
            v29 = v29 - 6.283185307179586;
        end;

        local v30;

        if v29 > -1.5707963267948966 then
            v30 = v29 < 1.5707963267948966;
        else
            v30 = false;
        end;

        if not v30 then
            v29 = v28;
        end;

        local math_min_ret = math.min(v29, v28);
        local math_max_ret = math.max(v29, v28);
        local v31 = 0;

        if math_min_ret > 0 then
            math_max_ret = math_min_ret;
        elseif math_max_ret >= 0 then
            math_max_ret = v31;
        end;

        p20.currentTorsoAngle = math_max_ret + p20.currentTorsoAngle;
    else
        p20.currentTorsoAngle = v22;
    end;

    return CFrame.new(UserCFrame.Position) * CFrame.fromEulerAnglesYXZ(0, -p20.currentTorsoAngle, 0);
end;

function u1.GetActiveController(p32) -- Line: 263
    return p32.activeController;
end;

function u1.UpdateActiveControlModuleEnabled(u33) -- Line: 268
    -- upvalues: Players (copy), ClickToMoveController (copy), GuiService (copy), UserInputService (copy), TouchThumbstick (copy), DynamicThumbstick (copy)
    local function _() -- Line: 270
        -- upvalues: u33 (copy), Players (ref)
        u33.activeController:Enable(false);

        if u33.moveFunction then
            u33.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;

    local function v34() -- Line: 278
        -- upvalues: u33 (copy), ClickToMoveController (ref), Players (ref)
        if u33.activeControlModule == ClickToMoveController then
            u33.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, u33.touchJumpController);

            return;
        end;

        if u33.touchControlFrame then
            u33.activeController:Enable(true, u33.touchControlFrame);

            return;
        end;

        u33.activeController:Enable(true);
    end;

    if not u33.activeController then
        return;
    end;

    if not u33.controlsEnabled then
        u33.activeController:Enable(false);

        if u33.moveFunction then
            u33.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;

        return;
    end;

    if GuiService.TouchControlsEnabled or not (UserInputService.TouchEnabled and (u33.activeControlModule == ClickToMoveController or (u33.activeControlModule == TouchThumbstick or u33.activeControlModule == DynamicThumbstick))) then
        v34();

        return;
    end;

    u33.activeController:Enable(false);

    if u33.moveFunction then
        u33.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
    end;
end;

function u1.Enable(p35: table, p36: boolean?) -- Line: 318
    p35.controlsEnabled = p36 == nil and true or p36;

    if not p35.activeController then
        return;
    end;

    p35:UpdateActiveControlModuleEnabled();
end;

function u1.Disable(p37) -- Line: 332
    p37.controlsEnabled = false;
    p37:UpdateActiveControlModuleEnabled();
end;

function u1.SelectComputerMovementModule(p38) -- Line: 340
    -- upvalues: UserInputService (copy), Players (copy), u5 (copy), u6 (ref), UserGameSettings (copy), Keyboard (copy), ClickToMoveController (copy), u4 (copy)
    if not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled) then
        return nil, false;
    end;

    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode;
    local v39;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        v39 = u5[u6];

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v39 == Keyboard then
            v39 = ClickToMoveController;
        end;
    else
        v39 = u4[DevComputerMovementMode];

        if not v39 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode);
        end;
    end;

    if v39 then
        return v39, true;
    end;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true;
    end;

    return nil, false;
end;

function u1.SelectTouchModule(p40) -- Line: 378
    -- upvalues: UserInputService (copy), Players (copy), u4 (copy), UserGameSettings (copy)
    if not UserInputService.TouchEnabled then
        return nil, false;
    end;

    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode;
    local v41;

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v41 = u4[UserGameSettings.TouchMovementMode];
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;

        v41 = u4[DevTouchMovementMode];
    end;

    return v41, true;
end;

local function getGamepadRightThumbstickPosition() -- Line: 394
    -- upvalues: UserInputService (copy)
    local GamepadState = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1);

    for _, v in pairs(GamepadState) do
        if v.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v.Position;
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

function u1.calculateRawMoveVector(p42: table, p43: userdata, p44: vector) -- Line: 404
    -- upvalues: Workspace (copy), VRService (copy), getGamepadRightThumbstickPosition (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p44;
    end;

    local CFrame2 = CurrentCamera.CFrame;

    if VRService.VREnabled and p43.RootPart then
        VRService:GetUserCFrame(Enum.UserCFrame.Head);
        local EstimatedVRTorsoFrame = p42:GetEstimatedVRTorsoFrame();

        if (CurrentCamera.Focus.Position - CFrame2.Position).Magnitude < 3 then
            CFrame2 = CFrame2 * EstimatedVRTorsoFrame;
        else
            CFrame2 = CurrentCamera.CFrame * (EstimatedVRTorsoFrame.Rotation + EstimatedVRTorsoFrame.Position * CurrentCamera.HeadScale);
        end;
    end;

    if p43:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v45, v46, v47, _, _, v48, _, _, v45 = CFrame2:GetComponents();

        if v48 >= 1 or v48 <= -1 then
            v47 = -v46 * math.sign(v48);
        end;

        local math_sqrt_ret = math.sqrt(v45 * v45 + v47 * v47);

        return Vector3.new((v45 * p44.X + v47 * p44.Z) / math_sqrt_ret, 0, (v45 * p44.Z - v47 * p44.X) / math_sqrt_ret);
    end;

    if not VRService.VREnabled then
        return CFrame2:VectorToWorldSpace(p44);
    end;

    local Vector3_new_ret = Vector3.new(p44.X, 0, p44.Z);

    if Vector3_new_ret.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0);
    end;

    local v49 = -getGamepadRightThumbstickPosition().Y * 1.3962634015954636;
    local math_atan2_ret = math.atan2(-Vector3_new_ret.X, -Vector3_new_ret.Z);
    local _, v50, _ = CFrame2:ToEulerAnglesYXZ();

    return CFrame.fromEulerAnglesYXZ(v49, math_atan2_ret + v50, 0).LookVector;
end;

function u1.OnRenderStepped(p51, p52) -- Line: 463
    -- upvalues: Gamepad (copy), Players (copy)
    if p51.activeController and (p51.activeController.enabled and p51.humanoid) then
        p51.activeController:OnRenderStepped(p52);
        local MoveVector = p51.activeController:GetMoveVector();
        local v53 = p51.activeController:IsMoveVectorCameraRelative();
        local ClickToMoveController2 = p51:GetClickToMoveController();

        if p51.activeController ~= ClickToMoveController2 then
            if MoveVector.magnitude > 0 then
                ClickToMoveController2:CleanupPath();
            else
                ClickToMoveController2:OnRenderStepped(p52);
                MoveVector = ClickToMoveController2:GetMoveVector();
                v53 = ClickToMoveController2:IsMoveVectorCameraRelative();
            end;
        end;

        if p51.vehicleController then
            local v54;
            MoveVector, v54 = p51.vehicleController:Update(MoveVector, v53, p51.activeControlModule == Gamepad);
        end;

        shared.moveVector = MoveVector;

        if v53 then
            MoveVector = p51:calculateRawMoveVector(p51.humanoid, MoveVector);
        end;

        p51.moveFunction(Players.LocalPlayer, MoveVector, false);
        local IsJumping = p51.activeController:GetIsJumping();

        if not IsJumping then
            if p51.touchJumpController then
                IsJumping = p51.touchJumpController:GetIsJumping() or false;
            else
                IsJumping = false;
            end;
        end;

        if p51.humanoid.JumpPower <= 0 then
            p51.jumpLockLatched = IsJumping;
            p51.humanoid.Jump = false;

            return;
        end;

        p51.jumpLockLatched = false;
        p51.humanoid.Jump = IsJumping;
    end;
end;

function u1.OnHumanoidSeated(p55: table, p56: boolean, p57: userdata) -- Line: 517
    -- upvalues: Value (copy)
    if p56 then
        if p57 and p57:IsA("VehicleSeat") then
            if not p55.vehicleController then
                p55.vehicleController = p55.vehicleController.new(Value);
            end;

            p55.vehicleController:Enable(true, p57);
        end;
    elseif p55.vehicleController then
        p55.vehicleController:Enable(false, p57);
    end;
end;

function u1.OnCharacterAdded(u58, p59) -- Line: 532
    u58.humanoid = p59:FindFirstChildOfClass("Humanoid");

    while not u58.humanoid do
        p59.ChildAdded:wait();
        u58.humanoid = p59:FindFirstChildOfClass("Humanoid");
    end;

    u58:UpdateTouchGuiVisibility();

    if u58.humanoidSeatedConn then
        u58.humanoidSeatedConn:Disconnect();
        u58.humanoidSeatedConn = nil;
    end;

    u58.humanoidSeatedConn = u58.humanoid.Seated:Connect(function(p60, p61) -- Line: 545
        -- upvalues: u58 (copy)
        u58:OnHumanoidSeated(p60, p61);
    end);
end;

function u1.OnCharacterRemoving(p62, p63) -- Line: 550
    p62.humanoid = nil;
    p62:UpdateTouchGuiVisibility();
end;

function u1.UpdateTouchGuiVisibility(p64) -- Line: 556
    -- upvalues: GuiService (copy)
    if p64.touchGui then
        p64.touchGui.Enabled = p64.humanoid and GuiService.TouchControlsEnabled and true or false;
    end;
end;

function u1.SwitchToController(p65, p66) -- Line: 570
    -- upvalues: Value (copy), ClickToMoveController (copy), TouchThumbstick (copy), DynamicThumbstick (copy), TouchJump (copy)
    if p66 then
        if not p65.controllers[p66] then
            p65.controllers[p66] = p66.new(Value);
        end;

        if p65.activeController ~= p65.controllers[p66] then
            if p65.activeController then
                p65.activeController:Enable(false);
            end;

            p65.activeController = p65.controllers[p66];
            p65.activeControlModule = p66;

            if p65.touchControlFrame and (p65.activeControlModule == ClickToMoveController or (p65.activeControlModule == TouchThumbstick or p65.activeControlModule == DynamicThumbstick)) then
                if not p65.controllers[TouchJump] then
                    p65.controllers[TouchJump] = TouchJump.new();
                end;

                p65.touchJumpController = p65.controllers[TouchJump];
                p65.touchJumpController:Enable(true, p65.touchControlFrame);
            elseif p65.touchJumpController then
                p65.touchJumpController:Enable(false);
            end;

            p65:UpdateActiveControlModuleEnabled();
        end;

        return;
    end;

    if p65.activeController then
        p65.activeController:Enable(false);
    end;

    p65.activeController = nil;
    p65.activeControlModule = nil;
end;

function u1.OnLastInputTypeChanged(p67, p68) -- Line: 612
    -- upvalues: u6 (ref), u5 (copy)
    if u6 == p68 then
        warn("LastInputType Change listener called with current type.");
    end;

    u6 = p68;

    if u6 == Enum.UserInputType.Touch then
        local v69, v70 = p67:SelectTouchModule();

        if v70 then
            while not p67.touchControlFrame do
                wait();
            end;

            p67:SwitchToController(v69);
        end;
    elseif u5[u6] ~= nil then
        local v71 = p67:SelectComputerMovementModule();

        if v71 then
            p67:SwitchToController(v71);
        end;
    end;

    p67:UpdateTouchGuiVisibility();
end;

function u1.OnComputerMovementModeChange(p72) -- Line: 639
    local v73, v74 = p72:SelectComputerMovementModule();

    if v74 then
        p72:SwitchToController(v73);
    end;
end;

function u1.OnTouchMovementModeChange(p75) -- Line: 646
    local v76, v77 = p75:SelectTouchModule();

    if v77 then
        while not p75.touchControlFrame do
            wait();
        end;

        p75:SwitchToController(v76);
    end;
end;

function u1.CreateTouchGuiContainer(p78) -- Line: 656
    -- upvalues: u3 (ref)
    if p78.touchGui then
        p78.touchGui:Destroy();
    end;

    p78.touchGui = Instance.new("ScreenGui");
    p78.touchGui.Name = "TouchGui";
    p78.touchGui.ResetOnSpawn = false;
    p78.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    p78:UpdateTouchGuiVisibility();

    if u3 then
        p78.touchGui.ClipToDeviceSafeArea = false;
    end;

    p78.touchControlFrame = Instance.new("Frame");
    p78.touchControlFrame.Name = "TouchControlFrame";
    p78.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p78.touchControlFrame.BackgroundTransparency = 1;
    p78.touchControlFrame.Parent = p78.touchGui;
    p78.touchGui.Parent = p78.playerGui;
end;

function u1.GetClickToMoveController(p79) -- Line: 679
    -- upvalues: ClickToMoveController (copy), Value (copy)
    if not p79.controllers[ClickToMoveController] then
        p79.controllers[ClickToMoveController] = ClickToMoveController.new(Value);
    end;

    return p79.controllers[ClickToMoveController];
end;

return u1.new();