  

 

return function(u1) -- Line: 1
    local TweenService = game:GetService("TweenService");
    local Parent = script.Parent;
    local v2 = u1.Knit.GetService("GameModeService");

    function u1.ShowBoundlessTowerInfo(p3, p4) -- Line: 9
        -- upvalues: Parent (copy), TweenService (copy)
        local State = p4.State;

        if not State or Parent.Visible then
            if Parent.Visible and not State then
                local v5 = TweenService:Create(Parent, TweenInfo.new(0.245, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(-0.025, 0.4)
                });
                v5:Play();
                v5.Completed:Wait();
                v5:Destroy();
                Parent.Visible = false;
            end;

            return;
        end;

        Parent.Visible = true;
        Parent.Position = UDim2.fromScale(-0.025, 0.4);
        local v6 = TweenService:Create(Parent, TweenInfo.new(0.245, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.025, 0.4)
        });
        v6:Play();
        v6.Completed:Wait();
        v6:Destroy();
    end;

    function u1.UpdateBoundlessTowerInfo(p7, p8) -- Line: 36
        -- upvalues: Parent (copy)
        local TimeRemaining = p8.TimeRemaining;
        local WavesUntilFloor = p8.WavesUntilFloor;
        local Wave = p8.Wave;
        local Floor = p8.Floor;
        local EnemyCount = p8.EnemyCount;
        local UpgradeStats = p8.UpgradeStats;
        local UCoinsGained = p8.UCoinsGained;

        if TimeRemaining then
            Parent.TimeRemaining.Text = `{TimeRemaining} REMAINING`;
        end;

        if Wave then
            Parent.Content.Wave.Content.Value.Text = Wave;
        end;

        if Floor then
            Parent.Content.Floor.Content.Value.Text = Floor;
        end;

        if EnemyCount then
            Parent.Content.EnemyCount.Content.Value.Text = EnemyCount;
        end;

        if WavesUntilFloor then
            Parent.Content.WavesUntilBoss.Content.Value.Text = WavesUntilFloor;
        end;

        if UCoinsGained then
            Parent.Content.UCoins.Content.Value.Text = UCoinsGained;
        end;

        if UpgradeStats then
            Parent.TempStats.StatsValue.Text = UpgradeStats;
        end;
    end;

    v2.Signal:Connect(function(p9) -- Line: 68
        -- upvalues: u1 (copy)
        local Action = p9.Action;

        if p9.Handler ~= "BoundlessTower" then
            return;
        end;

        if Action == "ShowInfo" then
            u1:ShowBoundlessTowerInfo(p9);

            return;
        end;

        if Action == "UpdateInfo" then
            u1:UpdateBoundlessTowerInfo(p9);
        end;
    end);
end;