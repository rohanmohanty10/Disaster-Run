 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local HudNavigation = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local MapLocator = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Game"):WaitForChild("MapLocator"));
game:GetService("ProximityPromptService").PromptTriggered:Connect(function(p1, p2) -- Line: 6
    -- upvalues: MapLocator (copy), LocalPlayer (copy), HudNavigation (copy)
    local v3 = MapLocator.interactable("ShopModel");

    if p2 == LocalPlayer and (v3 and p1:IsDescendantOf(v3)) then
        HudNavigation.activate("Shop");
        local ValleyArmory = LocalPlayer.PlayerGui:FindFirstChild("ValleyArmory");

        if ValleyArmory and ValleyArmory.Overlay.Visible then
            ValleyArmory.Overlay.Canvas.Storefront.CanvasPosition = Vector2.zero;
        end;
    end;
end);