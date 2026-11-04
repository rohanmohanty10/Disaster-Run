 
 

return function(p1) -- Line: 8
    function p1.ApplyZOffset(p2, p3, p4) -- Line: 12
        local ZOffset = p3.ZOffset;

        if not ZOffset or ZOffset == 0 then
            return;
        end;

        if not p4 then
            return;
        end;

        if not (p3.VisualPart and p3.VisualPart.Parent) then
            return;
        end;

        local Type = p3.Type;

        if Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment") then
            return;
        end;

        local v5 = Type == "Model";
        local v6 = v5 and p3.VisualPart:GetPivot() or p3.VisualPart.CFrame;
        local v7 = p3._postUpdateCF or v6;
        local v8;

        if Type == "Attachment" then
            v8 = p3.VisualPart.Parent;

            if v8 and v8:IsA("BasePart") then
                v7 = v8.CFrame * v7;
                v6 = v8.CFrame * v6;
            else
                v8 = nil;
            end;
        else
            v8 = nil;
        end;

        local Position = v7.Position;
        local v9 = p4 - Position;
        local Magnitude = v9.Magnitude;

        if Magnitude < 0.001 then
            return;
        end;

        local v10 = CFrame.new(Position + v9 / Magnitude * ZOffset) * v6.Rotation;

        if v8 then
            v10 = v8.CFrame:ToObjectSpace(v10);
        end;

        if v5 then
            p3.VisualPart:PivotTo(v10);

            return;
        end;

        p3.VisualPart.CFrame = v10;
    end;
end;