  

 

return function(p1, p2) -- Line: 1
    local v3 = game.ReplicatedStorage["Client Assets"]["SANS AAAAAAAA"].SANS:Clone();
    v3.f.TextLabel.Text = p1 or v3.f.TextLabel.Text;
    v3.Parent = game.Players.LocalPlayer.PlayerGui;

    if p2 then
        v3.f.sansface.ImageLabel.Position = UDim2.new(-p2 - 0.166, 0, -0.078, 0);
    end;
end;