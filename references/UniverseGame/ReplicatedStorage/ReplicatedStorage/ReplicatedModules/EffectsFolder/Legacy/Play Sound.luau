  

 

game:GetService("ReplicatedStorage");

return function(p1, p2, p3) -- Line: 3
    if type(p2) == "string" then
        return;
    end;

    if type(p2) == "number" then
        local Sound = Instance.new("Sound");
        Sound.Volume = 1;
        Sound.SoundId = "rbxassetid://" .. p2;
    end;
end;