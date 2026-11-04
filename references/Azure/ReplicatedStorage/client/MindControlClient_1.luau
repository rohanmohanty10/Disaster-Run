 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u1 = false;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = false;
local u6 = nil;
local u7 = false;
local u8 = nil;
local u9 = {};

local function isTextInputActive() -- Line: 23
    -- upvalues: UserInputService (copy), GuiService (copy)
    return UserInputService:GetFocusedTextBox() and true or (GuiService.MenuIsOpen and true or false);
end;

local function getStarterPlayer() -- Line: 35
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    return u6.metatable;
end;

local function getTargetPlayer() -- Line: 43
    -- upvalues: u2 (ref), Players (copy)
    if u2 then
        return Players:GetPlayerByUserId(u2);
    end;

    return nil;
end;

local function getTargetCharacter() -- Line: 51
    -- upvalues: u2 (ref), Players (copy)
    local v10;

    if u2 then
        v10 = Players:GetPlayerByUserId(u2);
    else
        v10 = nil;
    end;

    if v10 then
        v10 = v10.Character;
    end;

    return v10;
end;

local function getMouseLockController() -- Line: 56
    -- upvalues: u6 (ref), ReplicatedStorage (copy)
    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;

    if not (metatable and metatable.playerModule) then
        return nil;
    end;

    local success, result = pcall(function() -- Line: 62
        -- upvalues: metatable (copy)
        return metatable.playerModule:GetCameras();
    end);

    if success and result then
        return result.activeMouseLockController;
    end;

    return nil;
end;

local function setShiftlockCharacter(p11: userdata?) -- Line: 72
    -- upvalues: u6 (ref), ReplicatedStorage (copy), LocalPlayer (copy)
    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;
    local v12;

    if metatable and metatable.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable (copy)
            return metatable.playerModule:GetCameras();
        end);

        if success and result then
            v12 = result.activeMouseLockController;
        else
            v12 = nil;
        end;
    else
        v12 = nil;
    end;

    if not v12 then
        return;
    end;

    if v12.SetCharacter then
        v12:SetCharacter(p11 or LocalPlayer.Character);
    end;

    if v12.RefreshRotationLock then
        v12:RefreshRotationLock();
    end;
end;

local function restoreShiftlock(p13: userdata?) -- Line: 87
    -- upvalues: LocalPlayer (copy), u6 (ref), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;
    local v14;

    if metatable and metatable.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable (copy)
            return metatable.playerModule:GetCameras();
        end);

        if success and result then
            v14 = result.activeMouseLockController;
        else
            v14 = nil;
        end;
    else
        v14 = nil;
    end;

    if v14 then
        if v14.SetCharacter then
            v14:SetCharacter(Character or LocalPlayer.Character);
        end;

        if v14.RefreshRotationLock then
            v14:RefreshRotationLock();
        end;
    end;

    if p13 then
        p13.PlatformStand = false;
    end;
end;

local function getRawMoveVector() -- Line: 95
    -- upvalues: UserInputService (copy), GuiService (copy)
    if UserInputService:GetFocusedTextBox() and true or (GuiService.MenuIsOpen and true or false) then
        return Vector3.new(0, 0, 0);
    end;

    local v15 = Vector3.new(0, 0, 0);

    if UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
        v15 = v15 - Vector3.new(0, 0, 1);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
        v15 = v15 + Vector3.new(0, 0, 1);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
        v15 = v15 - Vector3.new(1, 0, 0);
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
        v15 = v15 + Vector3.new(1, 0, 0);
    end;

    for _, v in UserInputService:GetConnectedGamepads() do
        local success, result = pcall(function() -- Line: 116
            -- upvalues: UserInputService (ref), v (copy)
            return UserInputService:GetGamepadState(v);
        end);

        if success and (result and (result.Thumbstick1 and result.Thumbstick1.Magnitude > 0.1)) then
            local Thumbstick1 = result.Thumbstick1;
            v15 = v15 + Vector3.new(Thumbstick1.X, 0, -Thumbstick1.Y);
        end;
    end;

    if v15.Magnitude > 1 then
        v15 = v15.Unit;
    end;

    return v15;
end;

