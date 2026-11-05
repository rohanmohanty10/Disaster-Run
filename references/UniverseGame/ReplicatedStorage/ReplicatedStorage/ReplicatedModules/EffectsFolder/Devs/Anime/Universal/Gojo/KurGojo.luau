  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"].Kur.GojoTeleport:Clone();
    v3.Parent = workspace.Effects;
    v3.CFrame = p1.CFrame;
    v3.Attachment.vroom:Emit(v3.Attachment.vroom.Rate / 4);
    task.delay(1, v3.Destroy, v3);
end;