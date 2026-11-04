 

 

return function(p1) -- Line: 8
    function p1.GetEmitData(p2, p3, p4) -- Line: 11
        local Data = p2:GetData(p3);

        if p4 then
            p4 = p4.Overrides;
        end;

        if not (Data and p4) then
            return Data;
        end;

        if p4.LinkMode ~= nil then
            Data.LinkMode = p4.LinkMode;
        end;

        if p4.EmitParent ~= nil then
            Data.EmitParent = p4.EmitParent;
        end;

        return Data;
    end;
end;