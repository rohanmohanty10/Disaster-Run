 
 

local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"));
local u1 = setmetatable({}, BaseCharacterController);
u1.__index = u1;

function u1.new() -- Line: 20
    -- upvalues: BaseCharacterController (copy), u1 (copy)
    local v2 = BaseCharacterController.new();
    local v3 = setmetatable(v2, u1);
    v3.parentUIFrame = nil;
    v3.jumpButton = nil;
    v3.characterAddedConn = nil;
    v3.humanoidStateEnabledChangedConn = nil;
    v3.humanoidJumpPowerConn = nil;
    v3.humanoidParentConn = nil;
    v3.externallyEnabled = false;
    v3.jumpPower = 0;
    v3.jumpStateEnabled = true;
    v3.isJumping = false;
    v3.humanoid = nil;

    return v3;
end;

function u1.EnableButton(p4, p5) -- Line: 38
    -- upvalues: Players (copy)
    if p5 then
        if not p4.jumpButton then
            p4:Create();
        end;

        local v6 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if v6 and (p4.externallyEnabled and (p4.externallyEnabled and v6.JumpPower > 0)) then
            p4.jumpButton.Visible = true;
        end;
    else
        p4.jumpButton.Visible = false;
        p4.isJumping = false;
        p4.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;

function u1.UpdateEnabled(p7) -- Line: 58
    if p7.jumpPower > 0 and p7.jumpStateEnabled then
        p7:EnableButton(true);

        return;
    end;

    p7:EnableButton(false);
end;

function u1.HumanoidChanged(p8, p9) -- Line: 66
    -- upvalues: Players (copy)
    local v10 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

    if v10 then
        if p9 == "JumpPower" then
            p8.jumpPower = v10.JumpPower;
            p8:UpdateEnabled();

            return;
        end;

        if p9 == "Parent" and not v10.Parent then
            p8.humanoidChangeConn:Disconnect();
        end;
    end;
end;

function u1.HumanoidStateEnabledChanged(p11, p12, p13) -- Line: 80
    if p12 == Enum.HumanoidStateType.Jumping then
        p11.jumpStateEnabled = p13;
        p11:UpdateEnabled();
    end;
end;

function u1.CharacterAdded(u14, p15) -- Line: 87
    if u14.humanoidChangeConn then
        u14.humanoidChangeConn:Disconnect();
        u14.humanoidChangeConn = nil;
    end;

    u14.humanoid = p15:FindFirstChildOfClass("Humanoid");

    while not u14.humanoid do
        p15.ChildAdded:wait();
        u14.humanoid = p15:FindFirstChildOfClass("Humanoid");
    end;

    u14.humanoidJumpPowerConn = u14.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function() -- Line: 99
        -- upvalues: u14 (copy)
        u14.jumpPower = u14.humanoid.JumpPower;
        u14:UpdateEnabled();
    end);
    u14.humanoidParentConn = u14.humanoid:GetPropertyChangedSignal("Parent"):Connect(function() -- Line: 104
        -- upvalues: u14 (copy)
        if not u14.humanoid.Parent then
            u14.humanoidJumpPowerConn:Disconnect();
            u14.humanoidJumpPowerConn = nil;
            u14.humanoidParentConn:Disconnect();
            u14.humanoidParentConn = nil;
        end;
    end);
    u14.humanoidStateEnabledChangedConn = u14.humanoid.StateEnabledChanged:Connect(function(p16, p17) -- Line: 113
        -- upvalues: u14 (copy)
        u14:HumanoidStateEnabledChanged(p16, p17);
    end);
    u14.jumpPower = u14.humanoid.JumpPower;
    u14.jumpStateEnabled = u14.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping);
    u14:UpdateEnabled();
end;

function u1.SetupCharacterAddedFunction(u18) -- Line: 122
    -- upvalues: Players (copy)
    u18.characterAddedConn = Players.LocalPlayer.CharacterAdded:Connect(function(p19) -- Line: 123
        -- upvalues: u18 (copy)
        u18:CharacterAdded(p19);
    end);

    if Players.LocalPlayer.Character then
        u18:CharacterAdded(Players.LocalPlayer.Character);
    end;
end;

function u1.Enable(p20, p21, p22) -- Line: 131
    if p22 then
        p20.parentUIFrame = p22;
    end;

    p20.externallyEnabled = p21;
    p20:EnableButton(p21);
end;

function u1.Create(u23) -- Line: 139
    -- upvalues: GuiService (copy)
    if not u23.parentUIFrame then
        return;
    end;

    if u23.jumpButton then
        u23.jumpButton:Destroy();
        u23.jumpButton = nil;
    end;

    local v24 = math.min(u23.parentUIFrame.AbsoluteSize.x, u23.parentUIFrame.AbsoluteSize.y) <= 500;
    local v25 = v24 and 70 or 120;
    u23.jumpButton = Instance.new("ImageButton");
    u23.jumpButton.Name = "JumpButton";
    u23.jumpButton.Visible = false;
    u23.jumpButton.BackgroundTransparency = 1;
    u23.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
    u23.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    u23.jumpButton.ImageRectSize = Vector2.new(144, 144);
    u23.jumpButton.Size = UDim2.new(0, v25, 0, v25);
    u23.jumpButton.Position = v24 and UDim2.new(1, -(v25 * 1.5 - 10), 1, -v25 - 20) or UDim2.new(1, -(v25 * 1.5 - 10), 1, -v25 * 1.75);
    local u26 = nil;
    u23.jumpButton.InputBegan:connect(function(p27) -- Line: 166
        -- upvalues: u26 (ref), u23 (copy)
        if u26 or (p27.UserInputType ~= Enum.UserInputType.Touch or p27.UserInputState ~= Enum.UserInputState.Begin) then
            return;
        end;

        u26 = p27;
        u23.jumpButton.ImageRectOffset = Vector2.new(146, 146);
        u23.isJumping = true;
    end);

    local function _() -- Line: 179
        -- upvalues: u26 (ref), u23 (copy)
        u26 = nil;
        u23.isJumping = false;
        u23.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;

    u23.jumpButton.InputEnded:connect(function(p28: userdata) -- Line: 185
        -- upvalues: u26 (ref), u23 (copy)
        if p28 == u26 then
            u26 = nil;
            u23.isJumping = false;
            u23.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
    end);
    GuiService.MenuOpened:connect(function() -- Line: 191
        -- upvalues: u26 (ref), u23 (copy)
        if u26 then
            u26 = nil;
            u23.isJumping = false;
            u23.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        end;
    end);

    if not u23.characterAddedConn then
        u23:SetupCharacterAddedFunction();
    end;

    u23.jumpButton.Parent = u23.parentUIFrame;
end;

return u1;