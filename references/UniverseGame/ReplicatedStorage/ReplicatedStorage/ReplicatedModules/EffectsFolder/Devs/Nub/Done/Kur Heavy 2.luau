  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = game:GetService("ReplicatedStorage")["Client Assets"]["Hit Effects"].Heavy2:Clone();
    local br = v4.br;
    v4.CFrame = (p1.Torso or p1.PrimaryPart).CFrame;
    v4.Parent = workspace.Effects;
    game:GetService("Debris"):AddItem(v4, 3);
    local v5 = { 3016457791, 3016457978, 3016458179, 3016458353, 3016458471, 3016458635, 3016458751, 3016458856 };
    local v6 = math.random(-180, 180);

    for i = 1, #v5 do
        br.Texture = "rbxassetid://" .. v5[i];
        br.Lifetime = NumberRange.new(i / 65 + 0.1);
        br.Rotation = NumberRange.new(v6);
        br:Emit(1);
        task.wait(i / 65 + 0);
    end;
end;