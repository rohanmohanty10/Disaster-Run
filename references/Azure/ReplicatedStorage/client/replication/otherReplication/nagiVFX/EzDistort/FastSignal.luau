 

 

local BindableEvent = Instance.new("BindableEvent");
local u1 = false;
BindableEvent.Event:Connect(function() -- Line: 15
    -- upvalues: u1 (ref)
    u1 = true;
end);
BindableEvent:Fire();
BindableEvent:Destroy();

return (u1 == false and true or false) and require(script.Deferred) or require(script.Immediate);