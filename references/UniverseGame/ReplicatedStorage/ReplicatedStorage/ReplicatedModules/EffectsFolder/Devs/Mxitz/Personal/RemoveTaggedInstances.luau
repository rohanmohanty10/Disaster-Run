  

 

local CollectionService = game:GetService("CollectionService");

return function(p1) -- Line: 3
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged(p1) do
        v:Destroy();
    end;
end;