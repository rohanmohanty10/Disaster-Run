  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Knit.GetService("InventoryService");
local u2 = Knit.GetService("PlayerDataService");

return function(u3) -- Line: 16
    -- upvalues: u2 (copy), u1 (copy), ParticleHandler (copy)
    if not u3 then
        return;
    end;

    local u4 = u2:GetNPCFlag("UsedKumaBook");
    task.spawn(function() -- Line: 30
        -- upvalues: u3 (copy), u1 (ref), u4 (copy), ParticleHandler (ref)
        while u3:IsDescendantOf(game) do
            local v5 = u1:GetItemCount("ItemInventory", "ITEM_89"):expect();
            local v6 = v5 and v5 > 0 and true or u4;
            local Book = u3:FindFirstChild("Book", true);

            if Book then
                Book.Transparency = v6 and 0 or 1;
            end;

            local Aura = u3:FindFirstChild("Aura");

            if Aura then
                ParticleHandler.EnableAllParticles(Aura, v6);
                Aura.Transparency = v6 and 0 or 1;
            end;

            task.wait(5);
        end;
    end);
end;