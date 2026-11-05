  

 

local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return {
    PostRig = function(p1) -- Line: 4, Name: PostRig
        -- upvalues: AssetHandler (copy)
        local Player = p1.Player;
        local Character = p1.Character;
        local SkinName = p1.SkinName;
        local v2 = p1.AbilityName or "Crazy Diamond";

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player:IsA("Player") then
            Player:HasAppearanceLoaded();
        end;

        local Torso = Character:FindFirstChild("Torso");
        local v3 = AssetHandler.CloneAsset("Particles/Birthmark", {
            AbilityName = v2,
            SkinName = SkinName
        });
        v3.Parent = Torso;
        local Weld = Instance.new("Weld");
        Weld.Part0 = Torso;
        Weld.Part1 = v3;
        Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
        Weld.Parent = Torso;
    end
};