local function getMoveVector() -- Line: 132
    -- upvalues: UserInputService (copy), GuiService (copy), getRawMoveVector (copy), u6 (ref), ReplicatedStorage (copy)
    if UserInputService:GetFocusedTextBox() and true or (GuiService.MenuIsOpen and true or false) then
        return Vector3.new(0, 0, 0);
    end;

    local v16 = getRawMoveVector();

    if v16.Magnitude > 0 then
        return v16;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;

    if metatable and metatable.playerModule then
        local success, result = pcall(function() -- Line: 145
            -- upvalues: metatable (copy)
            return metatable.playerModule:GetControls();
        end);

        if success and (result and result.GetMoveVector) then
            return result:GetMoveVector();
        end;
    end;

    return Vector3.new(0, 0, 0);
end;

local function isJumpDown() -- Line: 156
    -- upvalues: UserInputService (copy), GuiService (copy)
    if UserInputService:GetFocusedTextBox() and true or (GuiService.MenuIsOpen and true or false) then
        return false;
    end;

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        return true;
    end;

    for _, v in UserInputService:GetConnectedGamepads() do
        if UserInputService:IsGamepadButtonDown(v, Enum.KeyCode.ButtonA) then
            return true;
        end;
    end;

    return false;
end;

local function refreshControlState() -- Line: 174
    -- upvalues: u1 (ref), u2 (ref), Players (copy), u6 (ref), ReplicatedStorage (copy), LocalPlayer (copy), workspace_CurrentCamera (copy)
    if not u1 then
        return;
    end;

    local v17;

    if u2 then
        v17 = Players:GetPlayerByUserId(u2);
    else
        v17 = nil;
    end;

    if v17 then
        v17 = v17.Character;
    end;

    if not v17 then
        return;
    end;

    local v18 = v17:FindFirstChildOfClass("Humanoid");

    if not v18 then
        return;
    end;

    v18.PlatformStand = false;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;
    local v19;

    if metatable and metatable.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable (copy)
            return metatable.playerModule:GetCameras();
        end);

        if success and result then
            v19 = result.activeMouseLockController;
        else
            v19 = nil;
        end;
    else
        v19 = nil;
    end;

    if v19 then
        if v19.SetCharacter then
            v19:SetCharacter(v17 or LocalPlayer.Character);
        end;

        if v19.RefreshRotationLock then
            v19:RefreshRotationLock();
        end;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable2 = u6.metatable;
    local v20;

    if metatable2 and metatable2.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable2 (copy)
            return metatable2.playerModule:GetCameras();
        end);

        if success and result then
            v20 = result.activeMouseLockController;
        else
            v20 = nil;
        end;
    else
        v20 = nil;
    end;

    local v21 = v20 and v20.GetIsMouseLocked and v20:GetIsMouseLocked();

    if v21 then
        v18.AutoRotate = false;
    else
        v18.AutoRotate = true;
    end;

    local State = v18:GetState();

    if State == Enum.HumanoidStateType.Physics or (State == Enum.HumanoidStateType.Ragdoll or State == Enum.HumanoidStateType.FallingDown) then
        v18:ChangeState(Enum.HumanoidStateType.Running);
    end;

    if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then
        workspace_CurrentCamera.CameraSubject = v18;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable3 = u6.metatable;

    if metatable3 then
        metatable3:refreshMovement();
    end;
end;

local function ensureCameraHooks() -- Line: 220
    -- upvalues: u7 (ref), workspace_CurrentCamera (copy), u1 (ref), refreshControlState (copy)
    if u7 then
        return;
    end;

    u7 = true;
    workspace_CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 227
        -- upvalues: u1 (ref), workspace_CurrentCamera (ref), refreshControlState (ref)
        if u1 and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
            task.defer(refreshControlState);
        end;
    end);
end;

