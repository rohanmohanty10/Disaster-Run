  

 

local u1 = {};
u1.__index = u1;
local Button = script.Button;
local Parent = script.Parent;

local function DefaultTransform(...) -- Line: 7
    return ...;
end;

function u1.new(p2, p3) -- Line: 11
    -- upvalues: u1 (copy)
    local v4 = {
        MetaData = p2,
        Trove = p3.new()
    };
    setmetatable(v4, u1);

    return v4;
end;

function u1.AddOption(u5, p6) -- Line: 19
    -- upvalues: Button (copy), DefaultTransform (copy), Parent (copy)
    local Index = p6.Index;
    local Option = p6.Option;
    local Transform = p6.Transform;
    local Callback = p6.Callback;
    local Delay = p6.Delay;
    local u7 = u5.Trove:Clone(Button);
    u7.TextLabel.Text = Option;

    if p6.RichText then
        u7.TextLabel.RichText = true;
        u7.TextLabel.UIGradient.Enabled = false;
    end;

    if type(Transform) ~= "function" then
        Transform = DefaultTransform;
    end;

    local u8 = {
        Index = Index,
        Choice = Index,
        Name = Option
    };

    local function Activate() -- Line: 41
        -- upvalues: u5 (copy), Callback (copy), Transform (ref), u8 (copy)
        u5:Destroy();
        Callback(Transform(u8));
    end;

    if type(Delay) == "number" then
        u7.TextLabel.TextTransparency = 0.5;
        task.delay(Delay, function() -- Line: 48
            -- upvalues: u7 (copy), Activate (copy)
            u7.TextLabel.TextTransparency = 0;
            u7.MouseButton1Click:Connect(Activate);
        end);
    else
        u7.MouseButton1Click:Connect(Activate);
    end;

    u7.Visible = true;
    u7.Parent = Parent.Frame.Buttons;
end;

function u1.IsDestroyed(p9) -- Line: 60
    return p9.Destroyed;
end;

function u1.Destroy(p10) -- Line: 64
    p10.MetaData.UI.Prompt.Visible = false;
    p10.Trove:Destroy();
    p10.Destroyed = true;
end;

return u1;