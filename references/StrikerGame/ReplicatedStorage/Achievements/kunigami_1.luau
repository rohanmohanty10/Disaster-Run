 
 

return { (function(p1) -- Line: 1, Name: CreateAchievement
        if p1.Name then
            local v2 = {
                Name = p1.Name
            };

            for i, v in p1 do
                if i ~= "Name" then
                    v2[i] = v;
                end;
            end;

            return v2;
        end;
    end)({
        Name = "ohhh i have a giant sword suddenly What....",
        Description = "Score with the secret awakening 🤫🤫🤫🤫",
        codename = "dattebayo gozaimas",
        Reward = {
            stylecoins = 500
        }
    }) };