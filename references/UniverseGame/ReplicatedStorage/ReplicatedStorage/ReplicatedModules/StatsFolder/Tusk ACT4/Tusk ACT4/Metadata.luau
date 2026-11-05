  

 

return {
    PostRig = function(p1) -- Line: 2, Name: PostRig
        local Character = p1.Character;
        local Player = p1.Player;

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player then
            Player:HasAppearanceLoaded();
        end;

        Character:SetAttribute("InfiniteRotation", true);
        Character:SetAttribute("TimestopResist", 3);
    end
};