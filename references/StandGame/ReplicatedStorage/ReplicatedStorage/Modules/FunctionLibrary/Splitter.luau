 

 

local u1 = {};
local l__ServerStorage__1 = game:GetService("ServerStorage");
local l__delay__2 = task.delay;
local _ = task.spawn;
local l__wait__3 = task.wait;
function u1.ReturnLongestAxis(p2, p3) --[[ Line: 5 ]]
    if typeof(p2) == "Instance" then
        p2 = p2.Size or p2;
    end;
    local l__X__4 = p2.X;
    local l__Y__5 = p2.Y;
    local l__Z__6 = p2.Z;
    if l__Y__5 < l__X__4 and l__Z__6 < l__X__4 then
        return p3 and l__X__4 and l__X__4 or Vector3.new(l__X__4, 0, 0);
    elseif l__X__4 < l__Y__5 and l__Z__6 < l__Y__5 then
        return p3 and l__Y__5 and l__Y__5 or Vector3.new(0, l__Y__5, 0);
    else
        return p3 and l__Z__6 and l__Z__6 or Vector3.new(0, 0, l__Z__6);
    end;
end;
function u1.SplitPart(u4, u5, ...) --[[ Line: 18 ]]
    -- upvalues: u1 (copy), l__delay__2 (copy), l__ServerStorage__1 (copy), l__wait__3 (copy)
    local u6 = ...;
    local l__Size__7 = u4.Size;
    local u7 = u1.ReturnLongestAxis(l__Size__7);
    local u8 = u1.ReturnLongestAxis(l__Size__7, true);
    local l__Parent__8 = u4.Parent;
    local u9 = u4.CFrame + Vector3.new(0, 1000, 0);
    local v10 = u6.Strength or (1 / 0);
    local u11 = u6.Lifetime or 999;
    local u12 = {
        Transparency = u4.Transparency,
        CanCollide = u4.CanCollide,
        Name = u4.Name
    };
    if u4.Transparency <= 1 and (not u4:IsDescendantOf(workspace.Living) and (u4.Name ~= "TreeChopped" and (u4.Name ~= "Chopped" and v10 >= u4.Size.Magnitude))) then
        u4.Name = "Chopped";
        if u12.Name == "Tree Base" then
            u4.Name = "TreeChopped";
        end;
        if not u4:GetAttribute("Chopped") then
            u4:SetAttribute("Chopped", true);
            l__delay__2(u11 - 5, function() --[[ Line: 45 ]] end);
        end;
        u4.Parent = l__ServerStorage__1;
        local u13 = 0;
        local u14 = {};
        for u15 = 1, 2 do
            coroutine.resume(coroutine.create(function() --[[ Line: 56 ]]
                -- upvalues: u4 (copy), u6 (copy), l__Size__7 (copy), u9 (copy), l__ServerStorage__1 (ref), u8 (copy), u15 (copy), u7 (copy), u5 (copy), u14 (copy), u13 (ref), l__delay__2 (ref), u11 (copy)
                local v16 = Instance.new("Part");
                v16.CanCollide = u4.CanCollide;
                if u6.CanCollide == false and u6.CanCollide ~= nil then
                    v16.CanCollide = false;
                end;
                v16.CastShadow = u4.CastShadow;
                v16.Massless = u4.Massless;
                v16.Color = u4.Color;
                v16.Material = u4.Material;
                v16.Transparency = u4.Transparency;
                v16.Reflectance = u4.Reflectance;
                v16.Size = l__Size__7;
                v16.CFrame = u9;
                v16.Parent = l__ServerStorage__1;
                local v17 = Instance.new("Part");
                v17.Size = l__Size__7 * 2;
                v17.Parent = l__ServerStorage__1;
                local v18 = u8 / 1 * (u15 == 2 and -1 or 1);
                v17.CFrame = u9 * CFrame.new(u7.X == 0 and 0 or v18, u7.Y == 0 and 0 or v18, u7.Z == 0 and 0 or v18);
                local u19 = v16:SubtractAsync({ v17 });
                u19.Parent = workspace.IgnoreInstances;
                u19.Anchored = false;
                if u5 then
                    u19:SetNetworkOwner(u5);
                end;
                u19.Velocity = Vector3.new(0, 10, 0) + (u9.p - v17.CFrame.p).Unit * 50;
                v17:Destroy();
                v16:Destroy();
                table.insert(u14, u19);
                u13 = u13 + 1;
                l__delay__2(u11, function() --[[ Line: 95 ]]
                    -- upvalues: u19 (copy)
                    u19:Destroy();
                end);
            end));
        end;
        u4.Transparency = 1;
        u4.CanCollide = false;
        l__delay__2(u11 - 5, function() --[[ Line: 105 ]]
            -- upvalues: u4 (copy), u12 (copy), l__wait__3 (ref), l__Parent__8 (copy)
            u4.CanCollide = u12.CanCollide;
            game.ReplicatedStorage.ClientFX:FireAllClients("Tween", {
                Origin = u4,
                Tweeninfo = TweenInfo.new(5, Enum.EasingStyle.Linear),
                Goal = {
                    Transparency = u12.Transparency
                }
            });
            l__wait__3(5);
            u4.Name = u12.Name;
            u4.Transparency = u12.Transparency;
            if u4.Parent then
                print(u4.Parent, l__Parent__8);
                u4.Parent = l__Parent__8;
            end;
        end);
        repeat
            l__wait__3();
        until u13 >= 2;
        for _, v20 in pairs(u14) do
            v20.CFrame = v20.CFrame + Vector3.new(0, -1000, 0);
        end;
        return u14;
    end;
end;
return u1;