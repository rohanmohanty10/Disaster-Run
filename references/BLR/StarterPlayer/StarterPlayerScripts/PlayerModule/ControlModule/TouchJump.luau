  

local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;
local success, result = pcall(function() -- Line: 21
    return UserSettings():IsUserFeatureEnabled("UserFixTouchJumpBug2");
end);
local u2 = success and result;

function u1.new() -- Line: 27
    -- upvalues: BaseCharacterController (copy), u1 (copy)
    local v3 = BaseCharacterController.new();
    local v4 = setmetatable(v3, u1);
    v4.parentUIFrame = nil;
    v4.jumpButton = nil;
    v4.characterAddedConn = nil;
    v4.humanoidStateEnabledChangedConn = nil;
    v4.humanoidJumpPowerConn = nil;
    v4.humanoidParentConn = nil;
    v4.externallyEnabled = false;
    v4.jumpPower = 0;
    v4.jumpStateEnabled = true;
    v4.isJumping = false;
    v4.humanoid = nil;

    return v4;
end;

function u1.EnableButton(p5, p6) -- Line: 45
    -- upvalues: Players (copy), u2 (ref)
    if p6 then
        if not p5.jumpButton then
            p5:Create();
        end;

        local v7 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if v7 and (p5.externallyEnabled and (p5.externallyEnabled and v7.JumpPower > 0)) then
            p5.jumpButton.Visible = true;
        end;
    else
        p5.jumpButton.Visible = false;

        if u2 then
            p5.touchObject = nil;
        end;

        p5.isJumping = false;
        p5.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;

function u1.UpdateEnabled(p8) -- Line: 68
    if p8.jumpPower > 0 and p8.jumpStateEnabled then
        p8:EnableButton(true);

        return;
    end;

    p8:EnableButton(false);
end;

function u1.HumanoidChanged(p9, p10) -- Line: 76
    -- upvalues: Players (copy)
    local v11 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v11 then
        if p10 == "JumpPower" then
            p9.jumpPower = v11.JumpPower;
            p9:UpdateEnabled();

            return;
        end;

        if p10 == "Parent" and not v11.Parent then
            p9.humanoidChangeConn:Disconnect();
        end;
    end;
end;

function u1.HumanoidStateEnabledChanged(p12, p13, p14) -- Line: 90
    if p13 == Enum.HumanoidStateType.Jumping then
        p12.jumpStateEnabled = p14;
        p12:UpdateEnabled();
    end;
end;

function u1.CharacterAdded(u15, p16) -- Line: 97
    if u15.humanoidChangeConn then
        u15.humanoidChangeConn:Disconnect();
        u15.humanoidChangeConn = nil;
    end;

    u15.humanoid = p16:FindFirstChildOfClass("Humanoid");

    while not u15.humanoid do
        p16.ChildAdded:wait();
        u15.humanoid = p16:FindFirstChildOfClass("Humanoid");
    end;

    u15.humanoidJumpPowerConn = u15.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function() -- Line: 109
        -- upvalues: u15 (copy)
        u15.jumpPower = u15.humanoid.JumpPower;
        u15:UpdateEnabled();
    end);
    u15.humanoidParentConn = u15.humanoid:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 114
        -- upvalues: u15 (copy)
        if not u15.humanoid.Parent then
            u15.humanoidJumpPowerConn:Disconnect();
            u15.humanoidJumpPowerConn = nil;
            u15.humanoidParentConn:Disconnect();
            u15.humanoidParentConn = nil;
        end;
    end);
    u15.humanoidStateEnabledChangedConn = u15.humanoid.StateEnabledChanged:Connect(function(p17, p18) -- Line: 123
        -- upvalues: u15 (copy)
        u15:HumanoidStateEnabledChanged(p17, p18);
    end);
    u15.jumpPower = u15.humanoid.JumpPower;
    u15.jumpStateEnabled = u15.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping);
    u15:UpdateEnabled();
end;

function u1.SetupCharacterAddedFunction(u19) -- Line: 132
    -- upvalues: Players (copy)
    u19.characterAddedConn = Players.LocalPlayer.CharacterAdded:Connect(function(p20) -- Line: 133
        -- upvalues: u19 (copy)
        u19:CharacterAdded(p20);
    end);

    if Players.LocalPlayer.Character then
        u19:CharacterAdded(Players.LocalPlayer.Character);
    end;
end;

function u1.Enable(p21, p22, p23) -- Line: 141
    if p23 then
        p21.parentUIFrame = p23;
    end;

    p21.externallyEnabled = p22;
    p21:EnableButton(p22);
end;

function u1.Create(u24) -- Line: 149
    -- upvalues: GuiService (copy)
    if not u24.parentUIFrame then
        return;
    end;

    if u24.jumpButton then
        u24.jumpButton:Destroy();
        u24.jumpButton = nil;
    end;

    if u24.absoluteSizeChangedConn then
        u24.absoluteSizeChangedConn:Disconnect();
        u24.absoluteSizeChangedConn = nil;
    end;

    u24.jumpButton = Instance.new("ImageButton");
    u24.jumpButton.Name = "JumpButton";
    u24.jumpButton.Visible = false;
    u24.jumpButton.BackgroundTransparency = 1;
    u24.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u24.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    u24.jumpButton.ImageRectSize = Vector2.new(144, 144);

    local function ResizeJumpButton() -- Line: 171
        -- upvalues: u24 (copy)
        local v25 = math.min(u24.parentUIFrame.AbsoluteSize.x, u24.parentUIFrame.AbsoluteSize.y) <= 500;
        local v26 = v25 and 70 or 120;
        u24.jumpButton.Size = UDim2.new(0, v26, 0, v26);
        u24.jumpButton.Position = v25 and UDim2.new(1, -(v26 * 1.5 - 10), 1, -v26 - 20) or UDim2.new(1, -(v26 * 1.5 - 10), 1, -v26 * 1.75);
    end;

    ResizeJumpButton();
    u24.absoluteSizeChangedConn = u24.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton);
    u24.touchObject = nil;
    u24.jumpButton.InputBegan:connect(function(p27) -- Line: 186
        -- upvalues: u24 (copy)
        if u24.touchObject or (p27.UserInputType ~= Enum.UserInputType.Touch or p27.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u24.touchObject = p27;
        u24.jumpButton.ImageRectOffset = Vector2.new(146, 146);
        u24.isJumping = true;
    end);

    local function _() -- Line: 199
        -- upvalues: u24 (copy)
        u24.touchObject = nil;
        u24.isJumping = false;
        u24.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;

    u24.jumpButton.InputEnded:connect(function(p28: userdata) -- Line: 205
        -- upvalues: u24 (copy)
        if p28 == u24.touchObject then
            u24.touchObject = nil;
            u24.isJumping = false;
            u24.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
    end);
    GuiService.MenuOpened:connect(function() -- Line: 211
        -- upvalues: u24 (copy)
        if u24.touchObject then
            u24.touchObject = nil;
            u24.isJumping = false;
            u24.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
    end);

    if not u24.characterAddedConn then
        u24:SetupCharacterAddedFunction();
    end;

    u24.jumpButton.Parent = u24.parentUIFrame;
end;

return u1;