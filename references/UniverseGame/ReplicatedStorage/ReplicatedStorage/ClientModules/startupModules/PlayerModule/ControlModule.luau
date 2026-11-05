  

 

local u1 = {};
u1.__index = u1;
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Workspace = game:GetService("Workspace");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
local Keyboard = require(script:WaitForChild("Keyboard"));
local Gamepad = require(script:WaitForChild("Gamepad"));
local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"));
local success, result = pcall(function() -- Line: 29
    return UserSettings():IsUserFeatureEnabled("UserMakeThumbstickDynamic");
end);
local u2 = success and result and DynamicThumbstick and DynamicThumbstick or require(script:WaitForChild("TouchThumbstick"));
local success2, result2 = pcall(function() -- Line: 38
    return UserSettings():IsUserFeatureEnabled("UserFixExternalJumpRequest2");
end);
local u3 = success2 and result2;
local success3, result3 = pcall(function() -- Line: 45
    return UserSettings():IsUserFeatureEnabled("UserFixModalEnabled");
end);
local u4 = success3 and result3;
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"));
local TouchJump = require(script:WaitForChild("TouchJump"));
local VehicleController = require(script:WaitForChild("VehicleController"));
local Value = Enum.ContextActionPriority.Default.Value;
local u5 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbstick] = u2,
    [Enum.DevTouchMovementMode.Thumbstick] = u2,
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
local u6 = {
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
local u7 = nil;

function u1.new() -- Line: 100
    -- upvalues: u1 (copy), Players (copy), VehicleController (copy), Value (copy), RunService (copy), UserInputService (copy), UserGameSettings (copy), u4 (ref)
    local u8 = setmetatable({}, u1);
    u8.controllers = {};
    u8.activeControlModule = nil;
    u8.activeController = nil;
    u8.touchJumpController = nil;
    u8.moveFunction = Players.LocalPlayer.Move;
    u8.humanoid = nil;
    u8.lastInputType = Enum.UserInputType.None;
    u8.humanoidSeatedConn = nil;
    u8.vehicleController = nil;
    u8.touchControlFrame = nil;
    u8.vehicleController = VehicleController.new(Value);
    Players.LocalPlayer.CharacterAdded:Connect(function(p9) -- Line: 122
        -- upvalues: u8 (copy)
        u8:OnCharacterAdded(p9);
    end);
    Players.LocalPlayer.CharacterRemoving:Connect(function(p10) -- Line: 123
        -- upvalues: u8 (copy)
        u8:OnCharacterRemoving(p10);
    end);

    if Players.LocalPlayer.Character then
        u8:OnCharacterAdded(Players.LocalPlayer.Character);
    end;

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p11) -- Line: 128
        -- upvalues: u8 (copy)
        u8:OnRenderStepped(p11);
    end);
    UserInputService.LastInputTypeChanged:Connect(function(p12) -- Line: 132
        -- upvalues: u8 (copy)
        u8:OnLastInputTypeChanged(p12);
    end);
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- Line: 137
        -- upvalues: u8 (copy)
        u8:OnTouchMovementModeChange();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- Line: 140
        -- upvalues: u8 (copy)
        u8:OnTouchMovementModeChange();
    end);
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- Line: 144
        -- upvalues: u8 (copy)
        u8:OnComputerMovementModeChange();
    end);
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 147
        -- upvalues: u8 (copy)
        u8:OnComputerMovementModeChange();
    end);
    u8.playerGui = nil;
    u8.touchGui = nil;
    u8.playerGuiAddedConn = nil;

    if u4 then
        UserInputService:GetPropertyChangedSignal("ModalEnabled"):Connect(function() -- Line: 157
            -- upvalues: u8 (copy)
            u8:UpdateTouchGuiVisibility();
        end);
    end;

    if not UserInputService.TouchEnabled then
        u8:OnLastInputTypeChanged(UserInputService:GetLastInputType());

        return u8;
    end;

    u8.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if not u8.playerGui then
        u8.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p13) -- Line: 168
            -- upvalues: u8 (copy), UserInputService (ref)
            if p13:IsA("PlayerGui") then
                u8.playerGui = p13;
                u8:CreateTouchGuiContainer();
                u8.playerGuiAddedConn:Disconnect();
                u8.playerGuiAddedConn = nil;
                u8:OnLastInputTypeChanged(UserInputService:GetLastInputType());
            end;
        end);

        return u8;
    end;

    u8:CreateTouchGuiContainer();
    u8:OnLastInputTypeChanged(UserInputService:GetLastInputType());

    return u8;
end;

function u1.GetMoveVector(p14) -- Line: 188
    return not p14.activeController and Vector3.new(0, 0, 0) or p14.activeController:GetMoveVector();
end;

function u1.GetActiveController(p15) -- Line: 195
    return p15.activeController;
end;

