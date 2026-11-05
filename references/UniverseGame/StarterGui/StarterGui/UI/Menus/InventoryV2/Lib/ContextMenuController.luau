  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local Fusion = require(ReplicatedStorage.ReplicatedRoot.Libraries.Interface.Fusion);
local Trove = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
local u1 = {};
u1.__index = u1;
local u2 = Color3.fromRGB(218, 218, 218);
local Divider = script:WaitForChild("Divider");
local ActionButton = script:WaitForChild("ActionButton");
local u3 = require("./Icons");
require("./Types");

local function IsPointInsideGui(p4, p5) -- Line: 21
    local AbsolutePosition = p4.AbsolutePosition;
    local AbsoluteSize = p4.AbsoluteSize;
    local v6;

    if p5.X >= AbsolutePosition.X and (p5.X <= AbsolutePosition.X + AbsoluteSize.X and p5.Y >= AbsolutePosition.Y) then
        v6 = p5.Y <= AbsolutePosition.Y + AbsoluteSize.Y;
    else
        v6 = false;
    end;

    return v6;
end;

local function ApplyIcon(p7, p8) -- Line: 31
    -- upvalues: u3 (copy)
    local v9 = u3[p8];

    if v9 then
        p7.Image = v9.Atlas;
        p7.ImageRectSize = Vector2.new(256, 256);
        p7.ImageRectOffset = v9.ImageRectOffset;
    end;
end;

function u1.new(p10, p11, u12) -- Line: 41
    -- upvalues: Trove (copy), Fusion (copy), ActionButton (copy), u2 (copy), u3 (copy), Divider (copy), u1 (copy)
    local u13 = {
        Connection = nil,
        Frame = p10,
        ParentObject = p11,
        Trove = Trove.new(),
        Showing = Fusion.Value(false),
        Actions = Fusion.Value({}),
        Position = Fusion.Value(p10.Position),
        UIEngine = u12
    };
    local v14 = Fusion.Computed(function() -- Line: 54
        -- upvalues: u13 (copy)
        return u13.Showing:get() and 0 or 1;
    end);
    local u15 = Fusion.Spring(v14, 40, 0.95);
    Fusion.Hydrate(u13.Frame)({
        Visible = Fusion.Computed(function() -- Line: 61
            -- upvalues: u15 (copy)
            return u15:get() < 0.99;
        end),
        GroupTransparency = u15,
        Position = Fusion.Spring(u13.Position, 60, 0.95)
    });
    Fusion.Hydrate(u13.Frame:FindFirstChildOfClass("UIStroke"))({
        Transparency = u15
    });
    Fusion.Hydrate(p10.Actions)({
        [Fusion.Children] = Fusion.ForValues(u13.Actions, function(u16) -- Line: 74
            -- upvalues: ActionButton (ref), u2 (ref), u3 (ref), Fusion (ref), u12 (copy), Divider (ref)
            local v17 = u16.Kind or "Button";

            if v17 == "Button" then
                local v18 = ActionButton:Clone();
                v18.LayoutOrder = u16.Order;
                v18.Label.Text = u16.Label;
                v18.Label.TextColor3 = u16.Color or u2;
                v18.Icon.ImageColor3 = u16.Color or u2;
                v18.BackgroundColor3 = u16.Color or u2;

                if u16.IconName then
                    local Icon = v18.Icon;
                    local v19 = u3[u16.IconName];

                    if v19 then
                        Icon.Image = v19.Atlas;
                        Icon.ImageRectSize = Vector2.new(256, 256);
                        Icon.ImageRectOffset = v19.ImageRectOffset;
                    end;
                end;

                v18.Visible = true;
                local u20 = Fusion.Value(false);
                Fusion.Hydrate(v18)({
                    [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 96
                        -- upvalues: u12 (ref), u16 (copy)
                        u12:PlaySound("Inventory/inv_click");

                        if u16.Callback then
                            u16.Callback();
                        end;
                    end,

                    [Fusion.OnEvent("MouseEnter")] = function() -- Line: 103
                        -- upvalues: u20 (copy), u12 (ref)
                        u20:set(true);
                        u12:PlaySound("Inventory/inv_hover");
                    end,

                    [Fusion.OnEvent("MouseLeave")] = function() -- Line: 107
                        -- upvalues: u20 (copy)
                        u20:set(false);
                    end,

                    BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 111
                        -- upvalues: u20 (copy)
                        return u20:get() and 0.85 or 1;
                    end), 25, 1)
                });

                return v18;
            end;

            if v17 == "Divider" then
                local v21 = Divider:Clone();
                v21.LayoutOrder = u16.Order;
                v21.Visible = true;

                return v21;
            end;
        end, Fusion.cleanup)
    });

    return setmetatable(u13, u1);
end;

function u1.Hide(p22) -- Line: 131
    p22.Position:set(p22.Position:get() + UDim2.fromOffset(10, 0));
    p22.Showing:set(false);
end;

function u1.Show(u23, p24, p25) -- Line: 136
    -- upvalues: UserInputService (copy)
    local v26 = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080);
    local AbsoluteSize = u23.Frame.AbsoluteSize;
    local v27 = -u23.ParentObject.AbsolutePosition + p24 - Vector2.new(-6, 10);
    local u28 = math.min(v27.X, v26.X - AbsoluteSize.X);
    local u29 = math.min(v27.Y, v26.Y - AbsoluteSize.Y);

    if u23.Connection == nil then
        u23.Connection = u23.Trove:Connect(UserInputService.InputBegan, function(p30, p31) -- Line: 145
            -- upvalues: u23 (copy)
            if p30.UserInputType == Enum.UserInputType.MouseButton1 or p30.UserInputType == Enum.UserInputType.Touch then
                if not u23.Frame.Visible then
                    return;
                end;

                local v32 = Vector2.new(p30.Position.X, p30.Position.Y);
                local Frame = u23.Frame;
                local AbsolutePosition = Frame.AbsolutePosition;
                local AbsoluteSize2 = Frame.AbsoluteSize;
                local v33;

                if v32.X >= AbsolutePosition.X and (v32.X <= AbsolutePosition.X + AbsoluteSize2.X and v32.Y >= AbsolutePosition.Y) then
                    v33 = v32.Y <= AbsolutePosition.Y + AbsoluteSize2.Y;
                else
                    v33 = false;
                end;

                if not v33 then
                    u23:Hide();
                end;
            end;
        end);
    end;

    u23.Actions:set(p25 or {});
    task.defer(function() -- Line: 163
        -- upvalues: u23 (copy), u28 (copy), u29 (copy)
        u23.Position:set(UDim2.fromOffset(u28, u29));
    end);
    u23.Showing:set(true);
end;

function u1.Destroy(p34) -- Line: 169
    p34.Actions:set({});
    p34.Trove:Destroy();
    table.clear(p34);
end;

return u1;