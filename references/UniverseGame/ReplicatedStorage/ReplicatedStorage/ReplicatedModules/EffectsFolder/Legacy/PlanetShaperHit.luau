  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"].PS.HITPE:Clone();
    v3.Parent = p1.Torso;
    v3:Emit(25);
    wait(1);
    v3:Destroy();
end;