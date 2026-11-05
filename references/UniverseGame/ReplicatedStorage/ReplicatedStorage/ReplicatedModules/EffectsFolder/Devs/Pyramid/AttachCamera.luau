  

 

local u1 = nil;

return function(u2) -- Line: 2
    -- upvalues: u1 (ref)
    if u2 == "Detach" and u1 then
        u1:Disconnect();
        u1 = nil;
    end;

    if u1 ~= nil then
        return;
    end;

    u1 = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 8
        -- upvalues: u2 (copy)
        workspace.CurrentCamera.CFrame = u2.CFrame;
    end);
end;