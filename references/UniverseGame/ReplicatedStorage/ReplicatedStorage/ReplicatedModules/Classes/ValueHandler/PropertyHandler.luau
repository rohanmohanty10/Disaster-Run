  

 

return {
    Get = function(p1) -- Line: 3, Name: Get
        return p1.Object[p1.Property];
    end,

    GetMin = function(p2) -- Line: 7, Name: GetMin
        if p2.MinProperty then
            return p2.Object:GetAttribute(p2.MinProperty);
        end;

        return p2.Metadata.Min;
    end,

    GetMax = function(p3) -- Line: 11, Name: GetMax
        if p3.MaxProperty then
            return p3.Object:GetAttribute(p3.MaxProperty);
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

        p4.Object[p4.Property] = p5;

        return p5;
    end
};