local function step() -- Line: 234
    -- upvalues: u2 (ref), Players (copy), u6 (ref), ReplicatedStorage (copy), UserInputService (copy), GuiService (copy), actionUtil (copy), getMoveVector (copy), isJumpDown (copy), u5 (ref), workspace_CurrentCamera (copy)
    local v22;

    if u2 then
        v22 = Players:GetPlayerByUserId(u2);
    else
        v22 = nil;
    end;

    if v22 then
        v22 = v22.Character;
    end;

    if not v22 then
        return;
    end;

    local v23 = v22:FindFirstChildOfClass("Humanoid");

    if not v23 then
        return;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;
    local v24 = metatable and metatable.baseClient and metatable.baseClient.moveactived;
    local v25 = v22:FindFirstChildWhichIsA("BodyVelocity", true) ~= nil and true or v22:FindFirstChildWhichIsA("LinearVelocity", true) ~= nil;
    v23.PlatformStand = false;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable2 = u6.metatable;
    local v26;

    if metatable2 and metatable2.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable2 (copy)
            return metatable2.playerModule:GetCameras();
        end);

        if success and result then
            v26 = result.activeMouseLockController;
        else
            v26 = nil;
        end;
    else
        v26 = nil;
    end;

    local v27 = v26 and v26.GetIsMouseLocked and v26:GetIsMouseLocked();

    if v27 then
        v23.AutoRotate = false;
    end;

    local State = v23:GetState();

    if not (v24 or (v25 or (v22:GetAttribute("Ragdolled") or State ~= Enum.HumanoidStateType.Physics and (State ~= Enum.HumanoidStateType.Ragdoll and State ~= Enum.HumanoidStateType.FallingDown)))) then
        v23:ChangeState(Enum.HumanoidStateType.Running);
    end;

    if v24 or v25 or (UserInputService:GetFocusedTextBox() or GuiService.MenuIsOpen) then
        v23:Move(Vector3.new(0, 0, 0), true);
    else
        local _walkjump, v28 = actionUtil.get_walkjump(v22);
        v23.WalkSpeed = _walkjump;
        v23.JumpPower = v28;
        local v29 = getMoveVector();
        v23:Move(Vector3.new(v29.X, 0, v29.Z), true);
    end;

    local v30 = isJumpDown();

    if v30 and not (u5 or v24) then
        v23.Jump = true;

        if metatable and metatable.baseClient then
            metatable.baseClient:use("jump");
        end;
    end;

    u5 = v30;

    if workspace_CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and workspace_CurrentCamera.CameraSubject ~= v23 then
        workspace_CurrentCamera.CameraSubject = v23;
    end;
end;

function u9.getActiveRoot() -- Line: 294
    -- upvalues: u1 (ref), u2 (ref), Players (copy)
    if not u1 then
        return nil;
    end;

    local v31;

    if u2 then
        v31 = Players:GetPlayerByUserId(u2);
    else
        v31 = nil;
    end;

    if v31 then
        v31 = v31.Character;
    end;

    if v31 then
        v31 = v31:FindFirstChild("HumanoidRootPart");
    end;

    if v31 and v31:IsA("BasePart") then
        return v31;
    end;

    return nil;
end;

function u9.isActive() -- Line: 308
    -- upvalues: u1 (ref)
    return u1;
end;

function u9.stop() -- Line: 312
    -- upvalues: u1 (ref), u2 (ref), Players (copy), u5 (ref), u8 (ref), u6 (ref), ReplicatedStorage (copy), LocalPlayer (copy), workspace_CurrentCamera (copy), u4 (ref), u3 (ref)
    if not u1 then
        return;
    end;

    local v32;

    if u2 then
        v32 = Players:GetPlayerByUserId(u2);
    else
        v32 = nil;
    end;

    if v32 then
        v32 = v32.Character;
    end;

    u1 = false;
    u2 = nil;
    u5 = false;

    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;

    if v32 then
        v32 = v32:FindFirstChildOfClass("Humanoid");
    end;

    if v32 then
        v32.PlatformStand = false;
        v32.AutoRotate = true;

        if v32:GetState() == Enum.HumanoidStateType.Physics then
            v32:ChangeState(Enum.HumanoidStateType.GettingUp);
        end;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;

    if metatable then
        metatable:clearMindControlPuppet();
    end;

    local Character = LocalPlayer.Character;
    local v33;

    if Character then
        v33 = Character:FindFirstChildOfClass("Humanoid");
    else
        v33 = Character;
    end;

    local v34;

    if Character then
        v34 = Character:FindFirstChild("HumanoidRootPart");
    else
        v34 = Character;
    end;

    if v34 and v34:IsA("BasePart") then
        v34.Anchored = false;
    end;

    if v33 then
        v33.PlatformStand = false;
        v33.AutoRotate = true;

        if v33:GetState() == Enum.HumanoidStateType.Physics then
            v33:ChangeState(Enum.HumanoidStateType.GettingUp);
        end;
    end;

    if metatable then
        metatable:setControlsEnabled(true);
        metatable:refreshMovement();
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable2 = u6.metatable;
    local v35;

    if metatable2 and metatable2.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable2 (copy)
            return metatable2.playerModule:GetCameras();
        end);

        if success and result then
            v35 = result.activeMouseLockController;
        else
            v35 = nil;
        end;
    else
        v35 = nil;
    end;

    if v35 then
        if v35.SetCharacter then
            v35:SetCharacter(Character or LocalPlayer.Character);
        end;

        if v35.RefreshRotationLock then
            v35:RefreshRotationLock();
        end;
    end;

    local Character2 = LocalPlayer.Character;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable3 = u6.metatable;
    local v36;

    if metatable3 and metatable3.playerModule then
        local success, result = pcall(function() -- Line: 62
            -- upvalues: metatable3 (copy)
            return metatable3.playerModule:GetCameras();
        end);

        if success and result then
            v36 = result.activeMouseLockController;
        else
            v36 = nil;
        end;
    else
        v36 = nil;
    end;

    if v36 then
        if v36.SetCharacter then
            v36:SetCharacter(Character2 or LocalPlayer.Character);
        end;

        if v36.RefreshRotationLock then
            v36:RefreshRotationLock();
        end;
    end;

    if v33 then
        v33.PlatformStand = false;
    end;

    workspace_CurrentCamera.CameraType = u4 or Enum.CameraType.Custom;

    if v33 then
        v33.PlatformStand = false;
        v33.AutoRotate = true;
        workspace_CurrentCamera.CameraSubject = v33;
    elseif u3 then
        workspace_CurrentCamera.CameraSubject = u3;
    end;

    u3 = nil;
    u4 = nil;
