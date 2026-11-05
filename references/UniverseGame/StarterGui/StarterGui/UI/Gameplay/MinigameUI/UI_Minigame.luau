  

 

return function(u1) -- Line: 1
    local _ = u1.Xtal;

    game:GetService("ReplicatedStorage"):FindFirstChild("SystemRemotes"):FindFirstChild("ClientPrompt").OnClientInvoke = function(p2) -- Line: 8
        -- upvalues: u1 (copy)
        local v3 = os.clock();
        local u4 = false;
        u1:FloatingPrompt("MINIGAME!", ("<font size=\"17\">Participate in <font color=\"rgb(181, 116, 255)\">%s</font>?</font>"):format(p2), 10, "choose", "Top", function(p5, p6, p7) -- Line: 18
            -- upvalues: u4 (ref)
            if p6 == 2 then
                u4 = true;
            end;
        end);

        repeat
            task.wait();
        until os.clock() - v3 > 5 or u4;

        return u4;
    end;
end;