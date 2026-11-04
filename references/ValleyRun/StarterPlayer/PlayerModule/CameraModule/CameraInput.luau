 

 

game:GetService("ContextActionService");
local UserInputService = game:GetService("UserInputService");
game:GetService("Players");
local UserGameSettings = UserSettings():GetService("UserGameSettings");
game:GetService("VRService");
local GuiService = game:GetService("GuiService");
local v1 = require(script.Parent.Parent:WaitForChild("CommonUtils")).get("FlagUtil");
local UserFlag = v1.getUserFlag("UserPSTextboxResetCameraInput");
local UserFlag2 = v1.getUserFlag("UserPlayerScriptsSupportTVRemoteKeycodes");
local CameraContext = script.Parent.Parent:WaitForChild("InputContexts"):WaitForChild("CameraContext");
local CameraRotationAction = CameraContext:WaitForChild("CameraRotationAction");
local CameraZoomAction = CameraContext:WaitForChild("CameraZoomAction");
local GamepadBinding = CameraRotationAction:WaitForChild("GamepadBinding");
local u2;

if UserFlag2 then
    u2 = CameraRotationAction:WaitForChild("MicroGamepadBinding");
else
    u2 = nil;
end;

local MouseBinding = CameraRotationAction:WaitForChild("MouseBinding");
local TrackpadBinding = CameraRotationAction:WaitForChild("TrackpadBinding");
local CameraToggleAction = CameraContext:WaitForChild("CameraToggleAction");
local CameraPanActiveAction = CameraContext:WaitForChild("CameraPanActiveAction");
local u3 = 1;

local function updateCameraYInvert() -- Line: 38
    -- upvalues: UserGameSettings (copy), u3 (ref), CameraRotationAction (copy)
    local CameraYInvertValue = UserGameSettings:GetCameraYInvertValue();

    if CameraYInvertValue == u3 then
        return;
    end;

    u3 = CameraYInvertValue;

    for _, child in CameraRotationAction:GetChildren() do
        if child:IsA("InputBinding") then
            local Vector2Scale = child.Vector2Scale;
            child.Vector2Scale = Vector2.new(Vector2Scale.X, -Vector2Scale.Y);
        end;
    end;
end;

local function updateMouseCameraSensitivity() -- Line: 59
    -- upvalues: UserGameSettings (copy), MouseBinding (copy), TrackpadBinding (copy)
    local MouseSensitivity = UserGameSettings.MouseSensitivity;
    MouseBinding.Scale = MouseSensitivity;
    TrackpadBinding.Scale = MouseSensitivity;
end;

UserGameSettings:GetPropertyChangedSignal("GamepadCameraSensitivity"):Connect(function() -- Line: 52, Name: updateGamepadCameraSensitivity
    -- upvalues: GamepadBinding (copy), UserGameSettings (copy), UserFlag2 (copy), u2 (copy)
    GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity;

    if UserFlag2 and u2 then
        u2.Scale = UserGameSettings.GamepadCameraSensitivity;
    end;
end);
GamepadBinding.Scale = UserGameSettings.GamepadCameraSensitivity;

if UserFlag2 and u2 then
    u2.Scale = UserGameSettings.GamepadCameraSensitivity;
end;

UserGameSettings:GetPropertyChangedSignal("MouseSensitivity"):Connect(updateMouseCameraSensitivity);
local MouseSensitivity = UserGameSettings.MouseSensitivity;
MouseBinding.Scale = MouseSensitivity;
TrackpadBinding.Scale = MouseSensitivity;
updateCameraYInvert();

