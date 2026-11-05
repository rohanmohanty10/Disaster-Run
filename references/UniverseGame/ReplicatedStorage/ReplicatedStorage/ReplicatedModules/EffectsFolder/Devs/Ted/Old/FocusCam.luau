  

 

return function(p1, p2, p3) -- Line: 1
    local CurrentCamera = workspace.CurrentCamera;

    if p3 then
        CurrentCamera.CameraSubject = p2.Humanoid;

        return;
    end;

    CurrentCamera.CameraSubject = p1.Humanoid;
end;