  

 

return function(p1) -- Line: 1
    if not p1 then
        return;
    end;

    game:GetService("SoundService"):PlayLocalSound(p1);
end;