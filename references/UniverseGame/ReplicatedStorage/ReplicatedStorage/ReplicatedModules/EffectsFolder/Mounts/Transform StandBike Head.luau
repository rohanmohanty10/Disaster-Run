  

 

local RunService = game:GetService("RunService");

return function(p1, p2) -- Line: 3
    -- upvalues: RunService (copy)
    local u3 = p1:WaitForChild("Stand Bike", 5);

    if not u3 then
        return;
    end;

    local u4 = workspace.Effects:WaitForChild(p2, 5):WaitForChild("Stand Head", 3);
    local BikeHandleBone = u3:WaitForChild("BikeRoot", 3):WaitForChild("BikeControlBone", 3):WaitForChild("BikeHandleBone", 3);

    if not (u4 and BikeHandleBone) then
        return;
    end;

    local u5 = nil;
    u5 = RunService.RenderStepped:Connect(function() -- Line: 16
        -- upvalues: u3 (copy), u5 (ref), u4 (copy), BikeHandleBone (copy)
        if u3:IsDescendantOf(game) then
            u4.CFrame = BikeHandleBone.WorldCFrame * CFrame.Angles(0, 1.5707963267948966, 3.141592653589793) * CFrame.new(0, -0.75, -0.75) * CFrame.Angles(-0.5235987755982988, 0, 0);

            return;
        end;

        u5:Disconnect();
        u5 = nil;
    end);
end;