  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
local ReplicatedModules = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules");
local LockpickHandler = require(ReplicatedModules.LockpickHandler);
local Net = require(game.ReplicatedStorage.ReplicatedModules.KnitPackage.Net);
local LockpickTemplate = v1.LockpickTemplate;
local u2 = nil;

return function(p3, u4) -- Line: 10
    -- upvalues: u2 (ref), LockpickHandler (copy), LockpickTemplate (copy), Net (copy)
    if p3 then
        if not u2 then
            u2 = LockpickHandler.CreateMinigame({
                Template = LockpickTemplate,
                Origin = u4:IsA("BasePart") and u4.CFrame or u4:GetPivot()
            });
            local u5 = false;
            u2:Start();
            local u6 = u2.Lockpicked:ConnectOnce(function() -- Line: 21
                -- upvalues: u5 (ref)
                u5 = true;
            end);
            local u7 = nil;
            u7 = u2.Ended:Connect(function() -- Line: 25
                -- upvalues: u7 (ref), u6 (copy), Net (ref), u4 (copy), u5 (ref), u2 (ref)
                u7:Disconnect();
                u6:Disconnect();
                Net:RemoteEvent("LockpickChest"):FireServer(u4, u5);
                u2 = nil;
            end);
        end;
    elseif u2 then
        u2:Stop();
        u2:Destroy();
        u2 = nil;
    end;
end;