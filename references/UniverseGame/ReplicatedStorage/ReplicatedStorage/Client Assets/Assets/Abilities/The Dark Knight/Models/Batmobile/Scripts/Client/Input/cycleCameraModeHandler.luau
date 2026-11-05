  

 

local CycleCameraMode = script.Parent.Parent.Camera.CycleCameraMode;

return function(p1, p2) -- Line: 3, Name: cycleCameraModeHandler
    -- upvalues: CycleCameraMode (copy)
    if p2 == Enum.UserInputState.Begin then
        CycleCameraMode:Fire();
    end;
end;