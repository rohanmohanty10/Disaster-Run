  

 

return function(p1, p2, p3) -- Line: 2, Name: playRandomSound
    local u4 = p1[math.random(1, #p1)]:Clone();
    u4.Volume = u4.Volume * (p3 or 1);
    u4.Parent = p2;
    u4:Play();
    task.delay(u4.TimeLength / u4.PlaybackSpeed, function() -- Line: 12
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;