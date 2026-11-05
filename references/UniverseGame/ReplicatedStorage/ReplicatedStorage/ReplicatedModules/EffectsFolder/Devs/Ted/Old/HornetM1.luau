  

 

return function(p1) -- Line: 1
    local HumanoidRootPart = p1.Character.HumanoidRootPart;
    local v2 = game.ReplicatedStorage["Client Assets"].Slashes:Clone();
    v2.CFrame = HumanoidRootPart.CFrame;
    v2.Parent = workspace.Effects;

    if math.random(1, 2) == 2 then
        v2.MPat1.s1.Enabled = true;
    else
        v2.MPat3.s1.Enabled = true;
    end;

    game.Debris:AddItem(v2, 0.25);
end;