local function adjustTouchPitchSensitivity(p4) -- Line: 75
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return p4;
    end;

    local v5 = workspace_CurrentCamera.CFrame:ToEulerAnglesYXZ();

    if p4.Y * v5 >= 0 then
        return p4;
    end;

    local v6 = (1 - (math.abs(v5) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25;

    return Vector2.new(1, v6) * p4;
end;

local v7 = {};
local u8 = 0;

local function incPanInputCount() -- Line: 106
    -- upvalues: u8 (ref)
    u8 = math.max(0, u8 + 1);
end;

local function decPanInputCount() -- Line: 110
    -- upvalues: u8 (ref)
    u8 = math.max(0, u8 - 1);
end;

local function resetPanInputCount() -- Line: 114
    -- upvalues: u8 (ref)
    u8 = 0;
end;

function v7.getRotationActivated() -- Line: 118
    -- upvalues: u8 (ref), CameraRotationAction (copy)
    return u8 > 0 and true or CameraRotationAction:GetState().Magnitude > 0;
end;

function v7.getPanActivated() -- Line: 123
    -- upvalues: u8 (ref)
    return u8 > 0;
end;

function v7.getRotation(p9) -- Line: 127
    -- upvalues: updateCameraYInvert (copy), CameraRotationAction (copy), UserInputService (copy), adjustTouchPitchSensitivity (copy)
    updateCameraYInvert();
    local v10 = CameraRotationAction:GetState() * p9;

    if UserInputService.PreferredInput == Enum.PreferredInput.Touch then
        v10 = adjustTouchPitchSensitivity(v10);
    end;

    return v10;
end;

function v7.getZoomDelta(p11) -- Line: 136
    -- upvalues: CameraZoomAction (copy)
    return CameraZoomAction:GetState() * p11;
end;

CameraPanActiveAction.Pressed:Connect(incPanInputCount);
CameraPanActiveAction.Released:Connect(decPanInputCount);
local u12 = false;

function v7.setInputEnabled(p13) -- Line: 147
    -- upvalues: u12 (ref), u8 (ref), CameraZoomAction (copy), CameraRotationAction (copy), CameraPanActiveAction (copy)
    if u12 == p13 then
        return;
    end;

    u12 = p13;
    u8 = 0;

    if u12 then
        CameraZoomAction.Enabled = true;
        CameraRotationAction.Enabled = true;
        CameraPanActiveAction.Enabled = true;

        return;
    end;

    CameraZoomAction.Enabled = false;
    CameraRotationAction.Enabled = false;
    CameraPanActiveAction.Enabled = false;
end;

function v7.getInputEnabled() -- Line: 168
    -- upvalues: u12 (ref)
    return u12;
end;

UserInputService.WindowFocused:Connect(resetPanInputCount);
UserInputService.WindowFocusReleased:Connect(resetPanInputCount);
GuiService.MenuOpened:Connect(resetPanInputCount);

if UserFlag then
    UserInputService.TextBoxFocusReleased:Connect(resetPanInputCount);
end;

local u14 = false;
local u15 = false;
local u16 = 0;

function v7.getHoldPan() -- Line: 187
    -- upvalues: u14 (ref)
    return u14;
end;

function v7.getTogglePan() -- Line: 191
    -- upvalues: u15 (ref)
    return u15;
end;

function v7.getPanning() -- Line: 195
    -- upvalues: u15 (ref), u14 (ref)
    return u15 or u14;
end;

function v7.setTogglePan(p17: boolean) -- Line: 199
    -- upvalues: u15 (ref)
    u15 = p17;
end;

local u18 = false;
CameraToggleAction.Pressed:Connect(function() -- Line: 207
    -- upvalues: u14 (ref), u16 (ref)
    u14 = true;
    u16 = tick();
end);
CameraToggleAction.Released:Connect(function() -- Line: 212
    -- upvalues: u14 (ref), u16 (ref), u15 (ref), UserInputService (copy)
    u14 = false;

    if tick() - u16 < 0.3 and (u15 or UserInputService:GetMouseDelta().Magnitude < 2) then
        u15 = not u15;
    end;
end);

function v7.enableCameraToggleInput() -- Line: 219
    -- upvalues: u18 (ref), u14 (ref), u15 (ref), CameraToggleAction (copy)
    if u18 then
        return;
    end;

    u18 = true;
    u14 = false;
    u15 = false;
    CameraToggleAction.Enabled = true;
end;

function v7.disableCameraToggleInput() -- Line: 231
    -- upvalues: u18 (ref), CameraToggleAction (copy)
    if not u18 then
        return;
    end;

    u18 = false;
    CameraToggleAction.Enabled = false;
end;

return v7;