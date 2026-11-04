 

 

return {
    { 6, function(p1) -- Line: 3
            local WindUp = p1.HumanoidRootPart.RadiantKick.WindUp;
            shared.vfx.emit(WindUp);

            for _, descendant in ipairs(WindUp:GetDescendants()) do
                if descendant:IsA("Model") and descendant.Name == "Mesh" then
                    shared.vfx.emit(descendant);
                end;
            end;
        end },
    { 39, function(p2) -- Line: 14
            local Shoot = p2.HumanoidRootPart.RadiantKick.Shoot;
            shared.vfx.emit(Shoot);

            for _, descendant in ipairs(Shoot:GetDescendants()) do
                if descendant:IsA("Model") and descendant.Name == "Mesh" then
                    shared.vfx.emit(descendant);
                end;
            end;
        end }
};