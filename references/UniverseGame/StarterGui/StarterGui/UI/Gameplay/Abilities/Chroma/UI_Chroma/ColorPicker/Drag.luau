  

 

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1.New(p2) -- Line: 7
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.Instance = p2;
    v3.Active = false;

    return v3;
end;

function u1.Start(u4) -- Line: 15
    -- upvalues: UserInputService (copy), RunService (copy)
    if not u4.Active then
        u4.Active = true;
        local u5 = UserInputService:GetMouseLocation();
        local Position = u4.Instance.Position;
        u4._dragFunc = RunService.Heartbeat:Connect(function() -- Line: 21
            -- upvalues: UserInputService (ref), u5 (copy), u4 (copy), Position (copy)
            local v6 = UserInputService:GetMouseLocation() - u5;
            u4.Instance.Position = Position + UDim2.fromOffset(v6.X, v6.Y);
        end);
    end;
end;

function u1.Stop(p7) -- Line: 29
    p7.Active = false;

    if p7._dragFunc then
        p7._dragFunc:Disconnect();
        p7._dragFunc = nil;
    end;
end;

return u1;