end;

function u9.start(p37: number) -- Line: 378
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u9 (copy), Players (copy), u6 (ref), ReplicatedStorage (copy), u7 (ref), workspace_CurrentCamera (copy), refreshControlState (copy), u4 (ref), u3 (ref), u8 (ref), RunService (copy), step (copy)
    if LocalPlayer:GetAttribute("ControllingUserId") ~= p37 then
        return;
    end;

    if u1 and u2 == p37 then
        return;
    end;

    u9.stop();
    local PlayerByUserId = Players:GetPlayerByUserId(p37);
    local v38;

    if PlayerByUserId then
        v38 = PlayerByUserId.Character;
    else
        v38 = PlayerByUserId;
    end;

    if not (PlayerByUserId and v38) then
        return;
    end;

    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;

    if not (metatable and metatable:applyMindControlPuppet(PlayerByUserId)) then
        return;
    end;

    local v39 = v38:FindFirstChildOfClass("Humanoid");

    if v39 then
        v39.PlatformStand = false;

        if v39:GetState() == Enum.HumanoidStateType.Physics or (v39:GetState() == Enum.HumanoidStateType.Ragdoll or v39:GetState() == Enum.HumanoidStateType.FallingDown) then
            v39:ChangeState(Enum.HumanoidStateType.Running);
        end;
    end;

    u1 = true;
    u2 = p37;

    if not u7 then
        u7 = true;
        workspace_CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 227
            -- upvalues: u1 (ref), workspace_CurrentCamera (ref), refreshControlState (ref)
            if u1 and workspace_CurrentCamera.CameraType == Enum.CameraType.Custom then
                task.defer(refreshControlState);
            end;
        end);
    end;

    u4 = workspace_CurrentCamera.CameraType;
    u3 = workspace_CurrentCamera.CameraSubject;
    workspace_CurrentCamera.CameraType = Enum.CameraType.Custom;

    if v39 then
        workspace_CurrentCamera.CameraSubject = v39;
    end;

    refreshControlState();

    if u8 then
        u8:Disconnect();
    end;

    u8 = RunService.RenderStepped:Connect(step);
end;

function u9.setLocked(p40: boolean) -- Line: 432
    -- upvalues: u6 (ref), ReplicatedStorage (copy), LocalPlayer (copy)
    if not u6 then
        u6 = require(ReplicatedStorage.client.starterPlayer);
    end;

    local metatable = u6.metatable;

    if not metatable then
        return;
    end;

    metatable:setControlsEnabled(not p40);

    if not p40 then
        local Character = LocalPlayer.Character;
        local v41;

        if Character then
            v41 = Character:FindFirstChildOfClass("Humanoid");
        else
            v41 = Character;
        end;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if Character and Character:IsA("BasePart") then
            Character.Anchored = false;
        end;

        if v41 then
            v41.PlatformStand = false;
            v41.AutoRotate = true;
            local State = v41:GetState();

            if State == Enum.HumanoidStateType.Physics or (State == Enum.HumanoidStateType.Ragdoll or State == Enum.HumanoidStateType.FallingDown) then
                v41:ChangeState(Enum.HumanoidStateType.GettingUp);
            end;
        end;

        metatable:refreshMovement();
    end;
end;

return u9;