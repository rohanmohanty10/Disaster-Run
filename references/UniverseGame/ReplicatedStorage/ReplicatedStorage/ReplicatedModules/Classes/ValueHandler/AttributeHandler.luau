  

 

return {
    Get = function(p1) -- Line: 3, Name: Get
        return p1.Object:GetAttribute(p1.Attribute);
    end,

    GetMin = function(p2) -- Line: 7, Name: GetMin
        if p2.MinAttribute then
            return p2.Object:GetAttribute(p2.MinAttribute);
        end;

        return p2.Metadata.Min;
    end,

    GetMax = function(p3) -- Line: 11, Name: GetMax
        if p3.MaxAttribute then
            return p3.Object:GetAttribute(p3.MaxAttribute);
        end;

        return p3.Metadata.Max;
    end,

    Set = function(p4, p5) -- Line: 15, Name: Set
        local v6 = p4:GetMin();
        local v7 = p4:GetMax();

        if v6 then
            p5 = math.max(p5, v6);
        end;

        if v7 then
            p5 = math.min(p5, v7);
        end;

        p4.Object:SetAttribute(p4.Attribute, p5);

        return p5;
    end
};