 

 

local TweenService = game:GetService("TweenService");
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 5
    -- upvalues: u1 (copy)
    local u4 = setmetatable({
        sequence = 0,
        gui = p2,
        config = p3
    }, u1);
    u4.value = Instance.new("NumberValue");
    u4.value.Value = 0;
    u4.panels = {};

    for _, child in p2.Mask:GetChildren() do
        if child:IsA("Frame") then
            table.insert(u4.panels, child);
        end;
    end;

    u4.changed = u4.value.Changed:Connect(function() -- Line: 15
        -- upvalues: u4 (copy)
        u4:draw();
    end);
    u4.resized = p2.Mask:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 18
        -- upvalues: u4 (copy)
        u4:draw();
    end);
    u4:draw();

    return u4;
end;

function u1.draw(p5) -- Line: 24
    local AbsoluteSize = p5.gui.Mask.AbsoluteSize;
    local math_max_ret = math.max(AbsoluteSize.Magnitude, 1);
    local v6 = p5.value.Value * math_max_ret * 0.53;

    for _, v in p5.panels do
        local Attribute = v:GetAttribute("Angle");
        v.Size = UDim2.fromOffset(math_max_ret * 2, math_max_ret * 2);
        v.Position = UDim2.fromOffset(AbsoluteSize.X * 0.5 + math.cos(Attribute) * (v6 + math_max_ret), AbsoluteSize.Y * 0.5 + math.sin(Attribute) * (v6 + math_max_ret));
    end;

    p5.gui.Blackout.Visible = p5.value.Value <= 0.001;
end;

function u1.animate(u7, p8) -- Line: 40
    -- upvalues: TweenService (copy)
    u7.sequence = u7.sequence + 1;
    local sequence = u7.sequence;

    if u7.tween then
        u7.tween:Cancel();
    end;

    u7.gui.Enabled = true;
    u7.gui.InputBlocker.Visible = true;
    u7.gui.Mask.Visible = true;

    local function step(p9, p10, p11, p12) -- Line: 49
        -- upvalues: u7 (copy), TweenService (ref), sequence (copy)
        u7.tween = TweenService:Create(u7.value, TweenInfo.new(p10, p11, p12), {
            Value = p9
        });
        local tween = u7.tween;
        local u13 = false;
        local v14 = tween.Completed:Connect(function() -- Line: 53
            -- upvalues: u13 (ref)
            u13 = true;
        end);
        tween:Play();
        local v15 = os.clock() + p10 + 1;

        while sequence == u7.sequence and (not u13 and os.clock() < v15) do
            task.wait();
        end;

        v14:Disconnect();

        if sequence == u7.sequence then
            if not u13 then
                tween:Cancel();
            end;

            u7.value.Value = p9;
        end;

        return sequence == u7.sequence;
    end;

    if p8 then
        if not step(0.55, u7.config.OpenTime * 0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out) then
            return false;
        end;

        if not step(1, u7.config.OpenTime * 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) then
            return false;
        end;
    elseif not step(0, u7.config.CloseTime, Enum.EasingStyle.Quint, Enum.EasingDirection.In) then
        return false;
    end;

    if p8 then
        u7.gui.Mask.Visible = false;
        u7.gui.Blackout.Visible = false;
        u7.gui.InputBlocker.Visible = false;
        u7.gui.Enabled = false;
    end;

    return true;
end;

function u1.forceOpen(p16) -- Line: 89
    p16.sequence = p16.sequence + 1;

    if p16.tween then
        p16.tween:Cancel();
    end;

    p16.value.Value = 1;
    p16.gui.Enabled = false;
    p16.gui.Mask.Visible = false;
    p16.gui.Blackout.Visible = false;
    p16.gui.InputBlocker.Visible = false;
end;

function u1.destroy(p17) -- Line: 100
    p17:forceOpen();
    p17.changed:Disconnect();
    p17.resized:Disconnect();
    p17.value:Destroy();
    p17.gui:Destroy();
end;

return u1;