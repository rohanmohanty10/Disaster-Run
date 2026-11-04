 
 

game:GetService("RunService");

return {
    Weld = function(p1: table, p2: userdata, p3: userdata, p4, p5) -- Line: 5, Name: Weld
        if (typeof(p4) == "CFrame" or p4 == nil) and (typeof(p5) == "CFrame" or p5 == nil) then
            local v6 = p4 or CFrame.new();
            local v7 = p5 or CFrame.new();
            local Weld = Instance.new("Weld");

            if p2 and p3 then
                Weld.Name = string.format("%s 🡪 %s", p2.Name, p3.Name);
            end;

            Weld.Part0 = p2;
            Weld.Part1 = p3;
            Weld.C0 = v6;
            Weld.C1 = v7;
            Weld.Parent = p2;

            return Weld;
        end;
    end,

    Motor6D = function(p8: table, p9: userdata, p10: userdata, p11, p12, p13: string, p14: userdata) -- Line: 25, Name: Motor6D
        if (typeof(p11) == "CFrame" or p11 == nil) and (typeof(p12) == "CFrame" or p12 == nil) then
            local v15 = p11 or CFrame.new();
            local v16 = p12 or CFrame.new();
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Name = p13;
            Motor6D.Part0 = p9;
            Motor6D.Part1 = p10;
            Motor6D.C0 = v15;
            Motor6D.C1 = v16;
            Motor6D.Parent = p14;

            return Motor6D;
        end;
    end,

    GroupWeld = function(p17, p18, p19) -- Line: 46, Name: GroupWeld
        local PlayerFromCharacter = game:GetService("Players"):GetPlayerFromCharacter(p18);

        if p19 and p18 then
            local v20 = {};

            for _, child in p18:GetChildren() do
                if child:IsA("BasePart") then
                    table.insert(v20, child.Name);
                end;
            end;

            for _, descendant in pairs(p19:GetDescendants()) do
                if descendant:IsA("Weld") then
                    if table.find(v20, descendant.Name) then
                        descendant.Part1 = p18[descendant.Name];
                    end;
                elseif descendant:IsA("TextLabel") and PlayerFromCharacter then
                    local Data = PlayerFromCharacter.Data;
                    local Value = Data.JerseyName.Value;
                    local Value2 = Data.JerseyNumber.Value;

                    if Value == "" or Value == "None" then
                        Value = p18.Name;
                    end;

                    if descendant.Name == "ShirtName" then
                        descendant.Text = Value;
                    elseif descendant.Name == "Number" then
                        descendant.Text = Value2;
                    end;
                end;

                if descendant:IsA("BasePart") and descendant:GetAttribute("BodyColor") == true then
                    descendant.Color = p18:FindFirstChild("Torso") and p18.Torso.Color or Color3.fromRGB(255, 255, 255);
                end;
            end;
        end;
    end
};