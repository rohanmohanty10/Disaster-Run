 
-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__Debris__2 = game:GetService("Debris");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__VFX_Utility__4 = require(l__ReplicatedStorage__3.Services.Package.VFX_Utility);
local l__CameraShaker__5 = require(l__ReplicatedStorage__3.Services.Package.CameraShaker);
return {
    activate = function(_, u1, u2, p3) --[[ Name: activate, Line 10 ]]
        -- upvalues: l__Players__1 (copy), l__Debris__2 (copy), l__VFX_Utility__4 (copy), l__CameraShaker__5 (copy)
        if u1 or u2 then
            local u4 = p3 or {};
            local l__goalPoints__6 = u4.goalPoints;
            local l__leaderGoalPoints__7 = u4.leaderGoalPoints;
            if l__goalPoints__6 or l__leaderGoalPoints__7 then
                local u5 = u4.timeoutTime or nil;
                local u6 = {};
                local v7;
                if u1 then
                    v7 = u1:IsDescendantOf(l__Players__1);
                else
                    v7 = false;
                end;
                local v8;
                if u2 then
                    v8 = u2:IsDescendantOf(l__Players__1);
                else
                    v8 = false;
                end;
                local u9 = nil;
                local u10 = nil;
                local u11 = "running";
                local function v19() --[[ Line: 25 ]]
                    -- upvalues: u11 (ref), l__goalPoints__6 (copy), u6 (ref), u9 (ref), u1 (copy), u10 (ref), u2 (copy), l__leaderGoalPoints__7 (copy)
                    if u11 == "finished" then
                    else
                        u11 = "finished";
                        if l__goalPoints__6 then
                            if l__goalPoints__6 <= u6[1].points then
                                u9 = u1;
                                u10 = u2;
                            elseif l__goalPoints__6 <= u6[2].points then
                                u9 = u2;
                                u10 = u1;
                            elseif u6[1].points > u6[2].points then
                                u9 = u1;
                                u10 = u2;
                            elseif u6[1].points < u6[2].points then
                                u9 = u2;
                                u10 = u1;
                            else
                                local v12;
                                if math.random(1, 2) == 1 then
                                    v12 = u1;
                                else
                                    v12 = u2;
                                end;
                                u9 = v12;
                                local v13;
                                if u9 == u1 then
                                    v13 = u2;
                                else
                                    v13 = u1;
                                end;
                                u10 = v13;
                            end;
                        else
                            if l__leaderGoalPoints__7 then
                                local v14 = math.abs(u6[1].points - u6[2].points);
                                local v15;
                                if u6[1].points > u6[2].points then
                                    v15 = u1;
                                else
                                    v15 = u6[1].points >= u6[2].points and "draw" or u2;
                                end;
                                if v15 ~= "draw" and l__leaderGoalPoints__7 <= v14 then
                                    u9 = v15;
                                    local v16;
                                    if v15 == u1 then
                                        v16 = u2;
                                    else
                                        v16 = u1;
                                    end;
                                    u10 = v16;
                                    return;
                                end;
                                if u6[1].points > u6[2].points then
                                    u9 = u1;
                                    u10 = u2;
                                    return;
                                end;
                                if u6[1].points < u6[2].points then
                                    u9 = u2;
                                    u10 = u1;
                                    return;
                                end;
                                local v17;
                                if math.random(1, 2) == 1 then
                                    v17 = u1;
                                else
                                    v17 = u2;
                                end;
                                u9 = v17;
                                local v18;
                                if u9 == u1 then
                                    v18 = u2;
                                else
                                    v18 = u1;
                                end;
                                u10 = v18;
                            end;
                        end;
                    end;
                end;
                local function v27(u20) --[[ Line: 64 ]]
                    -- upvalues: u6 (ref), l__Players__1 (ref), l__goalPoints__6 (copy), l__leaderGoalPoints__7 (copy), u4 (ref), u5 (copy), u11 (ref)
                    local u21 = #u6 + 1;
                    local v22;
                    if u20 and u20:IsDescendantOf(l__Players__1) then
                        v22 = script._client:Clone();
                        v22:SetAttribute("goalPoints", l__goalPoints__6);
                        v22:SetAttribute("leaderGoalPoints", l__leaderGoalPoints__7);
                        v22.Parent = u20.PlayerGui;
                    else
                        v22 = nil;
                    end;
                    u6[u21] = {
                        points = 0,
                        _client = v22
                    };
                    if v22 then
                        v22:SetAttribute("myId", u21);
                        v22:SetAttribute("delay", u4._delay or 0);
                        v22:SetAttribute("timeoutTime", u5);
                        v22:SetAttribute("serverTime", workspace:GetServerTimeNow());
                        v22.Enabled = true;
                        v22.remote.OnServerEvent:Connect(function(p23, p24) --[[ Line: 100 ]]
                            -- upvalues: u20 (copy), u11 (ref), u6 (ref), u21 (copy)
                            if p23 == u20 then
                                if u11 == "finished" then
                                elseif u6 then
                                    if u6[1] and u6[2] then
                                        if p24 == "gained" then
                                            local v25 = u6[u21];
                                            v25.points = v25.points + 1;
                                        else
                                            if p24 == "missed" then
                                                local v26 = u6[u21];
                                                v26.points = v26.points - 2;
                                            end;
                                        end;
                                    end;
                                end;
                            else
                                p23:Kick("Unusual activities detected.");
                            end;
                        end);
                    end;
                end;
                local v28, v29 = pcall(v27, u1);
                if not v28 then
                    warn(v29);
                end;
                local v30, v31 = pcall(v27, u2);
                if not v30 then
                    warn(v31);
                end;
                local v32 = tick() - u4._delay;
                local u33 = u10;
                local u34 = u9;
                while (not v7 or u1 and u1:IsDescendantOf(l__Players__1)) and ((not v8 or u2 and u2:IsDescendantOf(l__Players__1)) and ((not u1:IsA("Model") or u1:IsDescendantOf(workspace)) and ((not u2:IsA("Model") or u2:IsDescendantOf(workspace)) and (u6[1] and u6[2])))) do
                    for _, v35 in u6 do
                        if v35._client then
                            for v36, v37 in u6 do
                                v35._client:SetAttribute(`plr_{v36}_points`, v37.points);
                            end;
                        end;
                    end;
                    if u5 and u5 < tick() - v32 then
                        v19();
                    elseif l__goalPoints__6 then
                        if l__goalPoints__6 <= u6[1].points or l__goalPoints__6 <= u6[2].points then
                            v19();
                        end;
                    elseif l__leaderGoalPoints__7 then
                        local v38 = math.abs(u6[1].points - u6[2].points);
                        local v39;
                        if u6[1].points > u6[2].points then
                            v39 = u1;
                        else
                            v39 = u6[1].points >= u6[2].points and "draw" or u2;
                        end;
                        if v39 ~= "draw" and l__leaderGoalPoints__7 <= v38 then
                            v19();
                        end;
                    end;
                    task.wait();
                    if u34 or u33 then
                        break;
                    end;
                end;
                task.wait();
                for _, u40 in u6 do
                    if u40._client then
                        pcall(function() --[[ Line: 168 ]]
                            -- upvalues: u40 (copy)
                            u40._client.UI_selector.Value:Destroy();
                        end);
                        l__Debris__2:AddItem(u40._client, 1);
                    end;
                end;
                table.clear(u6);
                u6 = nil;
                local v41, v42 = pcall(function() --[[ Line: 174 ]]
                    -- upvalues: l__VFX_Utility__4 (ref), u34 (ref), u33 (ref), l__CameraShaker__5 (ref)
                    l__VFX_Utility__4.emitVignetteEffect(Color3.fromRGB(85, 255, 0), Color3.fromRGB(85, 255, 0), 0, 3, 0, u34);
                    l__VFX_Utility__4.emitVignetteEffect(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 0, 0), 0, 3, 0, u33);
                    l__CameraShaker__5.QuickShake({
                        magnitude = 4,
                        roughness = 13,
                        fadeInTime = 0,
                        fadeOutTime = 0.7,
                        posInfluence = Vector3.new(1, 0.5, 0),
                        rotInfluence = Vector3.new(0, 0, 0.3),
                        players = { u34, u33 }
                    });
                end);
                if not v41 then
                    warn(v42);
                end;
                return u34, u33;
            end;
        end;
    end
};