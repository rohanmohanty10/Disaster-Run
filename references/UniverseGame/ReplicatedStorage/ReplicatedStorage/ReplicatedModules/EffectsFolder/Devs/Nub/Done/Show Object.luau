  

 

local function checkInheritance(p1, p2) -- Line: 1
    for _, v in ipairs(p2) do
        local v3 = p1:IsA(v);

        if v3 then
            return v3;
        end;
    end;
end;

return function(p4, p5, p6, p7, p8) -- Line: 8, Name: tweenObject
    local find = table.find;
    local v9 = type(p7) == "table" and p7 and p7 or {};
    local v10 = type(p8) == "table" and p8 and p8 or { "BasePart", "Decal" };
    local v11 = TweenInfo.new(unpack(p6));
    local v12 = type(p4) == "table" and p4 and p4 or p4:GetDescendants();
    local v13, v14, v15;
    v13, v14, v15 = ipairs(v12);

    while true do
        local v16, v17 = v13(v14, v15);

        if v16 == nil then
            break;
        end;

        v15 = v16;
        local v18;

        for _, v in ipairs(v10) do
            v18 = v17:IsA(v);

            if v18 then
                break;
            end;
        end;

        if v18 and not (find(v9, v17.Name) or find(v9, v17)) then
            game:GetService("TweenService"):Create(v17, v11, p5):Play();
        end;
    end;
end;