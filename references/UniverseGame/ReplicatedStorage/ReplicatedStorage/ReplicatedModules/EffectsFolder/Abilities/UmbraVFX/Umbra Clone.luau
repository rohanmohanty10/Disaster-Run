  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = game.ReplicatedStorage["Client Assets"];
game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game.Players.LocalPlayer;

local function tweendeb(p2, p3) -- Line: 11
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

return function(p4, p5, p6, p7, p8, p9, p10) -- Line: 18
    -- upvalues: Trove (copy), u1 (copy), LocalPlayer (copy), TweenService (copy)
    local v11 = Trove.new();
    local clone = u1.Umbra:FindFirstChild("clone");
    local Start = p8.Start;
    local End = p8.End;
    local Start2 = p9.Start;
    local End2 = p9.End;
    local u12;

    if Start then
        u12 = TweenInfo.new(unpack(Start));
    else
        u12 = Start;
    end;

    local u13;

    if End then
        u13 = TweenInfo.new(unpack(End));
    else
        u13 = End;
    end;

    local function find(p14, p15) -- Line: 25
        for _, child in ipairs(p14:GetChildren()) do
            if (child.Name == p15 or child.Name:find(p15)) and child:IsA("BasePart") then
                return child;
            end;
        end;
    end;

    local v16 = 0;

    if p10 then
        p4 = p4:FindFirstChild("Stand") or p4;
    end;

    if p7 and p4 ~= LocalPlayer.Character then
        task.wait(p7);
    end;

    while v16 <= p5 do
        local v17 = clone:Clone();
        v17.Parent = workspace.Effects;
        task.delay(5, v17.Destroy, v17);

        for _, child in ipairs(v17:GetChildren()) do
            local v18 = find(p4, child.Name);

            if v18 then
                child.CFrame = v18.CFrame;

                if Start then
                    task.spawn(function() -- Line: 50
                        -- upvalues: TweenService (ref), child (copy), u12 (copy), Start2 (copy), End (copy), u13 (copy), End2 (copy)
                        local v19 = TweenService:Create(child, u12, Start2);
                        v19:Play();
                        v19.Completed:Wait();

                        if End then
                            local v20 = TweenService:Create(child, u13, End2);
                            local v21 = child;
                            v20:Play();
                            v20.Completed:Wait();

                            if v21 then
                                v21:Destroy();
                            end;
                        else
                            child:Destroy();
                        end;
                    end);
                else
                    for i, v in pairs(Start2) do
                        child[i] = v;
                    end;

                    task.spawn(function() -- Line: 64
                        -- upvalues: End (copy), TweenService (ref), child (copy), u13 (copy), End2 (copy)
                        if End then
                            local v22 = TweenService:Create(child, u13, End2);
                            local v23 = child;
                            v22:Play();
                            v22.Completed:Wait();

                            if v23 then
                                v23:Destroy();
                            end;
                        else
                            child:Destroy();
                        end;
                    end);
                end;
            end;
        end;

        v16 = v16 + task.wait(p6);
    end;

    v11:Destroy();
end;