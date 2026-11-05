 
-- Decompiled with Potassium's decompiler.

return {
    activateQTE = function(p1, p2, p3, p4) --[[ Name: activateQTE, Line 4 ]]
        if script:FindFirstChild(p3) then
            if p1 or p2 then
                return require(script[p3]):activate(p1, p2, p4);
            end;
        end;
    end
};