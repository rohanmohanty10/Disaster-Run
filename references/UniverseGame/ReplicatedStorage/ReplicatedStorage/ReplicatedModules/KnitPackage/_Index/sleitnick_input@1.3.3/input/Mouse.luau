  

 

local Trove = require(script.Parent.Parent.Trove);
local Signal = require(script.Parent.Parent.Signal);
local UserInputService = game:GetService("UserInputService");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 65
    -- upvalues: u1 (copy), Trove (copy), Signal (copy), UserInputService (copy)
    local u2 = setmetatable({}, u1);
    u2._trove = Trove.new();
    u2.LeftDown = u2._trove:Construct(Signal);
    u2.LeftUp = u2._trove:Construct(Signal);
    u2.RightDown = u2._trove:Construct(Signal);
    u2.RightUp = u2._trove:Construct(Signal);
    u2.Scrolled = u2._trove:Construct(Signal);
    u2._trove:Connect(UserInputService.InputBegan, function(p3, p4) -- Line: 77
        -- upvalues: u2 (copy)
        if p4 then
            return;
        end;

        if p3.UserInputType == Enum.UserInputType.MouseButton1 then
            u2.LeftDown:Fire();

            return;
        end;

        if p3.UserInputType == Enum.UserInputType.MouseButton2 then
            u2.RightDown:Fire();
        end;
    end);
    u2._trove:Connect(UserInputService.InputEnded, function(p5, p6) -- Line: 86
        -- upvalues: u2 (copy)
        if p6 then
            return;
        end;

        if p5.UserInputType == Enum.UserInputType.MouseButton1 then
            u2.LeftUp:Fire();

            return;
        end;

        if p5.UserInputType == Enum.UserInputType.MouseButton2 then
            u2.RightUp:Fire();
        end;
    end);
    u2._trove:Connect(UserInputService.InputChanged, function(p7, p8) -- Line: 95
        -- upvalues: u2 (copy)
        if p8 then
            return;
        end;

        if p7.UserInputType == Enum.UserInputType.MouseWheel then
            u2.Scrolled:Fire(p7.Position.Z);
        end;
    end);

    return u2;
end;

function u1.IsLeftDown(p9) -- Line: 110
    -- upvalues: UserInputService (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1);
end;

function u1.IsRightDown(p10) -- Line: 118
    -- upvalues: UserInputService (copy)
    return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2);
end;

function u1.GetPosition(p11) -- Line: 126
    -- upvalues: UserInputService (copy)
    return UserInputService:GetMouseLocation();
end;

function u1.GetDelta(p12) -- Line: 141
    -- upvalues: UserInputService (copy)
    return UserInputService:GetMouseDelta();
end;

function u1.GetRay(p13, p14) -- Line: 150
    -- upvalues: UserInputService (copy)
    local v15 = p14 or UserInputService:GetMouseLocation();

    return workspace.CurrentCamera:ViewportPointToRay(v15.X, v15.Y);
end;

function u1.Raycast(p16, p17, p18, p19) -- Line: 178
    local v20 = p16:GetRay(p19);

    return workspace:Raycast(v20.Origin, v20.Direction * (p18 or 1000), p17);
end;

function u1.Project(p21, p22, p23) -- Line: 207
    local v24 = p21:GetRay(p23);

    return v24.Origin + v24.Direction.Unit * (p22 or 1000);
end;

function u1.Lock(p25) -- Line: 222
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition;
end;

function u1.LockCenter(p26) -- Line: 234
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter;
end;

function u1.Unlock(p27) -- Line: 242
    -- upvalues: UserInputService (copy)
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
end;

function u1.Destroy(p28) -- Line: 250
    p28._trove:Destroy();
end;

return u1;