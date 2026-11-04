 
 

local LinkCF = require(script.Parent.LinkCF);

return function(p1) -- Line: 10
    -- upvalues: LinkCF (copy)
    function p1.ReapplyLink(p2, p3) -- Line: 15
        -- upvalues: LinkCF (ref)
        local Link = p3.Link;

        if not Link then
            return;
        end;

        if not LinkCF.isValid(p3, Link) then
            LinkCF.freeze(p3);

            return;
        end;

        local _localWorldCF = p3._localWorldCF;

        if not _localWorldCF then
            return;
        end;

        if not (p3.VisualPart and p3.VisualPart.Parent) then
            return;
        end;

        local Type = p3.Type;

        if Type ~= "Part" and (Type ~= "Model" and Type ~= "Attachment") then
            return;
        end;

        if Type ~= "Attachment" then
            local v4 = LinkCF.reapplyFrame(p3.LinkMode, LinkCF.worldFrame(p3, Link), _localWorldCF);

            if Type == "Model" then
                p3.VisualPart:PivotTo(v4);

                return;
            end;

            p3.VisualPart.CFrame = v4;

            return;
        end;

        local Parent = p3.VisualPart.Parent;

        if not Parent then
            return;
        end;

        local v5 = LinkCF.toParentSpace(LinkCF.worldFrame(p3, Link), Parent);
        p3.VisualPart.CFrame = LinkCF.applyPositionRule(p3.LinkMode, v5) * _localWorldCF;
    end;
end;