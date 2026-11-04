 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local soundUtil = require(ReplicatedStorage.util.soundUtil);

return {
    Init = function(u1) -- Line: 7
        -- upvalues: soundUtil (copy), ReplicatedStorage (copy)
        local Jimmyeeih = workspace:WaitForChild("map"):WaitForChild("lobby"):WaitForChild("subscriptions"):WaitForChild("Jimmyeeih");
        Jimmyeeih.HumanoidRootPart.ProximityPrompt.Triggered:Connect(function(p2) -- Line: 9
            -- upvalues: u1 (copy), soundUtil (ref), ReplicatedStorage (ref)
            if p2 ~= u1.player then
                return;
            end;

            u1:destroyContainer();
            local v3 = u1:Menu();

            if v3 then
                local Frame = v3.Frame;
                Frame.choice.Shop.fill.Visible = false;
                Frame.Shop.Visible = false;
                Frame.choice.Product.fill.Visible = true;
                Frame.Product.Visible = true;
                soundUtil:play(ReplicatedStorage.Resources.click, "default");
            end;
        end);
        Jimmyeeih.Humanoid.Animator:LoadAnimation(Jimmyeeih.Animation):Play(0);
    end
};