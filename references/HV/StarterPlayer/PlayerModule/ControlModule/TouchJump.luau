 

 

local CommonUtils = require(script.Parent.Parent:WaitForChild("CommonUtils"));
local u1 = CommonUtils.get("ConnectionUtil");
local u2 = CommonUtils.get("CharacterUtil");
local v3 = CommonUtils.get("FlagUtil");
local UserFlag = v3.getUserFlag("UserPlayerScriptsCCLIntegrationD");
local UserFlag2 = v3.getUserFlag("UserPlayerScriptsRefactor1");
local UserFlag3 = v3.getUserFlag("UserPlayerScriptsFixTouchJumpVisibility");
game:GetService("Players");
local AvatarAbilitiesInterface = require(script.Parent:WaitForChild("AvatarAbilitiesInterface"));
local u4 = { "rbxasset://textures/ui/Input/JumpButtonRegular.png", "rbxasset://textures/ui/Input/JumpButtonPressed.png" };
local ActionController = require(script.Parent:WaitForChild("ActionController"));
local u5 = setmetatable({}, ActionController);
u5.__index = u5;

function u5.new(p6) -- Line: 61
    -- upvalues: ActionController (copy), u5 (copy), UserFlag3 (copy), u1 (copy)
    local v7 = ActionController.new();
    local u8 = setmetatable(v7, u5);
    u8.data = p6;
    p6.eventBus:subscribe("ACTIONS_RELOADED"):Connect(function() -- Line: 65
        -- upvalues: u8 (copy), UserFlag3 (ref)
        u8:Create();

        if UserFlag3 and u8._active then
            u8._active = false;
            u8:EnableButton(true);
        end;
    end);
    u8.parentUIFrame = nil;
    u8.jumpButton = nil;
    u8.externallyEnabled = false;
    u8._active = false;
    u8._connectionUtil = u1.new();

    return u8;
end;

function u5._reset(p9) -- Line: 83
    -- upvalues: UserFlag (copy), AvatarAbilitiesInterface (copy), u4 (copy)
    if p9.jumpButton then
        if not UserFlag and AvatarAbilitiesInterface.isEnabled() then
            p9.jumpButton.Image = u4[1];

            return;
        end;

        p9.jumpButton.ImageRectOffset = Vector2.new(1, 146);
    end;
end;

function u5.EnableButton(p10, p11) -- Line: 96
    if p11 == p10._active then
        return;
    end;

    if p11 then
        if not p10.jumpButton then
            p10:Create();
        end;

        p10.jumpButton.Visible = true;
    elseif p10.jumpButton then
        p10.jumpButton.Visible = false;
    end;

    p10:_reset();
    p10._active = p11;
end;

function u5.UpdateEnabled(p12) -- Line: 115
    -- upvalues: u2 (copy)
    local Child = u2.getChild("Humanoid", "Humanoid");

    if Child and p12.externallyEnabled and not ((not Child.UseJumpPower or Child.JumpPower <= 0) and (Child.UseJumpPower or Child.JumpHeight <= 0)) and Child:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
        p12:EnableButton(true);

        return;
    end;

    p12:EnableButton(false);
end;

function u5._setupConfigurations(u13) -- Line: 124
    -- upvalues: u2 (copy)
    local function update() -- Line: 125
        -- upvalues: u13 (copy)
        u13:UpdateEnabled();
    end;

    local v17 = u2.onChild("Humanoid", "Humanoid", function(p14) -- Line: 130
        -- upvalues: u13 (copy), update (copy)
        u13:UpdateEnabled();
        u13:_reset();
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_POWER", p14:GetPropertyChangedSignal("JumpPower"):Connect(update));
        u13._connectionUtil:trackConnection("HUMANOID_JUMP_HEIGHT", p14:GetPropertyChangedSignal("JumpHeight"):Connect(update));
        u13._connectionUtil:trackConnection("HUMANOID_STATE_ENABLED_CHANGED", p14.StateEnabledChanged:Connect(function(p15, p16) -- Line: 143
            -- upvalues: u13 (ref)
            if p15 == Enum.HumanoidStateType.Jumping and p16 ~= u13._active then
                u13:UpdateEnabled();
            end;
        end));
    end);
    u13._connectionUtil:trackConnection("HUMANOID", v17);
end;

