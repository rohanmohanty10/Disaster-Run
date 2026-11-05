  

 

local CollectionService = game:GetService("CollectionService");

return {
    FindNearest = function(p1) -- Line: 4, Name: FindNearest
        -- upvalues: CollectionService (copy)
        local Distance = p1.Distance;
        local Origin = p1.Origin;
        local v2 = p1.Ignore or {};
        local v3 = {};

        for _, v in ipairs(p1.Objects or workspace.Living:GetChildren()) do
            if v:IsA("Player") then
                local v = v.Character or v;
            end;

            if not (CollectionService:HasTag(v, "Intangible") or table.find(v2, v)) then
                local v4 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

                if v4 and (v4.Position - Origin.Position).Magnitude <= Distance then
                    table.insert(v3, v);
                end;
            end;
        end;

        table.sort(v3, function(p5, p6) -- Line: 22
            -- upvalues: Origin (copy)
            local v7 = p5:IsA("Model") and p5.PrimaryPart or p5:FindFirstChild("HumanoidRootPart");
            local v8 = p6:IsA("Model") and p6.PrimaryPart or p6:FindFirstChild("HumanoidRootPart");

            return (v7.Position - Origin.Position).Magnitude < (v8.Position - Origin.Position).Magnitude;
        end);

        for _, v in ipairs(v3) do
            local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
        end;

        return p1.Multiple and v3 and v3 or v3[1];
    end
};