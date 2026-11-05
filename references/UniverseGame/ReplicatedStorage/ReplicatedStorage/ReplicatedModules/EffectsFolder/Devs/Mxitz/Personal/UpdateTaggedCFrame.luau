  

 

local CollectionService = game:GetService("CollectionService");

return function(p1, p2) -- Line: 3
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged(p1) do
        if v:IsA("BasePart") then
            v.CFrame = p2;
        end;
    end;
end;