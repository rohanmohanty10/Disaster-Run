  

 

local CurrentCamera = workspace.CurrentCamera;

return function(p1) -- Line: 2
    -- upvalues: CurrentCamera (copy)
    local v2 = nil;

    for _, v in ipairs(p1) do
        if v.Values.Lives.Value > 0 then
            v2 = v;
            break;
        end;
    end;

    local HumanoidRootPart = v2.Character.HumanoidRootPart;
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    local Position = (HumanoidRootPart.CFrame * CFrame.new(0, 5, -15)).Position;
    CurrentCamera.CFrame = CFrame.lookAt(Position, HumanoidRootPart.CFrame.Position);
end;