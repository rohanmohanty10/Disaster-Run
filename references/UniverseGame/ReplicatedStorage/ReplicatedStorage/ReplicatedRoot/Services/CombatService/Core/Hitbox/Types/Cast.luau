  

 

return {
    Cast = function(p1) -- Line: 3, Name: Cast
        local v2 = nil;
        local _ = p1.Info;
        local HitboxInfo = p1.HitboxInfo;
        local WorldModel = p1.WorldModel;
        local Parameters = p1.Parameters;

        if HitboxInfo.Part then
            if HitboxInfo.Part then
                v2 = WorldModel:GetPartsInPart(p1.Part, Parameters);
            end;
        elseif typeof(p1.Size) == "number" then
            v2 = WorldModel:GetPartBoundsInRadius(typeof(p1.Origin) == "CFrame" and p1.Origin.Position or p1.Origin, p1.Size, Parameters);
        elseif typeof(p1.Size) == "Vector3" then
            v2 = WorldModel:GetPartBoundsInBox(typeof(p1.Origin) == "Vector3" and CFrame.new(p1.Origin) or p1.Origin, p1.Size, Parameters);
        end;

        return v2 or {};
    end
};