  

 

return function(p1) -- Line: 1
    if p1.Humanoid:GetAttribute("CustomDeathEffect") then
        return;
    end;

    game.Workspace.CurrentCamera.CameraSubject = p1.Head;
end;