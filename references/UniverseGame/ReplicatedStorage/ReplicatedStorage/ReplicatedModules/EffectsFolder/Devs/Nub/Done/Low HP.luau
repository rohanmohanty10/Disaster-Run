  

 

return function(p1, p2) -- Line: 1
    local Character = p1.Character;
    local Decal = Instance.new("Decal");
    Decal.Name = "BloodDecal";
    local v3 = { "Front", "Back", "Left", "Right", "Top", "Bottom" };
    local v4 = { "Left Arm", "Right Arm", "Head", "Torso", "Right Leg", "Left Leg" };

    if p2 then
        for _, child in ipairs(Character:GetChildren()) do
            if child:IsA("BasePart") and (not child:FindFirstChild("BloodDecal") and table.find(v4, child.Name)) then
                for _, v in ipairs(v3) do
                    local v5 = Decal:Clone();
                    v5.Face = Enum.NormalId[v];

                    if child.Name == "Head" then
                        v5.Texture = "http://www.roblox.com/asset/?id=6984560173";
                    else
                        v5.Texture = "http://www.roblox.com/asset/?id=6984561784";
                    end;

                    v5.Parent = child;
                end;
            end;
        end;

        return;
    end;

    for _, child in ipairs(Character:GetChildren()) do
        if child:FindFirstChild("BloodDecal") then
            child.BloodDecal:Destroy();
        end;
    end;
end;