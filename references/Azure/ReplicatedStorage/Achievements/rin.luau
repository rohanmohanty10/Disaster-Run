 

 

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
        Name = "I am the Egoist... Itoshi Rin!",
        Description = "Win Final Matchup as Rin",
        codename = "Rin Wins Matchup",
        Reward = {
            stylecoins = 500
        }
    }) };