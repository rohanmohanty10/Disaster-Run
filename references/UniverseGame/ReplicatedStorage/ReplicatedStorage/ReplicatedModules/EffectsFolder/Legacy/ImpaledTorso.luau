  

 

local LocalPlayer = game.Players.LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1, p2) -- Line: 4
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy)
    if LocalPlayer.Settings.Gore.Value == false and not p2 then
        return;
    end;

    if u1.Torso:GetAttribute("NoRays") then
        return;
    end;

    if u1.Torso.Transparency == 0 then
        u1.Torso.Transparency = 1;
        local u3 = ReplicatedStorage["Client Assets"]["The World"].DonutedTorso:Clone();
        u3.Massless = true;
        u3.CanCollide = false;
        u3.CanTouch = false;
        u3.CanQuery = false;
        u3.Parent = u1;
        u3.Color = u1.Torso.Color;
        u3.BloodHit.Enabled = true;
        local Weld = Instance.new("Weld");
        Weld.Parent = u1.Torso;
        Weld.Part0 = u3;
        Weld.Part1 = u1.Torso;
        pcall(function() -- Line: 25
            -- upvalues: u3 (copy), u1 (copy)
            for _, child in ipairs(u3:GetChildren()) do
                if child:IsA("Texture") then
                    child.Texture = u1:FindFirstChildOfClass("Shirt").ShirtTemplate;
                end;
            end;
        end);
        coroutine.wrap(function() -- Line: 33
            -- upvalues: u3 (copy), Weld (copy), u1 (copy)
            wait(0.25);
            u3.BloodHit.Enabled = false;
            wait(8);
            Weld:Destroy();
            u3:Destroy();

            if u1 and (u1:IsDescendantOf(game) and u1.Torso) then
                u1.Torso.Transparency = 0;
            end;
        end)();
    end;
end;