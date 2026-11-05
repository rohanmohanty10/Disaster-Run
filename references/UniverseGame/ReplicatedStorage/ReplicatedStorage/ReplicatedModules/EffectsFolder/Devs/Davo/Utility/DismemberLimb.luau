  

 

return function(p1, p2) -- Line: 1
    if not p1 or p1:GetAttribute("BeenDismembered") then
        return;
    end;

    local v3 = script.Rig:Clone();
    local Parent = p1.Parent;
    local v4 = v3:FindFirstChild(p1.Name);
    local v5 = v3:GetChildren();
    local v6 = Parent:GetChildren();

    for _, v in v6 do
        if v:IsA("Shirt") or (v:IsA("Pants") or (v:IsA("ShirtGraphic") or (v:IsA("CharacterMesh") or v:IsA("BodyColors")))) then
            v:Clone().Parent = v3;
        end;
    end;

    for _, v in v5 do
        if v:IsA("BasePart") and v ~= v4 then
            v:Destroy();
        end;
    end;

    v4.CanCollide = true;
    v4.Anchored = false;
    v4.Massless = false;
    v4.Color = p1.Color;
    v4.CFrame = p1.CFrame;
    local v7 = v4:Clone();
    v7.Name = "CP";
    v7.Transparency = 1;
    v7.Parent = v4;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = v4;
    WeldConstraint.Part1 = v7;
    WeldConstraint.Parent = v7;
    v3.Parent = workspace.Effects;
    p1:SetAttribute("BeenDismembered", true);
    local v8 = p1:FindFirstChildOfClass("SpecialMesh");

    if v8 then
        v8.Parent = v4;
    end;

    Instance.fromExisting(script.TransparencyMesh).Parent = p1;
    game:GetService("Debris"):AddItem(v3, p2 or 5);
    table.clear(v5);
    table.clear(v6);
end;