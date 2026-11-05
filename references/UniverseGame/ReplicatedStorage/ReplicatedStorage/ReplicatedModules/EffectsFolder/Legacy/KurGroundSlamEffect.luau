  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"].Kur.ground:Clone();
    v3.Parent = game.workspace.Effects;

    if p1 then
        if typeof(p1) == "CFrame" then
            v3.CFrame = p1;
        else
            v3.CFrame = p1.CFrame;
        end;
    end;

    v3.Particle1:Emit(v3.Particle1.Rate / 35);
    v3.Particle2:Emit(v3.Particle2.Rate / 35);
    v3.Particle3:Emit(v3.Particle3.Rate / 35);
    v3.Particle4:Emit(v3.Particle4.Rate / 35);
    v3.Attachment.vroom:Emit(v3.Attachment.vroom.Rate / 4);
    game.Debris:AddItem(v3, p2);
end;