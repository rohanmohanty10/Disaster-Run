  

 

local u1 = Random.new();

return function(p2, p3) -- Line: 3
    -- upvalues: u1 (copy)
    local v4 = p2:GetAttribute("PlaybackSpeedRange") or NumberRange.new(1, 1);
    p2.PlaybackSpeed = u1:NextNumber(v4.Min, v4.Max);
end;