  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local FastTween = require(ReplicatedStorage.Shared.Functions.FastTween);
local u1 = {};
u1.__index = u1;

function u1.Click(p2) -- Line: 8
    -- upvalues: FastTween (copy)
    if p2.UIScale then
        FastTween(p2.UIScale, {
            Scale = 0.9
        }, { 0.065, "Exponential", "Out" });
    end;
end;

function u1.Ended(p3) -- Line: 16
    -- upvalues: FastTween (copy)
    if p3.UIScale then
        FastTween(p3.UIScale, {
            Scale = 1
        }, { 0.25, "Circular", "Out" });
    end;
end;

function u1.Hover(p4) -- Line: 24
    -- upvalues: FastTween (copy)
    local IsHovering = p4.Button.IsHovering;

    if p4.UIScale then
        FastTween(p4.UIScale, {
            Scale = IsHovering and 1.05 or 1
        }, { 0.05, "Circular", "Out" });
    end;

    if p4.Icon then
        local DefaultIconRotation = p4.DefaultIconRotation;
        local Icon = p4.Icon;
        local v5 = {};

        if IsHovering then
            DefaultIconRotation = DefaultIconRotation + 10 or DefaultIconRotation;
        end;

        v5.Rotation = DefaultIconRotation;
        FastTween(Icon, v5, { 0.2, "Sine", "Out" });
    end;
end;

function u1.new(p6) -- Line: 40
    -- upvalues: u1 (copy)
    local Instance2 = p6.Instance;
    local v7 = setmetatable({
        Instance = Instance2,
        Button = p6
    }, u1);
    v7.UIScale = Instance2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale");

    if not (v7.UIScale and v7.UIScale.Parent) then
        v7.UIScale.Parent = Instance2;
    end;

    local Icon = Instance2:FindFirstChild("Icon");

    if Icon and (Icon:IsA("ImageLabel") and not p6.Settings.DisableIconTween) then
        v7.DefaultIconRotation = Icon.Rotation;
        v7.Icon = Icon;
    end;

    return v7;
end;

return u1;