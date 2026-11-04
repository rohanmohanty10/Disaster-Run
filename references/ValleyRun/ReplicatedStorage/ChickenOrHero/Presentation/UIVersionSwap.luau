 

 

local v1 = {};

local function at(p2, p3) -- Line: 11
    for i in string.gmatch(p3, "[^%.]+") do
        p2 = p2:FindFirstChild(i);

        if not p2 then
            return nil;
        end;
    end;

    return p2;
end;

local function collect(p4, p5) -- Line: 23
    -- upvalues: collect (copy)
    for _, child in p4:GetChildren() do
        if child:GetAttribute("Replaces") then
            table.insert(p5, child);
        elseif child:IsA("Folder") then
            collect(child, p5);
        end;
    end;

    return p5;
end;

function v1.swapIn(p6, p7) -- Line: 36
    -- upvalues: collect (copy), at (copy)
    local v8 = p7 or game;
    local OldUIReskin = p6:FindFirstChild("OldUIReskin");

    if OldUIReskin then
        OldUIReskin = OldUIReskin:FindFirstChild("Replacements");
    end;

    if not OldUIReskin then
        return true;
    end;

    for _, v in collect(OldUIReskin, {}) do
        local Attribute = v:GetAttribute("Replaces");
        local v9 = at(v8, Attribute);

        if v9 then
            local Parent = v9.Parent;
            v.Name = v9.Name;
            v9:Destroy();
            v:SetAttribute("Replaces", nil);
            v.Parent = Parent;
        else
            warn((`UIVersionSwap: nothing at {Attribute} for {v:GetFullName()}; that piece is left out`));
        end;
    end;

    OldUIReskin:Destroy();

    return true;
end;

return v1;