function u1.EnableActiveControlModule(p16) -- Line: 199
    -- upvalues: ClickToMoveController (copy), Players (copy)
    if p16.activeControlModule == ClickToMoveController then
        p16.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p16.touchJumpController);

        return;
    end;

    if p16.touchControlFrame then
        p16.activeController:Enable(true, p16.touchControlFrame);

        return;
    end;

    p16.activeController:Enable(true);
end;

function u1.Enable(p17, p18) -- Line: 215
    if not p17.activeController then
        return;
    end;

    if p18 == nil and true or p18 then
        p17:EnableActiveControlModule();

        return;
    end;

    p17:Disable();
end;

function u1.Disable(p19) -- Line: 231
    -- upvalues: Players (copy)
    if p19.activeController then
        p19.activeController:Enable(false);

        if p19.moveFunction then
            p19.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true);
        end;
    end;
end;

function u1.SelectComputerMovementModule(p20) -- Line: 243
    -- upvalues: UserInputService (copy), Players (copy), u6 (copy), u7 (ref), UserGameSettings (copy), Keyboard (copy), ClickToMoveController (copy), u5 (copy)
    if not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled) then
        return nil, false;
    end;

    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode;
    local v21;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        v21 = u6[u7];

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v21 == Keyboard then
            v21 = ClickToMoveController;
        end;
    else
        v21 = u5[DevComputerMovementMode];

        if not v21 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode);
        end;
    end;

    if v21 then
        return v21, true;
    end;

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true;
    end;

    return nil, false;
end;

function u1.SelectTouchModule(p22) -- Line: 281
    -- upvalues: UserInputService (copy), Players (copy), u5 (copy), UserGameSettings (copy)
    if not UserInputService.TouchEnabled then
        return nil, false;
    end;

    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode;
    local v23;

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v23 = u5[UserGameSettings.TouchMovementMode];
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true;
        end;

        v23 = u5[DevTouchMovementMode];
    end;

    return v23, true;
end;

local function calculateRawMoveVector(p24, p25) -- Line: 297
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera;

    if not CurrentCamera then
        return p25;
    end;

    if p24:GetState() == Enum.HumanoidStateType.Swimming then
        return CurrentCamera.CFrame:VectorToWorldSpace(p25);
    end;

    local _, _, _, v26, v27, v28, _, _, v29, _, _, v26 = CurrentCamera.CFrame:GetComponents();

    if v29 >= 1 or v29 <= -1 then
        v28 = -v27 * math.sign(v29);
    end;

    local v30 = math.sqrt(v26 * v26 + v28 * v28);

    return Vector3.new((v26 * p25.x + v28 * p25.z) / v30, 0, (v26 * p25.z - v28 * p25.x) / v30);
end;

function u1.OnRenderStepped(p31, p32) -- Line: 327
    -- upvalues: Gamepad (copy), calculateRawMoveVector (copy), Players (copy), u3 (ref)
    if p31.activeController and (p31.activeController.enabled and p31.humanoid) then
        p31.activeController:OnRenderStepped(p32);
        local v33 = p31.activeController:GetMoveVector();
        local v34 = p31.activeController:IsMoveVectorCameraRelative();
        local v35 = p31:GetClickToMoveController();

        if p31.activeController ~= v35 then
            if v33.magnitude > 0 then
                v35:CleanupPath();
            else
                v35:OnRenderStepped(p32);
                v33 = v35:GetMoveVector();
                v34 = v35:IsMoveVectorCameraRelative();
            end;
        end;

        if p31.vehicleController then
            local v36;
            v33, v36 = p31.vehicleController:Update(v33, v34, p31.activeControlModule == Gamepad);
        end;

        if v34 then
            v33 = calculateRawMoveVector(p31.humanoid, v33);
        end;

        p31.moveFunction(Players.LocalPlayer, v33, false);

        if u3 then
            if p31.activeController:GetIsJumping() or p31.touchJumpController and p31.touchJumpController:GetIsJumping() then
                p31.humanoid.Jump = true;
            end;
        else
            local humanoid = p31.humanoid;
            local v37 = p31.activeController:GetIsJumping() or p31.touchJumpController and p31.touchJumpController:GetIsJumping();
            humanoid.Jump = v37;
        end;
    end;
end;

function u1.OnHumanoidSeated(p38, p39, p40) -- Line: 376
    -- upvalues: Value (copy)
    if p39 then
        if p40 and p40:IsA("VehicleSeat") then
            if not p38.vehicleController then
                p38.vehicleController = p38.vehicleController.new(Value);
            end;

            p38.vehicleController:Enable(true, p40);
        end;
    elseif p38.vehicleController then
        p38.vehicleController:Enable(false, p40);
    end;
end;

