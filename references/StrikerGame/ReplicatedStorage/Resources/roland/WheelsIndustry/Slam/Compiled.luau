 

 

return {
    { 50, function(p1, p2) -- Line: 3
            local Wheel = p2:FindFirstChild("Wheel");

            if Wheel then
                for _, descendant in Wheel:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.LocalTransparencyModifier = 0;
                        descendant.Transparency = descendant:GetAttribute("BaseTransparency") or 0;
                    end;
                end;
            end;

            local WheelsVFX = p2:FindFirstChild("WheelsVFX");

            if WheelsVFX then
                shared.vfx.emit(WheelsVFX);
            end;
        end },
    { 94, function(p3, p4) -- Line: 20
            shared.vfx.emit(p3.slash);
        end },
    { 102, function(p5, p6) -- Line: 25
            shared.vfx.emit(p5.slam);
            shared.vfx.emit(p5.DecalMesh);
        end }
};