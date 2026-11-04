  

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local CommonUtils = script.Parent.Parent:WaitForChild("CommonUtils");
local UserFlag = require(CommonUtils:WaitForChild("FlagUtil")).getUserFlag("UserUpdateInputConnections");
local Vector3_new_ret = Vector3.new();
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;

function u1.new(p2) -- Line: 24
    -- upvalues: BaseCharacterController (copy), u1 (copy), UserFlag (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u1);
    v4.CONTROL_ACTION_PRIORITY = p2;

    if not UserFlag then
        v4.textFocusReleasedConn = nil;
        v4.textFocusGainedConn = nil;
        v4.windowFocusReleasedConn = nil;
    end;

    v4.forwardValue = 0;
    v4.backwardValue = 0;
    v4.leftValue = 0;
    v4.rightValue = 0;
    v4.jumpEnabled = true;

    return v4;
end;

function u1.Enable(p5: table, p6: boolean) -- Line: 45
    -- upvalues: UserFlag (copy), UserInputService (copy), Vector3_new_ret (copy)
    if not (UserFlag or UserInputService.KeyboardEnabled) then
        return false;
    end;

    if p6 == p5.enabled then
        return true;
    end;

    p5.forwardValue = 0;
    p5.backwardValue = 0;
    p5.leftValue = 0;
    p5.rightValue = 0;
    p5.moveVector = Vector3_new_ret;
    p5.jumpRequested = false;
    p5:UpdateJump();

    if p6 then
        p5:BindContextActions();
        p5:ConnectFocusEventListeners();
    elseif UserFlag then
        p5._connections:disconnectAll();
    else
        p5:UnbindContextActions();
        p5:DisconnectFocusEventListeners();
    end;

    p5.enabled = p6;

    return true;
end;

function u1.UpdateMovement(p7, p8) -- Line: 83
    -- upvalues: Vector3_new_ret (copy)
    if p8 == Enum.UserInputState.Cancel then
        p7.moveVector = Vector3_new_ret;

        return;
    end;

    p7.moveVector = Vector3.new(p7.leftValue + p7.rightValue, 0, p7.forwardValue + p7.backwardValue);
end;

function u1.UpdateJump(p9) -- Line: 91
    p9.isJumping = p9.jumpRequested;
end;

function u1.BindContextActions(u10) -- Line: 95
    -- upvalues: ContextActionService (copy), UserFlag (copy)
    ContextActionService:BindActionAtPriority("moveForwardAction", function(p11, p12, p13) -- Line: 101
        -- upvalues: u10 (copy)
        u10.forwardValue = p12 == Enum.UserInputState.Begin and -1 or 0;
        u10:UpdateMovement(p12);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward);
    ContextActionService:BindActionAtPriority("moveBackwardAction", function(p14, p15, p16) -- Line: 107
        -- upvalues: u10 (copy)
        u10.backwardValue = p15 == Enum.UserInputState.Begin and 1 or 0;
        u10:UpdateMovement(p15);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward);
    ContextActionService:BindActionAtPriority("moveLeftAction", function(p17, p18, p19) -- Line: 113
        -- upvalues: u10 (copy)
        u10.leftValue = p18 == Enum.UserInputState.Begin and -1 or 0;
        u10:UpdateMovement(p18);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft);
    ContextActionService:BindActionAtPriority("moveRightAction", function(p20, p21, p22) -- Line: 119
        -- upvalues: u10 (copy)
        u10.rightValue = p21 == Enum.UserInputState.Begin and 1 or 0;
        u10:UpdateMovement(p21);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight);
    ContextActionService:BindActionAtPriority("jumpAction", function(p23, p24, p25) -- Line: 125
        -- upvalues: u10 (copy)
        u10.jumpRequested = u10.jumpEnabled and p24 == Enum.UserInputState.Begin;
        u10:UpdateJump();

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump);

    if UserFlag then
        u10._connections:connectManual("moveForwardAction", function() -- Line: 145
            -- upvalues: ContextActionService (ref)
            ContextActionService:UnbindAction("moveForwardAction");
        end);
        u10._connections:connectManual("moveBackwardAction", function() -- Line: 146
            -- upvalues: ContextActionService (ref)
            ContextActionService:UnbindAction("moveBackwardAction");
        end);
        u10._connections:connectManual("moveLeftAction", function() -- Line: 147
            -- upvalues: ContextActionService (ref)
            ContextActionService:UnbindAction("moveLeftAction");
        end);
        u10._connections:connectManual("moveRightAction", function() -- Line: 148
            -- upvalues: ContextActionService (ref)
            ContextActionService:UnbindAction("moveRightAction");
        end);
        u10._connections:connectManual("jumpAction", function() -- Line: 149
            -- upvalues: ContextActionService (ref)
            ContextActionService:UnbindAction("jumpAction");
        end);
    end;
end;

function u1.UnbindContextActions(p26) -- Line: 153
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("moveForwardAction");
    ContextActionService:UnbindAction("moveBackwardAction");
    ContextActionService:UnbindAction("moveLeftAction");
    ContextActionService:UnbindAction("moveRightAction");
    ContextActionService:UnbindAction("jumpAction");
end;

function u1.ConnectFocusEventListeners(u27) -- Line: 161
    -- upvalues: Vector3_new_ret (copy), UserFlag (copy), UserInputService (copy)
    local function onFocusReleased() -- Line: 162
        -- upvalues: u27 (copy), Vector3_new_ret (ref)
        u27.moveVector = Vector3_new_ret;
        u27.forwardValue = 0;
        u27.backwardValue = 0;
        u27.leftValue = 0;
        u27.rightValue = 0;
        u27.jumpRequested = false;
        u27:UpdateJump();
    end;

    local function onTextFocusGained(p28) -- Line: 172
        -- upvalues: u27 (copy)
        u27.jumpRequested = false;
        u27:UpdateJump();
    end;

    if UserFlag then
        u27._connections:connect("textBoxFocusReleased", UserInputService.TextBoxFocusReleased, onFocusReleased);
        u27._connections:connect("textBoxFocused", UserInputService.TextBoxFocused, onTextFocusGained);
        u27._connections:connect("windowFocusReleased", UserInputService.WindowFocused, onFocusReleased);

        return;
    end;

    u27.textFocusReleasedConn = UserInputService.TextBoxFocusReleased:Connect(onFocusReleased);
    u27.textFocusGainedConn = UserInputService.TextBoxFocused:Connect(onTextFocusGained);
    u27.windowFocusReleasedConn = UserInputService.WindowFocused:Connect(onFocusReleased);
end;

function u1.DisconnectFocusEventListeners(p29) -- Line: 188
    if p29.textFocusReleasedConn then
        p29.textFocusReleasedConn:Disconnect();
        p29.textFocusReleasedConn = nil;
    end;

    if p29.textFocusGainedConn then
        p29.textFocusGainedConn:Disconnect();
        p29.textFocusGainedConn = nil;
    end;

    if p29.windowFocusReleasedConn then
        p29.windowFocusReleasedConn:Disconnect();
        p29.windowFocusReleasedConn = nil;
    end;
end;

return u1;