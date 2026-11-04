 
 

return {
    { 259, function(p1, p2, p3) -- Line: 3
            for i = 3, 1, -1 do
                local v4 = p2:FindFirstChild((tostring(i)));

                if v4 then
                    v4.BackgroundTransparency = 1;
                    v4.Visible = true;
                    game.TweenService:Create(v4, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        BackgroundTransparency = 0
                    }):Play();
                end;

                task.wait(0.21052631578947367);
                local _ = i;
            end;

            local v5 = p2:FindFirstChild((tostring(3)));

            if v5 then
                v5.Visible = false;
            end;

            local v6 = p2:FindFirstChild((tostring(2)));

            if v6 then
                v6.Visible = false;
            end;

            local v7 = p2:FindFirstChild((tostring(1)));

            if v7 then
                v7.Visible = false;
            end;
        end },
    { 380, function(p8, p9, p10) -- Line: 28
            for i = 1, 10 do
                local v11 = p10:FindFirstChild((tostring(i)));

                if v11 then
                    v11.BackgroundTransparency = 1;
                    v11.Visible = true;
                    game.TweenService:Create(v11, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        BackgroundTransparency = 0
                    }):Play();
                end;

                task.wait(0.02);
                local _ = i;
            end;

            task.wait(0.1);

            for i = 1, 10 do
                local v12 = p10:FindFirstChild((tostring(i)));
                local v13;

                if v12 then
                    v12.Visible = false;
                    v13 = i;
                else
                    v13 = i;
                end;
            end;
        end }
};