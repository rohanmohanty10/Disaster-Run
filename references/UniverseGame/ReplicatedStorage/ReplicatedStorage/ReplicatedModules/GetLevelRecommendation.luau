  

 

local u4 = {
    GetRegionNameForLevel = function(p1) -- Line: 3, Name: GetRegionNameForLevel
        local v2 = 1;
        local v3 = "Center City";

        for _, child in workspace:WaitForChild("MappedRegions"):GetChildren() do
            local RegionName = child:FindFirstChild("RegionName");
            local RegionLevelRecommendation = child:FindFirstChild("RegionLevelRecommendation");

            if RegionLevelRecommendation and RegionName then
                local Value = RegionLevelRecommendation.Value;
                local Value2 = RegionName.Value;

                if v2 < Value and Value <= p1 then
                    v3 = Value2;
                    v2 = Value;
                end;
            end;
        end;

        return v3;
    end
};

function u4.DidRegionNameChange(p5, p6) -- Line: 24
    -- upvalues: u4 (copy)
    return (u4.GetRegionNameForLevel(p5 or 0) or "None") ~= (u4.GetRegionNameForLevel(p6 or 0) or "None");
end;

return u4;