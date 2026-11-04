 

 

local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function partsOf(p3) -- Line: 11
    -- upvalues: u2 (copy)
    local v4 = u2[p3];

    if not v4 then
        v4 = {};

        for _, descendant in p3:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Decal") then
                local Attribute = descendant:GetAttribute("KnifeTransparency");

                if type(Attribute) ~= "number" then
                    Attribute = descendant.Transparency;
                    descendant:SetAttribute("KnifeTransparency", Attribute);
                end;

                table.insert(v4, descendant);
                table.insert(v4, Attribute);
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or (descendant:IsA("Beam") or descendant:IsA("Light"))) then
                local Attribute = descendant:GetAttribute("KnifeEffectOn");

                if type(Attribute) ~= "boolean" then
                    Attribute = descendant.Enabled;
                    descendant:SetAttribute("KnifeEffectOn", Attribute);
                end;

                table.insert(v4, descendant);
                table.insert(v4, Attribute);
            end;
        end;

        u2[p3] = v4;
    end;

    return v4;
end;

function v1.set(p5, p6) -- Line: 40
    -- upvalues: partsOf (copy)
    local v7 = p6 and 0 or 1;

    if p5:IsA("BasePart") and p5.Transparency ~= v7 then
        p5.Transparency = v7;
    end;

    local v8 = partsOf(p5);

    for i = 1, #v8, 2 do
        local v9 = v8[i];
        local v10 = v8[i + 1];
        local v11;

        if type(v10) == "boolean" then
            local v12 = p6 and v10;

            if v9.Enabled == v12 then
                v11 = i;
            else
                v9.Enabled = v12;

                if v12 or not v9:IsA("ParticleEmitter") then
                    v11 = i;
                else
                    v9:Clear();
                    v11 = i;
                end;
            end;
        else
            local v13 = p6 and v10 and v10 or 1;

            if v9.Transparency == v13 then
                v11 = i;
            else
                v9.Transparency = v13;
                v11 = i;
            end;
        end;
    end;
end;

return table.freeze(v1);