  

 

local CollectionService = game:GetService("CollectionService");

return function(p1) -- Line: 3
    -- upvalues: CollectionService (copy)
    if p1 then
        local v2 = nil;
        local v3 = nil;

        if typeof(p1) == "Instance" then
            v2 = p1.CFrame;
            v3 = p1.Size;
        elseif typeof(p1) == "CFrame" then
            v3 = Vector3.new(4, 4, 4);
        elseif typeof(p1) == "Vector3" then
            v2 = CFrame.new(p1);
            v3 = Vector3.new(4, 4, 4);
        end;

        local v4 = OverlapParams.new();
        v4.FilterType = Enum.RaycastFilterType.Whitelist;
        v4.FilterDescendantsInstances = CollectionService:GetTagged("TimeZone");
        v4.MaxParts = 5;

        return #workspace:GetPartBoundsInBox(v2, v3, v4) > 0;
    end;
end;