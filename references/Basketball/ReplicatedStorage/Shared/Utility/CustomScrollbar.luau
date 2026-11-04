 
 

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: userdata) -- Line: 6
    -- upvalues: u1 (copy)
    return setmetatable({
        Frame = p2,
        Bar = p3
    }, u1);
end;

function u1.Destroy(p4) -- Line: 15
    p4:Stop();
end;

function u1.Start(u5) -- Line: 19
    -- upvalues: RunService (copy)
    u5:Stop();
    u5._Connection = RunService.RenderStepped:Connect(function() -- Line: 22
        -- upvalues: u5 (copy)
        local AbsoluteCanvasSize = u5.Frame.AbsoluteCanvasSize;
        local v6 = u5.Frame.AbsoluteWindowSize.Y / AbsoluteCanvasSize.Y;

        if v6 > 0.99 then
            u5.Bar.Visible = false;
        else
            u5.Bar.Visible = true;
            u5.Bar.Size = UDim2.new(u5.Bar.Size.X.Scale, u5.Bar.Size.X.Offset, v6, u5.Bar.Size.Y.Offset);
        end;

        u5.Bar.Position = UDim2.new(u5.Bar.Position.X.Scale, u5.Bar.Position.X.Offset, u5.Frame.CanvasPosition.Y / AbsoluteCanvasSize.Y, u5.Bar.Position.Y.Offset);
    end);
end;

function u1.Stop(p7) -- Line: 49
    if not p7._Connection then
        return;
    end;

    p7._Connection:Disconnect();
    p7._Connection = nil;
end;

return u1;