function u5.Enable(p18, p19, p20) -- Line: 155
    -- upvalues: ActionController (copy)
    if p20 then
        p18.parentUIFrame = p20;
    end;

    if p18.externallyEnabled == p19 then
        return;
    end;

    p18.externallyEnabled = p19;
    ActionController.Enable(p18, p19);
    p18:UpdateEnabled();

    if p19 then
        p18:_setupConfigurations();

        return;
    end;

    p18._connectionUtil:disconnectAll();
end;

function u5.Create(u21) -- Line: 173
    -- upvalues: UserFlag (copy), UserFlag2 (copy), AvatarAbilitiesInterface (copy), u4 (copy)
    if not u21.parentUIFrame then
        return;
    end;

    if u21.jumpButton then
        u21.jumpButton:Destroy();
        u21.jumpButton = nil;
    end;

    if u21.absoluteSizeChangedConn then
        u21.absoluteSizeChangedConn:Disconnect();
        u21.absoluteSizeChangedConn = nil;
    end;

    if not UserFlag and u21.avatarAbilitiesEnabledChangedConn then
        u21.avatarAbilitiesEnabledChangedConn:Disconnect();
        u21.avatarAbilitiesEnabledChangedConn = nil;
    end;

    u21.jumpButton = Instance.new("ImageButton");
    u21.jumpButton.Name = "JumpButton";
    u21.jumpButton.Visible = false;
    u21.jumpButton.BackgroundTransparency = 1;

    if UserFlag2 then
        u21.jumpButton.ZIndex = 10;
    end;

    if UserFlag or not AvatarAbilitiesInterface.isEnabled() then
        u21.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
        u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
        u21.jumpButton.ImageRectSize = Vector2.new(144, 144);
    else
        u21.jumpButton.Image = u4[1];
    end;

    local function ResizeJumpButton() -- Line: 211
        -- upvalues: u21 (copy), UserFlag (ref), AvatarAbilitiesInterface (ref), u4 (ref)
        local v22 = math.min(u21.parentUIFrame.AbsoluteSize.x, u21.parentUIFrame.AbsoluteSize.y) <= 500;

        if UserFlag or not AvatarAbilitiesInterface.isEnabled() then
            local v23 = v22 and 70 or 120;
            u21.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png";
            u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);
            u21.jumpButton.ImageRectSize = Vector2.new(144, 144);
            u21.jumpButton.Size = UDim2.new(0, v23, 0, v23);
            u21.jumpButton.Position = v22 and UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 - 20) or UDim2.new(1, -(v23 * 1.5 - 10), 1, -v23 * 1.75);

            return;
        end;

        local v24 = v22 and 72 or 120;
        u21.jumpButton.Image = u4[1];
        u21.jumpButton.ImageRectOffset = Vector2.new(0, 0);
        u21.jumpButton.ImageRectSize = Vector2.new(0, 0);
        u21.jumpButton.Size = UDim2.new(0, v24, 0, v24);
        u21.jumpButton.Position = UDim2.new(1, -v24 - (v22 and 64 or 100), 1, -v24 - (v22 and 64 or 112));
    end;

    ResizeJumpButton();
    u21.absoluteSizeChangedConn = u21.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton);

    if not UserFlag then
        u21.avatarAbilitiesEnabledChangedConn = AvatarAbilitiesInterface.GetEnabledChangedSignal():Connect(ResizeJumpButton);
    end;

    u21.jumpButton.Parent = u21.parentUIFrame;

    if not u21.data.actions.JumpAction then
        return;
    end;

    u21.data.actions.JumpAction:WaitForChild("TouchBinding").UIButton = u21.jumpButton;
    u21.data.actions.JumpAction.Pressed:Connect(function() -- Line: 253
        -- upvalues: u21 (copy), UserFlag (ref), AvatarAbilitiesInterface (ref), u4 (ref)
        if not u21.jumpButton then
            return;
        end;

        if UserFlag or not AvatarAbilitiesInterface.isEnabled() then
            u21.jumpButton.ImageRectOffset = Vector2.new(146, 146);

            return;
        end;

        u21.jumpButton.Image = u4[2];
    end);
    u21.data.actions.JumpAction.Released:Connect(function() -- Line: 265
        -- upvalues: u21 (copy), UserFlag (ref), AvatarAbilitiesInterface (ref), u4 (ref)
        if not u21.jumpButton then
            return;
        end;

        if UserFlag or not AvatarAbilitiesInterface.isEnabled() then
            u21.jumpButton.ImageRectOffset = Vector2.new(1, 146);

            return;
        end;

        u21.jumpButton.Image = u4[1];
    end);
end;

return u5;