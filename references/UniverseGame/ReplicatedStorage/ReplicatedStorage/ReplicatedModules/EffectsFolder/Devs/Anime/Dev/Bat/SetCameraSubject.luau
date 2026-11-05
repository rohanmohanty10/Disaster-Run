  

 

local CurrentCamera = workspace.CurrentCamera;

return function(p1) -- Line: 3
    -- upvalues: CurrentCamera (copy)
    if p1 then
        CurrentCamera.CameraSubject = p1;
    end;
end;