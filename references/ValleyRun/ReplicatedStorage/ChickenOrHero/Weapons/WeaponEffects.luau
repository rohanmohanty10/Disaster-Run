 

 

local u3 = {
    Tag = "ValleyWeaponVFX",
    FadeStart = 60,
    MaxDistance = 100,

    position = function(p1) -- Line: 3, Name: position
        for _, child in p1:GetChildren() do
            if child:IsA("BasePart") and child:GetAttribute("WeaponVFX") == true then
                local VFXWeld = child:FindFirstChild("VFXWeld");

                if VFXWeld and (VFXWeld:IsA("Weld") and (VFXWeld.Part0 and VFXWeld.Part1 == child)) then
                    child.CFrame = VFXWeld.Part0.CFrame * VFXWeld.C0 * VFXWeld.C1:Inverse();
                end;
            end;
        end;
    end,

    detail = function(p2) -- Line: 13, Name: detail
        local Value = p2.Value;

        return Value > 0 and Value <= 3 and 0.6 or 1;
    end
};

function u3.update(p4, p5, p6) -- Line: 18
    -- upvalues: u3 (copy)
    local VFXWeld = p4:FindFirstChild("VFXWeld");
    local v7 = VFXWeld and VFXWeld:IsA("Weld") and VFXWeld.Part0;
    local v8;

    if p5 == nil then
        v8 = false;
    else
        v8 = p4:IsDescendantOf(workspace) and (v7 and v7:IsDescendantOf(workspace));

        if v8 then
            if v7.Transparency < 0.99 then
                v8 = v7.LocalTransparencyModifier < 0.99;
            else
                v8 = false;
            end;
        end;
    end;

    local v9 = v8 and math.clamp((u3.MaxDistance - (v8 and ((p5 - p4.Position).Magnitude or (1 / 0)) or (1 / 0))) / (u3.MaxDistance - u3.FadeStart), 0, 1) * (p6 or 1) or 0;

    for _, descendant in p4:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local v10;

            if v9 > 0 then
                v10 = descendant:GetAttribute("VFXAuthoredEnabled") ~= false;
            else
                v10 = false;
            end;

            local Attribute = descendant:GetAttribute("VFXBaseRate");

            if Attribute == nil then
                Attribute = descendant.Rate;
                descendant:SetAttribute("VFXBaseRate", Attribute);
            end;

            local v11 = Attribute * v9;

            if math.abs(descendant.Rate - v11) > 0.05 then
                descendant.Rate = v11;
            end;

            if descendant.Enabled ~= v10 then
                descendant.Enabled = v10;

                if not v10 then
                    descendant:Clear();
                end;
            end;
        elseif descendant:IsA("Beam") or descendant:IsA("Trail") then
            local v12;

            if v9 > 0 then
                v12 = descendant:GetAttribute("VFXAuthoredEnabled") ~= false;
            else
                v12 = false;
            end;

            descendant.Enabled = v12;
        end;
    end;
end;

return table.freeze(u3);