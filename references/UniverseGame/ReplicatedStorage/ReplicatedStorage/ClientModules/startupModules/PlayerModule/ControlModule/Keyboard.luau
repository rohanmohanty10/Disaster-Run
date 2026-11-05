  

 

local UserInputService = game:GetService("UserInputService");
local ContextActionService = game:GetService("ContextActionService");
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;

function u1.new(p2) -- Line: 19
    -- upvalues: BaseCharacterController (copy), u1 (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u1);
    v4.CONTROL_ACTION_PRIORITY = p2;
    v4.textFocusReleasedConn = nil;
    v4.textFocusGainedConn = nil;
    v4.windowFocusReleasedConn = nil;
    v4.forwardValue = 0;
    v4.backwardValue = 0;
    v4.leftValue = 0;
    v4.rightValue = 0;
    v4.jumpEnabled = true;

    return v4;
end;

function u1.Enable(p5, p6) -- Line: 38
    -- upvalues: UserInputService (copy)
    if not UserInputService.KeyboardEnabled then
        return false;
    end;

    if p6 == p5.enabled then
        return true;
    end;

    p5.forwardValue = 0;
    p5.backwardValue = 0;
    p5.leftValue = 0;
    p5.rightValue = 0;
    p5.moveVector = Vector3.new(0, 0, 0);
    p5.jumpRequested = false;
    p5:UpdateJump();

    if p6 then
        p5:BindContextActions();
        p5:ConnectFocusEventListeners();
    else
        p5:UnbindContextActions();
        p5:DisconnectFocusEventListeners();
    end;

    p5.enabled = p6;

    return true;
end;

function u1.UpdateMovement(p7, p8) -- Line: 70
    if p8 == Enum.UserInputState.Cancel then
        p7.moveVector = Vector3.new(0, 0, 0);

        return;
    end;

    p7.moveVector = Vector3.new(p7.leftValue + p7.rightValue, 0, p7.forwardValue + p7.backwardValue);
end;

function u1.UpdateJump(p9) -- Line: 78
    p9.isJumping = p9.jumpRequested;
end;

function u1.BindContextActions(u10) -- Line: 82
    -- upvalues: ContextActionService (copy)
    ContextActionService:BindActionAtPriority("moveForwardAction", function(p11, p12, p13) -- Line: 88
        -- upvalues: u10 (copy)
        u10.forwardValue = p12 == Enum.UserInputState.Begin and -1 or 0;
        u10:UpdateMovement(p12);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward);
    ContextActionService:BindActionAtPriority("moveBackwardAction", function(p14, p15, p16) -- Line: 94
        -- upvalues: u10 (copy)
        u10.backwardValue = p15 == Enum.UserInputState.Begin and 1 or 0;
        u10:UpdateMovement(p15);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward);
    ContextActionService:BindActionAtPriority("moveLeftAction", function(p17, p18, p19) -- Line: 100
        -- upvalues: u10 (copy)
        u10.leftValue = p18 == Enum.UserInputState.Begin and -1 or 0;
        u10:UpdateMovement(p18);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft);
    ContextActionService:BindActionAtPriority("moveRightAction", function(p20, p21, p22) -- Line: 106
        -- upvalues: u10 (copy)
        u10.rightValue = p21 == Enum.UserInputState.Begin and 1 or 0;
        u10:UpdateMovement(p21);

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight);
    ContextActionService:BindActionAtPriority("jumpAction", function(p23, p24, p25) -- Line: 112
        -- upvalues: u10 (copy)
        u10.jumpRequested = u10.jumpEnabled and p24 == Enum.UserInputState.Begin;
        u10:UpdateJump();

        return Enum.ContextActionResult.Pass;
    end, false, u10.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump);
end;

function u1.UnbindContextActions(p26) -- Line: 132
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("moveForwardAction");
    ContextActionService:UnbindAction("moveBackwardAction");
    ContextActionService:UnbindAction("moveLeftAction");
    ContextActionService:UnbindAction("moveRightAction");
    ContextActionService:UnbindAction("jumpAction");
end;

function u1.ConnectFocusEventListeners(u27) -- Line: 140
    -- upvalues: UserInputService (copy)
    local function onFocusReleased() -- Line: 141
        -- upvalues: u27 (copy)
        u27.moveVector = Vector3.new(0, 0, 0);
        u27.forwardValue = 0;
        u27.backwardValue = 0;
        u27.leftValue = 0;
        u27.rightValue = 0;
        u27.jumpRequested = false;
        u27:UpdateJump();
    end;

    u27.textFocusReleasedConn = UserInputService.TextBoxFocusReleased:Connect(onFocusReleased);
    u27.textFocusGainedConn = UserInputService.TextBoxFocused:Connect(function(p28) -- Line: 151, Name: onTextFocusGained
        -- upvalues: u27 (copy)
        u27.jumpRequested = false;
        u27:UpdateJump();
    end);
    u27.windowFocusReleasedConn = UserInputService.WindowFocused:Connect(onFocusReleased);
end;

function u1.DisconnectFocusEventListeners(p29) -- Line: 161
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