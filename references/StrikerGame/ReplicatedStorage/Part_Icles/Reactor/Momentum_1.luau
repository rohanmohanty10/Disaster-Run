 
 

return {
    of = function(p1, p2, p3) -- Line: 35, Name: of
        local VisualPart = p2.VisualPart;
        local CFrame = VisualPart.CFrame;
        local v4 = p2.LifeTime / math.max(p2.TotalKeyFrames, 1);
        local v5 = Vector3.new(0, 0, 0);
        local CurrentStep = p2.CurrentStep;
        p1:UpdatePart(p2, v4, p3);
        local v6 = (p2._lastEffectiveDt or 0) / v4;

        if math.abs(v6) > 1e-6 then
            local Position = VisualPart.CFrame.Position;

            if p2.CurrentStep == CurrentStep then
                Position = (p2._postUpdateCF or CFrame).Position;
            end;

            local math_sign_ret = math.sign(v6);
            local CurrentStep2 = p2.CurrentStep;
            p2._effectiveElapsed = CurrentStep2 * v4;
            p2.AccumulatedDT = 0;
            p1:UpdatePart(p2, math_sign_ret * v4 * (math_sign_ret * 1e-6 + 1) / v6, p3);
            local v7 = p2._lastEffectiveDt or 0;

            if p2.CurrentStep ~= CurrentStep2 and math.abs(v7) > 1e-6 then
                v5 = (VisualPart.CFrame.Position - Position) * (v6 / v7);
            end;
        end;

        VisualPart.CFrame = CFrame;

        return v5;
    end
};