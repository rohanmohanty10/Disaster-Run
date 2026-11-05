  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"].xChara.xCharaTeleport:Clone();
    v3.Parent = game.workspace.Effects;
    task.delay(p2 or 1, v3.Destroy, v3);
    v3.CFrame = p1.CFrame;
    v3.Attachment.vroom:Emit(v3.Attachment.vroom.Rate / 4);
end;