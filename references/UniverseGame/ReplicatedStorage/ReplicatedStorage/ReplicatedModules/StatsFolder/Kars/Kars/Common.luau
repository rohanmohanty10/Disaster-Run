  

 

local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = {};
local u2 = {};
local u3 = {};

function u1.GetFriends(p4, u5) -- Line: 7
    -- upvalues: u3 (copy), u2 (copy)
    if u3[u5.UserId] then
        return u3[u5.UserId];
    end;

    if u2[u5.UserId] then
        table.insert(u2[u5.UserId], coroutine.running());

        return coroutine.yield();
    end;

    u2[u5.UserId] = {};
    local u6 = {};
    local success, result = pcall(function() -- Line: 15
        -- upvalues: u5 (copy), u6 (copy)
        local v7 = game.Players:GetFriendsAsync(u5.UserId);

        while true do
            for _, v in ipairs(v7:GetCurrentPage()) do
                table.insert(u6, v);
            end;

            if v7.IsFinished then
                return;
            end;

            v7:AdvanceToNextPageAsync();
        end;
    end);

    if success ~= true then
        for _, v in u2[u5.UserId] do
            task.spawn(v, false, result);
        end;

        u2[u5.UserId] = nil;

        return false, result;
    end;

    u3[u5.UserId] = u6;
    task.delay(180, function() -- Line: 35
        -- upvalues: u3 (ref), u5 (copy)
        u3[u5.UserId] = nil;
    end);

    for _, v in u2[u5.UserId] do
        task.spawn(v, u6);
    end;

    u2[u5.UserId] = nil;

    return u6;
end;

function u1.GetPillarmanModel(p8, p9, p10) -- Line: 43
    -- upvalues: AssetHandler (copy), u1 (copy)
    local Player = p10.Player;

    if not (Player and (Player:IsA("Player") and Player.Settings.PillarmenFriendsActive.Value)) then
        return AssetHandler.CloneAsset("Models/" .. p9, p10);
    end;

    local u11 = AssetHandler.CloneAsset("Models/Decoy", p10);
    u11.Parent = workspace;
    task.spawn(function() -- Line: 51
        -- upvalues: u1 (ref), Player (copy), u11 (copy)
        local v12 = u1:GetFriends(Player);

        if #v12 > 0 then
            local v13 = v12[math.random(1, #v12)];
            local u14 = game.Players:GetHumanoidDescriptionFromUserId(v13.Id);
            local _, result = pcall(function() -- Line: 60
                -- upvalues: u11 (ref), u14 (copy)
                if u11 and (u11:IsDescendantOf(game) and u11:FindFirstChild("Humanoid")) then
                    u11.Humanoid:ApplyDescription(u14);
                end;

                local function UpdateObjectProperties(p15) -- Line: 65
                    if p15:IsA("BasePart") then
                        p15.CanCollide = false;
                        p15.CanQuery = false;
                        p15.CanTouch = false;
                        p15.Massless = true;
                        p15.CollisionGroup = "Ghosted";
                    end;
                end;

                for _, descendant in u11:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.CanCollide = false;
                        descendant.CanQuery = false;
                        descendant.CanTouch = false;
                        descendant.Massless = true;
                        descendant.CollisionGroup = "Ghosted";
                    end;
                end;

                u11.DescendantAdded:Connect(function(p16) -- Line: 79
                    if p16:IsA("BasePart") then
                        p16.CanCollide = false;
                        p16.CanQuery = false;
                        p16.CanTouch = false;
                        p16.Massless = true;
                        p16.CollisionGroup = "Ghosted";
                    end;
                end);
            end);

            if result then
                warn(result);
            end;
        end;
    end);

    return u11;
end;

return u1;