  

 

return function(p1) -- Line: 1
    game:GetService("RunService");

    function p1.ActionLinesEffect(p2, p3, p4) -- Line: 4
        local v5 = p4 or Color3.new(1, 1, 1);
        local White = script.Parent.White;
        local White2 = script.Parent.White2;
        local Black = script.Parent.Black;
        local Black2 = script.Parent.Black2;
        White.Visible = true;
        White2.Visible = true;
        Black.Visible = true;
        Black2.Visible = true;
        local v6 = tick();
        local v7 = 1;

        while tick() - v6 < p3 do
            local Texture = script.ActionLines.White:FindFirstChild((tostring(v7))).Texture;
            local _ = script.ActionLines.Black:FindFirstChild((tostring(v7))).Texture;
            White.Image = Texture;
            White2.Image = Texture;
            White.ImageColor3 = v5;
            White2.ImageColor3 = v5;
            Black.Image = Texture;
            Black2.Image = Texture;
            local v8 = v7 + 1;
            v7 = v8 > 4 and 1 or v8;
            task.wait(0.05);
        end;

        White.Visible = false;
        White2.Visible = false;
        Black.Visible = false;
        Black2.Visible = false;
    end;
end;