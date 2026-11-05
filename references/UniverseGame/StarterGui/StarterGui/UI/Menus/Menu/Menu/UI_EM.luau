  

 

return function(u1) -- Line: 1
    local PathShortcuts = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PathShortcuts);
    local u2 = Random.new();
    script.Parent.MouseButton1Down:Connect(function() -- Line: 5
        -- upvalues: u1 (copy), u2 (copy), PathShortcuts (copy)
        u1:PlaySound("Click");
        u1:SetMenu("Menu");

        if game.PlaceId == 7481660839 then
            u1:Prompt(u2:NextInteger(1, 100) == 1 and "Exit Music" or "Exit to Menu", "You cannot exit to the main menu in testing.", "ok", function(p3, p4, p5) -- Line: 29
                -- upvalues: u1 (ref)
                u1:SetMenu("Menu");

                return true;
            end);

            return;
        end;

        u1:Prompt(u2:NextInteger(1, 100) == 1 and "Exit Music" or "Exit to Menu", "Are you sure you want to exit to the main menu?", "choose", function(p6, p7, p8) -- Line: 14
            -- upvalues: u1 (ref), PathShortcuts (ref)
            if p7 == 1 then
                u1:SetMenu("Menu");

                return true;
            end;

            if p7 == 2 then
                game:GetService("TeleportService"):Teleport(PathShortcuts.LinkedPlaces[game.GameId].TitleScreen, u1.Player);

                return false;
            end;
        end);
    end);
end;