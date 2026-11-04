 

 

local u1 = {};
u1.__index = u1;
local Value = Enum.ContextActionPriority.Medium.Value;
local Workspace = game:GetService("Workspace");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ContextActionService = game:GetService("ContextActionService");
local GameSettings = UserSettings().GameSettings;
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"));
local Maid = require(script.Parent:WaitForChild("Maid"));
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
local Settings = require(script:WaitForChild("Settings"));

function u1.new() -- Line: 52
    -- upvalues: u1 (copy), Maid (copy), GameSettings (copy), LocalPlayer (copy), CurrentCamera (copy)
    local u2 = setmetatable({}, u1);
    u2._runtimeMaid = Maid.new();
    u2.isEnabled = false;
    u2.isMouseLocked = false;
    u2.mouseLockToggledEvent = Instance.new("BindableEvent");
    GameSettings.Changed:Connect(function(p3) -- Line: 61
        -- upvalues: u2 (copy)
        if p3 == "ControlMode" or p3 == "ComputerMovementMode" then
            u2:UpdateMouseLockAvailability();
        end;
    end);
    LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function() -- Line: 68
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);
    LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- Line: 73
        -- upvalues: u2 (copy)
        u2:UpdateMouseLockAvailability();
    end);

    if LocalPlayer.Character then
        u2:SetCharacter(LocalPlayer.Character);
    end;

    LocalPlayer.CharacterAdded:Connect(function(u4: userdata) -- Line: 81
        -- upvalues: LocalPlayer (ref), u2 (copy)
        if LocalPlayer:GetAttribute("ControllingUserId") then
            return;
        end;

        task.spawn(function() -- Line: 86
            -- upvalues: u4 (copy), u2 (ref)
            local Humanoid = u4:WaitForChild("Humanoid", 10);
            local HumanoidRootPart = u4:WaitForChild("HumanoidRootPart", 10);

            if not (u4.Parent and (Humanoid and HumanoidRootPart)) then
                return;
            end;

            u2:SetCharacter(u4);
            u2:RefreshRotationLock();
        end);
    end);
    LocalPlayer:GetAttributeChangedSignal("ControllingUserId"):Connect(function() -- Line: 98
        -- upvalues: LocalPlayer (ref), u2 (copy)
        if LocalPlayer:GetAttribute("ControllingUserId") then
            return;
        end;

        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        task.defer(function() -- Line: 108
            -- upvalues: LocalPlayer (ref), Character (copy), u2 (ref)
            if LocalPlayer.Character ~= Character then
                return;
            end;

            u2:SetCharacter(Character);
            u2:RefreshRotationLock();
        end);
    end);
    CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- Line: 118
        -- upvalues: CurrentCamera (ref), u2 (copy)
        if CurrentCamera.CameraType ~= Enum.CameraType.Custom or not u2.isMouseLocked then
            return;
        end;

        task.defer(function() -- Line: 123
            -- upvalues: u2 (ref)
            u2:RefreshRotationLock();
        end);
    end);
    u2:UpdateMouseLockAvailability();

    return u2;
end;

function u1.SetCharacter(p5: table, p6: userdata?) -- Line: 135
    p5.Character = p6;
    local v7;

    if p6 then
        v7 = p6:FindFirstChildOfClass("Humanoid");
    else
        v7 = p6;
    end;

    p5.Humanoid = v7;

    if p6 then
        p6 = p6:FindFirstChild("HumanoidRootPart");
    end;

    p5.HumanoidRootPart = p6;

    if p5.Humanoid and not p5.isMouseLocked then
        p5.Humanoid.AutoRotate = true;
        p5.Humanoid.PlatformStand = false;
    end;
end;

function u1.RefreshRotationLock(p8) -- Line: 146
    if not p8.isMouseLocked then
        return;
    end;

    p8:ToggleShiftLock(false);
    p8:ToggleShiftLock(true);
end;

