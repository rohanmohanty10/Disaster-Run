 
 

return {
    ScreenFlip = function(u1: userdata, u2: userdata, u3: number) -- Line: 3, Name: ScreenFlip
        task.spawn(function() -- Line: 4
            -- upvalues: u2 (copy), u1 (copy), u3 (copy)
            for i = 1, #u2 do
                u1.Image = u2[i];
                task.wait(u3);
                local _ = i;
            end;
        end);
    end
};