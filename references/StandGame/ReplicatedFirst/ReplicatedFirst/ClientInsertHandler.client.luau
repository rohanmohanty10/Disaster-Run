 

 

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__PlayerGui__2 = l__LocalPlayer__1:WaitForChild("PlayerGui");
local l__ReplicatedFirst__3 = game:GetService("ReplicatedFirst");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("StarterGui");
local l__CollectionService__5 = game:GetService("CollectionService");
local l__spawn__6 = task.spawn;
local _ = task.delay;
local l__wait__7 = task.wait;
l__spawn__6(function() --[[ Line: 13 ]]
    -- upvalues: l__PlayerGui__2 (copy), l__ReplicatedFirst__3 (copy), l__spawn__6 (copy)
    local l__LoadingScreen1__8 = script:WaitForChild("LoadingScreen1");
    local v1 = l__LoadingScreen1__8:Clone();
    l__LoadingScreen1__8:Destroy();
    local l__LoadingFrame__9 = v1.Frame.LoadingFrame;
    local l__Skip__10 = l__LoadingFrame__9.BarFrame.Skip;
    l__LoadingFrame__9.Visible = true;
    l__Skip__10.Visible = false;
    v1.Parent = l__PlayerGui__2;
    v1.AnimationScript.Disabled = false;
    l__ReplicatedFirst__3:RemoveDefaultLoadingScreen();
    l__spawn__6(function() --[[ Line: 30 ]]
        -- upvalues: l__PlayerGui__2 (ref)
        l__PlayerGui__2:WaitForChild("BlackScreen"):Destroy();
    end);
end);
for _, v2 in pairs(game:GetService("ReplicatedStorage"):WaitForChild("StarterPlayerScripts"):GetChildren()) do
    v2.Parent = l__LocalPlayer__1.PlayerScripts;
end;
l__spawn__6(function() --[[ Line: 39 ]]
    -- upvalues: l__CollectionService__5 (copy), l__LocalPlayer__1 (copy), l__wait__7 (copy)
    while not l__CollectionService__5:HasTag(l__LocalPlayer__1, "PressedPlay") do
        l__wait__7(1);
        local l__Character__11 = l__LocalPlayer__1.Character;
        if l__Character__11 then
            local v3 = l__Character__11:findFirstChild("Humanoid");
            if v3 and v3.Health <= 0 then
                l__LocalPlayer__1:Kick("gg bro");
            end;
        end;
    end;
end);
repeat
    l__wait__7(1);
until l__ReplicatedStorage__4:FindFirstChild("ClientInsertHandlerRemote") and l__ReplicatedStorage__4:FindFirstChild("ReplicatedFirst");
local l__ClientInsertHandlerRemote__12 = l__ReplicatedStorage__4:WaitForChild("ClientInsertHandlerRemote");
local u4 = nil;
l__ClientInsertHandlerRemote__12.OnClientEvent:connect(function() --[[ Line: 64 ]]
    -- upvalues: u4 (ref), l__ReplicatedStorage__4 (copy)
    if u4 then
    else
        u4 = true;
        for _, v5 in pairs(l__ReplicatedStorage__4:WaitForChild("ReplicatedFirst"):GetChildren()) do
            v5.Parent = game.ReplicatedFirst;
        end;
    end;
end);