function u1.UpdateMouseLockAvailability(p9) -- Line: 156
    -- upvalues: LocalPlayer (copy), GameSettings (copy)
    local v10 = LocalPlayer.DevEnableMouseLock and (GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch and GameSettings.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove) and not (LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable);

    if v10 ~= p9.isEnabled then
        p9:EnableMouseLock(v10);
    end;
end;

function u1.GetBindableToggleEvent(p11) -- Line: 169
    return p11.mouseLockToggledEvent.Event;
end;

function u1.EnableMouseLock(p12: table, p13: boolean) -- Line: 174
    if p13 ~= p12.isEnabled then
        p12.isEnabled = p13;

        if p12.isEnabled then
            p12:BindContextActions();

            return;
        end;

        p12:UnbindContextActions();
        p12:ToggleShiftLock(false);
    end;
end;

function u1.DoMouseLockSwitch(p14, p15, p16, p17) -- Line: 188
    if p16 ~= Enum.UserInputState.Begin or workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        return Enum.ContextActionResult.Pass;
    end;

    p14:ToggleShiftLock(not p14.isMouseLocked);

    return Enum.ContextActionResult.Sink;
end;

function u1.BindContextActions(u18) -- Line: 198
    -- upvalues: ContextActionService (copy), Value (copy), Settings (copy)
    ContextActionService:BindActionAtPriority("MouseLockSwitchAction", function(p19, p20, p21) -- Line: 199
        -- upvalues: u18 (copy)
        return u18:DoMouseLockSwitch(p19, p20, p21);
    end, false, Value, unpack(Settings.SHIFT_LOCK_KEYBINDS));
end;

function u1.UnbindContextActions(p22) -- Line: 205
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("MouseLockSwitchAction");
end;

function u1.ToggleShiftLock(u23: table, p24: boolean) -- Line: 210
    -- upvalues: CameraUtils (copy), Settings (copy), RunService (copy), CurrentCamera (copy)
    u23.isMouseLocked = p24;

    if u23.isMouseLocked then
        CameraUtils.setMouseIconOverride(Settings.LOCKED_MOUSE_ICON);

        if u23.isMouseLocked and u23.Character then
            u23._runtimeMaid:GiveTask(RunService.RenderStepped:Connect(function(p25: number) -- Line: 217
                -- upvalues: u23 (copy), Settings (ref), CurrentCamera (ref)
                if not u23.Humanoid and u23.Character then
                    u23.Humanoid = u23.Character:FindFirstChildOfClass("Humanoid");
                end;

                if not u23.HumanoidRootPart and u23.Character then
                    u23.HumanoidRootPart = u23.Character:FindFirstChild("HumanoidRootPart");
                end;

                if not (u23.Humanoid and (u23.HumanoidRootPart and (workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable and not (u23.Character:GetAttribute("lockrotation") or u23.Character:GetAttribute("InMarble"))))) then
                    return;
                end;

                u23.Humanoid.AutoRotate = not u23.isMouseLocked;

                if u23.Humanoid.Sit then
                    return;
                end;

                if Settings.CHARACTER_SMOOTH_ROTATION then
                    local _, v26, _ = CurrentCamera.CFrame:ToOrientation();
                    u23.HumanoidRootPart.CFrame = u23.HumanoidRootPart.CFrame:Lerp(CFrame.new(u23.HumanoidRootPart.Position) * CFrame.Angles(0, v26, 0), p25 * 5 * Settings.CHARACTER_ROTATION_SPEED);

                    return;
                end;

                local _, v27, _ = CurrentCamera.CFrame:ToOrientation();
                u23.HumanoidRootPart.CFrame = CFrame.new(u23.HumanoidRootPart.Position) * CFrame.Angles(0, v27, 0);
            end));
        end;
    else
        u23._runtimeMaid:Destroy();

        if u23.Humanoid then
            u23.Humanoid.AutoRotate = not u23.isMouseLocked;
        end;

        CameraUtils.restoreMouseIcon();
    end;

    u23.mouseLockToggledEvent:Fire();
end;

function u1.GetIsMouseLocked(p28) -- Line: 251
    return p28.isMouseLocked;
end;

return u1;