function u1.OnCharacterAdded(u41, p42) -- Line: 391
    -- upvalues: u4 (ref)
    u41.humanoid = p42:FindFirstChildOfClass("Humanoid");

    while not u41.humanoid do
        p42.ChildAdded:wait();
        u41.humanoid = p42:FindFirstChildOfClass("Humanoid");
    end;

    if u4 then
        u41:UpdateTouchGuiVisibility();
    elseif u41.touchGui then
        u41.touchGui.Enabled = true;
    end;

    if u41.humanoidSeatedConn then
        u41.humanoidSeatedConn:Disconnect();
        u41.humanoidSeatedConn = nil;
    end;

    u41.humanoidSeatedConn = u41.humanoid.Seated:Connect(function(p43, p44) -- Line: 410
        -- upvalues: u41 (copy)
        u41:OnHumanoidSeated(p43, p44);
    end);
end;

function u1.OnCharacterRemoving(p45, p46) -- Line: 415
    -- upvalues: u4 (ref)
    p45.humanoid = nil;

    if u4 then
        p45:UpdateTouchGuiVisibility();

        return;
    end;

    if p45.touchGui then
        p45.touchGui.Enabled = false;
    end;
end;

function u1.UpdateTouchGuiVisibility(p47) -- Line: 427
    -- upvalues: UserInputService (copy)
    if p47.touchGui then
        p47.touchGui.Enabled = p47.humanoid and not UserInputService.ModalEnabled and true or false;
    end;
end;

function u1.SwitchToController(p48, p49) -- Line: 438
    -- upvalues: Value (copy), ClickToMoveController (copy), u2 (copy), DynamicThumbstick (copy), TouchJump (copy)
    if p49 then
        if not p48.controllers[p49] then
            p48.controllers[p49] = p49.new(Value);
        end;

        if p48.activeController ~= p48.controllers[p49] then
            if p48.activeController then
                p48.activeController:Enable(false);
            end;

            p48.activeController = p48.controllers[p49];
            p48.activeControlModule = p49;

            if p48.touchControlFrame and (p48.activeControlModule == ClickToMoveController or (p48.activeControlModule == u2 or p48.activeControlModule == DynamicThumbstick)) then
                if not p48.controllers[TouchJump] then
                    p48.controllers[TouchJump] = TouchJump.new();
                end;

                p48.touchJumpController = p48.controllers[TouchJump];
                p48.touchJumpController:Enable(true, p48.touchControlFrame);
            elseif p48.touchJumpController then
                p48.touchJumpController:Enable(false);
            end;

            p48:EnableActiveControlModule();
        end;

        return;
    end;

    if p48.activeController then
        p48.activeController:Enable(false);
    end;

    p48.activeController = nil;
    p48.activeControlModule = nil;
end;

function u1.OnLastInputTypeChanged(p50, p51) -- Line: 476
    -- upvalues: u7 (ref), u6 (copy), u4 (ref)
    if u7 == p51 then
        warn("LastInputType Change listener called with current type.");
    end;

    u7 = p51;

    if u7 == Enum.UserInputType.Touch then
        local v52, v53 = p50:SelectTouchModule();

        if v53 then
            while not p50.touchControlFrame do
                wait();
            end;

            p50:SwitchToController(v52);
        end;
    elseif u6[u7] ~= nil then
        local v54 = p50:SelectComputerMovementModule();

        if v54 then
            p50:SwitchToController(v54);
        end;
    end;

    if u4 then
        p50:UpdateTouchGuiVisibility();
    end;
end;

function u1.OnComputerMovementModeChange(p55) -- Line: 505
    local v56, v57 = p55:SelectComputerMovementModule();

    if v57 then
        p55:SwitchToController(v56);
    end;
end;

function u1.OnTouchMovementModeChange(p58) -- Line: 512
    local v59, v60 = p58:SelectTouchModule();

    if v60 then
        while not p58.touchControlFrame do
            wait();
        end;

        p58:SwitchToController(v59);
    end;
end;

function u1.CreateTouchGuiContainer(p61) -- Line: 522
    -- upvalues: u4 (ref)
    if p61.touchGui then
        p61.touchGui:Destroy();
    end;

    p61.touchGui = Instance.new("ScreenGui");
    p61.touchGui.Name = "TouchGui";
    p61.touchGui.ResetOnSpawn = false;
    p61.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    if u4 then
        p61:UpdateTouchGuiVisibility();
    else
        p61.touchGui.Enabled = p61.humanoid ~= nil;
    end;

    p61.touchControlFrame = Instance.new("Frame");
    p61.touchControlFrame.Name = "TouchControlFrame";
    p61.touchControlFrame.Size = UDim2.new(1, 0, 1, 0);
    p61.touchControlFrame.BackgroundTransparency = 1;
    p61.touchControlFrame.Parent = p61.touchGui;
    p61.touchGui.Parent = p61.playerGui;
end;

function u1.GetClickToMoveController(p62) -- Line: 545
    -- upvalues: ClickToMoveController (copy), Value (copy)
    if not p62.controllers[ClickToMoveController] then
        p62.controllers[ClickToMoveController] = ClickToMoveController.new(Value);
    end;

    return p62.controllers[ClickToMoveController];
end;

return u1.new();