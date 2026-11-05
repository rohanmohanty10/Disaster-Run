  

 

local v1 = {};
local Parent = script.Parent;
local Frame = Parent.Frame;
local ScrollingFrame = Frame.ScrollingFrame;
local _ = Frame.Close;
local u2 = nil;

function v1.Open(p3, p4) -- Line: 12
    -- upvalues: Parent (copy), ScrollingFrame (copy), u2 (ref)
    if Parent.Enabled == false then
        Parent.Enabled = true;
    end;

    ScrollingFrame.Colosseum.MouseButton1Click:Connect(function() -- Line: 18
        -- upvalues: u2 (ref)
        if u2 == nil then
            u2 = "Colosseum";
        end;
    end);
    ScrollingFrame["Devil\'s Palm"].MouseButton1Click:Connect(function() -- Line: 24
        -- upvalues: u2 (ref)
        if u2 == nil then
            u2 = "Devil\'s Palm";
        end;
    end);
    ScrollingFrame.Field.MouseButton1Click:Connect(function() -- Line: 30
        -- upvalues: u2 (ref)
        if u2 == nil then
            u2 = "Field";
        end;
    end);
    ScrollingFrame.Forest.MouseButton1Click:Connect(function() -- Line: 36
        -- upvalues: u2 (ref)
        if u2 == nil then
            u2 = "Forest";
        end;
    end);
    ScrollingFrame.Park.MouseButton1Click:Connect(function() -- Line: 42
        -- upvalues: u2 (ref)
        if u2 == nil then
            u2 = "Park";
        end;
    end);

    repeat
        task.wait();
    until u2 ~= nil or (p4 == nil or p4.Humanoid:GetState() == Enum.HumanoidStateType.Dead);

    return u2;
end;

function v1.Close(p5) -- Line: 54
    -- upvalues: Parent (copy), u2 (ref)
    Parent:Destroy();

    return u2;
end;

return v1;