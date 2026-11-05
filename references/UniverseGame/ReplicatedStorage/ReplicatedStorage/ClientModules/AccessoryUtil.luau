  

 

return {
    Add = function(p1, p2, p3, p4, p5) -- Line: 3, Name: Add
        local v6 = p5 and p4 and p4 or Instance.new("Model");
        v6:SetAttribute("Accessory", true);
        v6.Name = p3;
        v6.Parent = p2;

        for _, child in pairs(p4:GetChildren()) do
            local v7 = p5 and child and child or child:Clone();
            local v8 = p2[child.Name];
            v7.CFrame = v8.CFrame;
            local Weld = Instance.new("Weld");
            Weld.Part0 = v7;
            Weld.Part1 = v8;
            Weld.Parent = v7;
            v7.Parent = v6;
        end;

        return v6;
    end,

    AddMotorSetup = function(p9, p10, p11, p12, p13) -- Line: 26, Name: AddMotorSetup
        local v14 = p13 and p12 and p12 or Instance.new("Model");
        v14:SetAttribute("Accessory", true);
        v14.Name = p11;
        v14.Parent = p10;

        for _, child in pairs(p12:GetChildren()) do
            for _, child2 in pairs(child:GetChildren()) do
                if child2:IsA("Motor6D") then
                    local v15 = p13 and child2.Part1 or child2.Part1:Clone();
                    local v16 = p13 and child2 and child2 or child2:Clone();
                    v16.Part0 = p10[child.Name];
                    v16.Part1 = v15;
                    v15.Parent = v16;
                    v16.Parent = v14;
                end;
            end;
        end;

        return v14;
    end,

    Remove = function(p17, p18, p19) -- Line: 50, Name: Remove
        local v20 = p18:FindFirstChild(p19);

        if v20 then
            v20:Destroy();
        end;
    end
};