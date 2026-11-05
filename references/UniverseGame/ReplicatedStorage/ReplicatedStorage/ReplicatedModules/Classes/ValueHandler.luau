  

 

local u1 = {};
local Knit = require(script.Parent.Parent.KnitPackage.Knit);
local Trove = require(Knit.Util.Trove);
require(Knit.Util.Signal);
local AttributeHandler = require(script.AttributeHandler);
local PropertyHandler = require(script.PropertyHandler);
local RunService = game:GetService("RunService");

function u1.new(p2, p3, p4) -- Line: 12
    -- upvalues: u1 (copy), Trove (copy)
    local v5 = {};

    for i, v in u1 do
        v5[i] = v;
    end;

    v5.Trove = Trove.new();
    v5.Enabled = true;
    v5.Add = { 1, 3 };
    v5.AddTime = 1;
    v5.Delay = 1.5;
    v5.LastValue = nil;
    v5.Updating = false;
    v5.Interrupt = false;
    v5.Metadata = p4;
    v5:Initialize(p2, p3, p4);

    return v5;
end;

function u1.Enable(p6) -- Line: 40
    p6.Enabled = true;
    task.defer(p6.Check, p6);
end;

function u1.Disable(p7) -- Line: 45
    p7.Enabled = false;
end;

function u1.Initialize(u8, p9, p10, p11) -- Line: 50
    -- upvalues: AttributeHandler (copy), PropertyHandler (copy)
    if typeof(p9) == "Instance" then
        if p10 == "Attribute" then
            local Attribute = p11.Attribute;
            local _ = p11.MinAttribute;
            local _ = p11.MaxAttribute;
            u8.Object = p9;
            u8.Attribute = Attribute;
            u8.MinAttribute = p11.MinAttribute;
            u8.MaxAttribute = p11.MaxAttribute;
            u8.Trove:Clean();

            for i, v in AttributeHandler do
                u8[i] = v;
            end;

            u8.Trove:Connect(p9:GetAttributeChangedSignal(Attribute), function() -- Line: 68
                -- upvalues: u8 (copy)
                u8:Changed();
            end);
        elseif p10 == "Property" then
            local Property = p11.Property;
            local _ = p11.MinProperty;
            local _ = p11.MaxProperty;
            u8.Object = p9;
            u8.Property = Property;
            u8.MinProperty = p11.MinProperty;
            u8.MaxProperty = p11.MaxProperty;
            u8.Trove:Clean();

            for i, v in PropertyHandler do
                u8[i] = v;
            end;

            u8.Trove:Connect(p9:GetPropertyChangedSignal(u8.Property), function() -- Line: 88
                -- upvalues: u8 (copy)
                u8:Changed();
            end);
        end;

        u8.Trove:Connect(p9.AncestryChanged, function(p12, p13) -- Line: 93
            -- upvalues: u8 (copy)
            if p12:IsDescendantOf(game) then
                return;
            end;

            u8:Destroy();
        end);
    end;

    if p11 then
        u8.Add = p11.Add or u8.Add;
        u8.AddTime = p11.AddTime or 1;
        u8.Delay = p11.Delay or 1.5;
    end;
end;

function u1.GetAddValue(p14, p15) -- Line: 106
    local Add = p14.Add;
    local v16 = typeof(Add);

    if v16 == "function" then
        Add = Add(p15);
        v16 = typeof(Add);
    end;

    if v16 == "number" then
        return Add;
    end;

    if v16 == "table" and (Add[1] == Add[2] or p14.AddTime == 0) then
        return Add[1];
    end;

    local v17;

    if p15 then
        local v18 = os.clock() - p15;
        v17 = math.abs(v18);
    else
        v17 = p14.AddTime;
    end;

    return math.lerp(Add[1], Add[2], v17 / p14.AddTime);
end;

function u1.Changed(u19) -- Line: 126
    if not u19.Enabled then
        return;
    end;

    local v20 = u19:Get();

    if not u19.LastValue then
        u19.LastValue = v20 - u19:GetAddValue();
    end;

    local v21 = (u19:GetAddValue() > 0 and v20 < u19.LastValue or u19:GetAddValue() < 0 and u19.LastValue < v20) and true or false;
    u19.LastValue = v20;

    if v21 and u19.Updating then
        u19.Interrupt = true;
    end;

    task.defer(function() -- Line: 148
        -- upvalues: u19 (copy)
        repeat
            task.wait(0.1);
        until not u19.Interrupt or u19._Destroyed;

        if u19._Destroyed then
            return;
        end;

        u19:Check();
    end);
end;

function u1.Check(p22) -- Line: 158
    local v23 = p22:Get();
    local v24 = p22:GetMax();

    if not v23 then
        return;
    end;

    if p22:GetAddValue() > 0 and (not v24 or v23 < v24) or v23 > 0 then
        p22:Update();
    end;
end;

function u1.Update(p25) -- Line: 168
    -- upvalues: RunService (copy)
    if p25.Updating then
        return;
    end;

    if not p25.Enabled then
        return;
    end;

    p25.Updating = true;

    if p25.Delay and p25.Delay > 0 then
        local v26 = os.clock();

        while os.clock() < v26 + p25.Delay and not p25.Interrupt do
            RunService.Heartbeat:Wait();
        end;
    end;

    local v27 = os.clock();
    local v28 = os.clock() - 0.016666666666666666;

    if not p25.Interrupt then
        while not p25._Destroyed and (p25.Updating and (p25.Object and (not p25.Interrupt and p25.Enabled))) do
            local v29 = os.clock();
            local v30 = math.abs(v29 - v28);
            local v31 = p25:Get();
            local v32 = p25:GetMin();
            local v33 = p25:GetMax();

            if v33 and v33 <= v31 then
                if v33 < v31 then
                    p25:Set(v33);
                end;

                if p25:GetAddValue() > 0 then
                    break;
                end;
            elseif v32 and v31 <= v32 then
                if v31 < v32 then
                    p25:Set(v32);
                end;

                if p25:GetAddValue() < v32 then
                    break;
                end;
            end;

            p25:Set(v31 + p25:GetAddValue(v27) * v30);
            RunService.Heartbeat:Wait();
            v28 = v29;
        end;
    end;

    p25.Updating = false;
    p25.Interrupt = false;
end;

function u1.Destroy(p34) -- Line: 234
    p34._Destroyed = true;
    p34.Trove:Destroy();
end;

return u1;