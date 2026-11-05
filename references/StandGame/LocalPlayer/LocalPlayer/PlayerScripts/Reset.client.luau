 

 

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local u1 = Instance.new("BindableEvent");
local u2 = nil;
u1.Event:Connect(function() --[[ Line: 6 ]]
    -- upvalues: l__LocalPlayer__1 (copy), u2 (ref)
    local l__Character__2 = l__LocalPlayer__1.Character;
    local v3 = l__LocalPlayer__1:FindFirstChild("PlayerGui");
    game:GetService("ReplicatedStorage");
    l__Character__2:WaitForChild("RemoteEvent");
    local l__RemoteFunction__3 = l__Character__2:WaitForChild("RemoteFunction");
    if v3 and (l__Character__2 and not u2) then
        u2 = true;
        print("this ran and resetting me?");
        local _, v4 = l__RemoteFunction__3:InvokeServer("Reset", {
            Anchored = false
        });
        wait((tonumber(v4) or 0) + 1);
        u2 = nil;
    end;
end);
while true do
    local v5, v6 = pcall(function() --[[ Line: 27 ]]
        -- upvalues: u1 (copy)
        game:GetService("StarterGui"):SetCore("ResetButtonCallback", u1);
    end);
    if v5 then
        break;
    end;
    print(v6);
    wait(2);
end;